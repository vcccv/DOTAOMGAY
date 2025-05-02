
// 代替原有命令按钮的工具提示
library CommandButtonSimpleTooltip requires SimpleToolTipLib

    globals
        private trigger EnterTrig
        private trigger LeaveTrig

        private integer array ItemButton
        private integer array SkillButton
    endglobals

    private function OnEnterCommandButton takes nothing returns boolean
        local integer frame = MHEvent_GetFrame()
        call SimpleToolTip.EnterCommandButton(frame)
        return false
    endfunction

    private function OnLeaveCommandButton takes nothing returns boolean
        local integer frame = MHEvent_GetFrame()
        call SimpleToolTip.LeaveCommandButton(frame)
        return false
    endfunction

    function CommandButtonSimpleTooltip_Init takes nothing returns nothing
        local integer i

        set EnterTrig = CreateTrigger()
        set LeaveTrig = CreateTrigger()

        call TriggerAddCondition(EnterTrig, Condition(function OnEnterCommandButton))
        call TriggerAddCondition(LeaveTrig, Condition(function OnLeaveCommandButton))
        set i = 1
        loop
            exitwhen i > 12
            set SkillButton[i] = MHUI_GetSkillBarButton(i)
            
            call MHFrameEvent_Register(EnterTrig, SkillButton[i], EVENT_ID_FRAME_MOUSE_ENTER)
            call MHFrameEvent_Register(LeaveTrig, SkillButton[i], EVENT_ID_FRAME_MOUSE_LEAVE)
            
            set i = i + 1
        endloop

        set i = 1
        loop
            exitwhen i > 6
            set ItemButton[i] = MHUI_GetItemBarButton(i)
            
            call MHFrameEvent_Register(EnterTrig, ItemButton[i], EVENT_ID_FRAME_MOUSE_ENTER)
            call MHFrameEvent_Register(LeaveTrig, ItemButton[i], EVENT_ID_FRAME_MOUSE_LEAVE)
            set i = i + 1
        endloop
    endfunction
    
endlibrary
