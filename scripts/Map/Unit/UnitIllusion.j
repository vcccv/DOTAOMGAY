
library UnitIllusion requires UnitUtils, UnitWeapon
        
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
    function SyncIllusionUnitSkills takes unit illusion, unit summoning returns nothing
        local integer i = 1
        local integer lv
        loop
            set lv = GetUnitAbilityLevel(summoning, PassiveSkills_Learned[i])
            if PassiveSkills_Real[i]=='P084' then
                set lv = GetUnitAbilityLevel(summoning, 'A0DB')
            endif
            if lv > 0 then
                if PassiveSkills_SpellBook[i]> 0 or PassiveSkills_Real[i]> 0 then
                    call UnitAddPermanentAbility(illusion, PassiveSkills_SpellBook[i])
                    call UnitMakeAbilityPermanent(illusion, true, PassiveSkills_Real[i])
                    call UnitAddPermanentAbility(illusion, PassiveSkills_Show[i])
                    if PassiveSkills_illusion[i]> 0 then
                        call UnitAddPermanentAbility(illusion, PassiveSkills_illusion[i])
                        call SetUnitAbilityLevel(illusion, PassiveSkills_illusion[i], lv)
                    endif
                    call SetUnitAbilityLevel(illusion, PassiveSkills_Real[i], lv)
                    call MHAbility_Disable(illusion, PassiveSkills_Real[i], false, false)
                    if PassiveSkills_SpellBook[i] == 'A23F' then
                        call SetUnitAbilityLevel(illusion,'A1ER', lv)
                        call UnitAddPermanentAbility(illusion,'A1ER')
                        call SetUnitAbilityLevel(illusion,'A1ER', lv)
                        call BJDebugMsg("我有分裂箭，那我的禁用计数是多少？："+I2S(MHAbility_GetDisableCount(illusion, 'A1ER')))
                    endif
                endif
                // 瞄准
                if PassiveSkills_Learned[i] == 'A03U' then
                    set U2 = illusion
                    set Q2 = lv
                    call ExecuteFunc("range_Take_Aim")
                elseif PassiveSkills_Learned[i] == 'A0RO' then
                    // ta被动
                    set U2 = illusion
                    set Q2 = lv
                    call ExecuteFunc("range_Psi_Blades")
                elseif PassiveSkills_Learned[i]=='A0CL' then
                    set U2 = illusion
                    set Q2 = lv
                    call ExecuteFunc("SyncIllusionUnitDragonBlood")
                endif
            endif
            set i = i + 1
        exitwhen i > PassiveAbilityMaxCount
        endloop
        call RefreshUnitRange(illusion)
        // 如果幻象是变身单位 直接播放单位的变身Stand 否则被认出来太蠢
        if IsUnitMetamorphosis(illusion) or WTB(illusion) then
            call AddUnitAnimationProperties(illusion, "alternate", true)
            call SetUnitAnimation(illusion, "stand alternate")
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
    // 镜像被召唤事件
    function OnIllusionSummoned takes nothing returns boolean
        local unit    illusion  = GetSummonedUnit()
        local integer pid       = GetPlayerId(GetOwningPlayer(illusion))
        local unit    summoning = null
        local integer typeId
        local real    hp
        if not IsUnitIllusion(illusion) or GetUnitTypeId(illusion)< 1 then
            set illusion = null
            return false
        endif
        set summoning = LoadUnitHandle(HY, GetHandleId(GetSummoningUnit()),'0ILU')
        if GetUnitAbilityLevel(illusion,'B0EN')> 0 then
            set pid = TempInt
        endif
        if summoning != null then
            set pid = GetPlayerId(GetOwningPlayer(summoning))
        else
            set summoning = Player__Hero[pid]
        endif
        call SaveUnitHandle(HY, GetHandleId(illusion),'0ILU', summoning)
        // 这里似乎是判断一下是否有变体精灵的镜像
        set typeId = GetUnitTypeId(summoning)
        if GetUnitTypeId(illusion) != typeId then
            set hp = GetUnitState(illusion, UNIT_STATE_MAX_LIFE)
            call UnitMakeAbilityPermanent(illusion, true, 'A09J')
            // 原本是极低效率的一大堆马甲技能，改成了japi的逆变身
            call YDWEUnitTransform(illusion, typeId)
            // 然后同步下最大生命值
            call SetUnitState(illusion, UNIT_STATE_MAX_LIFE, hp)
        endif
        // 同步一下幻象单位的技能 不然可能会有奇怪现象(一堆被动技能)
        call SyncIllusionUnitSkills(illusion, summoning)
        // 同步射手天赋给幻象
        if GetUnitAbilityLevel(summoning,'A0VC')> 0 then
            call SaveUnitHandle(OtherHashTable2,'ILLU', 0, illusion)
            call SaveUnitHandle(OtherHashTable2,'ILLU', 1, summoning)
            call ExecuteFunc("I8R")
        endif
        // 幻象的协同升级
        if GetUnitAbilityLevel(Player__Hero[pid],'A0A8')> 0 then
            call UnitAddPermanentAbilitySetLevel(illusion,'A3L3', GetUnitAbilityLevel(Player__Hero[pid],'A0A8'))
        endif
        // 同步长大技能
        if a_fx_b[pid] and GetUnitTypeId(illusion) == 'Ucrl' and GetUnitAbilityLevel(summoning,'A2KK')> 0 then
            // 小小模型有A就拿棒子
            call AddUnitAnimationProperties(illusion, "upgrade", true)
        endif
        // 长大等级
        if GetUnitAbilityLevel(summoning,'A0CY')> 0 then
            set Temp__Int = CreateTimerEventTrigger( .0, false, function Wait0sSetUnitScale ) 
            call SaveUnitHandle( HY, Temp__Int, 0, illusion )
            // call SaveReal( HY, Temp__Int, 1, 1 + .25 *  GetUnitAbilityLevel(summoning,'A0CY') )
            call SaveReal( ExtraHT, GetHandleId(illusion), HTKEY_UNIT_CURRENT_ADDSCALE, GetUnitAbilityLevel(summoning,'A0CY') * 0.25 )
            // 模型缩放
            // call SetUnitCurrentScaleEx(illusion, )
        endif
        if ( UnitHasItemOfType(illusion, XOV[it_mlq]) ) or ( UnitHasItemOfType(illusion, XOV[Item_HurricanePike]) ) then
            call AddUnitBonusRange(illusion, 140., true)
        endif
        set illusion  = null
        set summoning = null
        return false
    endfunction

    globals
        private constant key ILLUSION_OWNER
    endglobals

    function CreateIllusion takes player whichPlayer, unit whichUnit, real damageDealt, real damageTaken, real x, real y, integer buffId, real dur returns unit
        set bj_lastCreatedUnit = MHUnit_CreateIllusion(whichPlayer, whichUnit, x, y)
        call MHUnit_ApplyTimedLife(bj_lastCreatedUnit, buffId, dur)
        call MHUnit_SetIllusionDamageDeal(bj_lastCreatedUnit, damageDealt)
        call MHUnit_SetIllusionDamageReceive(bj_lastCreatedUnit, damageTaken)
        set Table[GetHandleId(bj_lastCreatedUnit)].unit[ILLUSION_OWNER] = whichUnit
        return bj_lastCreatedUnit
    endfunction

    function GetIllusionDamageDealt takes unit illusion returns real
        return MHUnit_GetIllusionDamageDeal(illusion)
    endfunction
    function GetIllusionDamageTaken takes unit illusion returns real
        return MHUnit_GetIllusionDamageReceive(illusion)
    endfunction
    function GetIllusionOwner takes unit illusion returns unit
        return Table[GetHandleId(illusion)].unit[ILLUSION_OWNER]
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
            set damageDealt = table[h].real['1']
            set damageTaken = table[h].real['2']
            set dur         = table[h].real['3']
            set buffId      = table[h]['B']
            set ownerIndex  = GetRandomInt(1, max)

            call DestroyFogModifier(table[h].fogmodifier['F'])
            loop
                exitwhen i > max
                set missileEffect = table[h].effect[-i]
                set x = GetUnitX(whichUnit) + rng * Cos(angle * i * bj_DEGTORAD)
                set y = GetUnitY(whichUnit) + rng * Sin(angle * i * bj_DEGTORAD)
                call MHEffect_SetPosition(missileEffect, x, y, MHGame_GetAxisZ(x, y))
                call DestroyEffect(missileEffect)
                if i != ownerIndex then
                    call CreateIllusion(whichPlayer, whichUnit, damageDealt, damageTaken, x, y, buffId, dur)
                else
                    set x = MHUnit_ModifyPositionX(whichUnit, x, y)
                    set y = MHUnit_ModifyPositionY(whichUnit, x, y)
                    call UnitSubInvulnerableCount(whichUnit)
                    call UnitSubStunCount(whichUnit)
                    call UnitSubHideExCount(whichUnit)
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
            call MHEffect_SetYaw(bj_lastCreatedEffect, angle * i)
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

        set table = SimpleTick.GetTable()
        set tick  = SimpleTick.Create(0)
        set h     = tick
        call tick.Start(delay, false, function MirrorImageOnDelayEnd)

        set g = AllocationGroup(187)

        call GroupEnumUnitsOfPlayer(g, GetOwningPlayer(whichUnit), null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)
            
            if UnitAlive(first) and IsUnitIllusion(first) and GetUnitAbilityLevel(first, buffId) > 0 and GetIllusionOwner(first) == whichUnit then
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
        call UnitAddStunCount(whichUnit)
        call UnitAddHideExCount(whichUnit)
    endfunction

    function UnitIllusion_Init takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterPlayerUnitEventBJ(trig, EVENT_PLAYER_UNIT_SUMMON)
        call TriggerAddCondition(trig, Condition(function OnIllusionSummoned))
    endfunction

endlibrary
