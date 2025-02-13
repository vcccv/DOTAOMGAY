library UnitMorph requires UnitWeapon, UnitLimitation, UnitUpdate

    globals
        private trigger SpellFinishTrig
        private trigger SpellEndCastTrig
    endglobals
    
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

    private function MorphUpdateUnit takes unit whichUnit returns nothing
        call UnitUpdateData(whichUnit)
    endfunction

    private function MorphUpdateUnitOnExpired takes nothing returns nothing
        local SimpleTick tick      = SimpleTick.GetExpired()

        call MorphUpdateUnit(SimpleTickTable[tick].unit['u'])
        call tick.Destroy()
    endfunction

    function MorphUpdateUnitToTimed takes unit whichUnit, real timeout returns nothing
        local SimpleTick tick             
        set tick = SimpleTick.CreateEx()
        call tick.Start(timeout, false, function MorphUpdateUnitOnExpired)
        set SimpleTickTable[tick].unit['u'] = whichUnit     
    endfunction

    private function OnSpellFinish takes nothing returns nothing
        local unit       whichUnit = GetTriggerUnit()
        local integer    abilId    = GetSpellAbilityId()
        local integer    baseId    = MHAbility_GetBaseId(whichUnit, abilId)
        
        if baseId == 'AEme' then
            call MorphUpdateUnit(whichUnit)
        elseif baseId == 'Abrf' or baseId == 'ANrg' then
            call MorphUpdateUnitToTimed(whichUnit, 0.)
        endif

        set whichUnit = null
    endfunction

    private function OnSpellEndCast takes nothing returns nothing
        local unit       whichUnit = GetTriggerUnit()
        local integer    abilId    = GetSpellAbilityId()
        local integer    baseId    = MHAbility_GetBaseId(whichUnit, abilId)
        local integer    level     = GetUnitAbilityLevel(whichUnit, abilId)
        local real       dur
        
        if baseId == 'ANcr' then
            call MorphUpdateUnit(whichUnit)
            set dur = MHAbility_GetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_NORMAL_DUR) + MHAbility_GetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_HERO_DUR)
            call MorphUpdateUnitToTimed(whichUnit, dur + 0.001)
        endif

        set whichUnit = null
    endfunction

    function UnitMorph_Init takes nothing returns nothing
        set SpellFinishTrig  = CreateTrigger()
        set SpellEndCastTrig = CreateTrigger()
        
        call TriggerRegisterAnyUnitEvent(SpellFinishTrig, EVENT_PLAYER_UNIT_SPELL_FINISH)
        call TriggerAddCondition(SpellFinishTrig, Condition(function OnSpellFinish))

        call TriggerRegisterAnyUnitEvent(SpellEndCastTrig, EVENT_PLAYER_UNIT_SPELL_ENDCAST)
        call TriggerAddCondition(SpellEndCastTrig, Condition(function OnSpellEndCast))
    endfunction

endlibrary
