
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

        method CreateFrameByType takes string typeName, string name, string inherits, integer createContext returns thistype
            local thistype newFrame

            static if DEBUG_MODE then
                call ThrowError(this.ptr == 0, "UISystem", "CreateFrameByType", name, createContext, "parent == null")
            endif

            set newFrame = thistype.create(DzCreateFrameByTagName(typeName, name, this.ptr, inherits, createContext))
            debug call BJDebugMsg("CreateFrameByType() error \ntypeName: " + typeName + "\nname:" + name + "\ninherits:" + inherits + "\nowner:" + I2S(this))
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
            return thistype.GetPtrInstance(MHFrame_GetByName(name, createContext))
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


        private Frame pushedOffsetFrame
        method IsPushedOffset takes nothing returns boolean
            return this.pushedOffsetFrame != 0
        endmethod
        method SetPushedOffset takes thistype frame returns nothing
            set this.pushedOffsetFrame = frame
        endmethod
        method GetPushedOffsetFrame takes nothing returns thistype
            return this.pushedOffsetFrame
        endmethod

        // 获取鼠标指向的Frame
        static method GetUnderCursor takes nothing returns thistype
            return thistype.GetPtrInstanceSafe(MHFrame_GetUnderCursor())
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
                local thistype this = thistype.GetPtrInstanceSafe(DzGetTriggerUIEventFrame())
                
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

        private thistype tooltip
        method SetTooltip takes Frame tooltip returns nothing
            if this.ptr == 0 or tooltip.ptr == 0 or this.tooltip != 0 then
                return
            endif

            call this.tooltip.ClearAllPoints()
            call DzFrameSetTooltip(this.ptr, this.tooltip.ptr)
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

            return Frame.GetPtrInstance(MHFrame_GetSimpleButtonTexture(this.ptr, state))
        endmethod
        method GetRelativeFrame takes integer point returns thistype
            if this.ptr == 0 then
                return 0
            endif
            
            return Frame.GetPtrInstance(MHFrame_GetRelativeFrame(this.ptr, point ))
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
