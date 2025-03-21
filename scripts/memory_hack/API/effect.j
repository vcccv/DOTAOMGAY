#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHEffect
    function MHEffect_GetX takes effect eff returns real
        JapiPlaceHolder 0.
    endfunction
    function MHEffect_GetY takes effect eff returns real
        JapiPlaceHolder 0.
    endfunction
    function MHEffect_GetZ takes effect eff returns real
        JapiPlaceHolder 0.
    endfunction
    function MHEffect_SetX takes effect eff, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetY takes effect eff, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetZ takes effect eff, real value returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetPosition takes effect eff, real x, real y, real z returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetRoll takes effect eff, real deg returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetPitch takes effect eff, real deg returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetYaw takes effect eff, real deg returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_Rotate takes effect eff, real deg returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_Rotation takes effect eff returns real
        JapiPlaceHolder 0.
    endfunction
    function MHEffect_SetVector takes effect eff, real xv, real yv, real zv returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_GetVectorX takes effect eff returns real
        JapiPlaceHolder 0.
    endfunction
    function MHEffect_GetVectorY takes effect eff returns real
        JapiPlaceHolder 0.
    endfunction
    function MHEffect_GetVectorZ takes effect eff returns real
        JapiPlaceHolder 0.
    endfunction
    function MHEffect_SetMirror takes effect eff, integer axis returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetScale takes effect eff, real scale returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetScaleEx takes effect eff, real x, real y, real z returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetParticleScale takes effect eff, real scale returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_ResetMatrix takes effect eff returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetModel takes effect eff, string model_path, boolean flag returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetTeamColor takes effect eff, playercolor color returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetTeamGlow takes effect eff, playercolor glow returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_Hide takes effect eff, boolean is_hide returns nothing
        JapiPlaceHolder
    endfunction
     function MHEffect_IsHidden takes effect eff returns boolean
        JapiPlaceHolder false
    endfunction
    function MHEffect_SetAlpha takes effect eff, integer alpha returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetColor takes effect eff, integer color returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetColorEx takes effect eff, integer alpha, integer red, integer green, integer blue returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetAnimation takes effect eff, integer index, integer rarity returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetAnimationByName takes effect eff, string name, string attachment returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetAnimationByType takes effect eff, integer anim_type, boolean looping returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_GetAnimationProgress takes effect eff returns real
        JapiPlaceHolder 0.
    endfunction
    function MHEffect_SetAnimationProgress takes effect eff, real progress returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SetTimeScale takes effect eff, real scale returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_BindToWidget takes effect eff, widget target, string attach_name returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_BindToEffect takes effect eff, effect target, string attach_name returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_BindToFrame takes effect eff, integer frame, string attach_name returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_Unbind takes effect eff returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_EnumInRange takes real x, real y, real range, code callback returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_EnumInRangeEx takes real x, real y, real range, string func_name returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_GetEnumEffect takes nothing returns effect
        JapiPlaceHolder null
    endfunction
endlibrary



library AMHEffectHook
    function MHEffect_ForceRender takes effect eff, boolean is_force returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SwitchRender takes boolean is_render returns nothing
        JapiPlaceHolder
    endfunction
    function MHEffect_SwitchExclude takes effect eff, boolean is_exclude returns nothing
        JapiPlaceHolder
    endfunction
endlibrary
