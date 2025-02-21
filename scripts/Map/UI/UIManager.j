
// 硬件事件先在一起？
library UIManager /*
    */ requires /*
    */ UISystem, /*
    */ optional CommandButtonHelper,    /*
    */ optional CallCommandButton,      /*
    */ optional TownPortalScrollFrame,  /*
    */ optional DisableResourceTrading, /*
    */

    private function OnGameStart takes nothing returns nothing
        call LoadTOCFile("UI\\FrameDef\\CustomFrameDef.toc")
        static if LIBRARY_CallCommandButton then
            call CallCommandButton_Init()
        endif
        static if LIBRARY_CommandButtonHelper then
            call CommandButtonHelper_Init()
        endif
        static if LIBRARY_TownPortalScrollFrame then
            call TownPortalScrollFrame_Init()
        endif
        static if LIBRARY_DisableResourceTrading then
            call DisableResourceTradingFrame()
        endif
    endfunction

    function UIManager_Init takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call MHGameStartEvent_Register(trig)
        call TriggerAddCondition(trig, Condition(function OnGameStart))
    endfunction

endlibrary

