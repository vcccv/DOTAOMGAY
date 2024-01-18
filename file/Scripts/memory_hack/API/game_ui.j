// by Asphodelus



library MHGameUI
    function MHUI_GetGameUI takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetConsoleUI takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetConsoleTexture takes integer index returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetResourceBarTexture takes integer index returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetUberToolTip takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetUnitTip takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetWorldFrameWar3 takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetTimeIndicator takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetInventoryCover takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetInventoryTexture takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetBuffBar takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetBuffBarText takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetBuffIndicator takes integer index returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetUpperButtonBar takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetMiniMap takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetMiniMapSignalButton takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetMiniMapTerrainButton takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetMiniMapColorButton takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
        function MHUI_GetMiniMapCreepButton takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetMiniMapFormationButton takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetCommandBar takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetSkillBarButton takes integer index returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetSkillBarButtonEx takes integer x, integer y returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetItemBarButton takes integer index returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetHeroBar takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetHeroBarButton takes integer index returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetHeroButtonHPBar takes integer hero_button returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetHeroButtonMPBar takes integer hero_button returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetHeroButtonSubscriptFrame takes integer hero_button returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetHeroButtonSubscriptText takes integer hero_button returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetHeroButtonStreamer takes integer hero_button returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetPeonBar takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetPeonBarButton takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetPortraitButton takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetPortraitButtonUnit takes nothing returns unit
        local integer yjsp = 114514
        return null
    endfunction
    function MHUI_GetPortraitButtonHPText takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetPortraitButtonMPText takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_GetCursorFrame takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUI_SetCursorModel takes string model_path returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_IsChatEditBarOn takes nothing returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHUI_SendPlayerChat takes player p, string msg, real dur, integer channel returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_SendChatMessage takes string msg, real dur, integer color returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_SendErrorMessage takes string msg, real dur, integer color returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_SendUpKeepMessage takes string msg, real dur, integer color returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_PlayNativeSound takes string label returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_PlayErrorSound takes nothing returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary



library MHGameUIHook
    function MHUI_DrawAttackSpeed takes boolean is_draw returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_DrawMoveSpeed takes boolean is_draw returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary



// #include "event.j"
library MHGameUIEvent
    function MHUITickEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUIHPBarEvent_Register takes trigger trig returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHUIHPBarEvent_GetHPBar()       MHEvent_GetFrame()
    // #define MHUIHPBarEvent_GetUnit()        MHEvent_GetUnit()
    function MHUIHPBarEvent_GetPoint takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHUIHPBarEvent_GetX takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUIHPBarEvent_SetX takes real x returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUIHPBarEvent_GetY takes nothing returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHUIHPBarEvent_SetY takes real x returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary



library MHGameUISystem
    function MHUI_EnableDrawMPBar takes boolean is_enable returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_OnlyDrawAllyMPBar takes boolean is_only returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_MPBarDrawHeroLevel takes boolean is_draw returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHUI_GetMPBarCount takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
endlibrary
