library UnitUtils requires Table
    
    //***************************************************************************
    //*
    //*  单位召唤
    //*
    //***************************************************************************
    globals
        private key SUMMON_SOURCE
    endglobals
    function SummonUnit takes unit summoningUnit, integer unitId, real x, real y, real face returns unit
        set bj_lastCreatedUnit = CreateUnit(GetOwningPlayer(summoningUnit), unitId, x, y, face)
        set Table[GetHandleId(bj_lastCreatedUnit)].unit[SUMMON_SOURCE] = summoningUnit
        return bj_lastCreatedUnit
    endfunction
    // 用SummonUnit创建的召唤单位的来源单位
    function GetUnitSummonSource takes unit summonedUnit returns unit
        return Table[GetHandleId(summonedUnit)].unit[SUMMON_SOURCE]
    endfunction

    function GetUnitGoldCostById takes integer unitId returns integer
        if IsHeroUnitId(unitId) then
            return 0
        endif
        return MHUnit_GetDefDataInt(unitId, UNIT_DEF_DATA_GOLD_COST)
    endfunction

    function UnitModifyPosition takes unit whichUnit returns nothing
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        call SetUnitX(whichUnit, MHUnit_ModifyPositionX(whichUnit, x, y))
        call SetUnitY(whichUnit, MHUnit_ModifyPositionY(whichUnit, x, y))
    endfunction

    function SetUnitPositionEx takes unit whichUnit, real x, real y returns nothing
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
