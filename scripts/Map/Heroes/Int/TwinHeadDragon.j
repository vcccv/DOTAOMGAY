
scope TwinHeadDragon

    //***************************************************************************
    //*
    //*  冰火交加
    //*
    //***************************************************************************
    private function OnBreathFireUpdate takes nothing returns nothing
        local SimpleTick tick  = SimpleTick.GetExpired()
        local TableArray table = tick.GetTable()

        local unit       owner  = table[tick].unit[1]
        local unit       targ   = table[tick].unit[2]
        local real       damage = table[tick].real[1]

        call UnitDamageTargetEx(owner, targ, 1, damage)

        set tick.data = tick.data + 1
        //call BJDebugMsg("造成伤害了次数："+I2S(tick.data))

        set owner = null
        set targ  = null
    endfunction

    function TwinHeadDragonBreathFireOnBuffRemove takes nothing returns nothing
        local unit       u    = MHEvent_GetUnit()
        local integer    h    = GetHandleId(MHUnit_GetAbility(u, MHEvent_GetAbility(), false))
        local SimpleTick tick
        
        set tick = Table[h]['BUFF']

        call tick.Destroy()
        call Table[h].remove('BUFF')

        set u = null
    endfunction

    private struct BreathFire extends array

        real    level

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            local buff       b
            local integer    h
            local SimpleTick tick
            local TableArray table
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call AlarmDamage(sw.owner, targ)
                if GetUnitAbilityLevel(targ, 'B06R') > 0 then
                    call MHBuff_SetRemain(targ, 'B06R', 5.)
                else
                    set b = MHBuff_Create(targ, 'B06R', BUFF_TEMPLATE_BNAB, 5.)
                    set h = GetHandleId(b)
                    set tick = SimpleTick.Create(0)
                    call tick.Start(0.5, true, function OnBreathFireUpdate)
                    set table = SimpleTick.GetTable()
                    set table[tick].real[1] = thistype(sw).level * 20. * 0.5
                    set table[tick].unit[1] = sw.owner
                    set table[tick].unit[2] = targ
                    set Table[h]['BUFF'] = tick

                    set b = null
                endif
            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    private struct BreathFrost extends array

        integer level

        static method OnCollide takes Shockwave sw, unit targ returns boolean
            // 敌对存活非魔免非无敌非守卫非建筑
            if UnitAlive(targ) and IsUnitEnemy(sw.owner, GetOwningPlayer(targ)) and not IsUnitMagicImmune(targ) and not IsUnitInvulnerable(targ) and not IsUnitWard(targ) and not IsUnitStructure(targ) then
                call AlarmDamage(sw.owner, targ)
                call UnitAddAbilityToTimed(targ,'A3JI'-1 + thistype(sw).level, 1, 5.,'B3J1')

            endif
            return false
        endmethod
        
        implement ShockwaveStruct
    endstruct

    private function DualBreathDelayAction takes nothing returns nothing
        local SimpleTick tick  = SimpleTick.GetExpired()
        local TableArray table = SimpleTick.GetTable()

        local real      x        = table[tick].real['x']
        local real      y        = table[tick].real['y']
        local real      angle    = table[tick].real['a']
        local real      distance = table[tick].real['d']
        local integer   level    = table[tick][1]

        local Shockwave sw
        set sw = Shockwave.CreateByDistance(table[tick].unit[2], x, y, angle, distance)
        call sw.SetSpeed(1050.)
        set sw.minRadius = 200.
        set sw.maxRadius = 250.
        set sw.model = "Abilities\\Spells\\Other\\BreathOfFire\\BreathOfFireMissile.mdl"
        call sw.FixTimeScale(0.500)
        set BreathFire(sw).level = level
        call BreathFire.Launch(sw)

        call tick.Destroy()
    endfunction

    function DualBreathOnSpellEffect takes nothing returns nothing
        local unit       whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local unit       targUnit  = GetSpellTargetUnit()
        local real       x = GetUnitX(whichUnit)
        local real       y = GetUnitY(whichUnit)
        local real       tx
        local real       ty
        local real       angle
        local Shockwave  sw

        local integer    level    = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real       distance = 750. + GetUnitCastRangeBonus(whichUnit)
        local SimpleTick tick     = SimpleTick.Create(0)
        local TableArray table
        
        call SetAbilityRemoveAction('B06R', "TwinHeadDragonBreathFireOnBuffRemove")

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
        set sw.minRadius = 200.
        set sw.maxRadius = 250.
        set sw.model = "Abilities\\Spells\\Other\\BreathOfFrost\\BreathOfFrostMissile.mdl"
        call sw.FixTimeScale(0.500)
        set BreathFrost(sw).level = level
        call BreathFrost.Launch(sw)

        call tick.Start(0.3, false, function DualBreathDelayAction)
        set table = SimpleTick.GetTable()
        set table[tick][1] = level
        set table[tick].unit[2] = whichUnit
        set table[tick].real['x'] = x
        set table[tick].real['y'] = y
        set table[tick].real['a'] = angle
        set table[tick].real['d'] = distance

        set whichUnit = null
    endfunction
    /*


// 冰火交加
function DualBreathDamagedEvent takes nothing returns nothing
	local integer i = GetUnitAbilityLevel(DamageEvent.Source[DamageEvent.INDEX],'A0OB')
	if i > 0 and GetUnitAbilityLevel(DamageEvent.Source[DamageEvent.INDEX],'A3JI'-1 + i) == 0 then
		call UnitAddAbilityToTimed(DETarget,'A3JI'-1 + GetUnitAbilityLevel(DamageEvent.Source[DamageEvent.INDEX],'A0OB'), 1, 5,'B3J1')
	endif
endfunction
function U9R takes nothing returns nothing
	local trigger t = GetTriggeringTrigger()
	local integer h = GetHandleId(t)
	local unit d = LoadUnitHandle(HY, h, 0)
	call IssuePointOrderById(d, 852560, LoadReal(HY, h, 0), LoadReal(HY, h, 1))
	call FlushChildHashtable(HY, h)
	call DestroyTrigger(t)
	set d = null
	set t = null
endfunction
function DualBreathOnSpellEffect takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local real x = GetSpellTargetX()
	local real y = GetSpellTargetY()
	local trigger t = CreateTrigger()
	local integer level = GetUnitAbilityLevel(u, GetSpellAbilityId())
	local integer h = GetHandleId(t)
	local unit d = CreateUnit(GetOwningPlayer(u),'e00E', GetUnitX(u), GetUnitY(u), 0)
	call TGV(3)
	call TriggerRegisterTimerEvent(t, .3, false)
	call TriggerAddCondition(t, Condition(function U9R))
	call UnitAddAbility(d,'A0OB')
	call SetUnitAbilityLevel(d,'A0OB', level)
	call IssuePointOrderById(d, 852580, x, y)
	set d = CreateUnit(GetOwningPlayer(u),'e00E', GetUnitX(u), GetUnitY(u), 0)
	call UnitAddAbility(d,'A0OC')
	call SetUnitAbilityLevel(d,'A0OC', level)
	call SaveUnitHandle(HY, h, 0, d)
	call SaveReal(HY, h, 0, x)
	call SaveReal(HY, h, 1, y)
	set d = null
	set t = null
	set u = null
endfunction

    */


    //***************************************************************************
    //*
    //*  冰封路径
    //*
    //***************************************************************************
    struct IcePath extends array

        // 每个路径节点的间距
        #define TWIN_HEAD_DRAGON_ICE_PATH_INTERVAL 100.
        #define TWIN_HEAD_DRAGON_ICE_PATH_START    12.
        #define TWIN_HEAD_DRAGON_ICE_PATH_FRAME    0.02

        implement Alloc

        unit    owner
        real    damage
        real    duration
        real    remaining
        // 最大距离
        real    maxDistance
        // 路径生效延迟
        real    pathDelay

        // 最大路径节点数量
        private integer maxPathCount
        private integer pathCount

        real    radin
        real    startX
        real    startY
        real    targetX
        real    targetY

        private static key KEY

        private group      targGroup
        private trigger    pathTrig
        private SimpleTick delayTick

        static method Create takes nothing returns thistype
            return thistype.allocate()
        endmethod

        private static method OnIcePathUpdate takes nothing returns nothing
            local thistype   this = SimpleTick.GetExpired().data
            local group      g    = AllocationGroup(49)
            local unit       first
            local player     p    = GetOwningPlayer(this.owner)
            local integer    i
            local TableArray t

            set this.remaining = this.remaining - TWIN_HEAD_DRAGON_ICE_PATH_FRAME

            call LineSegment.EnumUnitsEx(g, this.startX, this.startY, this.targetX, this.targetY, 150., true, null)

            loop
                set first = FirstOfGroup(g)
                exitwhen first == null
                call GroupRemoveUnit(g, first)

                if IsAliveNotStrucNotWard(first) and IsUnitEnemy(first, p) and not IsUnitMagicImmune(first) and not IsUnitInGroup(first, this.targGroup) then
                    call GroupAddUnit(this.targGroup, first)
                    call CommonUnitAddStun(first, this.remaining, false)
                    call UnitDamageTargetEx(this.owner, first, 1, this.damage)
                    call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Undead\\FreezingBreath\\FreezingBreathMissile.mdl", GetUnitX(first), GetUnitY(first)))
                endif

            endloop
            
            call DeallocateGroup(g)

            if this.remaining <= 0. then

                set i = 1
                set t = this.delayTick.GetTable()
                loop
                    exitwhen i > this.maxPathCount
                    
                    //call BJDebugMsg("我爬了："+I2S(i) + " h:" + I2S(GetHandleId(t[this.delayTick].effect[ i])))
                    call DestroyEffect(t[this.delayTick].effect[i])
                    call DestroyUbersplat(t[this.delayTick].ubersplat[JASS_MAX_ARRAY_SIZE + i])

                    set i = i + 1
                endloop

                call DeallocateGroup(this.targGroup)
                call this.delayTick.Destroy()
                call this.deallocate()
            endif
        endmethod

        private static method OnDelayEnd takes nothing returns nothing
            local thistype   this = SimpleTick.GetExpired().data
            call Table[thistype.KEY].remove(GetHandleId(this.pathTrig))
            call AddTriggerToDestroyQueue(this.pathTrig)
            set this.remaining = this.duration
            call this.delayTick.Start(TWIN_HEAD_DRAGON_ICE_PATH_FRAME, true, function thistype.OnIcePathUpdate)
        endmethod

        private method CreateIcePath takes nothing returns nothing
            local TableArray t  = this.delayTick.GetTable()
            local ubersplat  ub
            local integer    c  = this.pathCount + 1
            set this.pathCount = c

            set ub = CreateUbersplat(this.targetX, this.targetY, "IPTH", 255, 255, 255, 255, false, false)
            call SetUbersplatRenderAlways(ub, true)
            set t[this.delayTick].effect[c] = AddSpecialEffect("effects\\IcePath.mdx", this.targetX, this.targetY)
            set t[this.delayTick].ubersplat[JASS_MAX_ARRAY_SIZE + c] = ub

            //call BJDebugMsg("我创了："+I2S(c) + " h:" + I2S(GetHandleId(t[this.delayTick].effect[c])))
        endmethod

        private static method OnUpdatePath takes nothing returns nothing
            local thistype this = Table[thistype.KEY][GetHandleId(GetTriggeringTrigger())]
            set this.targetX = this.targetX + TWIN_HEAD_DRAGON_ICE_PATH_INTERVAL * Cos(this.radin)
            set this.targetY = this.targetY + TWIN_HEAD_DRAGON_ICE_PATH_INTERVAL * Sin(this.radin)
            call this.CreateIcePath()
        endmethod

        method Launch takes nothing returns nothing
            local real timeout
            
            set this.maxPathCount = R2I(this.maxDistance / TWIN_HEAD_DRAGON_ICE_PATH_INTERVAL)
            set timeout = this.pathDelay / ( (this.maxPathCount - 1) * 1. )

            set this.pathCount = 0
            set this.pathTrig = CreateTrigger()
            set Table[thistype.KEY][GetHandleId(this.pathTrig)] = this
            call TriggerAddCondition(this.pathTrig, Condition(function thistype.OnUpdatePath))
            call TriggerRegisterTimerEvent(this.pathTrig, timeout, true)

            set this.startX = this.startX + TWIN_HEAD_DRAGON_ICE_PATH_START * Cos(this.radin)
            set this.startY = this.startY + TWIN_HEAD_DRAGON_ICE_PATH_START * Sin(this.radin)
            set this.targetX = this.startX
            set this.targetY = this.startY

            set this.delayTick = SimpleTick.Create(this)
            call this.delayTick.Start(this.pathDelay, false, function thistype.OnDelayEnd)

            call this.CreateIcePath()
            set this.targGroup = AllocationGroup(120)

            //call BJDebugMsg("this.maxPathCount" + I2S(this.maxPathCount))
        endmethod

    endstruct

    //   0.5 秒后路径成型，即在0.5秒内铺完路即可
    //   根据maxDistance和成型时间来决定speed

    function IcePathOnSpellEffect takes nothing returns nothing
        local unit whichUnit = GetRealSpellUnit(GetTriggerUnit())
        local real x = GetUnitX(whichUnit)
        local real y = GetUnitY(whichUnit)
        local real a = AngleBetweenXY(x, y, GetSpellTargetX(), GetSpellTargetY())

        local integer level = GetUnitAbilityLevel(whichUnit, GetSpellAbilityId())
        local real    maxDistance = 1400. + GetUnitCastRangeBonus(whichUnit)
        local real    pathDelay   = 0.5
        local real    duration    = 1.3 + 0.3 * level
        local real    damage      = 50.


        local IcePath ip = IcePath.Create()

        set ip.owner       = whichUnit
        set ip.startX      = x
        set ip.startY      = y
        set ip.duration    = duration
        set ip.maxDistance = maxDistance
        set ip.pathDelay   = pathDelay
        set ip.damage      = damage
        set ip.radin       = a * bj_DEGTORAD
        
        call ip.Launch()

        set whichUnit = null
    endfunction

    //***************************************************************************
    //*
    //*  烈火焚身
    //*
    //***************************************************************************

    function MacropyreOnLoopAction takes nothing returns boolean
        local trigger t = GetTriggeringTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = LoadUnitHandle(HY, h, 2)
        local integer level = LoadInteger(HY, h, 5)
        local real a = LoadReal(HY, h, 137)
        local real x = LoadReal(HY, h, 6)
        local real y = LoadReal(HY, h, 7)
        local integer id = GetPlayerId(GetOwningPlayer(whichUnit))
        local integer count = GetTriggerEvalCount(t)
        local real tx = x + 150 * count * Cos(a)
        local real ty = y + 150 * count * Sin(a)
        local real maxDistance = LoadReal(HY, h, 1)
        call IssuePointOrderById(MacropyreCasters[id], 852488, tx, ty)
        if(count * 150. >= maxDistance) then
            call FlushChildHashtable(HY, h)
            call AddTriggerToDestroyQueue(t)
            call SetUnitAnimation(whichUnit, "stand")
        endif
        set t = null
        set whichUnit = null
        return false
    endfunction
    function MacropyreOnSpellEffect takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer h = GetHandleId(t)
        local unit whichUnit = GetTriggerUnit()
        local real x = GetSpellTargetX()
        local real y = GetSpellTargetY()
        local real a = Atan2(y - GetUnitY(whichUnit), x - GetUnitX(whichUnit))
        local integer level = GetUnitAbilityLevel(whichUnit, 'A0O5')
        local integer upgradeId = 'A0OE'
        local real maxDistance = 900. + GetUnitCastRangeBonus(whichUnit)
        call SaveBoolean(HY, h, 0, false)
        if level == 0 then
            set level = GetUnitAbilityLevel(whichUnit, 'A1B1')
            set upgradeId = 'A1B2'
            call SaveBoolean(HY, h, 0, true)
            set maxDistance = 1800. + GetUnitCastRangeBonus(whichUnit)
        endif
        call SetUnitAnimation(whichUnit, "spell")
        set MacropyreCasters[GetPlayerId(GetOwningPlayer(whichUnit))] = CreateUnit(GetOwningPlayer(whichUnit), 'e00E', x, y, 0)
        call UnitAddPermanentAbility(MacropyreCasters[GetPlayerId(GetOwningPlayer(whichUnit))], upgradeId)
        call SetUnitAbilityLevel(MacropyreCasters[GetPlayerId(GetOwningPlayer(whichUnit))], upgradeId, level)
        call SaveInteger(HY, h, 5, level)
        call SaveReal(HY, h, 6, GetUnitX(whichUnit))
        call SaveReal(HY, h, 7, GetUnitY(whichUnit))
        call SaveReal(HY, h, 137, a * 1.)
        call SaveUnitHandle(HY, h, 2, whichUnit)
        call SaveReal(HY, h, 1, maxDistance)
        if upgradeId == 'A0OE' then
            call TriggerRegisterTimerEvent(t, .1, true)
        else
            call TriggerRegisterTimerEvent(t, .05, true)
        endif
        call TriggerAddCondition(t, Condition(function MacropyreOnLoopAction))
        set t = null
        set whichUnit = null
    endfunction

endscope
