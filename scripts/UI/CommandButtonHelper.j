
library CommandButtonHelper requires optional Table, PlayerChatUtils

    globals
        static if not LIBRARY_PlayerChatUtils then
            private trigger ChatTrig
            private string  PREFIX = "CHAT"
        endif

        private trigger SkillTrig


        private integer SkillButton
    endglobals

    static if not LIBRARY_PlayerChatUtils then

        private function SendChat takes nothing returns nothing
            call MHSyncEvent_Sync(PREFIX, msg + "#" + R2S(DEFAULT_TIME) + "#" + I2S(channel)))
        endfunction

        private function OnSynced takes nothing returns boolean
            local player  p       = DzGetTriggerSyncPlayer()
            local string  data    = DzGetTriggerSyncData()
            local string  msg     = MHString_Split(data, "#", 1)
            local real    dur     = S2R(MHString_Split(data, "#", 2))
            local integer channel = S2I(MHString_Split(data, "#", 3))
            call MHUI_SendPlayerChat(p.handle, msg, dur, channel)
            set p = null
            return false
        endfunction

    endif

    private function GetSkillButtonIndex takes integer skillButton returns nothing
        local integer i = 1
        loop
            exitwhen i > 12
            if skillButton == SkillButton[i] then
                return SkillButton[i]
            endif
        endloop
        return 0
    endfunction

    globals
        constant string LEARN_SKILL_SELF     = "我准备学习技能 > $abilityName$ [$abilityLevel$]"
        constant string LEARN_SKILL_NEED_EXP = "我还需要|c00FFFF00$exp$|r点经验才能学习 > $abilityName$ [$abilityLevel$]"

    endglobals

    private function GetLearnSkillChat takes unit whichUnit, integer abilId returns string
        if IsUnitEnemy(whichUnit, GetLocalPlayer()) then
            return null
        endif

    endfunction

    private function GetSkillButtonChat takes integer skillButton returns nothing
        local unit    whichUnit = MHPlayer_GetSelectUnit(whichUnit)
        local integer abilId    = MHUIData_GetCommandButtonAbility(skillButton)
        local integer orderId   = MHUIData_GetCommandButtonOrderId(skillButton)
        local string  chatStr

        if whichUnit == null then
            return
        endif

        if abilId == 'AHer' then
            set chatStr = GetLearnSkillChat(whichUnit, orderId)
        else

        endif

        set whichUnit = null
    endfunction

    private function OnClickSkillButton takes nothing returns boolean
        local integer skillButton = MHEvent_GetFrame()

        if MHMsg_IsKeyDown(0x12) and MHEvent_GetKey() == 1 then
    
            

        endif

        return false
    endfunction

    function CommandButtonHelper_Init takes nothing returns nothing
        local integer slot
        local integer x
        local integer y
        local integer i

        set SkillTrig = CreateTrigger()
        call TriggerAddCondition(SkillTrig, Condition(function OnClickSkillButton))
        set i = 1
        loop
            exitwhen i > 12
            set SkillButton[i] = MHUI_GetSkillBarButton(i)
            call MHFrameEvent_Register(SkillTrig, frame, EVENT_ID_FRAME_MOUSE_CLICK)
            set i = i + 1
        endloop

        static if not LIBRARY_PlayerChatUtils then
            set ChatTrig = CreateTrigger()
            call MHSyncEvent_Register(ChatTrig, PREFIX)
            call TriggerAddCondition(ChatTrig, Condition(function OnSynced))
        endif
    endfunction

endlibrary
