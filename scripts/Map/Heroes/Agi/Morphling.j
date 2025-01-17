
scope Morphling

    //***************************************************************************
    //*
    //*  波浪形态
    //*
    //***************************************************************************
    globals
        private constant key WAVEFORM_COUNT
    endglobals
    private struct MorphlingWave extends array
        
        real    damage
        integer data

        static method OnRemove takes Shockwave sw returns boolean
            if not IsUnitType(sw.owner, UNIT_TYPE_HERO) then
                return false
            endif
            if IsUnitType(sw.owner, UNIT_TYPE_HERO) then
                set Table[GetHandleId(sw.owner)][WAVEFORM_COUNT] = Table[GetHandleId(sw.owner)][WAVEFORM_COUNT] - 1
                if Table[GetHandleId(sw.owner)][WAVEFORM_COUNT] == 0 then
                    call SaveBoolean(OtherHashTable, GetHandleId(sw.owner), 99, false)
                endif
            endif
            call UnitSubCantSelectCount(sw.owner)
            call UnitSubHideByColorCount(sw.owner)
            call UnitSubPathingCount(sw.owner)
            call UnitSubInvulnerableCount(sw.owner)
            return false
        endmethod

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
            endif
            return false
        endmethod

        static method OnPeriod takes Shockwave sw returns boolean
            local real x = CoordinateX50(sw.x)
            local real y = CoordinateY50(sw.y)
            call SetUnitX(sw.owner, x)
            call SetUnitY(sw.owner, y)
            if thistype(sw).data == 1 then
                call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", x, y))
                set thistype(sw).data = 0
            endif
            set thistype(sw).data = thistype(sw).data + 1
            // 比如存在被生命移除击杀的可能性
            if not IsUnitType(sw.owner, UNIT_TYPE_HERO) and not UnitAlive(sw.owner) then
                return true
            endif
            return false
        endmethod

        implement ShockwaveStruct
    endstruct

    // 可以攻击，但不能被移动，如果被强制位移或击杀，则终止?
    function WaveformOnSpellEffect takes nothing returns nothing
        local unit      whichUnit = GetTriggerUnit()
        local unit      targUnit  = GetSpellTargetUnit()
        local real      x         = GetUnitX(whichUnit)
        local real      y         = GetUnitY(whichUnit)
        local real      tx
        local real      ty
        local real      angle
        local Shockwave sw

        local integer   level     = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real      distance
        local real      damage

        //if targUnit == null then
            set tx = GetSpellTargetX()
            set ty = GetSpellTargetY()
            set angle = RadianBetweenXY(x, y, tx, ty)
        //else
        //    set tx = GetUnitX(targUnit)
        //    set ty = GetUnitY(targUnit)
        //    set targUnit = null
        //endif
        set distance = GetDistanceBetween(x, y, tx, ty)
        set sw = Shockwave.CreateByDistance(whichUnit, x, y, angle, distance)
        call sw.SetSpeed(1250.)
        set sw.minRadius = 200.
        set sw.maxRadius = 200.
        set MorphlingWave(sw).damage = 25. + 75. * level
        call MorphlingWave.Launch(sw)

        if IsUnitType(whichUnit, UNIT_TYPE_HERO) then
            call UnitAddInvulnerableCount(whichUnit)
            call UnitAddPathingCount(whichUnit)
            call UnitAddCantSelectCount(whichUnit)
            call UnitAddHideByColorCount(whichUnit)
            
            call ShowUnit(whichUnit, false)
            call ShowUnit(whichUnit, true)
            call SelectUnitAddForPlayer(whichUnit, GetOwningPlayer(whichUnit))

            set Table[GetHandleId(whichUnit)][WAVEFORM_COUNT] = Table[GetHandleId(whichUnit)][WAVEFORM_COUNT] + 1
            if Table[GetHandleId(whichUnit)][WAVEFORM_COUNT] == 1 then
                call SaveBoolean(OtherHashTable, GetHandleId(whichUnit), 99, true)
            endif
        endif

        set whichUnit = null
    endfunction
    /*
    function Z_R takes nothing returns nothing
        call UnitDamageTargetEx(GW, GetEnumUnit(), 1, JW)
    endfunction
    function Z0R takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit dummyCaster =(LoadUnitHandle(HY, h, 19))
        local unit u =(LoadUnitHandle(HY, h, 221))
        local real a =(LoadReal(HY, h, 13))
        local integer Y2X =(LoadInteger(HY, h, 194))
        local group CNO =(LoadGroupHandle(HY, h, 133))
        local real GRR = GetUnitX(u)
        local real GIR = GetUnitY(u)
        local real GXR =(LoadReal(HY, h, 23))
        local real GOR =(LoadReal(HY, h, 24))
        local real NBX = GXR + 1000* .05 * Cos(a)
        local real NCX = GOR + 1000* .05 * Sin(a)
        local group g = AllocationGroup(224)
        call SaveReal(HY, h, 23,((NBX)* 1.))
        call SaveReal(HY, h, 24,((NCX)* 1.))
        set GW = u
        set JW = LoadInteger(HY, h, 0)* 75 + 25
        set LW = CNO
        call GroupEnumUnitsInRange(g, GRR, GIR, 225, Condition(function ZYR))
        call ForGroup(g, function Z_R)
        call GroupAddGroup(g, CNO)
        call DeallocateGroup(g)
        set Y2X = Y2X -1
        call SaveInteger(HY, h, 194,(Y2X))
        if IsUnitType(u, UNIT_TYPE_HERO) then
            call SaveBoolean(OtherHashTable, GetHandleId(u), 99, true)
        endif
        call SetUnitX(u, CoordinateX50(NBX))
        call SetUnitY(u, CoordinateY50(NCX))
        call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GRR, GIR))
        if Y2X == 0 then
            call SetUnitVertexColorEx(u,-1,-1,-1, 255)
            call SaveBoolean(HY,(GetHandleId(u)), 225,(false))
            call SetUnitInvulnerable(u, false)
            call SetUnitPathing(u, true)
            call DeallocateGroup(CNO)
            call FlushChildHashtable(HY, h)
            call CleanCurrentTrigger(t)
        endif
        set u = null
        set dummyCaster = null
        set CNO = null
        set g = null
        set t = null
        return false
    endfunction
    function WaveformOnSpellEffect takes nothing returns nothing
        local unit K4X = GetTriggerUnit()
        local player p = GetOwningPlayer(K4X)
        local real sx = GetUnitX(K4X)
        local real sy = GetUnitY(K4X)
        local real tx = GetSpellTargetX()
        local real ty = GetSpellTargetY()
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local group CNO = AllocationGroup(225)
        local unit dummyCaster = CreateUnit(p,'e00E', 0, 0, 0)
        local integer WWV = GetPlayerId(p)
        call UnitAddAbility(dummyCaster,'A2N4')
        if GetSpellTargetUnit()!= null then
            set tx = GetUnitX(GetSpellTargetUnit())
            set ty = GetUnitY(GetSpellTargetUnit())
        endif
        call SetUnitVertexColorEx(K4X,-1,-1,-1, 0)
        call SaveBoolean(HY,(GetHandleId(K4X)), 225,(true))
        call SetUnitInvulnerable(K4X, true)
        call SetUnitPathing(K4X, false)
        call SetUnitPathing(dummyCaster, false)
        call SaveUnitHandle(HY, h, 221,(K4X))
        call SaveUnitHandle(HY, h, 19,(dummyCaster))
        call SaveReal(HY, h, 23,((sx)* 1.))
        call SaveReal(HY, h, 24,((sy)* 1.))
        call SaveGroupHandle(HY, h, 133,(CNO))
        call SaveInteger(HY, h, 0, GetUnitAbilityLevel(K4X, GetSpellAbilityId()))
        call SaveInteger(HY, h, 1, GetSpellAbilityId())
        call SaveReal(HY, h, 13,((Atan2(ty -sy, tx -sx))* 1.))
        call SaveInteger(HY, h, 194,(IMaxBJ(R2I(SquareRoot((tx -sx)*(tx -sx)+(ty -sy)*(ty -sy))/ 50), 1)))
        call TriggerRegisterTimerEvent(t, .04, true)
        call TriggerAddCondition(t, Condition(function Z0R))
        call ShowUnit(K4X, false)
        call ShowUnit(K4X, true)
        call SelectUnitAddForPlayer(K4X, GetOwningPlayer(K4X))
        set dummyCaster = null
        set K4X = null
        set CNO = null
        set t = null
    endfunction
    */

endscope
