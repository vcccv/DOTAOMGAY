
library UnitRemove requires Table, EventSystem
    
    globals
        private trigger Trig = null
    endglobals

    private function OnRemove takes nothing returns nothing
        local unit    whichUnit = MHEvent_GetUnit()
        local integer h      = GetHandleId(whichUnit)

        call Table[GetHandleId(whichUnit)].flush()
        call FlushChildHashtable(HY, h)
        call FlushChildHashtable(ObjectHashTable, h)

        set whichUnit = null
    endfunction

    function UnitRemove_Init takes nothing returns nothing
        set Trig = CreateTrigger()
        call MHUnitRemoveEvent_Register(Trig)
        call TriggerAddCondition(Trig, Condition(function OnRemove))
    endfunction

endlibrary
