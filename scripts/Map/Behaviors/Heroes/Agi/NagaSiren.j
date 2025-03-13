
scope NagaSiren

    globals
        constant integer HERO_INDEX_NAGA_SIREN = 7
    endglobals
    //***************************************************************************
    //*
    //*  镜像
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_MIRROR_IMAGE = GetHeroSKillIndexBySlot(HERO_INDEX_NAGA_SIREN, 2)
    endglobals
    function MirrorImageOnSpellEffect takes nothing returns nothing
        local unit 	  whichUnit 	= GetTriggerUnit()
        local integer level			= GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local integer max
        local real    damageDealt
        local real    damageTaken
        local integer buffId
        local real 	  dur
        local real 	  delay
        local string  specialArt
        local string  missileArt
        local real 	  missileSpeed
        local real 	  rng
        local real 	  area

        set max		     = 3
        set damageDealt  = 0.25 + level * 0.05
        set damageTaken  = 7.00 - level * 1.
        set buffId       = 'Bngi'
        set dur			 = 30.
        set delay		 = 0.3
        set missileSpeed = 1000
        set rng		     = 128.
        set area		 = 1000.
        set specialArt   = "war3mapImported\\NagaSirenMirrorImage_4.mdx"
        set missileArt   = "Abilities\\Spells\\Orc\\MirrorImage\\MirrorImageMissile.mdl"
        if not IsUnitType(whichUnit, UNIT_TYPE_MELEE_ATTACKER) then
            set damageDealt = 0.20 + level * 0.05
            set damageTaken = 7.50 - level * 1.
            call SetUnitAbilityLevelCooldown(whichUnit, GetSpellAbility(), level, 50.)
        else
            call SetUnitAbilityLevelCooldown(whichUnit, GetSpellAbility(), level, 40.)
        endif

        call UnitMirrorImage(whichUnit, max, damageDealt, damageTaken, buffId, dur, delay, specialArt, missileArt, missileSpeed, rng, area)
        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  海妖之歌
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SONG_OF_THE_SIREN = GetHeroSKillIndexBySlot(HERO_INDEX_NAGA_SIREN, 4)
    endglobals
    function VLI takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), JSV) == false then
            call GroupAddUnit(JTV, GetEnumUnit())
            call UnitRemoveAbility(GetEnumUnit(),'B02J')
            call UnitRemoveAbility(GetEnumUnit(),'BUsp')
            call UnitRemoveAbility(GetEnumUnit(),'Bust')
        endif
    endfunction
    function VMI takes nothing returns nothing
        call UnitRemoveAbility(GetEnumUnit(),'B02J')
        call UnitRemoveAbility(GetEnumUnit(),'BUsp')
        call UnitRemoveAbility(GetEnumUnit(),'Bust')
    endfunction
    function VPI takes nothing returns nothing
        if IsUnitInGroup(GetEnumUnit(), JQV) == false then
            call SetUnitOwner(JPV, GetOwningPlayer(GetEnumUnit()), false)
            if IssueTargetOrderById(JPV, 852227, GetEnumUnit()) then
                call GroupAddUnit(JQV, GetEnumUnit())
            endif
        endif
    endfunction
    function VQI takes nothing returns nothing
        call SetWidgetLife(GetEnumUnit(), GetWidgetLife(GetEnumUnit()) + .08 * GetUnitState(GetEnumUnit(), UNIT_STATE_MAX_LIFE)* .05)
    endfunction
    function VSI takes nothing returns boolean
        return IsUnitAlly(TempUnit, GetOwningPlayer(GetFilterUnit())) and IsAliveNotStrucNotWard(GetFilterUnit())
    endfunction
    function VTI takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit =(LoadUnitHandle(HY, h, 2))
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local group g
        local group D7R =(LoadGroupHandle(HY, h, 187))
        //if GetTriggerEvalCount(t)== 10 then
        //    // call UnitAddPermanentAbility(whichUnit,'A24E')
        //    // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A07U', false)
        //    // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A38E', false)
        //    // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A24E', true)
        //endif
        if GetTriggerEventId() == EVENT_WIDGET_DEATH or GetTriggerEvalCount(t)> 140 or(GetTriggerEventId() == EVENT_UNIT_SPELL_EFFECT and GetSpellAbilityId()=='A24E') then
            // if Rubick_AbilityFilter(whichUnit , 'A07U') or(LoadInteger(HY,(GetHandleId(whichUnit)), 704))=='A38E' then
            //     call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A07U', true)
            //     call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A38E', true)
            // endif
            // call SetPlayerAbilityAvailableEx(GetOwningPlayer(whichUnit),'A24E', false)

            call ToggleSkill.SetState(whichUnit, 'A07U', false)

            call ForGroup(D7R, function VMI)
            call DeallocateGroup(D7R)
            call DestroyEffect((LoadEffectHandle(HY, h, 32)))
            call FlushChildHashtable(HY, h)
            call DestroyTrigger(t)
        else
            set g = AllocationGroup(226)
            set TempUnit = whichUnit
            set JPV = dummyCaster
            set JQV = D7R
            call GroupEnumUnitsInRange(g, x, y, 1250+ 25, Condition(function DCX))
            call ForGroup(g, function VPI)
            set JSV = g
            set JTV = AllocationGroup(227)
            call ForGroup(D7R, function VLI)
            call GroupRemoveGroup(JTV, D7R)
            set TempUnit = whichUnit
            if GetUnitAbilityLevel(whichUnit,'A38E')> 0 then
                call GroupEnumUnitsInRange(g, x, y, 1275, Condition(function VSI))
                call ForGroup(g, function VQI)
            endif
            call DeallocateGroup(g)
            call DeallocateGroup(JTV)
        endif
        set t = null
        set g = null
        set whichUnit = null
        set D7R = null
        set dummyCaster = null
        return false
    endfunction
    function SongOfTheSirenOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local unit dummyCaster = CreateUnit(GetOwningPlayer(whichUnit),'e00E', x, y, 0)
        call UnitAddAbility(dummyCaster,'A07T')

        call ToggleSkill.SetState(whichUnit, 'A07U', true)
        call SetUnitAbilityCooldownAbsolute(whichUnit, 'A24E', 1.)

        call TriggerRegisterTimerEvent(t, .05, true)
        call TriggerRegisterDeathEvent(t, whichUnit)
        call TriggerRegisterUnitEvent(t, whichUnit, EVENT_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(t, Condition(function VTI))
        call SaveGroupHandle(HY, h, 187,(AllocationGroup(228)))
        call SaveUnitHandle(HY, h, 2,(whichUnit))
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveEffectHandle(HY, h, 32,(AddSpecialEffectTarget("war3mapImported\\SongOfTheSiren_2.mdx", whichUnit, "origin")))
        set t = null
        set whichUnit = null
        set dummyCaster = null
    endfunction

endscope
