
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
*       */ optional HardwareMessage,        /*
*
*************************************************************************************
*/

    private function OnFrameInit takes nothing returns nothing
        call DestroyTrigger(GetTriggeringTrigger())

        call DzLoadToc("UI\\path.toc")
        
        static if LIBRARY_HardwareMessage then
            call HardwareMessage_Init()
        endif
        
        static if LIBRARY_DisableResourceTrading then
            call DisableResourceTradingFrame()
        endif
        
        static if LIBRARY_GlyphOfFortification then
            call Glyph.InitUI()
        endif
    endfunction
    
    private function Init takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call MHGameStartEvent_Register(trig)
        //call TriggerRegisterTimerEvent(trig, 1, false)
        call TriggerAddCondition(trig, Condition(function OnFrameInit))
        set trig = null
    endfunction

endlibrary
