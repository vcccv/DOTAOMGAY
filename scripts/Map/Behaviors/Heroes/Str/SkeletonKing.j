scope SkeletonKing

    globals
        constant integer HERO_INDEX_SKELETON_KING = 63
    endglobals
    //***************************************************************************
    //*
    //*  冥火暴击
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_HELLFIRE_BLAST = GetHeroSKillIndexBySlot(HERO_INDEX_SKELETON_KING, 1)
    endglobals
    
    function PWI takes nothing returns nothing
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        if GetTriggerEventId() == EVENT_UNIT_DAMAGED then
            if GetEventDamageSource() == LoadUnitHandle(HY, h, 0) then
                if GetUnitAbilityLevel(GetTriggerUnit(),'A3E9') == 1 and IsUnitMagicImmune(LoadUnitHandle(HY, h, 1)) == false and LoadBoolean(HY, h, 0) == false then
                    call SaveUnitHandle(OtherHashTable2,'A3E9', 0, GetTriggerUnit())
                    call SaveUnitHandle(OtherHashTable2,'A3E9', 1, LoadUnitHandle(HY, h, 1))
                    call SaveInteger(OtherHashTable2,'A3E9', 0, R2I(LoadReal(HY, h, 0)))
                    call ExecuteFunc("PYI")
                endif
                call CommonUnitAddStun(GetTriggerUnit(), 2., false)
                call UnitDamageTargetEx(LoadUnitHandle(HY, h, 1), GetTriggerUnit(), 1, 50 * LoadReal(HY, h, 0))
                call PUI(LoadUnitHandle(HY, h, 1), GetTriggerUnit(), R2I(LoadReal(HY, h, 0)))
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
        else
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        endif
        set t = null
    endfunction
    function PZI takes unit whichUnit, unit targetUnit, integer level, boolean FAR returns nothing
        local trigger t
        local integer h
        local unit d = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(whichUnit), GetUnitY(whichUnit), 0)
        call UnitAddAbility(d,'A42G')
        call B0R(d, targetUnit, 852095)
        set t = CreateTrigger()
        set h = GetHandleId(t)
        call TriggerRegisterTimerEvent(t, 5, false)
        call TriggerRegisterUnitEvent(t, targetUnit, EVENT_UNIT_DAMAGED)
        call TriggerAddCondition(t, Condition(function PWI))
        call SaveUnitHandle(HY, h, 0, d)
        call SaveUnitHandle(HY, h, 1, whichUnit)
        call SaveReal(HY, h, 0, level)
        call SaveBoolean(HY, h, 0, FAR)
        set t = null
        set d = null
    endfunction
    function HellfireBlastOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call PZI(GetTriggerUnit(), GetSpellTargetUnit(), GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()), false)
        endif
    endfunction
    function PYI takes nothing returns nothing
        local unit whichUnit = LoadUnitHandle(OtherHashTable2,'A3E9', 0)
        local unit targetUnit = LoadUnitHandle(OtherHashTable2,'A3E9', 1)
        local integer level = LoadInteger(OtherHashTable2,'A3E9', 0)
        call T4V(LoadUnitHandle(OtherHashTable2,'A3E9', 0))
        if UnitHasSpellShield(targetUnit) == false then
            call PZI(whichUnit, targetUnit, level, true)
        endif
        set whichUnit = null
        set targetUnit = null
        call FlushChildHashtable(OtherHashTable2,'A3E9')
    endfunction

    //***************************************************************************
    //*
    //*  重生
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_REINCARNATION = GetHeroSKillIndexBySlot(HERO_INDEX_SKELETON_KING, 4)
    endglobals
    
    function AhalimReincarnation_Actions takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit u = GetTriggerUnit()
        if GetTriggerEventId() == EVENT_WIDGET_DEATH then
            if GetUnitAbilityLevel(u,'A3DA') == 1 then
                call UnitRemoveAbility(u,'A3DA')
                call UnitRemoveAbility(u,'B3DA')
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
                call ResetUnitVertexColor(u)
                call BZR(u)
            elseif GetUnitAbilityLevel(u,'A3D9') == 1 then
                // 如果有盾或者自杀就倒闭
                if LoadBoolean(HY, GetHandleId(u),'suic') or GetUnitAbilityLevel(u,'AIrc') == 1 then
                    call UnitRemoveAbility(u,'A3DK')
                    call UnitRemoveAbility(u,'B3I9')
                    call FlushChildHashtable(HY, h)
                    call DestroyTrigger(t)
                else
                    // 正常死亡 0 0.1 4 秒计时器
                    call TriggerRegisterTimerEvent(t, 0, false)
                    call TriggerRegisterTimerEvent(t, .1, false)
                    call TriggerRegisterTimerEvent(t, 4, false)
                    call SaveUnitHandle(HY, h, 0, u)
                    call SaveReal(HY, h, 10, GetUnitState(u, UNIT_STATE_MANA))
                endif
            else
                call FlushChildHashtable(HY, h)
                call DestroyTrigger(t)
            endif
            call RemoveSavedHandle(HY, GetHandleId(u),'Leor')
        else
            //============================================
            // 计时器到期事件	
            set u = LoadUnitHandle(HY, h, 0)
            if LoadInteger(HY, h, 0) == 0 then // 0秒 复活了
                call UnitRemoveAbility(u,'A3DK')
                call UnitRemoveAbility(u,'B3I9')
                call UnitAddPermanentAbility(u,'A3DA')
                call SaveInteger(HY, h, 0, 1)
                call SetUnitVertexColor(u, 140, 120, 100, 70)
                call DisableUnitBloodstone(u)
                if LoadInteger(HY, GetHandleId(u), 4333) == 1 then
                    call EPX(u, 4334, 4.01)
                endif
                if LoadInteger(HY, GetHandleId(u), 4418) == 1 then
                    call EPX(u, 4419, 4.01)
                endif
            elseif LoadInteger(HY, h, 0) == 1 then
                call SaveInteger(HY, h, 0, 2)
                call SelectUnitAddForPlayer(u, GetOwningPlayer(u))
                call SetUnitState(u, UNIT_STATE_MANA, LoadReal(HY, h, 10))
            else
                call UnitRemoveAbility(u,'A3DA')
                call UnitRemoveAbility(u,'B3DA')
                call ResetUnitVertexColor(u)
                call UnitRemoveAbility(u,'Avul')
                call SetUnitInvulnerable(u, false)
                if not IsUnitType(u, UNIT_TYPE_SUMMONED) then
                    call UnitRemoveBuffs(u, true, true)
                endif
                call UnitRemoveAbility(u,'Aetl')
                call SetWidgetLife(u, 1)
                if LoadUnitHandle(HY, GetHandleId(u),'lstd') != null then
                    call UnitDamageTargetEx(LoadUnitHandle(HY, GetHandleId(u),'lstd'), u, 1, 99999999)
                    call UnitDamageTargetEx(LoadUnitHandle(HY, GetHandleId(u),'lstd'), u, 2, 99999999)
                    call UnitDamageTargetEx(LoadUnitHandle(HY, GetHandleId(u),'lstd'), u, 3, 99999999)
                    call UnitDamageTargetEx(LoadUnitHandle(HY, GetHandleId(u),'lstd'), u, 7, 99999999)
                    call UnitDamageTargetEx(LoadUnitHandle(HY, GetHandleId(u),'lstd'), u, 10, 99999999)
                    if UnitAlive(u) then
                        if GetHandleId(LoadUnitHandle(HY, GetHandleId(u),'lstd')) == 0 then
                            call KillUnit(u)
                        else
                            if GetUnitAbilityLevel(u,'A0MQ')> 0 or GetUnitAbilityLevel(u,'A1B6')> 0 then
                                call P0I(LoadUnitHandle(HY, GetHandleId(u),'lstd'), u)
                            endif
                        endif
                    endif
                else
                    call KillUnit(u)
                endif
                call BZR(u)
                if not UnitAlive(u) then
                    call FlushChildHashtable(HY, h)
                    call DestroyTrigger(t)
                else
                    call TriggerRegisterTimerEvent(t, .02, true)
                endif
            endif
        endif
        set t = null
        set u = null
        return false
    endfunction

    // 给单位添加效果
    function register_AhalimReincarnation takes unit whichUnit returns nothing
        local trigger t
        local integer h
        local integer hu = GetHandleId(whichUnit)
        if not HaveSavedHandle(HY, hu,'Leor') and GetUnitAbilityLevel(whichUnit,'A3DA') == 0 then
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call SaveTriggerHandle(HY, hu,'Leor', t)
            call TriggerRegisterDeathEvent(t, whichUnit)
            call TriggerAddCondition(t, Condition(function AhalimReincarnation_Actions))
        endif
        set t = null
    endfunction
    // 绿翔光环 0.3秒粘滞时间
    function EnumAddBuff_Reincarnation takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit skeletonKing = LoadUnitHandle(HY, h, 0)
        local group auraGroup = LoadGroupHandle(HY, h, 1)
        local group enumGroup
        local unit firstUnit
        // 单位死亡并且在重生 或者单位失去技能了
        if ( not UnitAlive(skeletonKing) and LoadInteger(HY, GetHandleId(skeletonKing),'A1AZ') != 1) or GetUnitAbilityLevel(skeletonKing,'A1AZ') == 0 then
            loop
                set firstUnit = FirstOfGroup(auraGroup)
            exitwhen firstUnit == null
                call UnitRemoveAbility(firstUnit,'A3DK')
                call UnitRemoveAbility(firstUnit,'B3I9')
                call GroupRemoveUnit(auraGroup, firstUnit)
            endloop
        else
            set TempUnit = skeletonKing
            set enumGroup = AllocationGroup(348)
            call GroupEnumUnitsInRange(enumGroup, GetUnitX(skeletonKing), GetUnitY(skeletonKing), 1225, null)
            //=======================================
            // remove
            loop
                set firstUnit = FirstOfGroup(auraGroup)
            exitwhen firstUnit == null
                if not IsUnitInGroup(firstUnit, enumGroup) then
                    call UnitRemoveAbility(firstUnit,'A3DK')
                    call UnitRemoveAbility(firstUnit,'B3I9')
                endif
                call GroupRemoveUnit(auraGroup, firstUnit)
            endloop
            //=======================================
            // add
            loop
                set firstUnit = FirstOfGroup(enumGroup)
            exitwhen firstUnit == null
                call GroupRemoveUnit(enumGroup, firstUnit)
                // 友军 存活 非建筑 非守卫 英雄 并且没有绿翔光环
                if IsUnitAlly(TempUnit, GetOwningPlayer(firstUnit)) and IsAliveNotStrucNotWard(firstUnit) and IsUnitType(firstUnit, UNIT_TYPE_HERO) and GetUnitAbilityLevel(firstUnit,'A3DA') == 0 then
                    call GroupAddUnit(auraGroup, firstUnit)
                    if GetUnitAbilityLevel(firstUnit,'A3DK') == 0 then
                        call UnitAddPermanentAbility(firstUnit,'A3DK')
                        call UnitMakeAbilityPermanent(firstUnit, true,'A3D9')
                        call UnitMakeAbilityPermanent(firstUnit, true,'A3I9')
                    endif
                    call register_AhalimReincarnation(firstUnit)
                endif
            endloop
            call DeallocateGroup(enumGroup)
            //=======================================
        endif
        set t = null
        set skeletonKing = null
        set auraGroup = null
        set enumGroup = null
        set firstUnit = null
        return false
    endfunction

    function P4I takes unit u returns nothing
        local trigger t
        local integer h
        local integer hu = GetHandleId(u)
        if HaveSavedHandle(HY, hu,'LeoR') == false then
            set t = CreateTrigger()
            set h = GetHandleId(t)
            call SaveTriggerHandle(HY, hu,'LeoR', t)
            call TriggerRegisterTimerEvent(t, .3, true)
            call SaveUnitHandle(HY, h, 0, u)
            call SaveGroupHandle(HY, h, 1, AllocationGroup(349))
            call TriggerAddCondition(t, Condition(function EnumAddBuff_Reincarnation))
        endif
        call SetAllPlayerAbilityUnavailable('A3DK')
        set t = null
    endfunction

    function ReincarnationOnGetScepterUpgrad takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()

        call P4I(whichUnit)

        set whichUnit = null
    endfunction

endscope
