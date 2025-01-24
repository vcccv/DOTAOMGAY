library UnitUtils
    
    function UnitAddPermanentAbility takes unit whichUnit, integer ab returns boolean
        return UnitAddAbility(whichUnit, ab) and UnitMakeAbilityPermanent(whichUnit, true, ab)
    endfunction

    function UnitAddPermanentAbilitySetLevel takes unit u, integer id, integer lv returns nothing
        if GetUnitAbilityLevel(u, id) == 0 then
            call UnitAddPermanentAbility(u, id)
        endif
        call SetUnitAbilityLevel(u, id, lv)
    endfunction

endlibrary
