
library FrameInit initializer Init /*
*************************************************************************************
*
*   */ requires /*
*
*************************************************************************************
*
*       */ optional DisableResourceTrading, /*
*       */ optional FrameSystem,            /*
*       */ optional GlyphOfFortification,   /*
*       */                                  /*
*
*************************************************************************************
*/

    private function OnFrameInit takes nothing returns nothing
        static if LIBRARY_DisableResourceTrading then
            call DisableResourceTradingFrame()
        endif
        
        static if LIBRARY_GlyphButton then
            call Glyph.InitUI()
        endif
    endfunction

    private function Init takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call MHGameStartEvent_Register(trig)
        call TriggerAddCondition(trig, Condition(function OnFrameInit))
    endfunction

endlibrary
