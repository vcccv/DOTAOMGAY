
library UnitAbility requires AbilityUtils, UnitLimitation
    
    globals
        private trigger SpellEffectTrig   = null
        private trigger EndCooldownTrig   = null
        private trigger StartCooldownTrig = null

        private trigger AddAbilityTrig    = null
        private trigger RemoveAbilityTrig = null

        private key NEXT_COOLDOWN
        private key ABSOLUTE_COOLDOWN

        // 熊灵的
        private key SPIRIT_BEAR_ITEM_ABILITY
    endglobals

    function GetUnitAbility takes unit whichUnit, integer abilId returns ability
        return MHUnit_GetAbility(whichUnit, abilId, false)
    endfunction

    function DisableEndCooldownTrigger takes nothing returns nothing
        call DisableTrigger(EndCooldownTrig)
    endfunction
    function EnableEndCooldownTrigger takes nothing returns nothing
        call EnableTrigger(EndCooldownTrig)
    endfunction

    function DisableStartCooldownTrigger takes nothing returns nothing
        call DisableTrigger(StartCooldownTrig)
    endfunction
    function EnableStartCooldownTrigger takes nothing returns nothing
        call EnableTrigger(StartCooldownTrig)
    endfunction


    // 前后摇
    function SetUnitAbilityCastpoint takes unit whichUnit, integer abilId, real costpoint returns nothing
        call MHAbility_SetCastpoint(whichUnit, abilId, costpoint)
    endfunction
    function SetUnitAbilityBackswing takes unit whichUnit, integer abilId, real backswing returns nothing
        call MHAbility_SetBackswing(whichUnit, abilId, backswing)
    endfunction

    function UnitDisableAbility takes unit whichUnit, integer abilId, boolean flag, boolean hideUI returns nothing
        if GetAbilityBaseIdById(abilId) == 'AOre' then
            call MHAbility_DisableEx(whichUnit, abilId, flag)
            if hideUI then
                call MHAbility_Hide(whichUnit, abilId, flag)
            endif
        else
            call MHAbility_Disable(whichUnit, abilId, flag, hideUI)
        endif
    endfunction
    function UnitEnableAbility takes unit whichUnit, integer abilId, boolean flag, boolean hideUI returns nothing
        call UnitDisableAbility(whichUnit, abilId, not flag, hideUI)
    endfunction
    function UnitShowAbility takes unit whichUnit, integer abilId, boolean flag returns nothing
        call MHAbility_Hide(whichUnit, abilId, not flag)
    endfunction
    function UnitHideAbility takes unit whichUnit, integer abilId, boolean flag returns nothing
        call MHAbility_Hide(whichUnit, abilId, flag)
    endfunction

    function UnitAddPermanentAbility takes unit whichUnit, integer ab returns boolean
        return UnitAddAbility(whichUnit, ab) and UnitMakeAbilityPermanent(whichUnit, true, ab)
    endfunction

    function UnitAddPermanentAbilitySetLevel takes unit whichUnit, integer id, integer level returns nothing
        if GetUnitAbilityLevel(whichUnit, id) == 0 then
            call UnitAddPermanentAbility(whichUnit, id)
        endif
        call SetUnitAbilityLevel(whichUnit, id, level)
    endfunction
    
    function GetAbilityCooldownRemaining takes ability whichAbility returns real
        return MHAbility_GetAbilityCooldown(whichAbility)
    endfunction

    function GetUnitAbilityCooldown takes unit whichUnit, integer abilId returns real
        return MHAbility_GetCustomLevelDataReal(whichUnit, abilId, GetUnitAbilityLevel(whichUnit, abilId), ABILITY_LEVEL_DEF_DATA_COOLDOWN)
    endfunction
    function GetUnitAbilityCooldownRemaining takes unit whichUnit, integer abilId returns real
        return MHAbility_GetCooldown(whichUnit, abilId)
    endfunction

    function EndUnitAbilityCooldown takes unit whichUnit, integer abilId returns nothing
        call MHAbility_SetCooldown(whichUnit, abilId, 0.)
    endfunction

    function SetAbilityCooldownFixOnExpired takes nothing returns nothing
        local SimpleTick tick           = SimpleTick.GetExpired()
        local ability    whichAbility
        local real       cooldown

        set whichAbility = SimpleTickTable[tick].ability['a']
        set cooldown     = SimpleTickTable[tick].real['C']

        call MHAbility_SetAbilityCooldown(whichAbility, cooldown)

        call tick.Destroy()

        set whichAbility = null
    endfunction
    function SetAbilityCooldownAbsoluteFixOnExpired takes nothing returns nothing
        local SimpleTick tick           = SimpleTick.GetExpired()
        local ability    whichAbility
        local real       cooldown

        set whichAbility = SimpleTickTable[tick].ability['a']
        set cooldown     = SimpleTickTable[tick].real['C']

        call DisableTrigger(StartCooldownTrig)
        call MHAbility_SetAbilityCooldown(whichAbility, cooldown)
        call EnableTrigger(StartCooldownTrig)

        call tick.Destroy()

        set whichAbility = null
    endfunction
    
    // 设置技能冷却
    function SetAbilityCooldown takes ability whichAbility, real cooldown returns nothing
        local SimpleTick tick
        if whichAbility == null then
            return
        endif
        if ( GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT or GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT) and GetSpellAbility() == whichAbility then
            set tick = SimpleTick.CreateEx()
            call tick.Start(0., false, function SetAbilityCooldownFixOnExpired)
            set SimpleTickTable[tick].ability['a'] = whichAbility
            set SimpleTickTable[tick].real['C']    = cooldown
        else
            call MHAbility_SetAbilityCooldown(whichAbility, cooldown)
        endif
    endfunction
    // 设置技能冷却(无视冷却缩减)
    function SetAbilityCooldownAbsolute takes ability whichAbility, real cooldown returns nothing
        local SimpleTick tick
        if whichAbility == null then
            return
        endif
        if ( GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT or GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT) and GetSpellAbility() == whichAbility then
            set tick = SimpleTick.CreateEx()
            call tick.Start(0., false, function SetAbilityCooldownAbsoluteFixOnExpired)
            set SimpleTickTable[tick].ability['a'] = whichAbility
            set SimpleTickTable[tick].real['C']    = cooldown
        else
            call DisableTrigger(StartCooldownTrig)
            call MHAbility_SetAbilityCooldown(whichAbility, cooldown)
            call EnableTrigger(StartCooldownTrig)
        endif
    endfunction

    function SetUnitAbilityCooldown takes unit whichUnit, integer abilId, real cooldown returns nothing
        local ability whichAbility = MHUnit_GetAbility(whichUnit, abilId, false)
        if whichAbility == null then
            return
        endif
        call SetAbilityCooldown(whichAbility, cooldown)
        set whichAbility = null
    endfunction
    function SetUnitAbilityCooldownAbsolute takes unit whichUnit, integer abilId, real cooldown returns nothing
        local ability whichAbility = MHUnit_GetAbility(whichUnit, abilId, false)
        if whichAbility == null then
            return
        endif
        call SetAbilityCooldownAbsolute(whichAbility, cooldown)
        set whichAbility = null
    endfunction

    function ReduceAbilityFixOnExpired takes nothing returns nothing
        local SimpleTick tick           = SimpleTick.GetExpired()
        local ability    whichAbility
        local real       reduceCooldown

        set whichAbility   = SimpleTickTable[tick].ability['a']
        set reduceCooldown = SimpleTickTable[tick].real['r']
    
        call MHAbility_SetAbilityCooldown(whichAbility, GetAbilityCooldownRemaining(whichAbility) - reduceCooldown)

        call tick.Destroy()

        set whichAbility = null
    endfunction
    // 减少技能冷却时间
    function ReduceAbilityCooldown takes ability whichAbility, real reduceCooldown returns nothing
        local SimpleTick tick
        if whichAbility == null then
            return
        endif
        if ( GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT or GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT) and GetSpellAbility() == whichAbility then
            set tick = SimpleTick.CreateEx()
            call tick.Start(0., false, function ReduceAbilityFixOnExpired)
            set SimpleTickTable[tick].ability['a'] = whichAbility
            set SimpleTickTable[tick].real['r']    = reduceCooldown
        else
            call SetAbilityCooldownAbsolute(whichAbility, GetAbilityCooldownRemaining(whichAbility) - reduceCooldown) 
        endif
    endfunction
    function ReduceUnitAbilityCooldown takes unit whichUnit, integer abilId, real reduceCooldown returns nothing
        local ability whichAbility = MHUnit_GetAbility(whichUnit, abilId, false)
        if whichAbility == null then
            return
        endif
        call ReduceAbilityCooldown(whichAbility, reduceCooldown)
        set whichAbility = null
    endfunction

    function StartAbilityCooldown takes ability whichAbility returns nothing
        local integer level        
        local real    cooldown     
        if whichAbility == null then
            return
        endif
        set level    = GetAbilityLevel(whichAbility)
        set cooldown = MHAbility_GetAbilityCustomLevelDataReal(whichAbility, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
        call SetAbilityCooldownAbsolute(whichAbility, cooldown)
    endfunction
    function StartAbilityCooldownAbsolute takes ability whichAbility returns nothing
        local real    cooldown     
        if whichAbility == null then
            return
        endif
        set cooldown = MHAbility_GetAbilityCustomLevelDataReal(whichAbility, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_COOLDOWN)
        call SetAbilityCooldownAbsolute(whichAbility, cooldown)
    endfunction
    
    // 指定当前冷却时间进入绝对冷却时间(不触发冷却缩减)
    function StartAbilityCooldownAbsoluteEx takes ability whichAbility, real cooldown returns nothing
        if whichAbility == null then
            return
        endif
        call MHAbility_SetAbilityCustomLevelDataReal(whichAbility, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_COOLDOWN, cooldown)
        call SetAbilityCooldownAbsolute(whichAbility, cooldown)
    endfunction

    function StartUnitAbilityCooldown takes unit whichUnit, integer abilId returns nothing
        local ability whichAbility = MHUnit_GetAbility(whichUnit, abilId, false)
        if whichAbility == null then
            return
        endif
        call StartAbilityCooldown(whichAbility)
        set whichAbility = null
    endfunction
    function StartUnitAbilityCooldownAbsolute takes unit whichUnit, integer abilId returns nothing
        local ability whichAbility = MHUnit_GetAbility(whichUnit, abilId, false)
        if whichAbility == null then
            return
        endif
        call StartAbilityCooldownAbsolute(whichAbility)
        set whichAbility = null
    endfunction
    
    function GetUnitCooldownReduceMultiplier takes unit whichUnit returns real
        if GetUnitAbilityLevel(whichUnit, 'A39S') == 1 then
            return 0.25
        endif
        return 0.
    endfunction

    function SetUnitAbilityLevelCooldown takes unit whichUnit, ability whichAbility, integer level, real cooldown returns nothing
        local real multiplier
        if whichUnit == null or whichAbility == null then
           return
        endif
        set multiplier = ( 1. - GetUnitCooldownReduceMultiplier(whichUnit) )
        call MHAbility_SetAbilityCustomLevelDataReal(whichAbility, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN, cooldown * multiplier)
    endfunction
    function SetUnitAbilityLevelCooldownAbsolute takes unit whichUnit, ability whichAbility, integer level, real cooldown returns nothing
        if whichUnit == null or whichAbility == null then
           return
        endif
        call MHAbility_SetAbilityCustomLevelDataReal(whichAbility, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN, cooldown)
    endfunction
    function SetAbilityLevelCooldownAbsolute takes ability whichAbility, integer level, real cooldown returns nothing
        if whichAbility == null then
           return
        endif
        call MHAbility_SetAbilityCustomLevelDataReal(whichAbility, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN, cooldown)
    endfunction

    // 更新单个技能
    function UnitAbilityUpdateCooldown takes unit whichUnit, ability whichAbility returns nothing
        local integer abilId   = GetAbilityId(whichAbility)
        local integer maxLevel = GetAbilityMaxLevelById(abilId)
        local real    cooldown
        local integer i
        local real    multiplier = ( 1. - GetUnitCooldownReduceMultiplier(whichUnit) )

        set i = 1
        loop
            exitwhen i > maxLevel

            set cooldown = MHAbility_GetLevelDefDataReal(abilId, i, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
            if cooldown > 0. then
                call MHAbility_SetAbilityCustomLevelDataReal(whichAbility, i, ABILITY_LEVEL_DEF_DATA_COOLDOWN, cooldown * multiplier)
            endif

            set i = i + 1
        endloop
    endfunction

    globals
        real TempReduceMultiplier = 0.
    endglobals

    private function UpdateCooldownOnEnum takes nothing returns nothing
        local ability enumAbility = MHUnit_GetEnumAbility()
        local integer abilId      = GetAbilityId(enumAbility)
        local integer maxLevel    = GetAbilityMaxLevelById(abilId)
        local real    cooldown
        local integer i
        local real    multiplier  = TempReduceMultiplier

        set i = 1
        loop
            exitwhen i > maxLevel

            set cooldown = MHAbility_GetLevelDefDataReal(abilId, i, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
            if cooldown > 0. then
                call MHAbility_SetAbilityCustomLevelDataReal(enumAbility, i, ABILITY_LEVEL_DEF_DATA_COOLDOWN, cooldown * multiplier)
                //call BJDebugMsg("|cffffff00 技能[" + Id2String(abilId) + "] " +  "(" + I2S(i) + ")"  +  " " + GetObjectName(abilId) + " cooldown:" + R2S(cooldown) + " new cooldown:" + R2S(cooldown * multiplier))
            endif

            set i = i + 1
        endloop

        set enumAbility = null
    endfunction

    // 更新单位所有技能
    function UnitAllAbilityUpdateCooldown takes unit whichUnit returns nothing
        if whichUnit == null then
            call ThrowWarning(true, "UnitAbility", "UnitAllAbilityUpdateCooldown", "unit", 0, "whichUnit == null")
            return
        endif
        set TempReduceMultiplier = ( 1. - GetUnitCooldownReduceMultiplier(whichUnit) )
        call MHUnit_EnumAbility(whichUnit, function UpdateCooldownOnEnum)
    endfunction

    private function OnEndCooldown takes nothing returns boolean
        local unit    whichUnit    = MHEvent_GetUnit()
        local ability whichAbility = MHEvent_GetAbilityHandle()
        local integer id     = MHEvent_GetAbility()

        set Event.INDEX = Event.INDEX + 1
        set Event.TriggerAbilityId[Event.INDEX] = id
        call AnyUnitEvent.ExecuteEvent(whichUnit, ANY_UNIT_EVENT_ABILITY_END_COOLDOWN)
        set Event.INDEX = Event.INDEX - 1

        if Table[GetHandleId(whichAbility)].item.has(SPIRIT_BEAR_ITEM_ABILITY) then
            call SetItemDroppable(Table[GetHandleId(whichAbility)].item[SPIRIT_BEAR_ITEM_ABILITY], true)
            call Table[GetHandleId(whichAbility)].item.remove(SPIRIT_BEAR_ITEM_ABILITY)
        endif

        set whichAbility = null
        set whichUnit    = null
        return false
    endfunction

    private function OnStartCooldown takes nothing returns boolean
        local unit    whichUnit    = MHEvent_GetUnit()
        local ability whichAbility = MHEvent_GetAbilityHandle()
        local integer id           = MHEvent_GetAbility()
        local real    cooldown     = GetAbilityCooldownRemaining(whichAbility)
        local boolean isChanged    = false

        //if HasOctarineCore and GetUnitAbilityLevel(whichUnit, 'A39S') == 1  then
        //    set cooldown = cooldown * 0.75
        //    set isChanged = true
        //endif
//
        //if isChanged then
        //    call BJDebugMsg("冷却真的改了啊不骗你现在是：" + R2S(cooldown))
        //    call MHAbility_SetAbilityCooldown(whichAbility, cooldown)
        //endif

        set whichAbility = null
        set whichUnit    = null
        return false
    endfunction

    // 对于主动技能？
    private function OnSpellEffect takes nothing returns boolean
        //local unit    whichUnit    = GetTriggerUnit()
        //local ability whichAbility = GetSpellAbility()
        //local integer level        = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        //local real    cooldown     = MHAbility_GetAbilityCustomLevelDataReal(whichAbility, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
        //local boolean isChanged    = false
        //
        //if HasOctarineCore and GetUnitAbilityLevel(whichUnit, 'A39S') == 1  then
        //    set cooldown = cooldown * 0.75
        //    set isChanged = true
        //endif
        //if isChanged then
        //    call BJDebugMsg("冷却真的改了啊不骗你现在是：" + R2S(cooldown))
        //    call MHAbility_SetAbilityCustomLevelDataReal(whichAbility, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN, cooldown)
        //endif
//
        //set whichAbility = null
        //set whichUnit    = null
        return false
    endfunction

    globals
        private key ABILITY_ADD_KEY
        private key ABILITY_REMOVE_KEY
    endglobals
    
    function RegisterAbilityAddMethod takes integer abilId, string func returns nothing
        set Table[ABILITY_ADD_KEY].string[abilId] = func
        call ThrowWarning(C2I(MHGame_GetCode(func)) == 0, "AbilityUtils", "RegisterAbilityAddMethod", Id2String(abilId), abilId, "func == 0")
    endfunction
    function RegisterAbilityRemoveMethod takes integer abilId, string func returns nothing
        set Table[ABILITY_REMOVE_KEY].string[abilId] = func
        call ThrowWarning(C2I(MHGame_GetCode(func)) == 0, "AbilityUtils", "RegisterAbilityRemoveMethod", Id2String(abilId), abilId, "func == 0")
    endfunction
    function ResgiterAbilityMethodSimple takes integer abilId, string addMethod, string removeMethod returns nothing
        call RegisterAbilityAddMethod(abilId, addMethod)
        call RegisterAbilityRemoveMethod(abilId, removeMethod)
    endfunction

    private function OnAbilityAdd takes nothing returns boolean
        local unit    whichUnit    = MHEvent_GetUnit()
        local ability whichAbility = MHEvent_GetAbilityHandle()
        local integer abilId       = MHEvent_GetAbility()

        if Table[ABILITY_ADD_KEY].string.has(abilId) then
            set Event.INDEX = Event.INDEX + 1
            set Event.TrigUnit[Event.INDEX] = whichUnit
            set Event.TriggerAbilityId[Event.INDEX] = abilId
            set Event.TriggerAbility[Event.INDEX] = whichAbility
            call MHGame_ExecuteFunc(Table[ABILITY_ADD_KEY].string[abilId])
            set Event.INDEX = Event.INDEX - 1
        endif

        // 如果是工程升级，则更新所有技能。
        if GetAbilityBaseIdById(abilId) == 'ANeg' then
            call UnitAllAbilityUpdateCooldown(whichUnit)
        elseif HasOctarineCore and GetUnitAbilityLevel(whichUnit, 'A39S') == 1  then
            call UnitAbilityUpdateCooldown(whichUnit, whichAbility)
        endif

        set whichAbility = null
        set whichUnit    = null
        return false
    endfunction

    private function OnAbilityRemove takes nothing returns boolean
        local unit    whichUnit    = MHEvent_GetUnit()
        local ability whichAbility = MHEvent_GetAbilityHandle()
        local integer abilId       = MHEvent_GetAbility()
        
        if Table[ABILITY_REMOVE_KEY].string.has(abilId) then
            set Event.INDEX = Event.INDEX + 1
            set Event.TrigUnit[Event.INDEX] = whichUnit
            set Event.TriggerAbilityId[Event.INDEX] = abilId
            set Event.TriggerAbility[Event.INDEX] = whichAbility
            call MHGame_ExecuteFunc(Table[ABILITY_REMOVE_KEY].string[abilId])
            set Event.INDEX = Event.INDEX - 1
        endif

        // 如果是工程升级，则更新所有技能。
        if GetAbilityBaseIdById(abilId) == 'ANeg' then
            call UnitAllAbilityUpdateCooldown(whichUnit)
        endif
        call Table[GetHandleId(whichAbility)].flush()
        
        set whichAbility = null
        set whichUnit    = null
        return false
    endfunction

    function SpiritBearOnUseItem takes unit whichUnit, item whichItem returns nothing
        local ability whichAbility = MHItem_GetAbility(whichItem, 1)
        local real    cooldown
    
        if whichAbility != null then
            set cooldown = GetAbilityCooldown(whichAbility)
            if cooldown > 0. then
                set Table[GetHandleId(whichAbility)].item[SPIRIT_BEAR_ITEM_ABILITY] = whichItem
                call SetItemDroppable(whichItem, false)
            endif
        endif
    
        set whichAbility = null
    endfunction

    function UnitAbility_Init takes nothing returns nothing
        set SpellEffectTrig = CreateTrigger()
        call TriggerRegisterAnyUnitEvent(SpellEffectTrig, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(SpellEffectTrig, Condition(function OnSpellEffect))

        set AddAbilityTrig = CreateTrigger()
        call TriggerAddCondition(AddAbilityTrig, Condition(function OnAbilityAdd))
        call MHAbilityAddEvent_Register(AddAbilityTrig)

        set RemoveAbilityTrig = CreateTrigger()
        call TriggerAddCondition(RemoveAbilityTrig, Condition(function OnAbilityRemove))
        call MHAbilityRemoveEvent_Register(RemoveAbilityTrig)

        set EndCooldownTrig = CreateTrigger()
        call MHAbilityEndCooldownEvent_Register(EndCooldownTrig)
        call TriggerAddCondition(EndCooldownTrig, Condition(function OnEndCooldown))

        set StartCooldownTrig = CreateTrigger()
        call MHAbilityStartCooldownEvent_Register(StartCooldownTrig)
        call TriggerAddCondition(StartCooldownTrig, Condition(function OnStartCooldown))

    endfunction

endlibrary
