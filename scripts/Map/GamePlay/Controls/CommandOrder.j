library CommandOrder

    globals
        private trigger KeyDownTrig
    endglobals

    private function GetSelectedUnit takes nothing returns unit
        return MHPlayer_GetSelectUnit()
    endfunction
    private function IsKeyPressed takes integer key returns boolean
        return MHMsg_IsKeyDown(key)
    endfunction

    private function OnKeyDown takes nothing returns boolean
        local integer pressedKey

        if MHUI_IsChatEditBarOn() then
            return false
        endif
        
        set pressedKey = MHEvent_GetKey()
        if pressedKey == OSKEY_M /*
            */ and not IsKeyPressed(OSKEY_ALT) and not IsKeyPressed(OSKEY_CONTROL) /*
            */ and GetUnitAbilityLevel(GetSelectedUnit(), 'Amov') > 0 then

            call MHMsg_CallTargetMode(0, 851986, ABILITY_CAST_TYPE_POINT + ABILITY_CAST_TYPE_TARGET)
        elseif pressedKey == OSKEY_P /*
            */ and not IsKeyPressed(OSKEY_ALT) and not IsKeyPressed(OSKEY_CONTROL) /*
            */ and GetUnitAbilityLevel(GetSelectedUnit(), 'Amov') > 0 then

            call MHMsg_CallTargetMode(0, 851990, ABILITY_CAST_TYPE_POINT + ABILITY_CAST_TYPE_TARGET)
        elseif pressedKey == OSKEY_S /*
            */ and not IsKeyPressed(OSKEY_ALT) and not IsKeyPressed(OSKEY_CONTROL) /*
            */ and GetUnitAbilityLevel(GetSelectedUnit(), 'Aatk') > 0 then

            if IsKeyPressed(OSKEY_SHIFT) then
                call MHMsg_SendImmediateOrder(851972, LOCAL_ORDER_FLAG_QUEUE)
            else
                call MHMsg_SendImmediateOrder(851972, LOCAL_ORDER_FLAG_NORMAL)
            endif
        elseif pressedKey == OSKEY_H /*
            */ and not IsKeyPressed(OSKEY_ALT) and not IsKeyPressed(OSKEY_CONTROL) /*
            */ and GetUnitAbilityLevel(GetSelectedUnit(), 'Aatk') > 0 and GetUnitAbilityLevel(GetSelectedUnit(), 'Amov') > 0 then

            if IsKeyPressed(OSKEY_SHIFT) then
                call MHMsg_SendImmediateOrder(851993, LOCAL_ORDER_FLAG_QUEUE)
            else
                call MHMsg_SendImmediateOrder(851993, LOCAL_ORDER_FLAG_NORMAL)
            endif
        endif
        return false
    endfunction
    
    function CallCommandButton_Init takes nothing returns nothing
        set KeyDownTrig = CreateTrigger()
        call MHMsgKeyDownEvent_Register(KeyDownTrig)
        call TriggerAddCondition(KeyDownTrig, Condition(function OnKeyDown))
    endfunction

endlibrary
