
library UnitIllusion requires UnitUtils, UnitWeapon, UnitMorph, BuffSystem
        
    // 单位类型是否是变身单位
    function IsUnitMetamorphosis takes unit u returns boolean
        local integer typeId = GetUnitTypeId(u)
        local integer abilId = 0
        if typeId =='N01J' or typeId =='N01T' or typeId =='N0HT' or typeId =='H600' or typeId =='H601' or typeId =='H602' then
            if Mode__BalanceOff then
                set abilId ='ANcr'
            else
                set abilId ='QB0K'
            endif
        elseif typeId =='N017' or typeId =='N02B' or typeId =='QTW2' or typeId =='QTW3' then
            set abilId ='A0BE'
        elseif typeId =='N013' or typeId =='N014' or typeId =='N015' then
            set abilId ='A0AG'
        elseif typeId =='H00F' or typeId =='H00E' or typeId =='H00F' then
            set abilId ='QM00'
        elseif typeId =='E015' then
            set abilId ='QM02'
        elseif typeId =='H06X' or typeId =='H06Y' or typeId =='H06W' then
            set abilId ='QM01'
        elseif typeId =='H07I' then
            set abilId ='QM03'
        elseif typeId =='O017' then
            set abilId ='QM04'
        elseif typeId =='H08D' or typeId =='H08C' or typeId =='H08B' or typeId =='H084' then
            return true
        elseif typeId =='N0MA' or typeId =='N0MB' or typeId =='N0MC' or typeId =='N0MO' then
            return true
        endif
        return abilId > 0
    endfunction
    
    function WTB takes unit u returns boolean
        local integer typeId = GetUnitTypeId(u)
        if typeId =='Eevm' or typeId =='E02V' or typeId =='E02W' or typeId =='E02U' then
            return true
        endif
        return false
    endfunction

    // 设置幻象的技能
    function SyncIllusionUnitSkills takes unit illusionUnit, unit sourceUnit returns nothing
        local integer i = 1
        local integer lv
        loop
            set lv = GetUnitAbilityLevel(sourceUnit, PassiveSkill_Learned[i])
            if PassiveSkill_Real[i]=='P084' then
                set lv = GetUnitAbilityLevel(sourceUnit, 'A0DB')
            endif
            if lv > 0 then
                if PassiveSkill_SpellBook[i]> 0 or PassiveSkill_Real[i]> 0 then
                    call UnitAddPermanentAbility(illusionUnit, PassiveSkill_SpellBook[i])
                    call UnitMakeAbilityPermanent(illusionUnit, true, PassiveSkill_Real[i])
                    call UnitAddPermanentAbility(illusionUnit, PassiveSkill_Show[i])
                    if PassiveSkill_Illusion[i]> 0 then
                        call UnitAddPermanentAbility(illusionUnit, PassiveSkill_Illusion[i])
                        call SetUnitAbilityLevel(illusionUnit, PassiveSkill_Illusion[i], lv)
                    endif
                    call SetUnitAbilityLevel(illusionUnit, PassiveSkill_Real[i], lv)
                    call MHAbility_Disable(illusionUnit, PassiveSkill_Real[i], false, false)
                    if PassiveSkill_SpellBook[i] == 'A23F' then
                        call SetUnitAbilityLevel(illusionUnit,'A1ER', lv)
                        call UnitAddPermanentAbility(illusionUnit,'A1ER')
                        call SetUnitAbilityLevel(illusionUnit,'A1ER', lv)
                        call MHAbility_Disable(illusionUnit, 'A1ER', false, false)
                    endif
                endif
                // 瞄准
                if PassiveSkill_Learned[i] == 'A03U' then
                    set TempUnit = illusionUnit
                    set Q2 = lv
                    call ExecuteFunc("range_Take_Aim")
                elseif PassiveSkill_Learned[i] == 'A0RO' then
                    // ta被动
                    set TempUnit = illusionUnit
                    set Q2 = lv
                    call ExecuteFunc("range_Psi_Blades")
                elseif PassiveSkill_Learned[i]=='A0CL' then
                    set TempUnit = illusionUnit
                    set Q2 = lv
                    call ExecuteFunc("SyncIllusionUnitDragonBlood")
                endif
            endif
            set i = i + 1
        exitwhen i > PassiveAbilityMaxCount
        endloop
        // 更新属性
        call UnitUpdateStateBonus(illusionUnit)
        // 如果幻象是变身单位 直接播放单位的变身Stand 否则被认出来太蠢
        if IsUnitMetamorphosis(illusionUnit) or WTB(illusionUnit) then
            call AddUnitAnimationProperties(illusionUnit, "alternate", true)
            call SetUnitAnimation(illusionUnit, "stand alternate")
        endif
    endfunction

    // 0s后再设置单位缩放 否则不生效
    function Wait0sSetUnitScale takes nothing returns boolean
        local trigger trig = GetTriggeringTrigger()
        local integer iHandleId = GetHandleId(trig)
        local unit whichUnit = LoadUnitHandle( HY, iHandleId, 0 )

        call SetUnitCurrentScaleEx( whichUnit, GetUnitCurrentScale(whichUnit) )
        // call SetUnitAnimation( whichUnit, "stand upgrade" )
        call FlushChildHashtable(HY, iHandleId)
        call DestroyTrigger(trig)
        set trig = null
        return false
    endfunction

    // ownerPlayer 来源玩家；sourceUnit来源单位(镜像来源)；illusionUnit镜像单位
    function OnIllusionSummoned takes player ownerPlayer, unit sourceUnit, unit illusionUnit returns boolean
        local integer pid    = GetPlayerId(ownerPlayer)
        local integer typeId
        local real    hp

        // 判一下类型
        set typeId = GetUnitTypeId(sourceUnit)
        if GetUnitTypeId(illusionUnit) != typeId then
            set hp = GetUnitState(illusionUnit, UNIT_STATE_MAX_LIFE)
            call UnitMakeAbilityPermanent(illusionUnit, true, 'A09J')
            // 原本是极低效率的一大堆马甲技能，改成了japi的逆变身
            call YDWEUnitTransform(illusionUnit, typeId)
            // 然后同步下最大生命值
            call SetUnitState(illusionUnit, UNIT_STATE_MAX_LIFE, hp)
        endif
        // 同步一下幻象单位的技能 不然可能会有奇怪现象(一堆被动技能)
        call SyncIllusionUnitSkills(illusionUnit, sourceUnit)
        // 同步射手天赋给幻象
        if GetUnitAbilityLevel(sourceUnit, 'A0VC')> 0 then
            call SaveUnitHandle(OtherHashTable2,'ILLU', 0, illusionUnit)
            call SaveUnitHandle(OtherHashTable2,'ILLU', 1, sourceUnit)
            call ExecuteFunc("I8R")
        endif
        // 幻象的协同升级
        if GetUnitAbilityLevel(PlayerHeroes[pid],'A0A8')> 0 then
            call UnitAddPermanentAbilitySetLevel(illusionUnit, 'A3L3', GetUnitAbilityLevel(PlayerHeroes[pid],'A0A8'))
            call MHAbility_Disable(illusionUnit, 'A3L3', false, false)
        endif
        // 同步长大技能
        if IsUnitScepterUpgraded(sourceUnit) and GetUnitTypeId(illusionUnit) == 'Ucrl' and GetUnitAbilityLevel(sourceUnit,'A2KK') > 0 then
            // 小小模型有A就拿棒子
            call AddUnitAnimationProperties(illusionUnit, "upgrade", true)
        endif
        // 长大等级
        if GetUnitAbilityLevel(sourceUnit,'A0CY')> 0 then
            //call SetUnitCurrentScaleEx(illusionUnit, GetUnitCurrentScale(sourceUnit))
            set Temp__Int = CreateTimerEventTrigger( .0, false, function Wait0sSetUnitScale ) 
            call SaveUnitHandle( HY, Temp__Int, 0, illusionUnit )
            //call SaveReal( HY, Temp__Int, 1, 1 + .25 *  GetUnitAbilityLevel(sourceUnit,'A0CY') )
            call SaveReal( ExtraHT, GetHandleId(illusionUnit), HTKEY_UNIT_CURRENT_ADDSCALE, GetUnitAbilityLevel(sourceUnit,'A0CY') * 0.25 )
            // 模型缩放
            // call SetUnitCurrentScaleEx(illusionUnit, )
        endif
        if ( UnitHasItemOfType(illusionUnit, ItemRealId[it_mlq]) ) or ( UnitHasItemOfType(illusionUnit, ItemRealId[Item_HurricanePike]) ) then
            // call UnitAddAttackRangeRangedAttackerOnlyBonus(illusionUnit, 140.)
        endif
        if IsPlayerAutoSelectSummoned[pid] then
            call SelectUnitAddForPlayer(illusionUnit, ownerPlayer)
        endif
        return false
    endfunction

    globals
        private constant key ILLUSION_SOURCE
    endglobals

    function CreateIllusion takes player whichPlayer, unit whichUnit, real damageDealt, real damageTaken, real x, real y, integer buffId, real dur returns unit
        set bj_lastCreatedUnit = MHUnit_CreateIllusion(whichPlayer, whichUnit, x, y)
        if bj_lastCreatedUnit == null then
            return null
        endif
        call MHUnit_ApplyTimedLife(bj_lastCreatedUnit, buffId, dur)
        call MHUnit_SetIllusionDamageDeal(bj_lastCreatedUnit, damageDealt)
        call MHUnit_SetIllusionDamageReceive(bj_lastCreatedUnit, damageTaken)
        set Table[GetHandleId(bj_lastCreatedUnit)].unit[ILLUSION_SOURCE] = whichUnit
        call OnIllusionSummoned(whichPlayer, whichUnit, bj_lastCreatedUnit)
        return bj_lastCreatedUnit
    endfunction

    function GetIllusionDamageDealt takes unit illusionUnit returns real
        return MHUnit_GetIllusionDamageDeal(illusionUnit)
    endfunction
    function GetIllusionDamageTaken takes unit illusionUnit returns real
        return MHUnit_GetIllusionDamageReceive(illusionUnit)
    endfunction
    function GetIllusionSourceUnit takes unit illusionUnit returns unit
        return Table[GetHandleId(illusionUnit)].unit[ILLUSION_SOURCE]
    endfunction

    #define MIRROR_IMAGE_FRAME 0.02
    private function MirrorImageOnUpdate takes nothing returns nothing
        local SimpleTick tick  = SimpleTick.GetExpired()
        local TableArray table = SimpleTick.GetTable()
        local integer    h     = tick
        local integer    max
        local integer    i
        local effect     missileEffect
        local real       vel
        local real       dist
        local real       angle
        local real       rng
        local real       x
        local real       y
        local unit       whichUnit
        local player     whichPlayer
        local real       damageDealt
        local real       damageTaken
        local integer    buffId
        local real       dur 
        local integer    ownerIndex

        set rng  = table[h][4]
        set vel  = table[h][5]
        set dist = table[h][6] + vel
        set max  = table[h]['M'] + 1
        set i = 1
        set angle = 360. / ( max * 1. )
        if dist >= rng then
            set whichUnit   = table[h].unit['U']
            set whichPlayer = GetOwningPlayer(whichUnit)
            set damageDealt = table[h].real[1]
            set damageTaken = table[h].real[2]
            set dur         = table[h].real[3]
            set buffId      = table[h]['B']
            set ownerIndex  = GetRandomInt(1, max)

            call DestroyFogModifier(table[h].fogmodifier['F'])
            loop
                exitwhen i > max
                set missileEffect = table[h].effect[-i]
                set x = GetUnitX(whichUnit) + rng * Cos(angle * i * bj_DEGTORAD)
                set y = GetUnitY(whichUnit) + rng * Sin(angle * i * bj_DEGTORAD)
                call MHEffect_SetPosition(missileEffect, x, y, MHGame_GetAxisZ(x, y))
                call MHEffect_Hide(missileEffect, true)
                call DestroyEffect(missileEffect)
                //call BJDebugMsg(R2S(damageDealt) + ":damageDealt")
                if i != ownerIndex then
                    call CreateIllusion(whichPlayer, whichUnit, damageDealt, damageTaken, x, y, buffId, dur)
                else
                    set x = MHUnit_ModifyPositionX(whichUnit, x, y)
                    set y = MHUnit_ModifyPositionY(whichUnit, x, y)
                    call UnitSubInvulnerableCount(whichUnit)
                    call UnitSubStunCount(whichUnit)
                    call UnitSubHideExCount(whichUnit)
                    call IssueImmediateOrderById(whichUnit, 851972)
                    call SetUnitX(whichUnit, x)
                    call SetUnitY(whichUnit, y)
                endif
                set i = i + 1
            endloop

            call tick.Destroy()
            set whichUnit = null
        else
            loop
                exitwhen i > max
                set missileEffect = table[h].effect[-i]
                set x = MHEffect_GetX(missileEffect) + vel * Cos(angle * i * bj_DEGTORAD)
                set y = MHEffect_GetY(missileEffect) + vel * Sin(angle * i * bj_DEGTORAD)
                call MHEffect_SetPosition(missileEffect, x, y, MHGame_GetAxisZ(x, y))
                set i = i + 1
            endloop
            set table[h].real[6] = dist
        endif
    endfunction

    private function MirrorImageOnDelayEnd takes nothing returns nothing
        local SimpleTick tick  = SimpleTick.GetExpired()
        local TableArray table = SimpleTick.GetTable()
        local integer    h     = tick
        local integer    max
        local integer    i
        local effect     missileEffect
        local string     missileArt
        local unit       whichUnit
        local real       scale
        local real       angle
        local real       x
        local real       y

        call DestroyEffect(table[h].effect['E'])
        set whichUnit = table[h].unit['U']
        set missileArt = table[h].string['M']
        set max   = table[h]['M'] + 1
        set scale = GetUnitCurrentScale(whichUnit)
        
        set x = GetUnitX(whichUnit)
        set y = GetUnitY(whichUnit)
        set angle = 360. / ( max * 1. )
        set i = 1
        loop
            exitwhen i > max
            set missileEffect = AddSpecialEffect(missileArt, x, y)
            call MHEffect_SetScale(missileEffect, scale)
            call MHEffect_SetYaw(missileEffect, angle * i)
            set table[h].effect[-i] = missileEffect
            
            set i = i + 1
        endloop

        call tick.Start(MIRROR_IMAGE_FRAME, true, function MirrorImageOnUpdate)
        set whichUnit     = null
        set missileEffect = null
    endfunction

    function UnitMirrorImage takes unit whichUnit, integer max, real damageDealt, real damageTaken, integer buffId, real dur, real delay, string specialArt, string missileArt, real missileSpeed, real rng, real area returns nothing
        local SimpleTick  tick
        local TableArray  table
        local integer     h
        local fogmodifier imageFog
        local unit        first
        local group       g
        local real        x
        local real        y

        set tick  = SimpleTick.Create(0)
        set table = SimpleTick.GetTable()
        set h     = tick
        call tick.Start(delay, false, function MirrorImageOnDelayEnd)

        set g = AllocationGroup(187)

        call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(whichUnit), null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)
            
            if UnitAlive(first) and IsUnitIllusion(first) and GetUnitAbilityLevel(first, buffId) > 0 and GetIllusionSourceUnit(first) == whichUnit then
                call KillUnit(first)
            endif
            
        endloop
        call DeallocateGroup(g)

        set x = GetUnitX(whichUnit)
        set y = GetUnitY(whichUnit)

        set imageFog = CreateFogModifierRadius(GetOwningPlayer(whichUnit), FOG_OF_WAR_VISIBLE, x, y, area, true, false)
		call FogModifierStart(imageFog)
        set table[h].fogmodifier['F'] = imageFog
		set imageFog = null

        if specialArt != null then
            set bj_lastCreatedEffect = AddSpecialEffect(specialArt, x, y)
            call MHEffect_SetYaw(bj_lastCreatedEffect, GetUnitFacing(whichUnit))
            call MHEffect_SetScale(bj_lastCreatedEffect, GetUnitCurrentScale(whichUnit))
            set table[h].effect['E'] = bj_lastCreatedEffect
        endif
        
        set table[h].real[1] = damageDealt
        set table[h].real[2] = damageTaken
        set table[h].real[3] = dur
        set table[h].real[4] = rng
        set table[h].real[5] = missileSpeed * MIRROR_IMAGE_FRAME

        set table[h]['M'] = max
        set table[h]['B'] = buffId
        set table[h].string['S'] = specialArt
        set table[h].string['M'] = missileArt
        set table[h].unit['U'] = whichUnit

        call UnitAddInvulnerableCount(whichUnit)
        call UnitDispelBuffs(whichUnit, false)
        call UnitAddStunCountSafe(whichUnit)
        call UnitAddHideExCount(whichUnit)
    endfunction

endlibrary
