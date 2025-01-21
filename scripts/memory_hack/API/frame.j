#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHFrame
    function MHFrame_Create takes string base_frame, integer parent_frame, integer priority, integer id returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_CreateEx takes string type_name, string name, string base_frame, integer parent_frame,  integer priority, integer id returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_CreateSimple takes string base_frame, integer parent_frame, integer id returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_CreatePortrait takes integer parent_frame returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_CreateSimpleTexture takes integer parent_frame returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_CreateSimpleFontString takes integer parent_frame returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_GetByName takes string name, integer id returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_GetUnderCursor takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_LoadTOC takes string file_path returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_Destroy takes integer frame returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_Update takes integer frame returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_Click takes integer frame returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetParent takes integer frame returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_SetParent takes integer frame, integer parent_frame returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetChildCount takes integer frame returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_GetChild takes integer frame, integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_GetName takes integer frame returns string
        JapiPlaceHolder null
    endfunction
    function MHFrame_Hide takes integer frame, boolean is_hide returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_IsHidden takes integer frame returns boolean
        JapiPlaceHolder false
    endfunction
    function MHFrame_Disable takes integer frame, boolean is_disable returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetLayerStyle takes integer frame returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_SetLayerStyle takes integer frame, integer style returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetPriority takes integer frame, integer priority returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetAlpha takes integer frame, integer alpha returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetPointType takes integer frame, integer point returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_SetAbsolutePoint takes integer frame, integer point, real x, real y returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetAbsolutePointX takes integer frame, integer point returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_GetAbsolutePointY takes integer frame, integer point returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_SetRelativePoint takes integer frame, integer point, integer relative_frame, integer relative_point, real x, real y returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetRelativeFrame takes integer frame, integer point returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_GetRelativePoint takes integer frame, integer point returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_GetRelativePointX takes integer frame, integer point returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_GetRelativePointY takes integer frame, integer point returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_SetAllPoints takes integer frame, integer relative_frame returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_ClearAllPoints takes integer frame returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_InFrame takes real x, real y, integer frame returns boolean
        JapiPlaceHolder false
    endfunction
    function MHFrame_GetBorderBottom takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_GetBorderLeft takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_GetBorderTop takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_GetBorderRight takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_SetWidth takes integer frame, real width returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetWidth takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_SetHeight takes integer frame, real height returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetHeight takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_SetSize takes integer frame, real width, real height returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetScale takes integer frame, real scale returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetColor takes integer frame, integer color returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetColorEx takes integer frame, integer alpha, integer red, integer green, integer blue returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetTexture takes integer frame, string texture_path, boolean is_tile returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetModel takes integer frame, string model_path, integer model_type, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetFont takes integer frame, string font_path, real height, integer flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetFontHeight takes integer frame, real height returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetText takes integer frame, string text returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetText takes integer frame returns string
        JapiPlaceHolder null
    endfunction
    function MHFrame_SetTextLimit takes integer frame, integer length returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetTextLimit takes integer frame returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_SetTextAlign takes integer frame, integer vertex_align, integer horizon_align returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetValue takes integer frame, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetValue takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_SetLimit takes integer frame, real max_limit, real min_limit returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_CageMouse takes integer frame, boolean flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetSimpleButtonTexture takes integer button_frame, integer state returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_GetSimpleButtonAdditiveFrame takes integer button_frame returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_SetSimpleButtonState takes integer button_frame, integer state returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetSimpleTextureBlendMode takes integer texture_frame returns blendmode
        JapiPlaceHolder null
    endfunction
    function MHFrame_GetSimpleTextureBlendModeInt takes integer texture_frame returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrame_SetSimpleTextureBlendMode takes integer texture_frame, blendmode blend_mode returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_AddTextAreaText takes integer text_area, string text returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetSpriteX takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_GetSpriteY takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_GetSpriteZ takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_SetSpriteX takes integer frame, real x returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteY takes integer frame, real y returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteZ takes integer frame, real z returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpritePosition takes integer frame, real x, real y, real z returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteRoll takes integer frame, real roll returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpritePitch takes integer frame, real pitch returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteYaw takes integer frame, real yaw returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteScale takes integer sprite_frame, real scale returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteScaleEx takes integer sprite_frame, real x_scale, real y_scale, real z_scale returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteColor takes integer frame, real color returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteAnimation takes integer frame, string anim, string attach returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteAnimationProgress takes integer frame, real progress returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetSpriteTexture takes integer frame, string texture, integer id returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_GetSpriteAnimationProgress takes integer frame returns real
        JapiPlaceHolder 0.
    endfunction
    function MHFrame_SetPortraitModel takes integer frame, string model, playercolor color returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetPortraitCameraPosition takes integer frame, real x, real y, real z returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrame_SetPortraitCameraFocus takes integer frame, real x, real y, real z returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



library AMHFrameHook
    function MHFrame_SetScreenLimit takes boolean is_limit returns boolean
        JapiPlaceHolder false
    endfunction
endlibrary



#include "event.j"
library AMHFrameEvent
    function MHFrameEvent_Register takes trigger trig, integer frame, integer event_id returns nothing
        JapiPlaceHolder
    endfunction
    function MHFrameEvent_Remove takes trigger trig, integer frame, integer event_id returns boolean
        JapiPlaceHolder false
    endfunction
    function MHFrameEvent_RemoveAll takes integer frame returns boolean
        JapiPlaceHolder false
    endfunction
    function MHFrameScrollEvent_GetValue takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHFrameScrollEvent_SetValue takes integer value returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



library AMHFrameSystem
    function MHFrame_BindToUnit takes integer frame, unit u returns boolean
        JapiPlaceHolder false
    endfunction
    function MHFrame_UnbindFrame takes integer frame returns boolean
        JapiPlaceHolder false
    endfunction
    function MHFrame_UnbindUnit takes unit u returns boolean
        JapiPlaceHolder false
    endfunction
endlibrary
