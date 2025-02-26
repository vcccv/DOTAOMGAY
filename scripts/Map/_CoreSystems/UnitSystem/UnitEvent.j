
library UnitEvent requires Base, EventSystem
    
    // 不重复注册
    function RegisterUnitDeathMethod takes string func returns nothing
        local integer i = 0
        loop
        exitwhen HaveSavedString(AbilityDataHashTable,'DEAD', i) == false
            if LoadStr(AbilityDataHashTable,'DEAD', i) == func then
                return
            endif
            set i = i + 1
        endloop
        call SaveStr(AbilityDataHashTable,'DEAD', i, func)
        call AnyUnitEvent.CreateEvent(UNIT_EVENT_DEATH_SIMPLE, func)
    endfunction

endlibrary
