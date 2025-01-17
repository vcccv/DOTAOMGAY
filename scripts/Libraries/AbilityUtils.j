
// 继续堆屎
library AbilityUtils initializer Init

    globals
        key ABILITY_REMOVE_KEY
    endglobals

    private function OnAbilityRemove takes nothing returns boolean
        local integer abilId = MHEvent_GetAbility()
        if Table[ABILITY_REMOVE_KEY].string.has(abilId) then
            call MHGame_ExecuteFunc(Table[ABILITY_REMOVE_KEY].string[abilId])
        endif
        return false
    endfunction

    function SetAbilityRemoveAction takes integer abilId, string func returns nothing
        set Table[ABILITY_REMOVE_KEY].string[abilId] = func
    endfunction

    private function Init takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call MHAbilityRemoveEvent_Register(trig)
        call TriggerAddCondition(trig, Condition(function OnAbilityRemove))
    endfunction

endlibrary
