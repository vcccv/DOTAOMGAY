
library UISystem requires ErrorMessage
    
    globals
        private hashtable         HT                      = InitHashtable()
        private string            FRAME_EVENT_SYNC_PREFIX = "FRAMEEVENT"
        private key               FRAME_NAME_CREATE_CONTEXT

        // 事件信息
        private integer           FrameEventStackTop      = 0
        private Frame       array TriggerFrame
        private integer     array TriggerEvent
        private player      array TriggerPlayer
    endglobals

    struct Frame
        
        private integer ptr
    
        static method create takes integer ptr returns thistype
            local thistype this 

            static if DEBUG_MODE then
                call ThrowError(ptr == 0, "UISystem", "create", null, 0, "ptr == null")
            endif
            
            set this = thistype.allocate()
            set this.ptr = ptr
            call SaveInteger(HT, ptr, 0, this)

            return this
        endmethod

        static method CreateEmptyInstance takes nothing returns thistype
            return thistype.allocate()
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

        static method GetPtrInstance takes integer ptr returns thistype
            local thistype this = LoadInteger(HT, ptr, 0)

            if this == 0 and ptr != 0 then
                set this = thistype.create(ptr)
            endif

            return this
        endmethod

        // 如果是没有被创建过实例的frame，则返回0，在异步情况下没有把握就用这个
        static method GetPtrInstanceSafe takes integer ptr returns thistype
            return LoadInteger(HT, ptr, 0)
        endmethod

        method CreateFrame takes string name, integer priority, integer createContext returns thistype
            local thistype newFrame

            static if DEBUG_MODE then
                call ThrowError(this.ptr == 0, "UISystem", "CreateFrame", name, createContext, "parent == null")
            endif

            set newFrame = thistype.create(MHFrame_Create(name, this.ptr, priority, createContext))
        
            static if DEBUG_MODE then
                call ThrowError(newFrame == 0, "UISystem", "CreateFrame", name, createContext, "newFrame == null" + "\nparent:" + I2S(this))
            endif

            return newFrame
        endmethod

        method CreateSimpleFrame takes string name, integer createContext returns thistype
            local thistype newFrame
            
            static if DEBUG_MODE then
                call ThrowError(this.ptr == 0, "UISystem", "CreateSimpleFrame", name, createContext, "parent == null")
            endif
            
            set newFrame = thistype.create(MHFrame_CreateSimple(name, this.ptr, createContext))

            static if DEBUG_MODE then
                call ThrowError(newFrame == 0, "UISystem", "CreateSimpleFrame", name, createContext, "newFrame == null" + "\nparent:" + I2S(this))
            endif

            return newFrame
        endmethod

        method CreateSimpleFontString takes nothing returns thistype
            static if DEBUG_MODE then
                call ThrowError(this.ptr == 0, "UISystem", "CreateFrameByType", null, 0, "parent == null")
            endif

            return thistype.create(MHFrame_CreateSimpleFontString(this.ptr))
        endmethod

        method CreateSimpleTexture takes nothing returns thistype
            static if DEBUG_MODE then
                call ThrowError(this.ptr == 0, "UISystem", "CreateFrameByType", null, 0, "parent == null")
            endif

            return thistype.create(MHFrame_CreateSimpleTexture(this.ptr))
        endmethod

        method CreateFrameByType takes string typeName, string name, string inherits, integer priority, integer createContext returns thistype
            local thistype newFrame

            static if DEBUG_MODE then
                call ThrowError(this.ptr == 0, "UISystem", "CreateFrameByType", name, createContext, "parent == null")
            endif

            set newFrame = thistype.create(MHFrame_CreateEx(typeName, name, inherits, this.ptr, priority, createContext))
            
            static if DEBUG_MODE then
                call ThrowError(newFrame == 0, "UISystem", "CreateFrameByType", name, createContext, "newFrame == null" + "\nparent:" + I2S(this) + "\ntypeName:" + typeName + "\ninherits:" + inherits)
            endif

            return newFrame
        endmethod

        method Destroy takes nothing returns nothing
            call MHFrame_Destroy(this.ptr)
            call RemoveSavedInteger(HT, this.ptr, 0)
            call FlushChildHashtable(HT, this)
            set this.ptr = 0
        endmethod

        method SetPoint takes integer point, Frame relative, integer relativePoint, real x, real y returns nothing
            if this.ptr == 0 or relative.ptr == 0 then
                return
            endif
            
            call MHFrame_SetRelativePoint(this.ptr, point, relative.ptr, relativePoint, x, y)
        endmethod

        method SetAbsPoint takes integer point, real x, real y returns nothing
            if this.ptr == 0 then
                return
            endif
            
            call MHFrame_SetAbsolutePoint(this.ptr, point, x, y)
        endmethod

        method ClearAllPoints takes nothing returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_ClearAllPoints(this.ptr)
        endmethod

        method SetAllPoints takes Frame relative returns nothing
            if this.ptr == 0 or relative.ptr == 0 then
                return
            endif

            call MHFrame_SetAllPoints(this.ptr, relative.ptr)
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
            call ThrowError(MHFrame_GetByName(name, createContext) == 0, "UISystem", "GetFrameByName", "name", 0, "no frame")
            return thistype.GetPtrInstance(MHFrame_GetByName(name, createContext))
        endmethod

        method GetHex takes nothing returns string
            return "0x" + MHMath_ToHex(this.ptr)
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

        // 仅对CModelFrame, CSpriteFrame和CStatBar有效
        method SetModel takes string modelFile, integer cameraIndex returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetModel(this.ptr, modelFile, cameraIndex, 0)
        endmethod

        method SetEnable takes boolean enable returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_Disable(this.ptr, not enable)
        endmethod

        method GetEnable takes nothing returns boolean
            if this.ptr == 0 then
                return false
            endif

            return DzFrameGetEnable(this.ptr)
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

        method SetTextureEx takes string texFile, integer flag, boolean blend returns nothing
            if this.ptr == 0 then
                return
            endif

            set texFile = MHString_Replace(texFile, "/", "\\")
            if MHString_Find(texFile, ".blp", 0) == - 1 then
                set texFile = texFile + ".blp"
            endif

            call MHFrame_SetTexture(this.ptr, texFile, flag != 0)
        endmethod

        method SetTexture takes string texFile returns nothing
            if this.ptr == 0 then
                return
            endif

            set texFile = MHString_Replace(texFile, "/", "\\")
            if MHString_Find(texFile, ".blp", 0) == - 1 then
                set texFile = texFile + ".blp"
            endif

            call MHFrame_SetTexture(this.ptr, texFile, false)
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

        method SetWidth takes real width returns nothing
            call MHFrame_SetWidth(this.ptr, width)
        endmethod
        method SetHeight takes real height returns nothing
            call MHFrame_SetHeight(this.ptr, height)
        endmethod

        method SetSize takes real width, real height returns nothing
            if this.ptr == 0 then
                return
            endif

            call MHFrame_SetSize(this.ptr, width, height)
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

            return thistype.GetPtrInstance(MHFrame_GetParent(this.ptr))
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
            
            if this.ptr == 0 then
                return
            endif

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

            call DzFrameSetTextAlignment(this.ptr, align)
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

            return thistype.GetPtrInstanceSafe(MHFrame_GetChild(this.ptr, index))
        endmethod

        private thistype tooltip
        method SetTooltip takes Frame tooltip returns nothing
            if this.ptr == 0 or tooltip.ptr == 0 or this.tooltip != 0 then
                return
            endif

            call this.tooltip.ClearAllPoints()
            call DzFrameSetTooltip(this.ptr, this.tooltip.ptr)
        endmethod

        // 获取鼠标指向的Frame
        static method GetUnderCursor takes nothing returns thistype
            return thistype.GetPtrInstanceSafe(MHFrame_GetUnderCursor())
        endmethod

        private Frame   pushedOffsetTexture
        private real    pushedOffsetScale
        private integer pushedOffsetFlag
        method IsPushedOffset takes nothing returns boolean
            return this.pushedOffsetTexture != 0
        endmethod
        method SetPushedOffsetTexture takes thistype frame, integer flag, real scale returns nothing
            if this.IsPushedOffset() then
                return
            endif
            set this.pushedOffsetTexture = frame
            set this.pushedOffsetScale   = scale
            set this.pushedOffsetFlag    = flag
            call MHFrameEvent_Register(MainTrigger, this.ptr, EVENT_ID_FRAME_MOUSE_DOWN)
            call MHFrameEvent_Register(MainTrigger, this.ptr, EVENT_ID_FRAME_MOUSE_UP)
        endmethod
        method GetPushedOffsetTexture takes nothing returns thistype
            return this.pushedOffsetTexture
        endmethod
        boolean disableState
        method IsEnabledEx takes nothing returns boolean
            return not this.disableState
        endmethod
        method SetEnableEx takes boolean flag returns nothing
            set this.disableState = not flag
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

        integer SyncEventHandler
        integer ASyncEventHandler
        static trigger MainTrigger = null
        // Frame事件，同步的函数
        method RegisterEvent takes integer eventId, string codeName, boolean sync returns nothing
            if this.ptr == 0 or codeName == null then
                return
            endif

            call ThrowError(MHGame_GetCode(codeName) == null, "UISystem", "RegisterEvent", "codeName", eventId, "code == null")
            
            if not HaveSavedBoolean(HT, this, eventId) then
                call SaveBoolean(HT, this, eventId, true)
                call MHFrameEvent_Register(MainTrigger, this.ptr, eventId)
            endif

            if sync then
                call SaveInteger(HT, this, eventId, C2I(MHGame_GetCode(codeName)))
            else
                call SaveInteger(HT, this + JASS_MAX_ARRAY_SIZE, eventId, C2I(MHGame_GetCode(codeName)))
            endif
        endmethod
        method RegisterEventByCode takes integer eventId, code callback, boolean sync returns nothing
            if this.ptr == 0 or callback == null then
                return
            endif

            call ThrowError(callback == null, "UISystem", "RegisterEvent", "callback", eventId, "code == null")
            
            if not HaveSavedBoolean(HT, this, eventId) then
                call SaveBoolean(HT, this, eventId, true)
                call MHFrameEvent_Register(MainTrigger, this.ptr, eventId)
            endif

            call BJDebugMsg("注册：" + I2S(this))
            if sync then
                call SaveInteger(HT, this, eventId, C2I(callback))
            else
                call SaveInteger(HT, this + JASS_MAX_ARRAY_SIZE, eventId, C2I(callback))
            endif
        endmethod

        static method EventOnSynced takes nothing returns nothing
            local player   p       = DzGetTriggerSyncPlayer()
            local string   data    = DzGetTriggerSyncData()
            local integer  index   = MHString_Find(data, ",", 0)
            local integer  eventId = S2I(SubString(data, 0, index))
            local thistype this    = S2I(SubString(data, index + 1, -1))

            if this == 0 or eventId == 0 or not HaveSavedInteger(HT, this, eventId) then
                return
            endif

            set FrameEventStackTop = FrameEventStackTop + 1
            set TriggerFrame[FrameEventStackTop]  = this
            set TriggerEvent[FrameEventStackTop]  = eventId
            set TriggerPlayer[FrameEventStackTop] = p
            call MHGame_ExecuteCodeEx(LoadInteger(HT, this, eventId))
            set FrameEventStackTop = FrameEventStackTop - 1
        endmethod

        static method EventOnHandler takes nothing returns boolean
            local thistype this    = GetPtrInstanceSafe(MHEvent_GetFrame())
            local integer  eventId = MHEvent_GetId()

            if this == 0 then
                return false
            endif

            if this.IsPushedOffset() and MHMath_IsBitSet(this.pushedOffsetFlag, MHEvent_GetKey()) and this.IsEnabledEx() then
                if eventId == EVENT_ID_FRAME_MOUSE_DOWN then
                    call this.GetPushedOffsetTexture().SetSize(this.GetWidth() * this.pushedOffsetScale, this.GetHeight() *  this.pushedOffsetScale)
                elseif eventId == EVENT_ID_FRAME_MOUSE_UP then
                    call this.GetPushedOffsetTexture().SetSize(this.GetWidth(), this.GetHeight())
                endif
            endif
            
            if HaveSavedInteger(HT, this + JASS_MAX_ARRAY_SIZE, eventId) then
                set FrameEventStackTop = FrameEventStackTop + 1
                set TriggerFrame[FrameEventStackTop]  = this
                set TriggerEvent[FrameEventStackTop]  = eventId
                set TriggerPlayer[FrameEventStackTop] = GetLocalPlayer()
                if MHGame_ExecuteCodeEx(LoadInteger(HT, this + JASS_MAX_ARRAY_SIZE, eventId)) > 0 then
                    if HaveSavedInteger(HT, this, eventId) then
                        call DzSyncData(FRAME_EVENT_SYNC_PREFIX, I2S(eventId) + "," + I2S(this))
                    endif
                endif
                set FrameEventStackTop = FrameEventStackTop - 1
            else
                if HaveSavedInteger(HT, this, eventId) then
                    call DzSyncData(FRAME_EVENT_SYNC_PREFIX, I2S(eventId) + "," + I2S(this))
                endif
            endif

            return false
        endmethod

        static method GetOriginFrame takes integer frameType, integer index returns thistype
            set index = index + 1
            if frameType == ORIGIN_FRAME_GAME_UI then
                return Frame.GetPtrInstance(MHUI_GetGameUI())
            elseif frameType == ORIGIN_FRAME_COMMAND_BUTTON then
                return Frame.GetPtrInstance(MHUI_GetSkillBarButton(index))
            elseif frameType == ORIGIN_FRAME_HERO_BAR then
                return Frame.GetPtrInstance(MHUI_GetHeroBar())
            elseif frameType == ORIGIN_FRAME_HERO_BUTTON then
                return Frame.GetPtrInstance(MHUI_GetHeroBarButton(index))
            elseif frameType == ORIGIN_FRAME_HERO_HP_BAR then
                return Frame.GetPtrInstance(MHUI_GetHeroButtonHPBar(MHUI_GetHeroBarButton(index)))
            elseif frameType == ORIGIN_FRAME_HERO_MANA_BAR then
                return Frame.GetPtrInstance(MHUI_GetHeroButtonMPBar(MHUI_GetHeroBarButton(index)))
            elseif frameType == ORIGIN_FRAME_HERO_BUTTON_INDICATOR then
                return Frame.GetPtrInstance(MHUI_GetHeroButtonStreamer(MHUI_GetHeroBarButton(index)))
            elseif frameType == ORIGIN_FRAME_ITEM_BUTTON then
                return Frame.GetPtrInstance(MHUI_GetItemBarButton(index))
            elseif frameType == ORIGIN_FRAME_MINIMAP then
                return Frame.GetPtrInstance(MHUI_GetMiniMap())
            elseif frameType == ORIGIN_FRAME_MINIMAP_BUTTON then
                if index == 0 then
                    return Frame.GetPtrInstance(MHUI_GetMiniMapSignalButton())
                elseif index == 1 then
                    return Frame.GetPtrInstance(MHUI_GetMiniMapTerrainButton())
                elseif index == 2 then
                    return Frame.GetPtrInstance(MHUI_GetMiniMapColorButton())
                elseif index == 3 then
                    return Frame.GetPtrInstance(MHUI_GetMiniMapCreepButton())
                elseif index == 4 then
                    return Frame.GetPtrInstance(MHUI_GetMiniMapFormationButton())
                endif
            elseif frameType == ORIGIN_FRAME_SYSTEM_BUTTON then
                return Frame.GetPtrInstance(DzFrameGetUpperButtonBarButton(index - 1))
            elseif frameType == ORIGIN_FRAME_TOOLTIP then
                return Frame.GetPtrInstance(DzFrameGetTooltip()) // ?
            elseif frameType == ORIGIN_FRAME_UBERTOOLTIP then
                return Frame.GetPtrInstance(MHUI_GetUberToolTip())
            elseif frameType == ORIGIN_FRAME_CHAT_MSG then
                return Frame.GetPtrInstance(MHUI_GetChatEditBar())
            elseif frameType == ORIGIN_FRAME_UNIT_MSG then
                return Frame.GetPtrInstance(MHFrame_GetByName("SimpleInfoPanelUnitDetail", 0))
            elseif frameType == ORIGIN_FRAME_TOP_MSG then
                return 0
            elseif frameType == ORIGIN_FRAME_PORTRAIT then
                return Frame.GetPtrInstance(MHUI_GetPortraitButton())
            elseif frameType == ORIGIN_FRAME_WORLD_FRAME then
                return Frame.GetPtrInstance(MHUI_GetWorldFrameWar3())
            elseif frameType == ORIGIN_FRAME_SIMPLE_UI_PARENT then
                return Frame.GetPtrInstance(MHUI_GetConsoleUI())
            elseif frameType == ORIGIN_FRAME_PORTRAIT_HP_TEXT then
                return Frame.GetPtrInstance(MHUI_GetPortraitButtonHPText())
            elseif frameType == ORIGIN_FRAME_PORTRAIT_MANA_TEXT then
                return Frame.GetPtrInstance(MHUI_GetPortraitButtonMPText())
            elseif frameType == ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR then
                return Frame.GetPtrInstance(MHUI_GetBuffIndicator(index))
            elseif frameType == ORIGIN_FRAME_UNIT_PANEL_BUFF_BAR_LABEL then
                return Frame.GetPtrInstance(MHUI_GetBuffBarText())
            endif
            return 0
        endmethod

        //***************************************************************************
        //*
        //*  debug
        //*
        //***************************************************************************
        method DebugAbsPoint takes string name returns nothing
            local integer i
            local string  s = name
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
                set s = s + ":no abs point."
            endif

            call BJDebugMsg(s)
        endmethod

        private static method GetAnchorPointName takes integer index returns string
            if index == FRAMEPOINT_TOPLEFT then
                return "TOPLEFT    "
            elseif index == FRAMEPOINT_TOP then
                return "TOP        "
            elseif index == FRAMEPOINT_TOPRIGHT then
                return "TOPRIGHT   "
            elseif index == FRAMEPOINT_LEFT then
                return "LEFT       "
            elseif index == FRAMEPOINT_CENTER then
                return "CENTER     "
            elseif index == FRAMEPOINT_RIGHT then
                return "RIGHT      "
            elseif index == FRAMEPOINT_BOTTOMLEFT then
                return "BOTTOMLEFT "
            elseif index == FRAMEPOINT_BOTTOM then
                return "BOTTOM     "
            elseif index == FRAMEPOINT_BOTTOMRIGHT then
                return "BOTTOMRIGHT"
            else
                return "INVALID    "
            endif
        endmethod
        
        method GetRelativeFrame takes integer point returns thistype
            if this.ptr == 0 then
                return 0
            endif
            
            return Frame.GetPtrInstance(MHFrame_GetRelativeFrame(this.ptr, point))
        endmethod

        method DebugInfo takes string frameName returns nothing
            local integer  i
            local string   s
            local string   absolutePointStr = null
            local string   relativePointStr = null
            local real     x
            local real     y
            local thistype tempFrame
            local integer  count
            // 新增颜色定义
            local string   COLOR_TITLE   = "|cff00ccff" // 青色标题
            local string   COLOR_HEADER  = "|cffFF8000" // 橙色表头
            local string   COLOR_POINT   = "|cff00FF00" // 绿色锚点名
            local string   COLOR_VALUE   = "|cffAAAAAA" // 灰色数值
            local string   COLOR_TARGET   = "|cffFF69B4" // 品红用于目标框架
            local string   COLOR_DIMENSION= "|cffFFD700"
            local string   COLOR_VISIBLE   = "|cff00FF00" // 绿色可见状态
            local string   COLOR_HIDDEN    = "|cffFF0000" // 红色隐藏状态
            local string   COLOR_RESET   = "|r"
            // 保持原有颜色配置...
        
            if this.ptr == 0 then
                call BJDebugMsg(COLOR_TITLE + "Invalid frame pointer!" + COLOR_RESET)
                return
            endif
        
            // 框架名称处理（添加隐藏状态）
            if StringLength(frameName) == 0 then
                set frameName = this.GetName()
                if StringLength(frameName) == 0 then
                    set frameName = "Unnamed"
                endif
            endif
            set s = COLOR_TITLE + "===== Frame: " + COLOR_DIMENSION + frameName + " " + COLOR_RESET + this.GetHex()
            // 添加当前框架隐藏状态
            if MHFrame_IsHidden(this.ptr) then
                set s = s + " " + COLOR_HIDDEN + "[HIDDEN]" + COLOR_RESET
            else
                set s = s + " " + COLOR_VISIBLE + "[Visible]"
            endif
            set s = s + COLOR_TITLE + " =====" + COLOR_RESET + "\n"
            
            // 父框架信息
            set tempFrame = this.GetParent()
            if tempFrame != 0 then
                set s = s + COLOR_HEADER + "Parent: " + COLOR_RESET + tempFrame.GetHex()
                set frameName = tempFrame.GetName()
                if StringLength(frameName) > 0 then
                    set s = s + COLOR_VALUE + " (" + frameName + ")" + COLOR_RESET
                endif
                // 父框架隐藏状态
                if MHFrame_IsHidden(tempFrame.ptr) then
                    set s = s + " " + COLOR_HIDDEN + "[HIDDEN]" + COLOR_RESET
                else
                    set s = s + " " + COLOR_VISIBLE + "[Visible]"
                endif
                set s = s + "\n"
            endif
            
            // 尺寸信息
            set s = s + COLOR_HEADER + "Size: " + COLOR_RESET + COLOR_VALUE + "Width: " + R2SW(this.GetWidth(), 1, 7) + "  Height: " + R2SW(this.GetHeight(), 1, 3) + COLOR_RESET + "\n\n"
        
            set i     = 0
            set count = 0
        
            // 绝对锚点检测
            loop
                set x = MHFrame_GetAbsolutePointX(this.ptr, i)
                set y = MHFrame_GetAbsolutePointY(this.ptr, i)
                
                if x != 0. or y != 0. then
                    set absolutePointStr = absolutePointStr +/*
                    */ COLOR_POINT + "| " + GetAnchorPointName(i) + COLOR_RESET + " | " +/*
                    */ COLOR_VALUE + "X: " + R2SW(x, 1, 7) + /*
                    */ "  Y: " + R2SW(y, 1, 7) + COLOR_RESET + " |\n"
                    set count = count + 1
                endif
        
                exitwhen i == 9
                set i = i + 1
            endloop
        
            // 输出逻辑
            if count > 0 then
                set s = s + COLOR_HEADER + "Absolute Anchors: " + COLOR_RESET + "\n"
                set s = s + COLOR_VALUE + "--------------------------------" + COLOR_RESET + "\n"
                set s = s + absolutePointStr
            else
                // 相对锚点检测
                set i = 0
                loop
                    if MHFrame_GetRelativePoint(this.ptr, i) != 9 then
                        set tempFrame = this.GetRelativeFrame(i)
                 
                        set x = MHFrame_GetRelativePointX(this.ptr, i)
                        set y = MHFrame_GetRelativePointY(this.ptr, i)
                        
                        set relativePointStr = relativePointStr +/*
                        */ COLOR_POINT + "| " + GetAnchorPointName(i) + COLOR_RESET + "       | " +/*
                        */ COLOR_VALUE + "Offset: (" + COLOR_DIMENSION + R2SW(x,1,7) + COLOR_VALUE + ", " + COLOR_DIMENSION + R2SW(y,1,7) + COLOR_VALUE + ")" + COLOR_RESET
                
                        set relativePointStr = relativePointStr +/*
                        */ "\n   L " + COLOR_POINT + "| " + GetAnchorPointName(MHFrame_GetRelativePoint(this.ptr, i)) + COLOR_RESET + COLOR_TARGET + "| Target: " + tempFrame.GetHex()
                        //if StringLength(tempFrame.GetName()) > 0 then
                        //    set relativePointStr = relativePointStr + COLOR_VALUE + " (" + tempFrame.GetName() + ")" + COLOR_RESET
                        //endif
                        if MHFrame_IsHidden(tempFrame.ptr) then
                            set relativePointStr = relativePointStr + " " + COLOR_HIDDEN + "[HIDDEN]" + COLOR_RESET
                        else
                            set relativePointStr = relativePointStr + " " + COLOR_VISIBLE + "[Visible]"
                        endif

                        set relativePointStr = relativePointStr +/*
                        */ COLOR_VALUE + "  w: " + COLOR_DIMENSION + R2SW(tempFrame.GetWidth(),1,7) +/*
                        */ COLOR_VALUE + "  h: " + COLOR_DIMENSION + R2SW(tempFrame.GetHeight(),1,7) + COLOR_RESET
             
                        
                        set count = count + 1
                    endif
                    
                    exitwhen i == 9
                    set i = i + 1
                endloop
                
                if count > 0 then
                    set s = s + COLOR_HEADER + "Relative Anchors: " + COLOR_RESET + "\n"
                    set s = s + COLOR_VALUE + "--------------------------------" + COLOR_RESET + "\n"
                    set s = s + relativePointStr
                endif
            endif
        
            // 无锚点提示
            if count == 0 then
                set s = s + COLOR_HEADER + "No anchors set" + COLOR_RESET
            endif
        
            set s = s + COLOR_TITLE + "\n===================================" + COLOR_RESET
            call BJDebugMsg(s)
        endmethod

        method GetSimpleButtonTexture takes integer state returns thistype
            if this.ptr == 0 then
                return 0
            endif

            return Frame.GetPtrInstance(MHFrame_GetSimpleButtonTexture(this.ptr, state))
        endmethod

        method AddBorder takes string border_file, string background_file, integer border_flag, real border_size, real padding, boolean is_tile returns nothing
            call MHFrame_AddBorder(this.ptr, border_file, background_file, border_flag, border_size, padding, is_tile)
        endmethod

        static method LoadTOCFile takes string TOCFile returns nothing
            call MHFrame_LoadTOC(TOCFile)
        endmethod

    endstruct

    function FrameSystem_Init takes nothing returns nothing
        local trigger trig
        
        set trig = CreateTrigger()
        call DzTriggerRegisterSyncData(trig, FRAME_EVENT_SYNC_PREFIX, false)
        call TriggerAddCondition(trig, Condition(function Frame.EventOnSynced))

        set Frame.MainTrigger = CreateTrigger()
        call TriggerAddCondition(Frame.MainTrigger, Condition(function Frame.EventOnHandler))
    endfunction

endlibrary
