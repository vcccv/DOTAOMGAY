
library UnitAbility requires AbilityUtils
    
    globals
        private trigger EndCooldownTrig = null
        private trigger StartCooldownTrig = null
    endglobals

    function EndUnitAbilityCooldown takes unit whichUnit, integer abilId returns nothing
        call MHAbility_SetCooldown(whichUnit, abilId, 0.)
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

        if GetUnitAbilityLevel(whichUnit, 'B3DU') == 1 then
            // 是物品技能就不减cd 被动也不减
            if not UnitAbilityFromItem(whichUnit, id) and not IsAbilityPassive(id) then
                if GetUnitAbilityLevel(whichUnit, 'A3DU') == 1 then
                    set cooldown = cooldown + 2.
                    call UnitRemoveAbility(whichUnit, 'A3DU')
                elseif GetUnitAbilityLevel(whichUnit, 'A3DV') == 1 then
                    set cooldown = cooldown + 3.
                    call UnitRemoveAbility(whichUnit, 'A3DV')
                elseif GetUnitAbilityLevel(whichUnit, 'A3DW') == 1 then
                    set cooldown = cooldown + 4.
                    call UnitRemoveAbility(whichUnit, 'A3DW')
                elseif GetUnitAbilityLevel(whichUnit, 'A3DX') == 1 then
                    set cooldown = cooldown + 5.
                    call UnitRemoveAbility(whichUnit, 'A3DX')
                endif
                call UnitRemoveAbility(whichUnit, 'B3DU')
                set isChange = true
            endif
        endif

        if cooldown > 0.5 then
            
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
