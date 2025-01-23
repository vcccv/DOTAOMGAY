
library UnitIllusion requires UnitUtils, UnitWeapon

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
        if UnitTypeIsMetamorphosis(illusion) or WTB(illusion) then
            // call BJDebugMsg("幻象是变身单位")
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
        call AddTriggerToDestroyQueue(trig)
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
            call UnitMakeAbilityPermanent(illusion, true,'A09J')
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
        if ( GetItemOfTypeFromUnit(illusion, XOV[it_mlq]) != null ) or ( GetItemOfTypeFromUnit(illusion, XOV[Item_HurricanePike]) != null ) then
            call AddUnitBonusRange(illusion, 140., true)
        endif
        set illusion  = null
        set summoning = null
        return false
    endfunction

    function UnitIllusion_Init takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterPlayerUnitEventBJ(trig, EVENT_PLAYER_UNIT_SUMMON)
        call TriggerAddCondition(trig, Condition(function OnIllusionSummoned))
    endfunction

endlibrary
