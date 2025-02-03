library UnitUtils
    

    function GetUnitCollisionSize takes unit whichUnit returns real
        return MHUnit_GetDefDataReal(GetUnitTypeId(whichUnit), UNIT_DEF_DATA_COLLISION)
    endfunction
    
    function UnitDodgeMissile takes unit whichUnit returns nothing
        local boolean b
        set b = IsUnitSelected(whichUnit, User.Local)
        call ShowUnit(whichUnit, false)
        call ShowUnit(whichUnit, true)
        if b then
            call SelectUnit(whichUnit, true)
        endif
    endfunction
    
endlibrary
