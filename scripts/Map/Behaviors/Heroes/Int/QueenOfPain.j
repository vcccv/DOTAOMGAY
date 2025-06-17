
scope QueenOfPain

    globals
        constant integer HERO_INDEX_QUEEN_OF_PAIN = 67
    endglobals

    //***************************************************************************
    //*
    //*  闪烁
    //*
    //***************************************************************************
    function QopBlinkOnSpellChannel takes nothing returns nothing
        local unit    whichUnit = GetTriggerUnit()
        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    value     = MHAbility_GetLevelDefDataReal(GetSpellAbilityId(), level, ABILITY_LEVEL_DEF_DATA_DATA_A)
        call MHAbility_SetAbilityCustomLevelDataReal(GetSpellAbility(), level, ABILITY_LEVEL_DEF_DATA_DATA_A, value + GetUnitCastRangeBonus(whichUnit))
        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  痛苦尖叫
    //*
    //***************************************************************************

    globals
        constant integer SKILL_INDEX_SCREAM_OF_PAIN = GetHeroSKillIndexBySlot(HERO_INDEX_QUEEN_OF_PAIN, 3)
    endglobals
    
    function CWA takes nothing returns nothing
        local integer h          = GetHandleId(GetTriggeringTrigger())
        local unit    whichUnit  = TempUnit
        local unit    targetUnit = MissileHitTargetUnit
        local real    damage     = LoadReal(HY, h, 20)
        call UnitDamageTargetEx(whichUnit, targetUnit, 1, damage)
        set whichUnit = null
        set targetUnit = null
    endfunction
    function ScreamOfPainLaunchMissimle takes unit whichUnit, unit targetUnit returns nothing
        local trigger t = LaunchMissileByUnitDummy(whichUnit, targetUnit,'h0BP', "CWA", 900, false)
        local integer h = GetHandleId(t)
        local integer level = GetUnitAbilityLevel(whichUnit,'A04A')
        local real damage
        if level == 1 then
            set damage = 135
        elseif level == 2 then
            set damage = 215
        elseif level == 3 then
            set damage = 275
        elseif level == 4 then
            set damage = 350
        endif
        call SaveReal(HY, h, 20,((damage)* 1.))
        set t = null
    endfunction

    function ScreamOfPainOnSpellEffect takes nothing returns nothing
        local unit    whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local integer level     = GetUnitAbilityLevel(whichUnit,'A04A')
        local real    x         = GetUnitX(whichUnit)
        local real    y         = GetUnitY(whichUnit)
        local real    area      = 600.

        init_group_variable()
        start_group_enum(x, y, area)

        // 敌对 存活非建筑非守卫
        if IsUnitEnemy(whichUnit, GetOwningPlayer(first)) and(IsAliveNotStrucNotWard(first)) /*and IsNotAncientOrBear(first)*/ then
            call ScreamOfPainLaunchMissimle(whichUnit, first)
        endif

        end_group_enum()

        call PlaySoundOnUnitBJ(BansheeDeathSound, 100, whichUnit)

        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  超声冲击波
    //*
    //***************************************************************************
    private struct SonicWave extends array
        
        real damage

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 7, thistype(sw).damage)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct

    endstruct

    function SonicWaveOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        //local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance  = 900. + GetUnitCastRangeBonus(whichUnit)
        local real    damage    = 200. + 90. * level
        local boolean isUpgraded = GetSpellAbilityId() == 'A28S'

        if isUpgraded then
            set damage = 325
            if GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 3 then
                set damage = 555
            elseif GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 2 then
                set damage = 440
            endif
        endif

        set tx = GetSpellTargetX()
        set ty = GetSpellTargetY()
        if x == tx and y == ty then
            set angle = GetUnitFacing(whichUnit) * bj_DEGTORAD
        else
            set angle = RadianBetweenXY(x, y, tx, ty)
        endif
  
        set sw = Shockwave.CreateFromUnit(whichUnit, angle, distance)
        call sw.SetSpeed(1200.)
        set sw.minRadius = 100.
        set sw.maxRadius = 450.
        set sw.model = "effects\\SonicBreathStream.mdx"
        set SonicWave(sw).damage = damage
        call SonicWave.Launch(sw)

        set whichUnit = null
    endfunction

endscope
