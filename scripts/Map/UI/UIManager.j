
// 硬件事件先在一起？
library UIManager /*
    */ requires /*
    */ optional CommandButtonHelper, /*
    */ optional CallCommandButton

    private function OnGameStart takes nothing returns nothing
        static if LIBRARY_CallCommandButton then
            call CallCommandButton_Init()
        endif
        static if LIBRARY_CommandButtonHelper then
            call CommandButtonHelper_Init()
        endif
    endfunction

    function UIManager_Init takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call MHGameStartEvent_Register(trig)
        call TriggerAddCondition(trig, Condition(function OnGameStart))
    endfunction

endlibrary

