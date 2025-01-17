
scope DragonKnight

    //***************************************************************************
    //*
    //*  火焰气息
    //*
    //***************************************************************************
    private struct BreatheFire extends array
        
        real    damage
        integer level

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            local integer i
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
                // 待优化 魔法书套耐久光环傻卵操作
                set i = thistype(sw).level
                call UnitAddAbilityToTimed(targ, 'A3KW'-1 + i, 1, 11, 'B387')
                call UnitMakeAbilityPermanent(targ, true, 'A3KS'-1 + i)
                call SetPlayerAbilityAvailable(GetOwningPlayer(targ), 'A3KW'-1 + i, false)
            endif
            return false
        endmethod

        implement ShockwaveStruct
    endstruct

    function BreatheFireOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x = GetUnitX(whichUnit)
        local real      y = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer level    = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    distance = 650. + GetUnitCastRangeBonus(whichUnit)
        local real    damage

        if level == 1 then
            set damage = 90
        elseif level == 2 then
            set damage = 170
        elseif level == 3 then
            set damage = 240
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
        set sw = Shockwave.CreateByDistance(whichUnit, x, y, angle, distance)
        call sw.SetSpeed(1050.)
        call sw.FixTimeScale(0.5)
        set sw.minRadius = 150.
        set sw.maxRadius = 250.
        set sw.model = "Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireMissile.mdl"
        set BreatheFire(sw).damage = damage
        set BreatheFire(sw).level = level
        call BreatheFire.Launch(sw)

        set whichUnit = null
    endfunction

    /*

    C;Y5192;X1;K"A3ES"
C;X2;K"ANbf"
C;X11;K4
C;X15;K"air,enemies,friend,ground"
C;X17;K5
C;X18;K5
C;X19;K9
C;X20;K90
C;X21;K150
C;X22;K500
C;X23;K90
C;X24;K99999
C;X25;K500
C;X26;K250
C;X33;K"BNbf"
C;X35;K"air,enemies,friend,ground"
C;X37;K5
C;X38;K5
C;X39;K9
C;X40;K100
C;X41;K150
C;X42;K500
C;X43;K170
C;X44;K99999
C;X45;K500
C;X46;K250
C;X53;K"BNbf"
C;X55;K"air,enemies,friend,ground"
C;X57;K5
C;X58;K5
C;X59;K9
C;X60;K110
C;X61;K150
C;X62;K500
C;X63;K240
C;X64;K99999
C;X65;K500
C;X66;K250
C;X73;K"BNbf"
C;X75;K"air,enemies,friend,ground"
C;X77;K5
C;X78;K5
C;X79;K9
C;X80;K120
C;X81;K150
C;X82;K500
C;X83;K300
C;X84;K99999
C;X85;K500
C;X86;K250
C;X93;K"BNbf"

    // 火焰气息
    function BreatheFireDamagedEvent takes nothing returns nothing
        local integer i = GetUnitAbilityLevel( DamagedEventSourceUnit ,'A3ES')
        if GetUnitAbilityLevel( DamagedEventSourceUnit ,'A3ES')> 0 then
            call UnitAddAbilityToTimed(DamagedEventTargetUnit,'A3KW'-1 + i, 1, 11,'B387')
            call UnitMakeAbilityPermanent(DamagedEventTargetUnit, true,'A3KS'-1 + i)
            call SetPlayerAbilityAvailable(GetOwningPlayer(DamagedEventTargetUnit),'A3KW'-1 + i, false)
        endif
    endfunction
    function ZMV takes nothing returns nothing
        local unit whichUnit = GetTriggerUnit()
        local unit d = CreateUnit(GetOwningPlayer(whichUnit),'e00E', GetUnitX(whichUnit), GetUnitY(whichUnit), 0)
        call UnitAddAbility(d,'A3ES')
        call SetUnitAbilityLevel(d,'A3ES', GetUnitAbilityLevel(whichUnit,'A03F'))
        call TGV(3)
        if GetSpellTargetUnit() == whichUnit then
            call B1R(d, "breathoffire", GetUnitX(whichUnit)+ 1 * Cos(bj_DEGTORAD * GetUnitFacing(whichUnit)), GetUnitY(whichUnit)+ 1 * Sin(bj_DEGTORAD * GetUnitFacing(whichUnit)))
        else
            call B1R(d, "breathoffire", GetSpellTargetX(), GetSpellTargetY())
        endif
        set d = null
        set whichUnit = null
    endfunction
    */

endscope
