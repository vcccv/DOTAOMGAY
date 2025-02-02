
#include "UIBase.j"
#include "HotkeySystem.j"

#include "MenuOption\MenuOptionPanel.j"
#include "CommandButtonHelper.j"
#include "HardwareMessage.j"
scope MainUI

    globals
        //======================================================================
        // 菜单设置的UI
        integer EscMenuMapSetupBackdrop
        integer OriginFrame_MainPanel //主菜单
        integer OriginFrame_MainPanel_ReturnButton //主菜单返回按钮
        // 地图设置框架
        integer EscMenuMapOptionsPanel
        // 命令设置框架
        integer UIFrame__OrderSetup
        integer GameUI // 等价于DzGetGameUI()
        boolean IsSetupUIEnable = false
        //复选框长宽初始值
        constant real CheckBox_WidthInitialValue = 0.150
        constant real CheckBox_HeightInitialValue = 0.490
        //复选框长宽间值
        constant real CheckBox_WidthSpacing = 0.115
        constant real CheckBox_HeightSpacing = 0.024
        //服务器值
        string ServerValue = ""
        //各种选项的布尔值
        boolean IsTabEnableMultiboard = false //Tab键是否启用多面板,异步
    endglobals
    
    function Click_LifeManaButton takes nothing returns nothing
        local unit u = GetPlayerSelectedUnit()
        local integer i = LocalPlayerId
        local player p
        if DzIsKeyDown(18) then
            if u != null and GetUnitAbilityLevel(u, 'AHer') > 0 then
                if IsUnitAlly(u, LocalPlayer) and IsUnitType(u, UNIT_TYPE_HERO) then
                    if GetChat_times() then
                        if u == PlayerHeroes[i] then 
                            call DzSyncData("t", "我拥有" + UnitLP(u, true)+ UnitMP(u))
                        else
                            set p = GetOwningPlayer(u)
                            call DzSyncData("t", "队友 " + PlayersColoerText[GetPlayerId(p)] + GetPlayerName(p) + "|r拥有" + UnitLP(u, true)+ UnitMP(u))
                            set p = null
                        endif
                    endif
                else
                    if GetChat_times() then
                        // 如果是敌人 则要发送信号 所以直接同步单位
                        call DzSyncData("p", I2S(GetHandleId(u)))
                    endif
                endif
            endif
        endif
        set u = null
    endfunction


    function Click_Key_S takes nothing returns nothing
        if IsSetupUIEnable then
            call DzClickFrame(UIFrame__Button[1])
        endif
    endfunction

    function Click_Key_R takes nothing returns nothing
        if IsSetupUIEnable then
            call DzClickFrame(UIFrame__Button[2])
        endif
    endfunction


    function CreateTopMsgFrame takes nothing returns nothing
        local integer i = 1
        local integer TopMessage = DzFrameGetTopMessage()

        loop
            set UIFrame__Text[i] = DzCreateFrameByTagName("TEXT", "TopMsg"+I2S(i), GameUI, "TopMessageTextTemplate", 0)
            call DzFrameSetPoint(UIFrame__Text[i], 1, TopMessage, 1, 0, -0.0054 + -0.0166 * i)
            call DzFrameShow(UIFrame__Text[i], false)
            exitwhen i == 6
            set i = i + 1
        endloop
    endfunction

    function UIMain_Init takes nothing returns nothing
        local integer i
        local integer x
        local integer y
        local integer frame
        call DzLoadToc("UI\\path.toc")
        set GameUI        = DzGetGameUI()
        set PortraitFrame = DzFrameGetPortrait()
        set IsReplayMode  = DzSimpleFrameFindByName("SimpleReplayPanel", 0) != 0
        //======================================================================
        // 防御符文按钮
        set GlyphFrame = DzCreateFrameByTagName("TEXTBUTTON", "name", GameUI, "Glyph_Button", 0)
        call DzFrameSetPoint(GlyphFrame, 4, DzFrameGetMinimap(), 4, 0.087, -0.061)
        //// 按钮提示
        call SetFrameToolTip(GlyphFrame, "激活 防御符文(|cffffcc00Alt-J|r)", "在5秒内，使你方阵营所有的建筑物对物理攻击免疫。|n|n|cff99ccff团队冷却时间：|r5分钟")
        //======================================================================
        // 创建顶部消息栏 击杀信息
        call CreateTopMsgFrame()
        //======================================================================
        // 创建底部信息提示栏 错误提示

        //======================================================================
        // 更新日志
        set UIFrame__UpdateLog = DzCreateFrame("UpdateLogDialog" , GameUI, 0)
        call DzFrameSetAbsolutePoint(UIFrame__UpdateLog, 4, 0.4, 0.35)
        call DzFrameSetText(DzFrameFindByName("UpdateLogArea", 0), UpdateLogStr)
        set UIButton__UpdateLogOK = DzFrameFindByName("UpdateLogOkButton", 0)
        call DzFrameSetScriptByCode(UIButton__UpdateLogOK, 1, function Click_OKButton_Script, false)
        call DzFrameShow(UIFrame__UpdateLog, false)
        //======================================================================
        call MenuOptionPanel_Init()
        //======================================================================
        // 工具提示
        set UIFrame__ToolTip    = DzCreateFrameByTagName("FRAME"   , null, GameUI             , null             , 0)
        set UIBackDrop__ToolTip = DzCreateFrameByTagName("BACKDROP", null, UIFrame__ToolTip   , "TooltipBackDrop", 0)
        set UIText__ToolTip     = DzCreateFrameByTagName("TEXT"    , null, UIBackDrop__ToolTip, "TooltipText"    , 0)
        set UIText__ToolUberTip = DzCreateFrameByTagName("TEXT"    , null, UIBackDrop__ToolTip, "TooltipText"    , 0)
        //call DzFrameSetSize(UIBackDrop__ToolTip, 0.209, 0)
        call DzFrameSetSize(UIText__ToolTip, 0.209, 0)
        call DzFrameSetSize(UIText__ToolUberTip, 0.209, 0)
        // 设置"提示背景"的左上为"提示"的左上
        call DzFrameSetPoint(UIBackDrop__ToolTip, FRAMEPOINT_TOPLEFT, UIText__ToolTip, FRAMEPOINT_TOPLEFT, - 0.005, 0.005)
        // 设置"提示"的底部为"扩展提示"的顶部
        call DzFrameSetPoint(UIText__ToolTip, FRAMEPOINT_BOTTOMLEFT, UIText__ToolUberTip, FRAMEPOINT_TOPLEFT, 0, 0.005)
        // 设置"提示背景"的右下为"扩展提示"的右下
        call DzFrameSetPoint(UIBackDrop__ToolTip, FRAMEPOINT_BOTTOMRIGHT, UIText__ToolUberTip, FRAMEPOINT_BOTTOMRIGHT, 0.005, - 0.005)
        call DzFrameSetAbsolutePoint(UIText__ToolUberTip, FRAMEPOINT_BOTTOMRIGHT, 0.7935, 0.168)

        call DzFrameShow(UIFrame__ToolTip, false)
        call DzFrameSetPriority(UIFrame__ToolTip, 3)
        //======================================================================
        // 捕捉点击血条的按钮
        call DzCreateSimpleFrame("StateButtonFrame", DzSimpleFrameFindByName("ConsoleUI", 0), 0)
        set UIFrame__Button[3] = DzSimpleFrameFindByName("StateButton", 0)
        call DzFrameSetAbsolutePoint(UIFrame__Button[3], 0, 0.214, 0.03)
        call DzFrameSetAbsolutePoint(UIFrame__Button[3], 8, 0.292, 0.002)
        call DzFrameSetScriptByCode(UIFrame__Button[3], 1, function Click_LifeManaButton, false)
        //======================================================================
        call MenuOptionCheckBox_Init()
        //======================================================================

        // 和谐资源栏
        if not IsSinglePlayerMode then
            set i = 0
            loop
                exitwhen i > 11
                call DzFrameShow(DzFrameFindByName("GoldBackdrop", i)  , false)
                call DzFrameShow(DzFrameFindByName("LumberBackdrop", i), false)
                set i = i + 1
            endloop
            call DzFrameShow(DzFrameFindByName("ResourceTradingTitle", 0), false)
            call DzFrameShow(DzFrameFindByName("GoldHeader"          , 0), false)
            call DzFrameShow(DzFrameFindByName("LumberHeader"        , 0), false)
        endif
        
        set i = 0
        loop
            set LocalCommandX[i] = ModuloInteger(i, 4)
            set LocalCommandY[i] = i / 4
            exitwhen i == 11
            set i = i + 1
        endloop

        //// 点击防御符文按钮
        call DzFrameSetScriptByCode(GlyphFrame, 1, function Click_UI_Glyph, false)
        // 注册一些异步事件
        //======================================================================
        // 读取服务器存档
        call GetLocalPlayerSetup()
        //======================================================================
       

        // 点击英雄图标按钮
        call DzFrameSetScriptByCode(DzFrameGetHeroBarButton(0), 1, function Click_UI_HeroBarButton, false)


        // 界面更新回调
        call DzFrameSetUpdateCallbackByCode(function OnUpdate)

        call HardwareMessage_Init222()
        call CommandButtonHelper_Init()

        if IsObserverPlayer(LocalPlayer) then
            call DzFrameSetEnable(GlyphFrame, false)
            call DzFrameSetEnable(UIFrame__Button[0], false)
        endif
        set FirstCommandBarButton = DzFrameGetCommandBarButton(0, 0)
        set ButtonInterval 		  = DzFrameGetCommandBarButton(1, 0) - FirstCommandBarButton

        //call DisplayTimedTextToPlayer(LocalPlayer, .0, .0, DisplayTextDuration[LocalPlayerId], "插件版本:" + MHGame_GetPluginVersion())
    endfunction

endscope
