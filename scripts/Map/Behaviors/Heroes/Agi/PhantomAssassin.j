scope PhantomAssassin

    globals
        constant integer HERO_INDEX_PHANTOM_ASSASSIN = 60
    endglobals
    //***************************************************************************
    //*
    //*  窒息之刃
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_STIFLING_DAGGER = GetHeroSKillIndexBySlot(HERO_INDEX_PHANTOM_ASSASSIN, 1)
    endglobals
    // 窒息之刃
    function StiflingDaggerOnMissileHit takes nothing returns nothing
        local integer h           = GetHandleId(GetTriggeringTrigger())
        local unit    whichUnit  = TempUnit
        local unit    targetUnit  = MissileHitTargetUnit
        local integer level       = (LoadInteger(HY, h, 5))
        local real    damage      = level * 40 + 20
        local unit    dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(targetUnit), GetUnitY(targetUnit), 0)
        local boolean b 		  = LoadBoolean(HY, h, 6)
        if b then
            set damage = damage * LoadReal(HY, h, 6)
        endif
        call UnitAddPermanentAbility(dummyCaster,'A0YL')
        call SetUnitAbilityLevel(dummyCaster,'A0YL', level)
        call IssueTargetOrderById(dummyCaster, 852075, targetUnit)
        if IsUnitType(targetUnit, UNIT_TYPE_HERO) then
            set damage = damage / 2
        endif
        
        if UnitAlive(targetUnit) and LoadBoolean(HY, h, 0) then
            call UnitLaunchAttack(whichUnit, targetUnit)
        endif

        call UnitDamageTargetEx(whichUnit, targetUnit, 3, damage)

        if b then
            call CommonTextTag(I2S(R2I(damage)) + "!", 3, targetUnit, .02, 255, 0, 0, 255)
        endif
        
        set b = false
        if IsUnitDummy(whichUnit) and HaveSavedHandle(HY, GetHandleId(whichUnit), 0) then
            set whichUnit = LoadUnitHandle(HY, GetHandleId(whichUnit), 0)
            set b = true
        endif
        // 回音护盾？
        if b == false and GetUnitAbilityLevel(targetUnit,'A3E9') == 1 and IsUnitMagicImmune(whichUnit) == false then
            set Q2 = level
            set TempUnit = whichUnit
            set MissileHitTargetUnit = targetUnit
            call ExecuteFunc("Z3I")
        endif
        set whichUnit = null
        set targetUnit = null
        set dummyCaster = null
    endfunction
    function StiflingDaggerOnMissileLaunch takes unit trigUnit, unit targetUnit, integer level returns nothing
        local trigger t 
        local integer h
        local unit u
        if IsUnitDummy(trigUnit) then
            set trigUnit = PlayerHeroes[GetPlayerId(GetOwningPlayer(trigUnit))]
        endif
        set t = LaunchMissileByUnitDummy(trigUnit, targetUnit,'h010', "StiflingDaggerOnMissileHit", 1200, false)
        set h = GetHandleId(t)
        set u = LoadUnitHandle(HY, GetHandleId(t), 45)
        
        if IsUnitType(trigUnit, UNIT_TYPE_MELEE_ATTACKER) then
            call SaveBoolean(HY, h, 0, true)
        else
            call UnitLaunchAttack(trigUnit, targetUnit)
        endif

        call SaveInteger(HY, h, 5, level)
        call SaveInteger(HY, h, 6, level -1)
        // if level > 1 and GetUnitPseudoRandom(trigUnit,'P240', 15) then
        //     call SaveBoolean(HY, h, 6, true)
        //     call SaveReal(HY, h, 6, .5 + level * 1.)
        //     call SetUnitScale(u, 2.5, 0, 0)
        //     call SetUnitVertexColor(u, 255, 50, 50, 255)
        // endif
        set t = null
        set u = null
    endfunction
    function Z3I takes nothing returns nothing
        call T4V(MissileHitTargetUnit)
        if UnitHasSpellShield(TempUnit) == false then
            call StiflingDaggerOnMissileLaunch(MissileHitTargetUnit, TempUnit, Q2)
        endif
    endfunction
    function StiflingDaggerOnSpellEffect takes nothing returns nothing
        if not UnitHasSpellShield(GetSpellTargetUnit()) then
            call StiflingDaggerOnMissileLaunch(GetTriggerUnit(), GetSpellTargetUnit(), GetUnitAbilityLevel(GetTriggerUnit(),'A0YM'))
        endif
    endfunction

endscope
