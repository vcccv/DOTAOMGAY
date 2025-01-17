
library UnitModel
    
    function JFX takes unit u returns nothing
        local integer unitTypeId = GetUnitTypeId(u)
        local integer a = 255
        if HaveSavedInteger(ObjectHashTable, GetHandleId(u),'ALPH') then
            set a = LoadInteger(ObjectHashTable, GetHandleId(u),'ALPH')
        endif
        call SetUnitVertexColor(u, 128, 192, 192, a)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 0, 128)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 1, 192)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 2, 192)
        call SaveInteger(ObjectHashTable, GetHandleId(u),'ALPH', a)
    endfunction
    // 恢复单位的RGB
    function ResetUnitVertexColor takes unit u returns nothing
        local integer unitTypeId = GetUnitTypeId(u)
        local integer r = 255
        local integer g = 255
        local integer b = 255
        local integer a = 255
        if HaveSavedInteger(UnitRGBHashTable, unitTypeId, 0) then
            set r = LoadInteger(UnitRGBHashTable, unitTypeId, 0)
        endif
        if HaveSavedInteger(UnitRGBHashTable, unitTypeId, 1) then
            set g = LoadInteger(UnitRGBHashTable, unitTypeId, 1)
        endif
        if HaveSavedInteger(UnitRGBHashTable, unitTypeId, 2) then
            set b = LoadInteger(UnitRGBHashTable, unitTypeId, 2)
        endif
        if HaveSavedInteger(ObjectHashTable, GetHandleId(u),'ALPH') then
            set a = LoadInteger(ObjectHashTable, GetHandleId(u),'ALPH')
        endif
        call SetUnitVertexColor(u, r, g, b, a)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 0, r)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 1, g)
        call SaveInteger(ObjectHashTable, GetHandleId(u), IC + 2, b)
        call SaveInteger(ObjectHashTable, GetHandleId(u),'ALPH', a)
    endfunction
    function SetUnitVertexColorEx takes unit u, integer r, integer g, integer b, integer a returns nothing
        local integer unitTypeId = GetUnitTypeId(u)
        local integer h = GetHandleId(u)
        if r ==-1 then
            if HaveSavedInteger(ObjectHashTable, h, IC + 0) then
                set r = LoadInteger(ObjectHashTable, h, IC + 0)
            elseif HaveSavedInteger(UnitRGBHashTable, unitTypeId, 0) then
                set r = LoadInteger(UnitRGBHashTable, unitTypeId, 0)
            else
                set r = 255
            endif
        endif
        if g ==-1 then
            if HaveSavedInteger(ObjectHashTable, h, IC + 1) then
                set g = LoadInteger(ObjectHashTable, h, IC + 1)
            elseif HaveSavedInteger(UnitRGBHashTable, unitTypeId, 1) then
                set g = LoadInteger(UnitRGBHashTable, unitTypeId, 1)
            else
                set g = 255
            endif
        endif
        if b ==-1 then
            if HaveSavedInteger(ObjectHashTable, h, IC + 2) then
                set b = LoadInteger(ObjectHashTable, h, IC + 2)
            elseif HaveSavedInteger(UnitRGBHashTable, unitTypeId, 2) then
                set b = LoadInteger(UnitRGBHashTable, unitTypeId, 2)
            else
                set b = 255
            endif
        endif
        if a ==-1 then
            if HaveSavedInteger(ObjectHashTable, h,'ALPH') then
                set a = LoadInteger(ObjectHashTable, h,'ALPH')
            else
                set a = 255
            endif
        endif
        call SetUnitVertexColor(u, r, g, b, a)
        call SaveInteger(ObjectHashTable, h, IC + 0, r)
        call SaveInteger(ObjectHashTable, h, IC + 1, g)
        call SaveInteger(ObjectHashTable, h, IC + 2, b)
        call SaveInteger(ObjectHashTable, h,'ALPH', a)
    endfunction

endlibrary
