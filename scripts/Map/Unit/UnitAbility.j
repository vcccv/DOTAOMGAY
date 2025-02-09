
library UnitAbility requires AbilityUtils, UnitLimitation
    
    globals
        private trigger SpellEffectTrig   = null
        private trigger EndCooldownTrig   = null
        private trigger StartCooldownTrig = null

        private trigger AddAbilityTrig    = null
        private trigger RemoveAbilityTrig = null

        private key NEXT_COOLDOWN
        private key ABSOLUTE_COOLDOWN
    endglobals

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
        local integer level        
        local real    cooldown     
        if whichAbility == null then
            return
        endif
        set level    = GetAbilityLevel(whichAbility)
        set cooldown = MHAbility_GetAbilityCustomLevelDataReal(whichAbility, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
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



    private function OnEndCooldown takes nothing returns boolean
        local unit whichUnit = MHEvent_GetUnit()
        local integer id     = MHEvent_GetAbility()

        set Event.INDEX = Event.INDEX + 1
        set Event.TriggerAbilityId[Event.INDEX] = id
        call AnyUnitEvent.ExecuteEvent(whichUnit, ANY_UNIT_EVENT_ABILITY_END_COOLDOWN)
        set Event.INDEX = Event.INDEX - 1

        set whichUnit = null
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
    function UpdateAbilityCooldown takes unit whichUnit, ability whichAbility returns nothing
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
    function UpdateUnitAbilityCooldown takes unit whichUnit returns nothing
        if whichUnit == null then
            call ThrowWarning(true, "UnitAbility", "UpdateUnitAbilityCooldown", "unit", 0, "whichUnit == null")
            return
        endif
        set TempReduceMultiplier = ( 1. - GetUnitCooldownReduceMultiplier(whichUnit) )
        call MHUnit_EnumAbility(whichUnit, function UpdateCooldownOnEnum)
    endfunction

    private function OnAbilityAdd takes nothing returns boolean
        local unit    whichUnit    = MHEvent_GetUnit()
        local ability whichAbility = MHEvent_GetAbilityHandle()
        local real    cooldown     = GetAbilityCooldownRemaining(whichAbility)
        local boolean isChanged    = false

        if HasOctarineCore and GetUnitAbilityLevel(whichUnit, 'A39S') == 1  then
            call UpdateAbilityCooldown(whichUnit, whichAbility)
        endif

        set whichAbility = null
        set whichUnit    = null
        return false
    endfunction

    private function OnAbilityRemove takes nothing returns boolean
        
        return false
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
