/* 
BlzGetTriggerFrameValue 无法使用
需要手动转换GetHandleId(frame) 为 GetFrameId(frame) 还有例如set frame = null要变成set frame = 0
ORIGIN_FRAME_TOOLTIP未知

FRAMEEVENT缺失3个事件：
constant integer FRAMEEVENT_DIALOG_CANCEL = ConvertFrameEventType(14)
constant integer FRAMEEVENT_DIALOG_ACCEPT = ConvertFrameEventType(15)
constant integer FRAMEEVENT_EDITBOX_ENTER = ConvertFrameEventType(16)

GetTriggerPlayer 需要转换为BlzGetTriggerPlayer 
考虑可能加个define 
if GetTriggerPlayer() != null then
    return GetTriggerPlayer()
endif
return BlzGetTriggerPlayer()
?
*/

library FrameSystem

    globals

	    // 框架相对锚点(UI) 左上
        constant integer FRAMEPOINT_TOPLEFT = (0)
        // 框架相对锚点(UI) 上
        constant integer FRAMEPOINT_TOP = (1)
        // 框架相对锚点(UI) 右上
        constant integer FRAMEPOINT_TOPRIGHT = (2)
        // 框架相对锚点(UI) 左
        constant integer FRAMEPOINT_LEFT = (3)
        // 框架相对锚点(UI) 中
        constant integer FRAMEPOINT_CENTER = (4)
        // 框架相对锚点(UI) 右
        constant integer FRAMEPOINT_RIGHT = (5)
        // 框架相对锚点(UI) 左下
        constant integer FRAMEPOINT_BOTTOMLEFT = (6)
        // 框架相对锚点(UI) 下
        constant integer FRAMEPOINT_BOTTOM = (7)
        // 框架相对锚点(UI) 右下
        constant integer FRAMEPOINT_BOTTOMRIGHT = (8)
        
	    // 文本对齐方式 顶部对齐
        constant integer TEXT_JUSTIFY_TOP = (0)
        // 文本对齐方式 纵向居中
        constant integer TEXT_JUSTIFY_MIDDLE = (1)
        // 文本对齐方式 底部对齐
        constant integer TEXT_JUSTIFY_BOTTOM = (2)
        // 文本对齐方式 左侧对齐
        constant integer TEXT_JUSTIFY_LEFT = (3)
        // 文本对齐方式 横向居中
        constant integer TEXT_JUSTIFY_CENTER = (4)
        // 文本对齐方式 右侧对齐
        constant integer TEXT_JUSTIFY_RIGHT = (5)

        // 原生UI 游戏UI(必要，没有它，什么都不显示)
        constant integer ORIGIN_FRAME_GAME_UI = (0)
        // 原生UI 技能按钮(含移动/停止/巡逻/攻击，共12格)
        // 每次选择单位时它会重新出现/更新
        constant integer ORIGIN_FRAME_COMMAND_BUTTON = (1)
        // 原生UI 英雄栏(F1、F2按钮对应的英雄头像所在区域)
        // 所有 HERO_BUTTONS 的父类，由 HeroButtons 控制可见性
        constant integer ORIGIN_FRAME_HERO_BAR = (2)
        // 原生UI 英雄头像(F1、F2...屏幕左侧的自己/共享控制盟友的英雄头像按钮)
        constant integer ORIGIN_FRAME_HERO_BUTTON = (3)
        // 原生UI 英雄头像下的血量条，与 HeroButtons 关联
        constant integer ORIGIN_FRAME_HERO_HP_BAR = (4)
        // 原生UI 英雄头像下的魔法条，与 HeroButtons 关联
        constant integer ORIGIN_FRAME_HERO_MANA_BAR = (5)
        // 原生UI 英雄获得新技能点时，英雄按钮发出的光
        // 与 HeroButtons 关联。当英雄新技能点时，即使所有原生UI都被隐藏，闪光也会出现
        constant integer ORIGIN_FRAME_HERO_BUTTON_INDICATOR = (6)
        // 原生UI 物品栏格按钮(共6格)
        // 当其父级可见时，每次选择物品时它会重新出现/更新
        constant integer ORIGIN_FRAME_ITEM_BUTTON = (7)
        // 原生UI 小地图
        // 使用该类型并不能直接兼容1.36新观战者模式带来的小地图位置变化(使控件位置自动随小地图位置变化)
        constant integer ORIGIN_FRAME_MINIMAP = (8)
        // 原生UI 小地图按钮
        // 0是顶部按钮，到底部的共4个按钮(发送信号、显示/隐藏地形、切换敌友/玩家颜色、显示中立敌对单位营地、编队方式)
        constant integer ORIGIN_FRAME_MINIMAP_BUTTON = (9)
        // 原生UI 系统按钮
        // 菜单，盟友，日志/聊天，任务
        constant integer ORIGIN_FRAME_SYSTEM_BUTTON = (10)
        // 原生UI 提示工具
        constant integer ORIGIN_FRAME_TOOLTIP = (11)
        // 原生UI 扩展提示工具
        constant integer ORIGIN_FRAME_UBERTOOLTIP = (12)
        // 原生UI 聊天信息显示框(玩家聊天信息)
        constant integer ORIGIN_FRAME_CHAT_MSG = (13)
        // 原生UI 单位信息显示框
        constant integer ORIGIN_FRAME_UNIT_MSG = (14)
        // 原生UI 顶部信息显示框(持续显示的变更警告消息，显示在昼夜时钟下方)
        constant integer ORIGIN_FRAME_TOP_MSG = (15)
        // 原生UI 头像(主选单位的模型视图)
        // 模型肖像区域，攻击力左边，看到单位头和嘴巴那块区域，其使用了特殊的协调系统,0在左下角绝对位置，这使得它很难与其他框架一起使用(不像其他4:3)
        constant integer ORIGIN_FRAME_PORTRAIT = (16)
        // 原生UI 世界UI
        // 游戏区域、单位、物品、特效、雾...游戏每个对象都显示在这
        constant integer ORIGIN_FRAME_WORLD_FRAME = (17)
        // 原生UI 简易UI(父级)
        constant integer ORIGIN_FRAME_SIMPLE_UI_PARENT = (18)
        // 原生UI 头像(主选单位的模型视图)(ORIGIN_FRAME_PORTRAIT)下方的生命值文字
        constant integer ORIGIN_FRAME_PORTRAIT_HP_TEXT = (19)
        // 原生UI 头像(主选单位的模型视图)(ORIGIN_FRAME_PORTRAIT)下方的魔法值文字
        constant integer ORIGIN_FRAME_PORTRAIT_MANA_TEXT = (20)
        // 原生UI 魔法效果(BUFF)状态栏(单位当前拥有光环的显示区域)，尺寸固定，最多显示8个BUFF
        constant integer ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR = (21)
        // 原生UI 魔法效果(BUFF)状态栏标题(单位当前拥有光环的显示区域的标题)，默认文本是 Status:(状态：)
        constant integer ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR_LABEL = (22)

        constant integer FRAMEEVENT_CONTROL_CLICK          = 1
        constant integer FRAMEEVENT_MOUSE_ENTER            = 2
        constant integer FRAMEEVENT_MOUSE_LEAVE            = 3
        constant integer FRAMEEVENT_MOUSE_UP               = 4
        constant integer FRAMEEVENT_MOUSE_DOWN             = 5
        constant integer FRAMEEVENT_MOUSE_WHEEL            = 6
        constant integer FRAMEEVENT_CHECKBOX_CHECKED       = 7
        constant integer FRAMEEVENT_CHECKBOX_UNCHECKED     = 8
        constant integer FRAMEEVENT_EDITBOX_TEXT_CHANGED   = 9
        constant integer FRAMEEVENT_POPUPMENU_ITEM_CHANGED = 10
        constant integer FRAMEEVENT_MOUSE_DOUBLECLICK      = 11
        constant integer FRAMEEVENT_SPRITE_ANIM_UPDATE     = 12
        constant integer FRAMEEVENT_SLIDER_VALUE_CHANGED   = 13

        private hashtable         HT                      = InitHashtable()
        private string            FRAME_EVENT_SYNC_PREFIX = "FRAMEEVENT"
        private integer           FrameEventStackTop      = 0
        private Frame       array TriggerFrame
        private integer     array TriggerEvent
        private player      array TriggerPlayer

        private key               FRAME_NAME_CREATE_CONTEXT
    endglobals

    struct Frame
        
        private integer ptr
    
        static method create takes integer ptr returns thistype
            local thistype this 

            if ptr == 0 then
                debug call BJDebugMsg("Frame.create() ptr == 0")
                return 0
            endif
            
            set this = thistype.allocate()
            set this.ptr = ptr
            call SaveInteger(HT, ptr, 0, this)

            return this
        endmethod

        static method CreateNullInstance takes nothing returns thistype
            local thistype this 

            set this = thistype.allocate()

            return this
        endmethod

        method SetPtr takes integer ptr returns nothing
            if this == 0 or ptr == 0 then
                return
            endif
            
            set this.ptr = ptr
            call SaveInteger(HT, ptr, 0, this)
        endmethod

        method GetPtr takes nothing returns integer
            return this.ptr
        endmethod

        static method GetPtrToInstance takes integer ptr returns thistype
            local thistype this = LoadInteger(HT, ptr, 0)

            if this == 0 and ptr != 0 then
                set this = thistype.create(ptr)
            endif

            return this
        endmethod

        // 如果是没有被创建过实例的frame，则返回0，在异步情况下没有把握就用这个
        static method GetPtrToInstanceSafe takes integer ptr returns thistype
            return LoadInteger(HT, ptr, 0)
        endmethod

        method CreateFrame takes string name, integer priority, integer createContext returns thistype
            local thistype newFrame

            if this.ptr != 0 then
                set newFrame = thistype.create(MHFrame_Create(name, this.ptr, priority, createContext))
            else
                debug call BJDebugMsg("CreateFrame() error \nname:" + name)
                return 0
            endif
    
            return newFrame
        endmethod

        method CreateSimpleFrame takes string name, integer createContext returns thistype
            local thistype newFrame

            if this.ptr != 0 then
                //set newFrame = thistype.create(DzCreateSimpleFrame(name, this.ptr, createContext))
                set newFrame = thistype.create(DzCreateSimpleFrame(name, this.ptr, createContext))
            else
                debug call BJDebugMsg("CreateSimpleFrame() error")
                return 0
            endif

            return newFrame
        endmethod

        method CreateFrameByType takes string typeName, string name, string inherits, integer createContext returns thistype
            local thistype newFrame

            if this.ptr != 0 then
                //set this = thistype.create(MHFrame_CreateEx(typeName, name, inherits, owner.ptr, 0, createContext))
                set newFrame = thistype.create(DzCreateFrameByTagName(typeName, name, this.ptr, inherits, createContext))
            else
                debug call BJDebugMsg("CreateFrameByType() error \ntypeName: " + typeName + "\nname:" + name + "\ninherits:" + inherits + "\nowner:" + I2S(this))
                return 0
            endif
    
            return newFrame
        endmethod

        method onDestroy takes nothing returns nothing
            call MHFrame_Destroy(this.ptr)
            call RemoveSavedInteger(HT, this.ptr, 0)
            call FlushChildHashtable(HT, this)
            set this.ptr = 0
        endmethod

        method destroy takes nothing returns nothing
            call this.deallocate()
        endmethod

        method SetPoint takes integer point, Frame relative, integer relativePoint, real x, real y returns nothing
            if this.ptr == 0 or relative.ptr == 0 then
                return
            endif
            
            call MHFrame_SetRelativePoint(this.ptr, point, relative.ptr, relativePoint, x, y)
            //call DzFrameSetPoint(this.ptr, point, relative.ptr, relativePoint, x, y)
        endmethod

        method SetAbsPoint takes integer point, real x, real y returns nothing
            if this.ptr == 0 then
                return
            endif
            
            call MHFrame_SetAbsolutePoint(this.ptr, point, x, y)
            //call DzFrameSetAbsolutePoint(this.ptr, point, x, y)
        endmethod

        method ClearAllPoints takes nothing returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_ClearAllPoints(this.ptr)
            //call DzFrameClearAllPoints(this.ptr)
        endmethod

        method SetAllPoints takes Frame relative returns nothing
            if this.ptr == 0 or relative.ptr == 0 then
                return
            endif

            call MHFrame_SetAllPoints(this.ptr, relative.ptr)
            //call DzFrameSetAllPoints(this.ptr, relative.ptr)
        endmethod

        method SetVisible takes boolean visible returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_Hide(this.ptr, not visible)
        endmethod

        method IsVisible takes nothing returns boolean
            if this.ptr == 0 then
                return false
            endif

            return not MHFrame_IsHidden(this.ptr)
        endmethod

        static method GetFrameByName takes string name, integer createContext returns thistype
            return thistype.GetPtrToInstance(MHFrame_GetByName(name, createContext))
        endmethod

        method GetName takes nothing returns string
            if this.ptr == 0 then
                return null
            endif

            return MHFrame_GetName(this.ptr)
        endmethod

        method Click takes nothing returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_Click(this.ptr)
        endmethod

        method SetText takes string text returns nothing
            if this.ptr == 0 then
                return
            endif

            //call MHFrame_SetText(this.ptr, text)
            call DzFrameSetText(this.ptr, text)
        endmethod

        method GetText takes nothing returns string
            if this.ptr == 0 then
                return null
            endif
            
            return MHFrame_GetText(this.ptr)
        endmethod

        method AddText takes string text returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_AddTextAreaText(this.ptr, text)
        endmethod

        method SetTextSizeLimit takes integer size returns nothing
            if this.ptr == 0 then
                return
            endif

            call DzFrameSetTextSizeLimit(this.ptr, size)
        endmethod

        method GetTextSizeLimit takes nothing returns integer
            if this.ptr == 0 then
                return 0
            endif

            return DzFrameGetTextSizeLimit(this.ptr)
        endmethod

        method SetTextColor takes integer color returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetColor(this.ptr, color)
        endmethod

        method SetFocus takes boolean flag returns nothing
            if this.ptr == 0 then
                return
            endif

            call DzFrameSetFocus(this.ptr, flag)
        endmethod

        method SetModel takes string modelFile, integer cameraIndex returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetModel(this.ptr, modelFile, cameraIndex, 0)
        endmethod

        method SetEnable takes boolean enabled returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_Disable(this.ptr, not enabled)
        endmethod

        method GetEnable takes nothing returns boolean
            if this.ptr == 0 then
                return false
            endif

            return DzFrameGetEnable(this.ptr)
        endmethod

        private boolean disableState
        method IsEnabledEx takes nothing returns boolean
            return not this.disableState
        endmethod
        method SetEnableEx takes boolean flag returns nothing
            set this.disableState = not flag
        endmethod

        Frame pushedOffsetFrame
        method IsPushedOffset takes nothing returns boolean
            return this.pushedOffsetFrame != 0
        endmethod
        method SetPushedOffset takes thistype frame returns nothing
            set this.pushedOffsetFrame = frame
        endmethod
        method GetPushedOffsetFrame takes nothing returns thistype
            return this.pushedOffsetFrame
        endmethod

        method SetAlpha takes integer alpha returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetAlpha(this.ptr, alpha)
        endmethod

        method GetAlpha takes nothing returns integer
            if this.ptr == 0 then
                return 0
            endif

            return DzFrameGetAlpha(this.ptr)
        endmethod

        method SetSpriteAnimate takes integer primaryProp, integer flags returns nothing
            if this.ptr == 0 then
                return
            endif

            call DzFrameSetAnimate(this.ptr, primaryProp, flags == 1)
        endmethod

        method SetAnimateOffset takes real offset returns nothing
            if this.ptr == 0 then
                return
            endif

            call DzFrameSetAnimateOffset(this.ptr, offset)
        endmethod

        method SetTexture takes string texFile, integer flag, boolean blend returns nothing
            if this.ptr == 0 then
                return
            endif

            set texFile = MHString_Replace(texFile, "/", "\\")
            if MHString_Find(texFile, ".blp", 0) == - 1 then
                set texFile = texFile + ".blp"
            endif

            call MHFrame_SetTexture(this.ptr, texFile, flag != 0)
        endmethod

        method SetScale takes real scale returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetScale(this.ptr, scale)
        endmethod

        method SetSpriteScale takes real scale returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetSpriteScale(this.ptr, scale)
        endmethod

        method CageMouse takes boolean enable returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_CageMouse(this.ptr, enable)
        endmethod

        method SetValue takes real value returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetValue(this.ptr, value)
        endmethod

        method GetValue takes nothing returns real
            if this.ptr == 0 then
                return 0.
            endif

            return MHFrame_GetValue(this.ptr)
        endmethod

        method SetMinMaxValue takes real minValue, real maxValue returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetLimit(this.ptr, maxValue, minValue)
        endmethod
        
        method SetStepSize takes real stepSize returns nothing
            if this.ptr == 0 then
                return
            endif

            call DzFrameSetStepValue(this.ptr, stepSize)
        endmethod

        method SetSize takes real width, real height returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetSize(this.ptr, width, height)
            //call DzFrameSetSize(this.ptr, width, height)
        endmethod

        method SetVertexColor takes integer color returns nothing
            if this.ptr == 0 then
                return
            endif

            call DzFrameSetVertexColor(this.ptr, color)
        endmethod

        method SetLevel takes integer level returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetPriority(this.ptr, level)
        endmethod

        method SetParent takes Frame parent returns nothing
            if this.ptr == 0 or parent.ptr == 0 then
                return
            endif

            call MHFrame_SetParent(this.ptr, parent.ptr)
        endmethod

        method GetParent takes nothing returns thistype
            if this.ptr == 0 then
                return 0
            endif

            return thistype.GetPtrToInstance(MHFrame_GetParent(this.ptr))
        endmethod

        method GetHeight takes nothing returns real
            if this.ptr == 0 then
                return 0.
            endif

            return MHFrame_GetHeight(this.ptr)
        endmethod

        method GetWidth takes nothing returns real
            if this.ptr == 0 then
                return 0.
            endif

            return MHFrame_GetWidth(this.ptr)
        endmethod

        method SetFont takes string fileName, real height, integer flags returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetFont(this.ptr, fileName, height, flags)
        endmethod

        method SetTextAlignment takes integer vert, integer horz returns nothing
            local integer align = 0
            if vert == TEXT_JUSTIFY_TOP then
                set align = 1
            elseif vert == TEXT_JUSTIFY_MIDDLE then
                set align = 2
            elseif vert == TEXT_JUSTIFY_BOTTOM then
                set align = 4
            endif
            if horz == TEXT_JUSTIFY_LEFT then
                set align = align + 8
            elseif horz == TEXT_JUSTIFY_CENTER then
                set align = align + 16
            elseif horz == TEXT_JUSTIFY_RIGHT then
                set align = align + 32
            endif
            if this.ptr == 0 then
                return
            endif

            call DzFrameSetTextAlignment(this.ptr, align)
            //call MHFrame_SetTextAlign(this.ptr, vert, horz)
        endmethod

        method GetChildrenCount takes nothing returns integer
            if this.ptr == 0 then
                return 0
            endif

            return MHFrame_GetChildCount(this.ptr)
        endmethod

        method GetChild takes integer index returns thistype
            if this.ptr == 0 then
                return 0
            endif

            return thistype.GetPtrToInstanceSafe(MHFrame_GetChild(this.ptr, index))
        endmethod

        static method GetUnderCursor takes nothing returns thistype
            return thistype.GetPtrToInstanceSafe(MHFrame_GetUnderCursor())
        endmethod

        static method GetTriggerFrame takes nothing returns thistype
            return TriggerFrame[FrameEventStackTop] 
        endmethod

        static method GetTriggerPlayer takes nothing returns player
            return TriggerPlayer[FrameEventStackTop]
        endmethod

        static method GetTriggerFrameEvent takes nothing returns integer
            return TriggerEvent[FrameEventStackTop] 
        endmethod

        //! textmacro MethodEventSetCallBack takes EventName
            private string $EventName$CodeName
            static method $EventName$CallBack takes nothing returns nothing
                local thistype this = thistype.GetPtrToInstanceSafe(DzGetTriggerUIEventFrame())
                
                if this == 0 then
                    return
                endif

                if $EventName$CodeName != null then
                    set FrameEventStackTop = FrameEventStackTop + 1
                    set TriggerFrame[FrameEventStackTop]  = this
                    set TriggerEvent[FrameEventStackTop]  = $EventName$
                    set TriggerPlayer[FrameEventStackTop] = GetLocalPlayer()
                    if MHGame_ExecuteCode(MHGame_GetCode(($EventName$CodeName))) == 0 then
                        set TriggerFrame[FrameEventStackTop]  = 0
                        set TriggerEvent[FrameEventStackTop]  = 0
                        set TriggerPlayer[FrameEventStackTop] = null
                        set FrameEventStackTop = FrameEventStackTop - 1
                        return
                    endif
                    set TriggerFrame[FrameEventStackTop]  = 0
                    set TriggerEvent[FrameEventStackTop]  = 0
                    set TriggerPlayer[FrameEventStackTop] = null
                    set FrameEventStackTop = FrameEventStackTop - 1
                endif

                if not HaveSavedString(HT, this, $EventName$) then
                    return
                endif

                call DzSyncData(FRAME_EVENT_SYNC_PREFIX, I2S($EventName$) + "," + I2S(this))
            endmethod
        //! endtextmacro

        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_CONTROL_CLICK")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_MOUSE_ENTER")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_MOUSE_LEAVE")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_MOUSE_UP")  
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_MOUSE_DOWN")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_MOUSE_WHEEL")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_CHECKBOX_CHECKED")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_CHECKBOX_UNCHECKED")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_EDITBOX_TEXT_CHANGED")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_POPUPMENU_ITEM_CHANGED")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_MOUSE_DOUBLECLICK")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_SPRITE_ANIM_UPDATE")
        //! runtextmacro MethodEventSetCallBack("FRAMEEVENT_SLIDER_VALUE_CHANGED")

        //! textmacro RegisterEventSetCallBack takes EventName
            if eventId == $EventName$ then
                call DzFrameSetScriptByCode(this.ptr, eventId, function thistype.$EventName$CallBack, false)
            endif
        //! endtextmacro

        //! textmacro RegisterEventSetCode takes EventName
            if eventId == $EventName$ then
                set $EventName$CodeName = codeName
                call DzFrameSetScriptByCode(this.ptr, eventId, function thistype.$EventName$CallBack, false)
            endif
        //! endtextmacro
        
        // Frame事件，同步的函数
        method RegisterEvent takes integer eventId, string codeName returns nothing
            if this.ptr == 0 or codeName == null then
                return
            endif

            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_CONTROL_CLICK")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_MOUSE_ENTER")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_MOUSE_LEAVE")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_MOUSE_UP")  
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_MOUSE_DOWN")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_MOUSE_WHEEL")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_CHECKBOX_CHECKED")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_CHECKBOX_UNCHECKED")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_EDITBOX_TEXT_CHANGED")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_POPUPMENU_ITEM_CHANGED")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_MOUSE_DOUBLECLICK")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_SPRITE_ANIM_UPDATE")
            //! runtextmacro RegisterEventSetCallBack("FRAMEEVENT_SLIDER_VALUE_CHANGED")
            call SaveStr(HT, this, eventId, codeName)
        endmethod

        // 异步 返回值代表是否会继续同步操作 true会继续同步 false则不发送同步内容
        method RegisterLocalScript takes integer eventId, string codeName returns nothing
            if this.ptr == 0 or codeName == null then
                return
            endif
            
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_CONTROL_CLICK")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_MOUSE_ENTER")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_MOUSE_LEAVE")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_MOUSE_UP")  
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_MOUSE_DOWN")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_MOUSE_WHEEL")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_CHECKBOX_CHECKED")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_CHECKBOX_UNCHECKED")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_EDITBOX_TEXT_CHANGED")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_POPUPMENU_ITEM_CHANGED")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_MOUSE_DOUBLECLICK")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_SPRITE_ANIM_UPDATE")
            //! runtextmacro RegisterEventSetCode("FRAMEEVENT_SLIDER_VALUE_CHANGED")
        endmethod

        thistype tooltip
        method SetTooltip takes Frame tooltip returns nothing
            if this.ptr == 0 or tooltip.ptr == 0 or this.tooltip != 0 then
                return
            endif

            call tooltip.ClearAllPoints()
            call DzFrameSetTooltip(this.ptr, tooltip.ptr)
        endmethod

        static method OnFrameEventSynced takes nothing returns nothing
            local player   p       = DzGetTriggerSyncPlayer()
            local string   data    = DzGetTriggerSyncData()
            local integer  index   = MHString_Find(data, ",", 0)
            local integer  eventId = S2I(SubString(data, 0, index))
            local thistype this    = S2I(SubString(data, index + 1, -1))

            if this == 0 or eventId == 0 or not HaveSavedString(HT, this, eventId) then
                return
            endif

            set FrameEventStackTop = FrameEventStackTop + 1
            set TriggerFrame[FrameEventStackTop] = this
            set TriggerEvent[FrameEventStackTop] = eventId
            set TriggerPlayer[FrameEventStackTop] = p
            call ExecuteFunc(LoadStr(HT, this, eventId))
            set TriggerFrame[FrameEventStackTop] = 0
            set TriggerEvent[FrameEventStackTop] = 0
            set TriggerPlayer[FrameEventStackTop] = null
            set FrameEventStackTop = FrameEventStackTop - 1
        endmethod

        static method GetOriginFrame takes integer frameType, integer index returns thistype
            set index = index + 1
            if frameType == ORIGIN_FRAME_GAME_UI then
                return Frame.GetPtrToInstance(MHUI_GetGameUI())
            elseif frameType == ORIGIN_FRAME_COMMAND_BUTTON then
                return Frame.GetPtrToInstance(MHUI_GetSkillBarButton(index))
            elseif frameType == ORIGIN_FRAME_HERO_BAR then
                return Frame.GetPtrToInstance(MHUI_GetHeroBar())
            elseif frameType == ORIGIN_FRAME_HERO_BUTTON then
                return Frame.GetPtrToInstance(MHUI_GetHeroBarButton(index))
            elseif frameType == ORIGIN_FRAME_HERO_HP_BAR then
                return Frame.GetPtrToInstance(MHUI_GetHeroButtonHPBar(MHUI_GetHeroBarButton(index)))
            elseif frameType == ORIGIN_FRAME_HERO_MANA_BAR then
                return Frame.GetPtrToInstance(MHUI_GetHeroButtonMPBar(MHUI_GetHeroBarButton(index)))
            elseif frameType == ORIGIN_FRAME_HERO_BUTTON_INDICATOR then
                return Frame.GetPtrToInstance(MHUI_GetHeroButtonStreamer(MHUI_GetHeroBarButton(index)))
            elseif frameType == ORIGIN_FRAME_ITEM_BUTTON then
                return Frame.GetPtrToInstance(MHUI_GetItemBarButton(index))
            elseif frameType == ORIGIN_FRAME_MINIMAP then
                return Frame.GetPtrToInstance(MHUI_GetMiniMap())
            elseif frameType == ORIGIN_FRAME_MINIMAP_BUTTON then
                if index == 0 then
                    return Frame.GetPtrToInstance(MHUI_GetMiniMapSignalButton())
                elseif index == 1 then
                    return Frame.GetPtrToInstance(MHUI_GetMiniMapTerrainButton())
                elseif index == 2 then
                    return Frame.GetPtrToInstance(MHUI_GetMiniMapColorButton())
                elseif index == 3 then
                    return Frame.GetPtrToInstance(MHUI_GetMiniMapCreepButton())
                elseif index == 4 then
                    return Frame.GetPtrToInstance(MHUI_GetMiniMapFormationButton())
                endif
            elseif frameType == ORIGIN_FRAME_SYSTEM_BUTTON then
                return Frame.GetPtrToInstance(DzFrameGetUpperButtonBarButton(index - 1))
            elseif frameType == ORIGIN_FRAME_TOOLTIP then
                return Frame.GetPtrToInstance(DzFrameGetTooltip()) // ?
            elseif frameType == ORIGIN_FRAME_UBERTOOLTIP then
                return Frame.GetPtrToInstance(MHUI_GetUberToolTip())
            elseif frameType == ORIGIN_FRAME_CHAT_MSG then
                return Frame.GetPtrToInstance(MHUI_GetChatEditBar())
            elseif frameType == ORIGIN_FRAME_UNIT_MSG then
                return Frame.GetPtrToInstance(MHFrame_GetByName("SimpleInfoPanelUnitDetail", 0))
            elseif frameType == ORIGIN_FRAME_TOP_MSG then
                return 0
            elseif frameType == ORIGIN_FRAME_PORTRAIT then
                return Frame.GetPtrToInstance(MHUI_GetPortraitButton())
            elseif frameType == ORIGIN_FRAME_WORLD_FRAME then
                return Frame.GetPtrToInstance(MHUI_GetWorldFrameWar3())
            elseif frameType == ORIGIN_FRAME_SIMPLE_UI_PARENT then
                return Frame.GetPtrToInstance(MHUI_GetConsoleUI())
            elseif frameType == ORIGIN_FRAME_PORTRAIT_HP_TEXT then
                return Frame.GetPtrToInstance(MHUI_GetPortraitButtonHPText())
            elseif frameType == ORIGIN_FRAME_PORTRAIT_MANA_TEXT then
                return Frame.GetPtrToInstance(MHUI_GetPortraitButtonMPText())
            elseif frameType == ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR then
                return Frame.GetPtrToInstance(MHUI_GetBuffIndicator(index))
            elseif frameType == ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR_LABEL then
                return Frame.GetPtrToInstance(MHUI_GetBuffBarText())
            endif
            return 0
        endmethod

        // debug
        method DebugAbsPoint takes nothing returns nothing
            local integer i
            local string  s = ""
            local integer c

            if this.ptr == 0 then
                return
            endif

            set s = s + "Parent:" + MHMath_ToHex(MHFrame_GetParent(this.ptr)) + "\n"
            set i = 0
            set c = 0
            loop

                if MHFrame_GetAbsolutePointX(this.ptr, i) != 0. and MHFrame_GetAbsolutePointY(this.ptr, i) != 0. then
                    set s = s + "Point:" + I2S(i) + " | AbsX:" + R2S(MHFrame_GetAbsolutePointX(this.ptr, i))  + " , AbsY:" + R2S(MHFrame_GetAbsolutePointY(this.ptr, i)) + "\n"
                    set c = c + 1
                endif

                exitwhen i == 9
                set i = i + 1
            endloop

            if c == 0 then
                set s = "no abs point."
            endif

            call BJDebugMsg(s)
        endmethod

        method DebugPoint takes nothing returns nothing
            local integer i
            local string  s = ""
            local integer c

            if this.ptr == 0 then
                return
            endif

            set s = s + "Parent:" + MHMath_ToHex(MHFrame_GetParent(this.ptr)) + "\n"
            set i = 0
            set c = 0
            loop

                if MHFrame_GetRelativePoint(this.ptr, i) != 9 then
                    set s = s + "Point:" + I2S(i) + " | X:" + R2S(MHFrame_GetRelativePointX(this.ptr, i))  + " , Y:" + R2S(MHFrame_GetRelativePointY(this.ptr, i))/*
                    */ + " | TargetPoint" + I2S(MHFrame_GetRelativePoint(this.ptr, i)) + "\n"
                    set c = c + 1
                endif
                
                exitwhen i == 9
                set i = i + 1
            endloop

            if c == 0 then
                set s = "no relative point."
            endif

            call BJDebugMsg(s)
        endmethod

        method GetSimpleButtonTexture takes integer state returns thistype
            if this.ptr == 0 then
                return 0
            endif

            return Frame.GetPtrToInstance(MHFrame_GetSimpleButtonTexture(this.ptr, state))
        endmethod

        method GetRelativeFrame takes integer point returns thistype
            if this.ptr == 0 then
                return 0
            endif
            
            return Frame.GetPtrToInstance(MHFrame_GetRelativeFrame(this.ptr, point ))
        endmethod

    endstruct

    function GetOriginFrame takes integer frameType, integer index returns Frame
        return Frame.GetOriginFrame(frameType, index)
    endfunction

    function GetFrameId takes Frame frame returns integer
        return frame
    endfunction

    function LoadTOCFile takes string TOCFile returns nothing
        call MHFrame_LoadTOC(TOCFile)
    endfunction

    function FrameSystem_Init takes nothing returns nothing
        local trigger trig = CreateTrigger()

        call DzTriggerRegisterSyncData(trig, FRAME_EVENT_SYNC_PREFIX, false)
        call TriggerAddCondition(trig, Condition(function Frame.OnFrameEventSynced))
    endfunction

endlibrary
