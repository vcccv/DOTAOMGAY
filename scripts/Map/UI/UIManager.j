
// 硬件事件先在一起？
library UIManager /*
    */ requires /*
    */ UISystem, /*
    */ optional CommandButtonHelper,    /*
    */ optional CallCommandButton,      /*
    */ optional TownPortalScrollFrame,  /*
    */ optional TownPortalScrollHandler /*
    */ optional DisableResourceTrading, /*
    */

    private function OnUdpate takes nothing returns nothing
        static if LIBRARY_TownPortalScrollFrame then
            call TownPortalScroll_Update()
        endif
        static if LIBRARY_GlyphFrame then
            call Glyph_Update()
        endif
    endfunction

    private function OnGameStart takes nothing returns nothing
        call FrameSystem_Init()
        call DzFrameSetUpdateCallbackByCode(function OnUdpate)

        call Frame.LoadTOCFile("UI\\FrameDef\\CustomFrameDef.toc")

        static if LIBRARY_SimpleToolTipLib then
            call SimpleToolTip.Init()
        endif
    
        static if LIBRARY_TownPortalScrollFrame then
            call TownPortalScrollFrame_Init()
        endif
        static if LIBRARY_GlyphFrame then
            call GlyphFrame_Init()
        endif
        static if LIBRARY_CommandOrder then
            call CallCommandButton_Init()
        endif
        static if LIBRARY_Communication then
            call Communication_Init()
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

