#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHGameUI
    function MHUI_GetGameUI takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetConsoleUI takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetConsoleTexture takes integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetResourceBarTexture takes integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetFpsFrame takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetFps takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUI_GetUberToolTip takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetUberToolTipTarget takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetUberToolTipIcon takes integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetUnitTip takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetWorldFrameWar3 takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetBuildFrame takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetTimeIndicator takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetInventoryText takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetInventoryCover takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetInventoryTexture takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetBuffBar takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetBuffBarText takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetBuffIndicator takes integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetUpperButtonBar takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetMiniMap takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_UpdateMiniMap takes real min_x, real min_y, real max_x, real max_y returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUI_GetMiniMapSignalButton takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetMiniMapTerrainButton takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetMiniMapColorButton takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetMiniMapCreepButton takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetMiniMapFormationButton takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetCommandBar takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetSkillBarButton takes integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetSkillBarButtonEx takes integer x, integer y returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetItemBarButton takes integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetHeroBar takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetHeroBarButton takes integer index returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetHeroButtonHPBar takes integer hero_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetHeroButtonMPBar takes integer hero_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetHeroButtonSubscriptFrame takes integer hero_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetHeroButtonSubscriptText takes integer hero_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetHeroButtonStreamer takes integer hero_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetPeonBar takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetPeonBarButton takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetPortraitButton takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetPortraitButtonUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHUI_GetPortraitButtonHPText takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetPortraitButtonMPText takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetCursorFrame takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_SetCursorModel takes string model_path returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_SetCursorItemIcon takes string texture_path returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_GetChatEditBar takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_GetChatEditBox takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_IsChatEditBarOn takes nothing returns boolean
        JapiPlaceHolder false
    endfunction
    function MHUI_SendPlayerChat takes player p, string msg, real dur, integer channel returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_SendChatMessage takes string msg, real dur, integer color returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_SendErrorMessage takes string msg, real dur, integer color returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_SendUpKeepMessage takes string msg, real dur, integer color returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_PlayNativeSound takes string label returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_PlayErrorSound takes nothing returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



library AMHGameUIHook
    function MHUI_DrawAttackSpeed takes boolean is_draw returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_DrawMoveSpeed takes boolean is_draw returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



#include "event.j"
library AMHGameUIEvent
    function MHUITickEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUIHPBarEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
    function MHUIHPBarEvent_GetX takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUIHPBarEvent_SetX takes real x returns nothing
        JapiPlaceHolder
    endfunction
    function MHUIHPBarEvent_GetY takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUIHPBarEvent_SetY takes real x returns nothing
        JapiPlaceHolder
    endfunction
    function MHUIRenderEvent_Register takes trigger trig returns nothing
        JapiPlaceHolder
    endfunction
endlibrary



library AMHGameUISystem
    function MHUI_EnableDrawMPBar takes boolean is_enable returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_OnlyDrawAllyMPBar takes boolean is_only returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_MPBarDrawHeroLevel takes boolean is_draw returns nothing
        JapiPlaceHolder
    endfunction
    function MHUI_GetMPBarCount takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUI_FixGarbled takes boolean is_enable returns nothing
        JapiPlaceHolder
    endfunction
endlibrary
