
library MissileSystem initializer init requires base

    globals
        private constant real frame = 0.02
        private conditionfunc callback = null
    endglobals

    struct missile

        integer         level
        real            damageValue
        integer         damageType

        real            dataA

        boolean         scaleBull
        boolean         usePlayerColor
        unit            missileUnit
        string          missileFile
        string          hitFile
        unit            owner
        unit            target
        unit            startUnit

        real            startX
        real            startY

        real            missileX
        real            missileY
        real            targetX
        real            targetY
        real            arc

        real            addValue
        real            speed
        real            startingHeight
        real            endHeight
        real            maxHeight
        real            addHeight
        real            currentHeight
        real            distance
        real            maxDistance
        real            currentDistance

        trigger         moveTrig
        trigger         hitTrig

        effect          sfx

        boolean         isDodge
        boolean         canDodge
        boolean         isArc
        boolean         targetMove
        boolean         echoShell
        boolean         canCountered
        boolean         isCountered
        real            scale
        real            count

        string          hitActions

        /*method operator hitActions= takes code funcHandle returns nothing
            set this.hitTrig = CreateTrigger()
            call TriggerAddCondition(this.hitTrig, Condition( funcHandle))
            call SaveInteger(HY, GetHandleId(this.hitTrig), 0, this)
        endmethod*/

        static method create takes unit owner, unit target, real speed returns missile

            local missile m = missile.allocate()
 
            set m.canDodge = true
            set m.scaleBull = true
            set m.isArc = false
            //set m.scale = 1.
            set m.owner = owner
            set m.target = target
            set m.speed = speed
            set m.echoShell = false
            set m.level = 0

            return m

        endmethod

        method destroy takes nothing returns nothing
    
            if not this.echoShell and this.hitActions != null then
                set this.hitActions = null
            endif

            if this.sfx != null then
                call DestroyEffect(this.sfx)
                set this.sfx = null
            endif

            call EXPauseUnit(this.missileUnit, false)
            call KillUnit(this.missileUnit)

            set this.dataA = 0
            set this.damageType = 0
            set this.damageValue = 0.
            set this.distance = 0.
            set this.arc = 0.
            set this.scale = 1.
            set this.isDodge = false
            set this.targetMove = false
            set this.missileFile = null
            set this.hitFile = null
            set this.startUnit = null
            set this.usePlayerColor = false
            call missile.deallocate(this)
   
        endmethod

        method LaunchMissile takes nothing returns nothing
            local integer soucreId
            local real launchX = 0.
            local real launchY = 0.
            local real launchZ = 0.
            local real impactZ = 0.
            local real targetX = GetUnitX(this.target)
            local real targetY = GetUnitY(this.target)
            local real radian          
    
            if this.startUnit != null then
                set soucreId = GetUnitTypeId(this.startUnit)
                set launchX = GetUnitLaunchXById(soucreId)                   // 单位X轴射弹偏移
                set launchY = GetUnitLaunchYById(soucreId)                   // 单位Y轴射弹偏移
                set launchZ = GetUnitLaunchZById(soucreId)                   // 单位Z轴射弹偏移
                set impactZ = GetUnitImpactZById(GetUnitTypeId(this.target))    // 目标Z轴射弹碰撞 
                set this.startX = GetUnitX(this.startUnit)
                set this.startY = GetUnitY(this.startUnit)
            endif
            set radian = RadianBetweenXY(this.startX, this.startY, targetX, targetY)
            set this.targetX = targetX
            set this.targetY = targetY
    
            set this.moveTrig = CreateTrigger()
            call TriggerAddCondition(this.moveTrig, callback)
            call TriggerRegisterTimerEvent(this.moveTrig, frame, true)
    
            if this.target != null and this.canDodge then
                call TriggerRegisterUnitEvent(this.moveTrig, this.target, EVENT_UNIT_SPELL_EFFECT)
            endif
            call SaveInteger(HY, GetHandleId(this.moveTrig), 0, this)
    
            if launchX != 0. then
                set this.startX = this.startX + launchX * Cos(radian)
            endif
            if launchY != 0. then
                set this.startY = this.startY + launchY * Sin(radian)
            endif
            
            call MoveLocation(Temp__Location, targetX, targetY)
            set this.endHeight = GetUnitFlyHeight(this.target) + impactZ + GetLocationZ(Temp__Location)
    
            call MoveLocation(Temp__Location, this.startX, this.startY)
            if this.startUnit != null then
                set this.startingHeight = GetUnitFlyHeight(this.startUnit) + launchZ
            else
                set this.startingHeight = launchZ
            endif
    
            set this.maxDistance = GetDistanceBetween(this.startX, this.startY, targetX, targetY) // 最大距离
            if this.arc != 0. then
                set this.maxHeight = this.arc * this.maxDistance // 抛物线最大高度
            endif
            set this.missileUnit = CreateUnit(GetOwningPlayer(this.owner), 'dumi', this.startX, this.startY, radian * bj_RADTODEG)
            call SetUnitBlendTime( this.missileUnit, 0.00 )
            if this.scaleBull then
                // 小小长大是固定缩放值 HTKEY_UNIT_CURRENT_ADDSCALE
                set this.scale = GetUnitCurrentScale(this.owner) + LoadReal( ExtraHT, GetHandleId(this.owner), HTKEY_UNIT_CURRENT_ADDSCALE )
            endif
            call SetUnitScale(this.missileUnit, this.scale, this.scale, this.scale)
            if this.missileFile != null then
                set this.sfx = AddSpecialEffectTarget(this.missileFile, this.missileUnit, "origin")
            endif
    
            call SetUnitFlyHeight(this.missileUnit, this.startingHeight, 0.)
            call EXPauseUnit(this.missileUnit, true)
    
            set this.startingHeight = this.startingHeight + GetLocationZ(Temp__Location)
            set this.currentHeight = this.startingHeight
    
            set this.missileX = this.startX
            set this.missileY = this.startY
            set this.addValue = this.speed * frame
            if this.arc == 0. then
                call SetUnitAnimationByIndex(this.missileUnit, R2I(bj_RADTODEG * Atan2(this.endHeight - this.startingHeight, this.maxDistance) + 0.50) + 90)
                set this.count = this.maxDistance / ( this.addValue )
                set this.addHeight = ( this.endHeight - this.startingHeight ) / ( this.count )
            endif
    
           if this.usePlayerColor then
               call SetUnitColor(this.missileUnit, GetPlayerColor(GetOwningPlayer(this.owner)))
           endif
    
        endmethod

    endstruct

  

    private function counter_missile takes missile m returns nothing
        local missile newM = missile.create(m.target, m.owner, m.speed)
        local integer h
        set newM.isArc = m.isArc
        set newM.canDodge = m.canDodge
        set newM.isCountered = true
        set newM.missileFile = m.missileFile
        set newM.hitFile = m.hitFile
        set newM.level = m.level
        set newM.damageValue = m.damageValue
        set newM.damageType = m.damageType

        call newM.LaunchMissile()
    endfunction

    function MissileMoveLoop takes nothing returns nothing
        local missile m = LoadInteger(HY, GetHandleId(GetTriggeringTrigger()), 0)
        local real radian
        local real targetX
        local real targetY
        local boolean end

        if m.canDodge and GetTriggerEventId()== EVENT_UNIT_SPELL_EFFECT then

            if IsBlinkAbilityId(GetSpellAbilityId()) then
                set m.isDodge = true
                set m.targetX = GetUnitX(m.target)
                set m.targetY = GetUnitY(m.target)
            endif

        else

            if m.target == null then
                set m.isDodge = true
            endif

            if m.isDodge then
                set targetX = m.targetX
                set targetY = m.targetY
            else
                set targetX = GetUnitX(m.target)
                set targetY = GetUnitY(m.target)
            endif

            set radian = RadianBetweenXY(m.missileX, m.missileY, targetX, targetY)

            if not m.targetMove and ( targetX != m.targetX or targetY != m.targetY  ) then

                set m.targetMove = true
                set m.count = RMaxBJ(0.0001, (m.maxDistance - m.distance) / ( m.addValue ))
                set m.addHeight = ( m.endHeight - m.startingHeight ) / ( m.count ) 
                
            endif

            if m.targetMove then
                set end = GetDistanceBetween(m.missileX, m.missileY, targetX, targetY) <= m.addValue
            else
                set end = m.distance >= m.maxDistance
            endif
            if not end then

                set m.distance = m.distance + m.addValue
                set m.missileX = CoordinateX50(m.missileX + m.addValue * Cos(radian))
                set m.missileY = CoordinateY50(m.missileY + m.addValue * Sin(radian))
                call SetUnitX(m.missileUnit, m.missileX)
                call SetUnitY(m.missileUnit, m.missileY)
                call EXSetUnitFacing(m.missileUnit, radian * bj_RADTODEG) // 弧度转角度

                if m.isArc and not m.targetMove then

                    call MoveLocation(Temp__Location, m.missileX, m.missileY)
                    set m.currentHeight = GetParabolaZEx(m.distance, m.maxDistance, m.maxHeight, m.startingHeight, m.endHeight)
                    call SetUnitFlyHeight(m.missileUnit, m.currentHeight - GetLocationZ(Temp__Location), 0.)

                else

                    call MoveLocation(Temp__Location, m.missileX, m.missileY)
                    set m.currentHeight = m.currentHeight + m.addHeight
            
                    if m.count >0. then
                        set m.count = m.count - 1.
                        if m.count <= 0. then
                            set m.currentHeight = m.endHeight
                        endif
            
                    else
            
                        set m.currentHeight = m.endHeight
            
                    endif
            
                    call SetUnitFlyHeight(m.missileUnit, m.currentHeight - GetLocationZ(Temp__Location), 0.)
                
                endif

            else

                if m.hitFile != null then
                    call DestroyEffect(AddSpecialEffectTarget(m.hitFile, m.target, "origin"))
                endif

                if m.target != null and UnitAlive(m.target) then

                    if m.damageValue > 0. then
                        call UnitDamageTargetEx(m.owner, m.target, m.damageType, m.damageValue)
                    endif
    
                    if m.hitActions != null then
                        call DzExecuteFunc(m.hitActions)
                    endif
                endif

                // 如果有莲花
                if m.canCountered and not m.isCountered and GetUnitAbilityLevel(m.target,'A3E9')== 1 then
                    call counter_missile(m)
                    set m.echoShell = true
                endif

                call FlushChildHashtable(HY, GetHandleId(m.moveTrig))
                call CleanCurrentTrigger(m.moveTrig)
                set m.moveTrig = null
                call m.destroy()

            endif

        endif

    endfunction

    private function init takes nothing returns nothing
        set callback = Condition( function MissileMoveLoop)
    endfunction

    function GetHitMissile takes nothing returns missile
        return LoadInteger(HY, GetHandleId(GetTriggeringTrigger()), 0)
    endfunction

endlibrary
