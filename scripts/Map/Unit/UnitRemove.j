
library UnitRemove requires Table
    
    globals
        private trigger Trig = null
    endglobals

    private function OnRemove takes nothing returns nothing
        local unit whichUnit = MHEvent_GetUnit()

        call Table[GetHandleId(whichUnit)].flush()

        set whichUnit = null
    endfunction

    function UnitRemove_Init takes nothing returns nothing
        set Trig = CreateTrigger()
        call MHUnitRemoveEvent_Register(Trig)
        call TriggerAddCondition(Trig, Condition(function OnRemove))
    endfunction

endlibrary
