
library UnitAbility requires AbilityUtils
    
    globals
        private trigger EndCooldownTrig = null
        private trigger StartCooldownTrig = null

        private key NEXT_COOLDOWN
        private key ABSOLUTE_COOLDOWN
    endglobals

    function DisableEndCooldownTrigger takes nothing returns nothing
        call DisableTrigger(EndCooldownTrig)
    endfunction
    function EnableEndCooldownTrigger takes nothing returns nothing
        call EnableTrigger(EndCooldownTrig)
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

        set whichAbility = SimpleTickTable[tick].ability['A']
        set cooldown     = SimpleTickTable[tick].real['C']

        call MHAbility_SetAbilityCooldown(whichAbility, cooldown)

        call tick.Destroy()

        set whichAbility = null
    endfunction
    function SetAbilityCooldownAbsoluteFixOnExpired takes nothing returns nothing
        local SimpleTick tick           = SimpleTick.GetExpired()
        local ability    whichAbility
        local real       cooldown

        set whichAbility = SimpleTickTable[tick].ability['A']
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
            set SimpleTickTable[tick].ability['A'] = whichAbility
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
            set SimpleTickTable[tick].ability['A'] = whichAbility
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

        set whichAbility   = SimpleTickTable[tick].ability['A']
        set reduceCooldown = SimpleTickTable[tick].real['R']
    
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
            set SimpleTickTable[tick].ability['A'] = whichAbility
            set SimpleTickTable[tick].real['R']    = reduceCooldown
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

    function StartUnitAbilityCooldown takes unit whichUnit, integer abilId returns nothing
        local ability whichAbility = MHUnit_GetAbility(whichUnit, abilId, false)
        local integer level        
        local real    cooldown     
        if whichAbility == null then
            return
        endif
        set level    = GetUnitAbilityLevel(whichUnit, abilId)
        set cooldown = MHAbility_GetAbilityCustomLevelDataReal(whichAbility, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
        call SetAbilityCooldown(whichAbility, cooldown)
        set whichAbility = null
    endfunction
    function StartUnitAbilityCooldownAbsolute takes unit whichUnit, integer abilId returns nothing
        local ability whichAbility = MHUnit_GetAbility(whichUnit, abilId, false)
        local integer level        
        local real    cooldown     
        if whichAbility == null then
            return
        endif
        set level    = GetUnitAbilityLevel(whichUnit, abilId)
        set cooldown = MHAbility_GetAbilityCustomLevelDataReal(whichAbility, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
        call SetAbilityCooldownAbsolute(whichAbility, cooldown)
        set whichAbility = null
    endfunction


    function OnEndCooldown takes nothing returns boolean
        local unit whichUnit = MHEvent_GetUnit()
        local integer id     = MHEvent_GetAbility()


        set whichUnit = null
        return false
    endfunction

    function OnStartCooldown takes nothing returns boolean
        local unit    whichUnit = MHEvent_GetUnit()
        local integer id        = MHEvent_GetAbility()
        local real    cooldown  = GetUnitAbilityCooldownRemaining(whichUnit, id)
        local boolean isChange  = false

        if HasOctarineCore and GetUnitAbilityLevel(whichUnit, 'A39S') == 1 then
            set cooldown = cooldown * 0.75
            set isChange = true
        endif

       // call BJDebugMsg("我触发了不骗你啊")

        if isChange then
        //    call BJDebugMsg("冷却真的改了啊不骗你现在是：" + R2S(cooldown))
            call MHAbility_SetCooldown(whichUnit, id, cooldown)
        endif

        set whichUnit = null
        return false
    endfunction

    function UnitAbility_Init takes nothing returns nothing
        set EndCooldownTrig = CreateTrigger()
        call MHAbilityEndCooldownEvent_Register(EndCooldownTrig)
        call TriggerAddCondition(EndCooldownTrig, Condition(function OnEndCooldown))

        set StartCooldownTrig = CreateTrigger()
        call MHAbilityStartCooldownEvent_Register(StartCooldownTrig)
        call TriggerAddCondition(StartCooldownTrig, Condition(function OnStartCooldown))
    endfunction

endlibrary
