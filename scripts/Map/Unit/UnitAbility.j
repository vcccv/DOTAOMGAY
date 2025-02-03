
library UnitAbility requires AbilityUtils
    
    globals
        private trigger EndCooldownTrig = null
        private trigger StartCooldownTrig = null
    endglobals

    function UnitAddPermanentAbility takes unit whichUnit, integer ab returns boolean
        return UnitAddAbility(whichUnit, ab) and UnitMakeAbilityPermanent(whichUnit, true, ab)
    endfunction

    function UnitAddPermanentAbilitySetLevel takes unit whichUnit, integer id, integer level returns nothing
        if GetUnitAbilityLevel(whichUnit, id) == 0 then
            call UnitAddPermanentAbility(whichUnit, id)
        endif
        call SetUnitAbilityLevel(whichUnit, id, level)
    endfunction

    
    function EndUnitAbilityCooldown takes unit whichUnit, integer abilId returns nothing
        call MHAbility_SetCooldown(whichUnit, abilId, 0.)
    endfunction
    function StartUnitAbilityCooldown takes unit whichUnit, integer abilId returns nothing
        local integer level = GetUnitAbilityLevel(whichUnit, abilId)
        if level <= 0 then
            return
        endif
        call MHAbility_SetCooldown(whichUnit, abilId, MHAbility_GetCustomLevelDataReal(whichUnit, abilId, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN))
    endfunction

    function StartUnitAbilityCooldownAbsolute takes unit whichUnit, integer abilId returns nothing
        local integer level    = GetUnitAbilityLevel(whichUnit, abilId)
        local real    cooldown = MHAbility_GetLevelDefDataReal(abilId, level, ABILITY_LEVEL_DEF_DATA_COOLDOWN)
        if level <= 0 then
            return
        endif
        call DisableTrigger(StartCooldownTrig)
        call MHAbility_SetCooldown(whichUnit, abilId, cooldown)
        call EnableTrigger(StartCooldownTrig)
    endfunction
    function SetUnitAbilityCooldownAbsolute takes unit whichUnit, integer abilId, real cooldown returns nothing
        local integer level    = GetUnitAbilityLevel(whichUnit, abilId)
        if level <= 0 then
            return
        endif
        call DisableTrigger(StartCooldownTrig)
        call MHAbility_SetCooldown(whichUnit, abilId, cooldown)
        call EnableTrigger(StartCooldownTrig)
    endfunction

    function ReduceUnitAbilityFixOnExpired takes nothing returns nothing
        local SimpleTick tick           = SimpleTick.GetExpired()
        local integer    abilId
        local unit       whichUnit
        local real       reduceCooldown

        set abilId         = SimpleTickTable[tick]['A']
        set whichUnit      = SimpleTickTable[tick].unit['U']
        set reduceCooldown = SimpleTickTable[tick].real['R']

        //call SetUnitAbilityCooldownAbsolute(whichUnit, abilId, MHAbility_GetCooldown(whichUnit, abilId) - reduceCooldown) 
        call BJDebugMsg("减了" + R2S(reduceCooldown))

        call tick.Destroy()

        set whichUnit = null
    endfunction

    function ReduceUnitAbilityCooldown takes unit whichUnit, integer abilId, real reduceCooldown returns nothing
        local SimpleTick tick
        if GetUnitAbilityLevel(whichUnit, abilId) <= 0 then
            return
        endif
        if ( GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT or GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT) and GetTriggerUnit() == whichUnit then
            set tick = SimpleTick.CreateEx()
            call tick.Start(0., false, function ReduceUnitAbilityFixOnExpired)
            set SimpleTickTable[tick]['A']     = abilId
            set SimpleTickTable[tick].unit['U'] = whichUnit
            set SimpleTickTable[tick].real['R'] = reduceCooldown
            call BJDebugMsg("1")
        else
            call BJDebugMsg("2")
            //call MHAbility_SetCooldown(whichUnit, abilId, MHAbility_GetCooldown(whichUnit, abilId) - reduceCooldown) 
        endif
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
        local real    cooldown  = MHAbility_GetCooldown(whichUnit, id)
        local boolean isChange  = false

        if HasOctarineCore and GetUnitAbilityLevel(whichUnit, 'A39S') == 1 then
            set cooldown = cooldown * 0.75
            set isChange = true
        endif

        if isChange then
            call BJDebugMsg("冷却真的改了啊不骗你现在是：" + R2S(cooldown))
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
