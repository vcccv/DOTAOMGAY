
library UnitWeapon requires Base, UnitUtils

    globals
        key UNIT_BONUS_RANGE
        key UNIT_BONUS_RANGE_ONLY_RANGE
    endglobals

    function IsAttackOrdersId takes integer id returns boolean
        return id == 851983 or id == 851984 or id == 851985 or id == 851971
    endfunction

    function FixOrderActions takes nothing returns boolean
        local trigger trig           = GetTriggeringTrigger()
        local integer h              = GetHandleId(trig)
        local unit    whichUnit      = LoadUnitHandle(HY, h, 0)
        local integer currentOrderId = GetUnitCurrentOrder(whichUnit)

        if IsAttackOrdersId(currentOrderId) and UnitAlive(whichUnit) then
            call EXPauseUnit(whichUnit, true)
            call EXPauseUnit(whichUnit, false)
        endif
        call FlushChildHashtable(HY, h)
        call DestroyTrigger(trig)

        set whichUnit = null
        set trig      = null
        return false
    endfunction

    function FixUnitOrder takes unit whichUnit returns nothing
        local integer h = CreateTimerEventTrigger(0., false, function FixOrderActions)
        call SaveUnitHandle(HY, h, 0, whichUnit)
    endfunction

    function SetUnitRange takes unit whichUnit, real range returns nothing
        call MHUnit_SetAtkDataReal(whichUnit, UNIT_ATK_DATA_ATTACK_RANGE1, range)
    endfunction

    function GetUnitDefaultAttackRangeById takes integer uid returns real
        return MHUnit_GetDefDataReal(uid, UNIT_DEF_DATA_ATTACK_RANGE1)
    endfunction

    function GetUnitDefaultAttackRange takes unit whichUnit returns real
        return GetUnitDefaultAttackRangeById(GetUnitTypeId(whichUnit))
    endfunction

    function GetUnitBonusRange takes unit whichUnit, boolean isOnlyRange returns real
        if isOnlyRange then
            return LoadReal(UnitDataHashTable, GetHandleId(whichUnit), UNIT_BONUS_RANGE_ONLY_RANGE)
        endif
        return LoadReal(UnitDataHashTable, GetHandleId(whichUnit), UNIT_BONUS_RANGE)
    endfunction

    function UpdateUnitAttackRangeBonus takes unit whichUnit returns nothing
        local real bonusRange = GetUnitBonusRange(whichUnit, false)
        if IsUnitType(whichUnit, UNIT_TYPE_RANGED_ATTACKER) then
            set bonusRange = bonusRange + GetUnitBonusRange(whichUnit, true)
        endif
        call SetUnitAcquireRange(whichUnit, GetUnitDefaultAcquireRange(whichUnit) + bonusRange)
        call SetUnitRange(whichUnit, GetUnitDefaultAttackRange(whichUnit) + bonusRange)
        call FixUnitOrder(whichUnit)
    endfunction

    function AddUnitBonusRange takes unit whichUnit, real bonusValue, boolean isOnlyRange returns nothing
        local real newValue = GetUnitBonusRange(whichUnit, isOnlyRange) + bonusValue
        if isOnlyRange then
            call SaveReal(UnitDataHashTable, GetHandleId(whichUnit), UNIT_BONUS_RANGE_ONLY_RANGE, newValue)
        else
            call SaveReal(UnitDataHashTable, GetHandleId(whichUnit), UNIT_BONUS_RANGE, newValue)
        endif
        call UpdateUnitAttackRangeBonus(whichUnit)
    endfunction

endlibrary
