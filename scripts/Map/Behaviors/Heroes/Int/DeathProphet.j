
scope DeathProphet

    //***************************************************************************
    //*
    //*  食腐蝠群
    //*
    //***************************************************************************
    private struct CarrionSwarm extends array

        real damage

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
                call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmDamage.mdl", targ, "origin"))
                //call sw.EnableHitAfter(targ, 0.12)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    function CarrionSwarmOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level    = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance = 810. + GetUnitCastRangeBonus(whichUnit)
        local real    damage

        if level == 1 then
            set damage = 100
        elseif level == 2 then
            set damage = 175
        elseif level == 3 then
            set damage = 250
        else
            set damage = 300
        endif
        
        if targUnit == null then
            set tx = GetSpellTargetX()
            set ty = GetSpellTargetY()
            set angle = RadianBetweenXY(x, y, tx, ty)
        else
            set tx = GetUnitX(targUnit)
            set ty = GetUnitY(targUnit)
            if targUnit == whichUnit then
                set angle = GetUnitFacing(whichUnit) * bj_DEGTORAD
            else
                set angle = RadianBetweenXY(x, y, tx, ty)
            endif
            set targUnit = null
        endif
        set sw = Shockwave.CreateFromUnit(whichUnit, angle, distance)
        call sw.SetSpeed(1100.)
        set sw.minRadius = 110.
        set sw.maxRadius = 300.
        set sw.model = "Abilities\\Spells\\Undead\\CarrionSwarm\\CarrionSwarmMissile.mdl"
        //call sw.FixTimeScale(0.033 + 1.166)
        set CarrionSwarm(sw).damage = damage
        call CarrionSwarm.Launch(sw)

        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  巫术精研
    //*
    //***************************************************************************
    //function OnWitchcraftSetCooldown takes nothing returns nothing
    //    local SimpleTick tick         = SimpleTick.GetExpired()
    //    local unit       whichUnit
    //    local ability    whichAbility
//
    //    set whichUnit    = SimpleTickTable[tick].ability['A']
    //    set whichAbility = SimpleTickTable[tick].unit['U']
//
    //    if MHAbility_GetAbilityCooldown(whichAbility) > 0.5 then
    //        call SetAbilityCooldownAbsolute(whichAbility, 0.5)
    //    endif
//
    //    call tick.Destroy()
//
    //    set whichUnit = null
    //    set whichAbility = null
    //endfunction
    //function OnWitchcraft takes unit u, ability a returns nothing
    //    local SimpleTick tick = SimpleTick.CreateEx()
//
    //    call tick.Start(0., false, function OnWitchcraftSetCooldown)
    //    set SimpleTickTable[tick].ability['A'] = a
    //    set SimpleTickTable[tick].unit['U'] = u
//
    //    set t = null
    //endfunction
    function WitchcraftOnSpellEffect takes nothing returns nothing
        local integer probability 
        local unit 	  whichUnit    = GetTriggerUnit()
        local ability whichAbility = GetSpellAbility()
        local integer level    	   = GetUnitAbilityLevel(whichUnit, 'A02C')   
        local integer id 	 	   = GetSpellAbilityId()	  
        call BJDebugMsg("cooldown:"+R2S(MHAbility_GetAbilityCustomLevelDataReal(whichAbility, GetUnitAbilityLevel(whichUnit, id), ABILITY_LEVEL_DEF_DATA_COOLDOWN)))
        if level != 0 and MHAbility_GetAbilityCustomLevelDataReal(whichAbility, GetUnitAbilityLevel(whichUnit, id), ABILITY_LEVEL_DEF_DATA_COOLDOWN) > 0.5 then
            if IsUltimateSkill(id) then
                set probability = level * 5 - 5
            else
                set probability = level * 5 + 5
            endif
            // X8R = 有效技能
            if probability > 0 and not IsMetamorphosisSkill(id) and X8R(id) then
                if GetUnitPseudoRandom(whichUnit, 'A02C', probability) or TEST_MODE then
                    call SetAbilityCooldownAbsolute(whichAbility, 0.5)
                    call CommonTextTag("傻了吧!爷还有!", 3.5, whichUnit, .03, 255, 0, 0, 255)
                endif
            endif
        endif
        set whichUnit    = null
        set whichAbility = null
    endfunction

endscope
