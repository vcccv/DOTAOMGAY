// by Asphodelus



library MHFrame
    function MHFrame_Create takes string base_frame, integer parent_frame, integer priority, integer id returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_CreateEx takes string type_name, string name, string base_frame, integer parent_frame,  integer priority, integer id returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_CreateSimple takes string base_frame, integer parent_frame, integer id returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_CreateSimpleTexture takes integer parent_frame returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_CreateSimpleFontString takes integer parent_frame returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_GetByName takes string name, integer id returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_GetUnderCursor takes nothing returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_LoadTOC takes string file_path returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_Destroy takes integer frame returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_Update takes integer frame returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_Click takes integer frame returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetParent takes integer frame returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_SetParent takes integer frame, integer parent_frame returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetChildCount takes integer frame returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_GetChild takes integer frame, integer index returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_GetName takes integer frame returns string
        local integer yjsp = 114514
        return null
    endfunction
    function MHFrame_Hide takes integer frame, boolean is_hide returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_Disable takes integer frame, boolean is_disable returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetPriority takes integer frame, integer priority returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetAlpha takes integer frame, integer alpha returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetAbsolutePoint takes integer frame, integer point, real x, real y returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetAbsolutePointX takes integer frame, integer point returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHFrame_GetAbsolutePointY takes integer frame, integer point returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHFrame_SetRelativePoint takes integer frame, integer point, integer relative_frame, integer relative_point, real x, real y returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetRelativeFrame takes integer frame, integer point returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_GetRelativePoint takes integer frame, integer point returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_GetRelativePointX takes integer frame, integer point returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHFrame_GetRelativePointY takes integer frame, integer point returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHFrame_SetAllPoints takes integer frame, integer relative_frame returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_ClearAllPoints takes integer frame returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetWidth takes integer frame, real width returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetWidth takes integer frame returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHFrame_SetHeight takes integer frame, real height returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetHeight takes integer frame returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHFrame_SetSize takes integer frame, real width, real height returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetScale takes integer frame, real scale returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetColor takes integer frame, integer color returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetColorEx takes integer frame, integer alpha, integer red, integer green, integer blue returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetTexture takes integer frame, string texture_path, boolean is_tile returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetModel takes integer frame, string model_path, integer model_type, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetFont takes integer frame, string font_path, real height, integer flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetText takes integer frame, string text returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetText takes integer frame returns string
        local integer yjsp = 114514
        return null
    endfunction
    function MHFrame_SetTextLength takes integer frame, integer length returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetTextAlign takes integer frame, integer vertex_align, integer horizon_align returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_SetValue takes integer frame, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetValue takes integer frame returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    function MHFrame_SetLimit takes integer frame, real max_limit, real min_limit returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_CageMouse takes integer frame, boolean flag returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetSimpleButtonTexture takes integer button_frame, integer state returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_GetSimpleButtonAdditiveFrame takes integer button_frame returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_SetSimpleButtonState takes integer button_frame, integer state returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_GetSimpleTextureBlendMode takes integer texture_frame returns blendmode
        local integer yjsp = 114514
        return null
    endfunction
    function MHFrame_GetSimpleTextureBlendModeInt takes integer texture_frame returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHFrame_SetSimpleTextureBlendMode takes integer texture_frame, blendmode blend_mode returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrame_AddTextAreaText takes integer text_area, string text returns nothing
        local integer yjsp = 114514
        return
    endfunction
endlibrary



// #include "event.j"
library MHFrameEvent
    function MHFrameEvent_Register takes trigger trig, integer frame, integer event_id returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHFrameEvent_Remove takes trigger trig, integer frame, integer event_id returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHFrameEvent_RemoveAll takes integer frame returns boolean
        local integer yjsp = 114514
        return false
    endfunction
endlibrary
