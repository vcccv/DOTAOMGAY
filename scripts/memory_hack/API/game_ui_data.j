#pragma once
// by Asphodelus
#include "../memory_hack_constant.j"



library AMHGameUIData
    function MHUIData_GetBuffIndicatorBuff takes integer index returns integer
        JapiPlaceHolder 0
    endfunction
    #define MHUIData_GetBuffIndicatorBuffInt(index)  MHUIData_GetBuffIndicatorBuff(index)
    function MHUIData_GetTargetModeAbility takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetTargetModeOrder takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetTargetModeUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetTargetModeItem takes nothing returns item
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetTargetModeDest takes nothing returns destructable
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetTargetModeCastType takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetSelectModeUnit takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetSelectModeItem takes nothing returns item
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetSelectModeDest takes nothing returns destructable
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetBuildFrameUnitId takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetBuildFrameSpriteX takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUIData_GetBuildFrameSpriteY takes nothing returns real
        JapiPlaceHolder 0.
    endfunction
    function MHUIData_GetBuildFrameBuilder takes nothing returns unit
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetBuildFrameBuildAbility takes nothing returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonSubscriptFrame takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonSubscriptText takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonCooldownFrame takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonStreamFrame takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonAbility takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonOrderId takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonCastType takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_SetCommandButtonCastType takes integer command_button, integer cast_type returns nothing
        JapiPlaceHolder
    endfunction
    function MHUIData_GetCommandButtonItem takes integer command_button returns item
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetCommandButtonTip takes integer command_button returns string
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetCommandButtonUbertip takes integer command_button returns string
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetCommandButtonGoldCost takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonLumberCost takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonManaCost takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonFoodCost takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonHotkey takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonX takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_GetCommandButtonY takes integer command_button returns integer
        JapiPlaceHolder 0
    endfunction
    function MHUIData_SetCommandButtonXY takes integer command_button, integer x, integer y returns nothing
        JapiPlaceHolder
    endfunction
    function MHUIData_GetCommandButtonTexture takes integer command_button returns string
        JapiPlaceHolder null
    endfunction
    function MHUIData_GetCommandButtonCooldown takes integer command_button returns real
        JapiPlaceHolder 0.
    endfunction
endlibrary
