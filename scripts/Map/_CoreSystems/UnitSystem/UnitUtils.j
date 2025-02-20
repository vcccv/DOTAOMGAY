library UnitUtils
    
    function GetUnitGoldCostById takes integer unitId returns integer
        if IsHeroUnitId(unitId) then
            return 0
        endif
        return MHUnit_GetDefDataInt(unitId, UNIT_DEF_DATA_GOLD_COST)
    endfunction

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
    
    // 生命恢复
    function UnitRegenLife takes unit source, unit target, real value returns nothing
        call MHUnit_RestoreLife(target, value)
    endfunction
    function UnitRegenMana takes unit source, unit target, real value returns nothing
        call MHUnit_RestoreMana(target, value)
    endfunction
    
    globals
        key UNIT_LAST_DAMGED_TIME
    endglobals
    function GetUnitLastDamagedTime takes unit whichUnit returns real
        return Table[GetHandleId(whichUnit)].real[UNIT_LAST_DAMGED_TIME]
    endfunction
    
endlibrary
