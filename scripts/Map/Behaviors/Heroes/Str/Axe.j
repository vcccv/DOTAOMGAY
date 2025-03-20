scope Axe

    globals
        constant integer HERO_INDEX_AXE = 82
    endglobals
    //***************************************************************************
    //*
    //*  反击螺旋
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_COUNTER_HELIX = GetHeroSKillIndexBySlot(HERO_INDEX_AXE, 3)
    endglobals
    
    function CounterHelixOnAttackedAS takes unit trigUnit returns nothing
        //local unit d = I_X(trigUnit)
        local integer level = GetUnitAbilityLevel(trigUnit,'P327')
        local real    damageValue = level * 35 + 65
        local real    x
        local real    y
        local real    area = 275.

        init_group_variable()
        
        call StartUnitAbilityCooldown(trigUnit, HeroSkill_BaseId[SKILL_INDEX_COUNTER_HELIX])
        set x = GetUnitX(trigUnit)
        set y = GetUnitY(trigUnit)

        start_group_enum(x, y, area)

        if IsUnitAlive(first) and IsUnitEnemy(trigUnit, GetOwningPlayer(first)) /*
            */ and not IsUnitWard(first) and not IsUnitStructure(first) then

            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", first, "origin"))
            call UnitDamageTargetEx(trigUnit, first, 2, damageValue)

        endif

        end_group_enum()

        if (GetUnitTypeId(trigUnit)!='Nbbc' and GetUnitTypeId(trigUnit)!='Opgh') then
            call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\SpinFX3.mdx", trigUnit, "origin"))
        else
            call SetUnitAnimation(trigUnit, "spin")
        endif
        call BAX(trigUnit, .6)
    endfunction
    function CounterHelixOnAttackedFilter takes unit sourceUnit, unit targetUnit returns nothing
        if GetUnitAbilityLevel(targetUnit, HeroSkill_BaseId[SKILL_INDEX_COUNTER_HELIX]) > 1 then
            call BJDebugMsg(R2S(GetUnitAbilityCooldownRemaining(targetUnit, HeroSkill_BaseId[SKILL_INDEX_COUNTER_HELIX])))
        endif
        if GetUnitAbilityLevel(targetUnit,'B03P')> 0 and not IsUnitType(sourceUnit, UNIT_TYPE_STRUCTURE) /*
            */ and not (IsUnitType(sourceUnit, UNIT_TYPE_MECHANICAL) and not IsUnitWard(sourceUnit) or IsUnitDefenseTypeFort(sourceUnit)) /*
            */ and IsUnitEnemy(sourceUnit, GetOwningPlayer(targetUnit)) and GetUnitAbilityLevel(targetUnit,'A1HX') == 0 /*
            */ and not IsUnitBroken(targetUnit) and GetUnitAbilityCooldownRemaining(targetUnit, HeroSkill_BaseId[SKILL_INDEX_COUNTER_HELIX]) == 0./*
            */ and GetUnitPseudoRandom(targetUnit, 'B03P', 20) then
            call CounterHelixOnAttackedAS(targetUnit)
        endif
    endfunction
    function CounterHelixOnAttacked takes nothing returns nothing
        call CounterHelixOnAttackedFilter(DESource, DETarget)
    endfunction
    function CounterHelixOnInitializer takes nothing returns nothing
        call RegisterUnitAttackFunc("CounterHelixOnAttacked",-1)
    endfunction

endscope
