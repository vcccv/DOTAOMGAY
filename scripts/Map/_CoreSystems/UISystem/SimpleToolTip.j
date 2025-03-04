
library SimpleToolTipLib
    
    struct SimpleToolTip extends array
        
        static Frame ToolTipFrame

        static Frame ToolTipNameString
        static Frame RequireToolTipString
        static Frame UberToolTipString

        static Frame HorizontalSeparatorTexture

        static Frame array CostTexture
        static Frame array CostString

        // 瞄准的UI
        static Frame FocusFrame
        //

        integer GoldCost
        integer LumberCost
        integer ManaCost
        real    Cooldown
        string  TipName
        string  RequireTip
        string  UberTip

        // 黄金 木材 食物
        // 魔法消耗 冷却时间
        private static method GetCooldown takes real cooldown returns string
            if R2I(cooldown) == cooldown then
                return I2S(R2I(cooldown))
            endif
            return R2SW(cooldown, 7, 2)
        endmethod

        // 更新工具提示
        static method Update takes nothing returns nothing
            local thistype this   = FocusFrame
            local boolean hasCost = GoldCost != 0 or LumberCost != 0 or ManaCost != 0 or Cooldown != 0. and StringLength(RequireTip) == 0
            local integer count   = 0
            local real    height  = 0.

            if StringLength(UberTip) > 0 then
                call UberToolTipString.SetVisible(true)
                call UberToolTipString.SetText(UberTip)

                set height = height + UberToolTipString.GetHeight()
                call HorizontalSeparatorTexture.ClearAllPoints()
                call HorizontalSeparatorTexture.SetPoint(FRAMEPOINT_CENTER, ToolTipFrame, FRAMEPOINT_BOTTOM, 0, 0.0025 + height)

                // ToolTip动态锚点修改
                call UberToolTipString.ClearAllPoints()
                if hasCost then
                    call UberToolTipString.SetPoint(FRAMEPOINT_TOPLEFT, CostTexture[1], FRAMEPOINT_BOTTOMLEFT, 0, - 0.015)
                elseif StringLength(RequireTip) > 0 then
                    call UberToolTipString.SetPoint(FRAMEPOINT_TOPLEFT, RequireToolTipString, FRAMEPOINT_BOTTOMLEFT, 0, - 0.015)
                else
                    call UberToolTipString.SetPoint(FRAMEPOINT_TOPLEFT, ToolTipNameString, FRAMEPOINT_BOTTOMLEFT, 0, - 0.015)
                endif
                set height = height + 0.010
            else
                call UberToolTipString.SetVisible(false)
            endif

            // 各种消耗
            if hasCost then
                set height = height + 0.013

                if GoldCost != 0 then
                    set count = count + 1
                    call CostTexture[count].SetTexture("UI\\Widgets\\ToolTips\\Human\\ToolTipGoldIcon.blp")
                    call CostString[count].SetText(I2S(GoldCost))
                    call CostTexture[count].SetVisible(true)
                    call CostString[count].SetVisible(true)
                endif

                if LumberCost != 0 then
                    set count = count + 1
                    call CostTexture[count].SetTexture("UI\\Widgets\\ToolTips\\Human\\ToolTipLumberIcon.blp")
                    call CostString[count].SetText(I2S(LumberCost))
                    call CostTexture[count].SetVisible(true)
                    call CostString[count].SetVisible(true)
                endif

                if ManaCost != 0 then
                    set count = count + 1
                    call CostTexture[count].SetTexture("UI\\Widgets\\ToolTips\\Human\\ToolTipManaIcon.blp")
                    call CostString[count].SetText(I2S(ManaCost))
                    call CostTexture[count].SetVisible(true)
                    call CostString[count].SetVisible(true)
                endif

                if Cooldown != 0 then
                    set count = count + 1
                    call CostTexture[count].SetTexture("UI\\Widgets\\ToolTips\\Human\\ToolTipCooldownIcon.blp")
                    call CostString[count].SetText(GetCooldown(Cooldown))
                    call CostTexture[count].SetVisible(true)
                    call CostString[count].SetVisible(true)
                endif
                call BJDebugMsg("count:" + I2S(count))
                loop
                    exitwhen count >= 4
                    set count = count + 1
                    call CostTexture[count].SetVisible(false)
                    call CostString[count].SetVisible(false)
                endloop
            endif

            // 需求提示
            if StringLength(RequireTip) > 0 then
                call RequireToolTipString.SetText(RequireTip)
                call RequireToolTipString.SetVisible(true)
                set height = height + RequireToolTipString.GetHeight() + 0.005
            else
                call RequireToolTipString.SetVisible(false)
            endif

            // 需求提示
            if StringLength(TipName) > 0 then
                call ToolTipNameString.SetText(TipName)
                call ToolTipNameString.SetVisible(true)
                set height = height + ToolTipNameString.GetHeight() + 0.005
            else
                call ToolTipNameString.SetVisible(false)
            endif

            call ToolTipFrame.SetHeight(height)
            call ToolTipFrame.SetVisible(true)
        endmethod

        private static method OnEnter takes nothing returns nothing
            set FocusFrame = Frame.GetTriggerFrame()
            call Update()
            call BJDebugMsg("FocusFrame!:" + I2S(FocusFrame))
        endmethod
        private static method OnLeave takes nothing returns nothing
            set FocusFrame = 0
            call ToolTipFrame.SetVisible(false)
        endmethod
        // 
        static method RegisterToolTip takes Frame frame returns thistype
            if frame == 0 then
                return 0
            endif
            call frame.RegisterEventByCode(EVENT_ID_FRAME_MOUSE_ENTER, function thistype.OnEnter, false)
            call frame.RegisterEventByCode(EVENT_ID_FRAME_MOUSE_LEAVE, function thistype.OnLeave, false)
            return frame
        endmethod

        static method CreateCostString takes nothing returns Frame
            local Frame frame = ToolTipFrame.CreateSimpleFontString()
            call frame.SetFont("Fonts\\dfst-m3u.ttf", 0.011, 0)
            call frame.SetTextColor(0xFFFED312)
            call frame.SetTextAlignment(TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_LEFT)
            return frame
        endmethod
        
        static method CreateCostTexture takes nothing returns Frame
            local Frame frame = ToolTipFrame.CreateSimpleTexture()
            call frame.SetSize(0.009375, 0.009375)
            return frame
        endmethod

        static method Init takes nothing returns nothing
            local Frame parent       = Frame.GetPtrInstance(MHUI_GetConsoleUI())

            set ToolTipFrame         = parent.CreateFrameByType("SIMPLEFRAME", "", "", 0, 0)
            call ToolTipFrame.ClearAllPoints()
            call ToolTipFrame.SetSize(0.220, 0.094)
            call ToolTipFrame.SetPoint(FRAMEPOINT_BOTTOMRIGHT, parent, FRAMEPOINT_BOTTOMRIGHT, 0, 0.1625)

            set ToolTipNameString    = ToolTipFrame.CreateSimpleFontString()
            call ToolTipNameString.SetWidth(0.210)
            call ToolTipNameString.SetFont("Fonts\\dfst-m3u.ttf", 0.011, 0)
            call ToolTipNameString.SetTextAlignment(TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
            call ToolTipNameString.SetPoint(FRAMEPOINT_TOPLEFT, ToolTipFrame, FRAMEPOINT_TOPLEFT, 0.005, - 0.005)

            set RequireToolTipString = ToolTipFrame.CreateSimpleFontString()
            call RequireToolTipString.SetWidth(0.210)
            call RequireToolTipString.SetFont("Fonts\\dfst-m3u.ttf", 0.011, 0)
            call RequireToolTipString.SetTextAlignment(TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
            call RequireToolTipString.SetPoint(FRAMEPOINT_TOPLEFT, ToolTipNameString, FRAMEPOINT_BOTTOMLEFT, 0, - 0.005)

            set UberToolTipString    = ToolTipFrame.CreateSimpleFontString()
            call UberToolTipString.SetWidth(0.210)
            call UberToolTipString.SetFont("Fonts\\dfst-m3u.ttf", 0.011, 0)
            call UberToolTipString.SetTextAlignment(TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)

            set HorizontalSeparatorTexture = ToolTipFrame.CreateSimpleTexture()
            call HorizontalSeparatorTexture.SetSize(0.200, 0.0005)
            call HorizontalSeparatorTexture.SetTexture("UI\\Widgets\\ToolTips\\Human\\HorizontalSeparator.blp")

            set CostTexture[1] = CreateCostTexture()
            set CostString [1] = CreateCostString()
            set CostTexture[2] = CreateCostTexture()
            set CostString [2] = CreateCostString()
            set CostTexture[3] = CreateCostTexture()
            set CostString [3] = CreateCostString()
            set CostTexture[4] = CreateCostTexture()
            set CostString [4] = CreateCostString()

            call ToolTipNameString.SetText("tooltip missing!")
            call RequireToolTipString.SetText("tooltip missing!")
            call UberToolTipString.SetText("tooltip missing!")
            
            call CostTexture[1].SetPoint(FRAMEPOINT_TOPLEFT, ToolTipNameString, FRAMEPOINT_BOTTOMLEFT, 0., - 0.004)
            call CostString [1].SetPoint(FRAMEPOINT_LEFT, CostTexture[1], FRAMEPOINT_RIGHT, 0.003125, 0.)

            call CostTexture[2].SetPoint(FRAMEPOINT_LEFT, CostString[1] , FRAMEPOINT_RIGHT, 0.00625, 0.)
            call CostString [2].SetPoint(FRAMEPOINT_LEFT, CostTexture[2], FRAMEPOINT_RIGHT, 0.003125, 0.)

            call CostTexture[3].SetPoint(FRAMEPOINT_LEFT, CostString[2] , FRAMEPOINT_RIGHT, 0.00625, 0.)
            call CostString [3].SetPoint(FRAMEPOINT_LEFT, CostTexture[3], FRAMEPOINT_RIGHT, 0.003125, 0.)

            call CostTexture[4].SetPoint(FRAMEPOINT_LEFT, CostString[3] , FRAMEPOINT_RIGHT, 0.00625, 0.)
            call CostString [4].SetPoint(FRAMEPOINT_LEFT, CostTexture[4], FRAMEPOINT_RIGHT, 0.003125, 0.)

            call ToolTipFrame.SetVisible(false)
        endmethod

    endstruct

endlibrary
