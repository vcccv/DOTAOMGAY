

scope UnitRemoveEvent initializer Init
    
    // https://www.hiveworkshop.com/threads/system-unitdex-unit-indexer.248209/
    // 可以参考这个来简化捕捉单位离开地图

    globals
        private constant key HAS_ADEF
        private constant key ADEF_USED
        private constant integer CANCEL_DEFENSE = 852056
        private constant integer DEFENSE_ABILITYID = 'Adef'
    endglobals

    private function remove takes unit removeUnit returns nothing
        local integer h
        if not IsUnitType(removeUnit, UNIT_TYPE_HERO) then
            if IsUnitIllusion(removeUnit) then
                call IllusionUnitGetItem(removeUnit, false)
            endif
            // 清空非英雄单位绑定的数据
            set h = GetHandleId(removeUnit)
            // 说明是防御塔单位 需要清空反隐马甲
            if GetUnitAbilityLevel(removeUnit,'Adts')> 0 or GetUnitAbilityLevel(removeUnit,'Atru')> 0 then
                call RemoveUnit(LoadUnitHandle(HY, h, 145))
            endif
            call FlushChildHashtable(HY, h) // 相当傻卵, 有时候会在RemoveUnit后LoadHY哈希表的数据,直接清空有风险
            // 爬了再说
            call FlushChildHashtable(ExtraHT, h)
        endif
    endfunction

    private function UnitDeathEvent takes nothing returns boolean
        local unit trigUnit = GetDyingUnit()
        if IsUnitType( trigUnit, UNIT_TYPE_HERO ) then
            set trigUnit = null
            return false
        endif
        if LoadBoolean( ExtraHT, GetHandleId( trigUnit ), ADEF_USED ) then
            call SaveBoolean( ExtraHT, GetHandleId( trigUnit ), HAS_ADEF, true )
        elseif GetUnitAbilityLevel( trigUnit, DEFENSE_ABILITYID ) <= 0 then
            call UnitAddAbility( trigUnit, DEFENSE_ABILITYID )
        endif
        set trigUnit = null
        return false
    endfunction

    private function IssuedOrder takes nothing returns boolean
        local integer order = GetIssuedOrderId()
        local unit trigUnit = GetOrderedUnit()
        // 存活时发布命令就不管了
        if order != CANCEL_DEFENSE or UnitAlive( trigUnit ) or IsUnitType( trigUnit, UNIT_TYPE_HERO ) then
            set trigUnit = null
            return false
        endif
        if LoadBoolean( ExtraHT, GetHandleId( trigUnit ), ADEF_USED ) then
            call RemoveSavedBoolean( ExtraHT, GetHandleId( trigUnit ), ADEF_USED )
            //call TriggerExecuteBJ( gg_trg_RemoveUnitEvent, true )
            call remove(trigUnit)
        else // 第一次顶盾是单位死亡 第二次顶盾才是单位彻底死亡
            call SaveBoolean( ExtraHT, GetHandleId( trigUnit ), ADEF_USED, true )
        endif
        set trigUnit = null
        return false
    endfunction

    private function Init takes nothing returns nothing
        local trigger trig = CreateTrigger()

        set trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DEATH )
        call TriggerAddCondition( trig, function UnitDeathEvent )

        set trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_ISSUED_ORDER )
        call TriggerAddCondition( trig, function IssuedOrder )

        set trig = null
    endfunction

endscope


    