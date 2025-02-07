library UnitUtils
    
    function UnitModifyPostion takes unit whichUnit returns nothing
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        call SetUnitX(whichUnit, MHUnit_ModifyPositionX(whichUnit, x, y))
        call SetUnitY(whichUnit, MHUnit_ModifyPositionY(whichUnit, x, y))
    endfunction

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
