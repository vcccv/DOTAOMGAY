library UnitMoprh
    
    // 单位逆变身
    function YDWEUnitTransform takes unit whichUnit, integer typeId returns nothing
        if GetUnitTypeId(whichUnit) != typeId then
            call UnitAddAbility(whichUnit, 'M000')
            call MHAbility_SetLevelDefDataInt('M000', 1, ABILITY_LEVEL_DEF_DATA_UNIT_ID, GetUnitTypeId(whichUnit))
            call EXSetAbilityAEmeDataA(EXGetUnitAbility(whichUnit, 'M000'), GetUnitTypeId(whichUnit))
            call UnitRemoveAbility(whichUnit, 'M000')
            call UnitAddAbility(whichUnit, 'M000')
            call EXSetAbilityAEmeDataA(EXGetUnitAbility(whichUnit, 'M000'), typeId)
            call UnitRemoveAbility(whichUnit, 'M000')
            // 修正单位的 技能
            //call FixUnitSkillsBug(whichUnit)
        endif
    endfunction

endlibrary
