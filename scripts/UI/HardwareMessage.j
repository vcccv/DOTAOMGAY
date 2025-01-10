
library HardwareMessage requires FrameSystem

    globals
        private boolean     ButtonPushedState = false
        private Frame PushedOffsetFrame
        private Frame PushedFrame
        private boolean array KeyIsDown
    endglobals

    private function OnMouseLeftDown takes nothing returns nothing
        local Frame frame = Frame.GetPtrToInstanceSafe(MHFrame_GetUnderCursor())
        
        if frame != 0 and frame.IsPushedOffset() and frame.IsEnabledEx() then
            set ButtonPushedState = true
            set PushedOffsetFrame = frame.GetPushedOffsetFrame()
            set PushedFrame       = frame
            call PushedOffsetFrame.SetScale(0.95)
        endif
    endfunction

    private function OnMouseLeftUp takes nothing returns nothing
        local Frame frame = Frame.GetPtrToInstanceSafe(MHFrame_GetUnderCursor())
        
        if ButtonPushedState then
            call PushedOffsetFrame.SetScale(1.)
            call PushedFrame.SetEnable(false)
            call PushedFrame.SetEnable(true)
            set PushedOffsetFrame = 0
            set PushedFrame       = 0
        elseif frame != 0 and frame.IsPushedOffset() and frame.GetEnable() then
            call frame.SetEnable(false)
            call frame.SetEnable(true)
        endif
    endfunction

    private function OnMouseMove takes nothing returns nothing
        static if LIBRARY_ExtraPingMap then
            call ExtraPingMap_OnMouseMove()
        endif
    endfunction

    private function OnKeyDown takes nothing returns nothing
        local integer key = DzGetTriggerKey()
        if KeyIsDown[key] then
            return
        endif
        set KeyIsDown[key] = true

        static if LIBRARY_MutationFactorPanel then
            call MutationFactorPanel_OnKeyDown(key)
        endif
    endfunction

    private function OnKeyUp takes nothing returns nothing
        local integer key = DzGetTriggerKey()
        if not KeyIsDown[key] then
            return
        endif
        set KeyIsDown[key] = false
    endfunction
    
    function HardwareMessage_Init takes nothing returns nothing
        local integer i

        set i = 0
        loop
        exitwhen i > 400
            call DzTriggerRegisterKeyEventByCode(null,i,1,false, function OnKeyDown)
            call DzTriggerRegisterKeyEventByCode(null,i,0,false, function OnKeyUp)
            set i = i + 1
        endloop
        call DzTriggerRegisterMouseEventByCode(null, 1, 1, false, function OnMouseLeftDown)
        call DzTriggerRegisterMouseEventByCode(null, 1, 0, false, function OnMouseLeftUp)
        call DzTriggerRegisterMouseMoveEventByCode(null, false, function OnMouseMove)
    endfunction

endlibrary
