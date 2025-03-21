
scope ShadowFiend

    globals
        constant integer HERO_INDEX_SHADOW_FIEND = 80
    endglobals
    //***************************************************************************
    //*
    //*  毁灭阴影
    //*
    //***************************************************************************
    globals
        constant integer SKILL_INDEX_SHADOWRAZE  = GetHeroSKillIndexBySlot(HERO_INDEX_SHADOW_FIEND, 1)
        constant integer SHADOWRAZE_Z_ABILITY_ID = 'A0EY'
        constant integer SHADOWRAZE_X_ABILITY_ID = 'A0FH'
        constant integer SHADOWRAZE_C_ABILITY_ID = 'A0F0'
    endglobals

    function ZDI takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(), UNIT_TYPE_STRUCTURE) == false and IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetFilterUnit())) and not IsUnitWard(GetFilterUnit())) != null
    endfunction
    function ZFI takes nothing returns nothing
        call UnitDamageTargetEx(TK, GetEnumUnit(), 1, 25 + 75 * UK)
    endfunction
    function ShadowrazeOnSpellEffect takes nothing returns boolean
        local unit trigUnit = GetTriggerUnit()
        local real ZRO
        local real a
        local real x
        local real y
        local group g = AllocationGroup(369)
        if IsUnitWard(trigUnit) then
            set trigUnit = PlayerHeroes[GetPlayerId(GetOwningPlayer(trigUnit))]
        endif
        if GetSpellAbilityId()== SHADOWRAZE_Z_ABILITY_ID then
            set ZRO = 200
        elseif GetSpellAbilityId()== SHADOWRAZE_X_ABILITY_ID then
            set ZRO = 450
        elseif GetSpellAbilityId()== SHADOWRAZE_C_ABILITY_ID then
            set ZRO = 700
        endif
        set a = GetUnitFacing(trigUnit)
        set x = GetWidgetX(trigUnit) + ZRO * Cos(a * bj_DEGTORAD)
        set y = GetWidgetY(trigUnit) + ZRO * Sin(a * bj_DEGTORAD)
        set TK = trigUnit
        set UK = GetUnitAbilityLevel(trigUnit, GetSpellAbilityId())
        call UnitApplyTimedLife(CreateUnit(GetOwningPlayer(trigUnit),'e006', x, y, 0),'BTLF', 2)
        call GroupEnumUnitsInRange(g, x, y, 275, Condition(function ZDI))
        call ForGroup(g, function ZFI)
        call DeallocateGroup(g)
        set trigUnit = null
        set g = null
        return false
    endfunction
    function ShadowrazeOnLearn takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer abilLevel = GetUnitAbilityLevel(u, SHADOWRAZE_Z_ABILITY_ID)
        if abilLevel == 1 then
            call UnitAddPermanentAbility(u, SHADOWRAZE_C_ABILITY_ID)
            call UnitAddPermanentAbility(u, SHADOWRAZE_X_ABILITY_ID)
        else
            call SetUnitAbilityLevel(u, SHADOWRAZE_C_ABILITY_ID, abilLevel)
            call SetUnitAbilityLevel(u, SHADOWRAZE_X_ABILITY_ID, abilLevel)
        endif
        set u = null
    endfunction
    //***************************************************************************
    //*
    //*  魂之挽歌
    //*
    //***************************************************************************
    private struct SoulwaveUpgradeR extends array
        
        real damage
        // 恢复的值
        real regenLife
        static method OnFinish takes Shockwave sw returns boolean
            if thistype(sw).regenLife == 0. then
                return true
            endif
            call UnitRegenLife(sw.owner, sw.owner, thistype(sw).regenLife)
            return true
        endmethod

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
                set thistype(sw).regenLife = thistype(sw).regenLife + thistype(sw).damage
            endif
            return false
        endmethod

        implement ShockwaveStruct
    endstruct

    private struct Soulwave extends array
        
        real    damage
        boolean isUpgraded

        static method OnFinish takes Shockwave sw returns boolean
            local real      x
            local real      y
            local real      angle
            local Shockwave new
            if not thistype(sw).isUpgraded then
                return true
            endif
            
            set x     = GetUnitX(sw.owner) + sw.distance * Cos(sw.angle)
            set y     = GetUnitY(sw.owner) + sw.distance * Sin(sw.angle)
            set angle = sw.angle + 180. * bj_DEGTORAD
            set new   = Shockwave.Create(sw.owner, x, y, angle, sw.distance)
            call new.SetSpeed(sw.speed)
            set new.minRadius = sw.maxRadius
            set new.maxRadius = sw.minRadius
            set new.model     = sw.model
            set SoulwaveUpgradeR(new).damage    = thistype(sw).damage * 0.4
            set SoulwaveUpgradeR(new).regenLife = 0.
            call SoulwaveUpgradeR.Launch(new)
            return true
        endmethod

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call UnitDamageTargetEx(sw.owner, targ, 1, thistype(sw).damage)
                call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", sw.x, sw.y))
                call CreateBuffByTemplate(sw.owner, targ, 'B04Q', 5., BUFF_TEMPLATE_BCRI)
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct
/*
    function IYRPI takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        local unit u = LoadUnitHandle(HY, h, 0)
        local integer OTRTO = LoadInteger(HY, h, 1)
        local integer IYRUI = LoadInteger(HY, h, 0)
        local integer i
        local integer k
        local real a
        local real x = GetUnitX(u)
        local real y = GetUnitY(u)
        local real r
        local unit d = CreateUnit(GetOwningPlayer(u),'e00E', x, y, 0)
        local real dx
        local real dy
        local integer id ='S0HG'
        call UnitAddAbility(d, id)
        call SetUnitAbilityLevel(d, id, OTRTO)
        set a = 360. /(IYRUI * 1.)
        set i = 1
        set k = IYRUI
        loop
        exitwhen i > k
            set r = i * a * bj_DEGTORAD
            set dx = CoordinateX50(x +(1060)*(Cos(r)))
            set dy = CoordinateY50(y +(1060)*(Sin(r)))
            call SetUnitX(d, dx)
            call SetUnitY(d, dy)
            call IssuePointOrderById(d, 852218, x, y)
            set i = i + 1
        endloop
        set d = null
        call PauseTimer(t)
        call FlushChildHashtable(HY, GetHandleId(t))
        call DestroyTimer(t)
        set u = null
        set t = null
    endfunction

    function IYRYI takes unit u, integer IYRII, integer OTRTO returns nothing
        local timer t = CreateTimer()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(HY, h, 0, u)
        call SaveInteger(HY, h, 0, IYRII)
        call SaveInteger(HY, h, 1, OTRTO)
        call TimerStart(t, 1.4, false, function IYRPI)
        set t = null
    endfunction

    function ZGI takes nothing returns boolean
        return IsAliveNotStrucNotWard(GetFilterUnit()) and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(TempUnit))
    endfunction

    // 减速buff
    // B04Q
    function RequiemOfSoulsOnAoeSlow takes unit u returns nothing
        local group g
        local unit u2
        local integer level
        local unit d = CreateUnit(GetOwningPlayer(u),'e00E', GetUnitX(u), GetUnitY(u), 0)
        call UnitAddAbility(d,'A0HH')
        set g = AllocationGroup(370)
        set TempUnit = u
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 700, Condition(function ZGI))
        loop
            set u2 = FirstOfGroup(g)
        exitwhen u2 == null
            call SetUnitX(d, GetUnitX(u2))
            call SetUnitY(d, GetUnitY(u2))
            call SetUnitOwner(d, GetOwningPlayer(u2), false)
            call IssueTargetOrderById(d, 852189, u2)
            call GroupRemoveUnit(g, u2)
        endloop
        call UnitRemoveAbility(d,'A0HH')
        set d = null
        call DeallocateGroup(g)
    endfunction
    */

    function ShadowFiendRequiemOfSoulsSlowBuffOnAdd takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitSubMoveSpeedBonusPercent(whichUnit, 25)
        set whichUnit = null
    endfunction

    function ShadowFiendRequiemOfSoulsSlowBuffOnRemove takes nothing returns nothing
        local unit whichUnit = Event.GetTriggerUnit()
        call UnitAddMoveSpeedBonusPercent(whichUnit, 25)
        set whichUnit = null
    endfunction

    function UnitLaunchSoulwave takes unit u, integer max returns nothing
        local real      x         = GetWidgetX(u)
        local real      y         = GetWidgetY(u)
        local integer   count     = 0
        local integer   offset    = 360 / max
        local integer   level     = GetUnitAbilityLevel(u, GetSpellAbilityId())
        local boolean   isUpgraded = GetSpellAbilityId() == 'A3OJ'
        local Shockwave sw
        local real      distance  = 1000.
        local real      angle       
        local real      damage    = 40. + 40. * level

        call RegisterAbilityAddMethod('B04Q', "ShadowFiendRequiemOfSoulsSlowBuffOnAdd")
        call RegisterAbilityRemoveMethod('B04Q', "ShadowFiendRequiemOfSoulsSlowBuffOnRemove")

        loop
        exitwhen count > max
            set angle = bj_DEGTORAD * count * offset
            //call IssuePointOrderById(d, 852218, x + 50 * Cos(bj_DEGTORAD * count * offset), y + 50 * Sin(bj_DEGTORAD * count * offset))
            set sw = Shockwave.CreateFromUnit(u, angle, distance)
            call sw.SetSpeed(700.)
            set sw.minRadius = 125.
            set sw.maxRadius = 425.
            set sw.model = "Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl"
            set Soulwave(sw).isUpgraded = isUpgraded
            set Soulwave(sw).damage    = damage
            call Soulwave.Launch(sw)
            set count = count + 1
        endloop

        //call RequiemOfSoulsOnAoeSlow(u)
        //if isUpgraded then
        //    call IYRYI(u, max, level)
        //endif
    endfunction
    function RequiemOfSoulsOnSpellEffect takes nothing returns nothing
        call UnitLaunchSoulwave(GetRealSpellUnit(GetTriggerUnit()), 18)
    endfunction
    
    function RequiemOfSoulsOnDeath takes nothing returns nothing
        if GetUnitAbilityLevel(GetTriggerUnit(),'A29J')> 0 then
            call UnitLaunchSoulwave(GetTriggerUnit(), 9)
        endif
    endfunction

endscope
