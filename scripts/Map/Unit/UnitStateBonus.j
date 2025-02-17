
library UnitStateBonus requires UnitUtils, UnitAbility, UnitWeapon

    globals
        constant integer UNIT_BONUS_DAMAGE     = 'AUdb'
        constant integer UNIT_BONUS_ATTACK     = 'AUab'
        constant integer UNIT_BONUS_ARMOR      = 'AUeb'
        constant integer UNIT_BONUS_LIFE_REGEM = 'AUlb'
    endglobals

    function UnitGetStateBonus takes unit whichUnit, integer abilId returns real
        return Table[GetHandleId(whichUnit)].real[abilId]
    endfunction

    function UnitAddStateBonus takes unit whichUnit, real addValue, integer abilId returns real
        local real    value
        local integer h
        if whichUnit == null then
            return 0.
        endif
        call UnitAddPermanentAbility(whichUnit, abilId)
        if abilId == UNIT_BONUS_ATTACK then
            set addValue = (addValue * 1.) * 0.01
        endif
        set h     = GetHandleId(whichUnit)
        set value = Table[h].real[abilId] + addValue
        set Table[h].real[abilId] = value
        call MHAbility_SetLevelDefDataReal(abilId, 1, ABILITY_LEVEL_DEF_DATA_DATA_A, value)
        call IncUnitAbilityLevel(whichUnit, abilId)
        call DecUnitAbilityLevel(whichUnit, abilId)
        if abilId == UNIT_BONUS_LIFE_REGEM then
            call UnitAddAbility(whichUnit, 'AIml')
            call UnitRemoveAbility(whichUnit, 'AIml')
        endif
        return value
    endfunction
    function UnitSetStateBonus takes unit whichUnit, real newValue, integer abilId returns real
        local real    value
        local integer h
        if whichUnit == null then
            return 0.
        endif
        call UnitAddPermanentAbility(whichUnit, abilId)
        if abilId == UNIT_BONUS_ATTACK then
            set newValue = (newValue * 1.) * 0.01
        endif
        set h     = GetHandleId(whichUnit)
        set Table[h].real[abilId] = newValue
        call MHAbility_SetLevelDefDataReal(abilId, 1, ABILITY_LEVEL_DEF_DATA_DATA_A, newValue)
        call IncUnitAbilityLevel(whichUnit, abilId)
        call DecUnitAbilityLevel(whichUnit, abilId)
        if abilId == UNIT_BONUS_LIFE_REGEM then
            call UnitAddAbility(whichUnit, 'AIml')
            call UnitRemoveAbility(whichUnit, 'AIml')
        endif
        return newValue
    endfunction
    function UnitReduceStateBonus takes unit whichUnit, real reduceValue, integer abilId returns real
        local real    value
        local integer h
        if whichUnit == null then
            return 0.
        endif
        call UnitAddPermanentAbility(whichUnit, abilId)
        if abilId == UNIT_BONUS_ATTACK then
            set reduceValue = (reduceValue * 1.) * 0.01
        endif
        set h     = GetHandleId(whichUnit)
        set value = Table[h].real[abilId] - reduceValue
        set Table[h].real[abilId] = value
        call MHAbility_SetLevelDefDataReal(abilId, 1, ABILITY_LEVEL_DEF_DATA_DATA_A, value)
        call IncUnitAbilityLevel(whichUnit, abilId)
        call DecUnitAbilityLevel(whichUnit, abilId)
        if abilId == UNIT_BONUS_LIFE_REGEM then
            call UnitAddAbility(whichUnit, 'AIml')
            call UnitRemoveAbility(whichUnit, 'AIml')
        endif
        return value
    endfunction

    // 百分比移速奖励
    function UnitAddMoveSpeedBonusPercent takes unit whichUnit, real percent returns nothing
        if whichUnit == null then
            return
        endif
        set percent = percent * 0.01
        call MHUnit_SetData(whichUnit, UNIT_DATA_BONUS_MOVESPEED, MHUnit_GetData(whichUnit, UNIT_DATA_BONUS_MOVESPEED) + percent)
    endfunction
    function UnitReduceMoveSpeedBonusPercent takes unit whichUnit, real percent returns nothing
        if whichUnit == null then
            return
        endif
        set percent = percent * 0.01
        call MHUnit_SetData(whichUnit, UNIT_DATA_BONUS_MOVESPEED, MHUnit_GetData(whichUnit, UNIT_DATA_BONUS_MOVESPEED) - percent)
    endfunction

    // 基础护甲奖励
    function UnitAddBaseArmorBonus takes unit whichUnit, real addArmor returns nothing
        if whichUnit == null then
            return
        endif
        call MHUnit_SetData(whichUnit, UNIT_DATA_DEF_VALUE, MHUnit_GetData(whichUnit, UNIT_DATA_DEF_VALUE) + addArmor)
    endfunction

    // 技能增强
    globals
        private key SPELL_DAMAGE_AMP
    endglobals
    // 乘数
    function GetUnitSpellDamageAmplificationBonus takes unit whichUnit returns real
        if whichUnit == null then
            return 0.
        endif
        return Table[GetHandleId(whichUnit)].real[SPELL_DAMAGE_AMP]
    endfunction
    function UnitAddSpellDamageAmplificationBonus takes unit whichUnit, real value returns nothing
        if whichUnit == null then
            return
        endif
        set Table[GetHandleId(whichUnit)].real[SPELL_DAMAGE_AMP] = Table[GetHandleId(whichUnit)].real[SPELL_DAMAGE_AMP] + value
    endfunction
    function UnitReduceSpellDamageAmplificationBonus takes unit whichUnit, real value returns nothing
        if whichUnit == null then
            return
        endif
        set Table[GetHandleId(whichUnit)].real[SPELL_DAMAGE_AMP] = Table[GetHandleId(whichUnit)].real[SPELL_DAMAGE_AMP] - value
    endfunction

    // 攻击距离奖励
    globals
        private key UNIT_ATTACK_RANGE_BONUS
        private key UNIT_RANGED_ATTACK_RANGE_BONUS
    endglobals

    // 攻击距离奖励
    function GetUnitAttackRangeBonus takes unit whichUnit returns real
        return Table[GetHandleId(whichUnit)].real[UNIT_ATTACK_RANGE_BONUS]
    endfunction
    // 攻击距离奖励 远程限定
    function GetUnitRangedAttackRangeBonus takes unit whichUnit returns real
        return Table[GetHandleId(whichUnit)].real[UNIT_RANGED_ATTACK_RANGE_BONUS]
    endfunction

    function UnitUpdateAttackRangeBonus takes unit whichUnit returns nothing
        local real attackRangeBonus
        if whichUnit == null then
            return
        endif
        set attackRangeBonus = GetUnitAttackRangeBonus(whichUnit)
        if IsUnitMeleeAttacker(whichUnit) then
            set attackRangeBonus = attackRangeBonus + GetUnitRangedAttackRangeBonus(whichUnit)
        endif
        // 物编攻击距离 + 攻击距离奖励
        call MHUnit_SetAtkDataReal(whichUnit, UNIT_ATK_DATA_ATTACK_RANGE1, MHUnit_GetDefDataReal(GetUnitTypeId(whichUnit), UNIT_DEF_DATA_ATTACK_RANGE1) + attackRangeBonus)
        call UnitUpdateAttackOrder(whichUnit)
    endfunction

    function UnitAddAttackRangeBonus takes unit whichUnit, real addValue returns nothing
        local real attackRangeBonus
        if whichUnit == null then
            return
        endif
        set attackRangeBonus = Table[GetHandleId(whichUnit)].real[UNIT_ATTACK_RANGE_BONUS]
        set Table[GetHandleId(whichUnit)].real[UNIT_ATTACK_RANGE_BONUS] = attackRangeBonus + addValue
        call UnitUpdateAttackRangeBonus(whichUnit)
    endfunction
    function UnitReduceAttackRangeBonus takes unit whichUnit, real reduceValue returns nothing
        local real attackRangeBonus
        if whichUnit == null then
            return
        endif
        set attackRangeBonus = Table[GetHandleId(whichUnit)].real[UNIT_ATTACK_RANGE_BONUS]
        set Table[GetHandleId(whichUnit)].real[UNIT_ATTACK_RANGE_BONUS] = attackRangeBonus - reduceValue
        call UnitUpdateAttackRangeBonus(whichUnit)
    endfunction
    function UnitAddAttackRangeRangedAttackerOnlyBonus takes unit whichUnit, real addValue returns nothing
        local real attackRangeBonus
        if whichUnit == null then
            return
        endif
        set attackRangeBonus = Table[GetHandleId(whichUnit)].real[UNIT_RANGED_ATTACK_RANGE_BONUS]
        set Table[GetHandleId(whichUnit)].real[UNIT_RANGED_ATTACK_RANGE_BONUS] = attackRangeBonus + addValue
        call UnitUpdateAttackRangeBonus(whichUnit)
    endfunction
    function UnitReduceAttackRangeRangedAttackerOnlyBonus takes unit whichUnit, real reduceValue returns nothing
        local real attackRangeBonus
        if whichUnit == null then
            return
        endif
        set attackRangeBonus = Table[GetHandleId(whichUnit)].real[UNIT_RANGED_ATTACK_RANGE_BONUS]
        set Table[GetHandleId(whichUnit)].real[UNIT_RANGED_ATTACK_RANGE_BONUS] = attackRangeBonus - reduceValue
        call UnitUpdateAttackRangeBonus(whichUnit)
    endfunction

    // 更新属性奖励
    function UnitUpdateStateBonus takes unit whichUnit returns nothing
        call UnitUpdateAttackRangeBonus(whichUnit)
    endfunction

endlibrary
