
scope TownPortalScroll

    //***************************************************************************
    //*
    //*  回城卷轴
    //*
    //***************************************************************************
    function GetScrollOfTeleportEffectUnitTypeByPlayerId takes integer index returns integer
        if index == GetPlayerId(SentinelPlayers[1]) then
            return 'h0BI'
        elseif index == GetPlayerId(SentinelPlayers[2]) then
            return 'h0BK'
        elseif index == GetPlayerId(SentinelPlayers[3]) then
            return 'h0BG'
        elseif index == GetPlayerId(SentinelPlayers[4]) then
            return 'h0BF'
        elseif index == GetPlayerId(SentinelPlayers[5]) then
            return 'h0BL'
        elseif index == GetPlayerId(ScourgePlayers[1]) then
            return 'h0BH'
        elseif index == GetPlayerId(ScourgePlayers[2]) then
            return 'h0BJ'
        elseif index == GetPlayerId(ScourgePlayers[3]) then
            return 'h0BM'
        elseif index == GetPlayerId(ScourgePlayers[4]) then
            return 'h0A5'
        elseif index == GetPlayerId(ScourgePlayers[5]) then
            return 'h0BN'
        endif
        return 'h0BN'
    endfunction
    function GetScrollOfTeleportEffectModelNameByPlayerId takes integer index returns string
        if index == GetPlayerId(SentinelPlayers[1]) then
            return "war3mapImported\\TeleportTarget_Blue.mdx"
        elseif index == GetPlayerId(SentinelPlayers[2]) then
            return "war3mapImported\\TeleportTarget_Teal.mdx"
        elseif index == GetPlayerId(SentinelPlayers[3]) then
            return "war3mapImported\\TeleportTarget_Purple.mdx"
        elseif index == GetPlayerId(SentinelPlayers[4]) then
            return "war3mapImported\\TeleportTarget_Yellow.mdx"
        elseif index == GetPlayerId(SentinelPlayers[5]) then
            return "war3mapImported\\TeleportTarget_Orange.mdx"
        elseif index == GetPlayerId(ScourgePlayers[1]) then
            return "war3mapImported\\TeleportTarget_Pink.mdx"
        elseif index == GetPlayerId(ScourgePlayers[2]) then
            return "war3mapImported\\TeleportTarget_Gray.mdx"
        elseif index == GetPlayerId(ScourgePlayers[3]) then
            return "war3mapImported\\TeleportTarget_LightBlue.mdx"
        elseif index == GetPlayerId(ScourgePlayers[4]) then
            return "war3mapImported\\TeleportTarget_DarkGreen.mdx"
        elseif index == GetPlayerId(ScourgePlayers[5]) then
            return "war3mapImported\\TeleportTarget_Brown.mdx"
        endif
        return "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl"
    endfunction

    function IsUnitTownPortalTarget takes unit whichUnit, unit targetUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
            return IsUnitAlive(targetUnit) and IsUnitStructure(targetUnit)  /*
        */ and not IsUnitShop(targetUnit) and not IsUnitAncient(targetUnit) /*
        */ and IsUnitAlly(whichUnit, GetOwningPlayer(targetUnit))           /*
        */ and ( id !='ntav' and id !='u00S' and id !='ncop' and id !='emow' and id !='uzig' )
        // 不选取 酒馆 能量齿轮 能量圈 月亮井 通灵塔
    endfunction

    function IsUnitBootsOfTravelTarget takes unit whichUnit, unit targetUnit, boolean isUpgraded returns boolean
            return IsUnitAlive(targetUnit) and not IsUnitShop(targetUnit)   /*
        */ and ( not IsUnitWard(targetUnit) or IsUnitFountain(targetUnit) ) /*
        */ and IsUnitAlly(whichUnit, GetOwningPlayer(targetUnit))           /*
        */ and GetOwningPlayer(targetUnit) != NEUTRAL_PASSIVE_PLAYER        /*
        */ and ( isUpgraded or not IsHeroUnitId(GetUnitTypeId(targetUnit)) )
    endfunction

    // 获取tp的传送目标单位
    function GetTownPortalScrollTargetUnit takes unit whichUnit, real x, real y returns unit
        local group g = AllocationGroup(23)
        local unit  first
        local real  maxDistance = 99999.
        local real  dist

        call GroupEnumUnitsInRange(g, x, y, 99999., null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)
            
            if IsUnitTownPortalTarget(whichUnit, first) then
                set dist = GetDistanceBetween(x, y, GetUnitX(first), GetUnitY(first))
                if dist < maxDistance then
                    set maxDistance = dist
                    set TempUnit    = first
                endif
            endif
        endloop

        call DeallocateGroup(g)
        return TempUnit
    endfunction

    function GetBootsOfTravelTargetUnit takes unit whichUnit, real x, real y, boolean isUpgraded returns unit
        local group g = AllocationGroup(23)
        local unit  first
        local real  maxDistance = 99999.
        local real  dist

        call GroupEnumUnitsInRange(g, x, y, 99999., null)
        loop
            set first = FirstOfGroup(g)
            exitwhen first == null
            call GroupRemoveUnit(g, first)
            
            if IsUnitBootsOfTravelTarget(whichUnit, first, isUpgraded) then
                set dist = GetDistanceBetween(x, y, GetUnitX(first), GetUnitY(first))
                if dist < maxDistance then
                    set maxDistance = dist
                    set TempUnit    = first
                endif
            endif
        endloop

        call DeallocateGroup(g)
        return TempUnit
    endfunction

    private function GetUnitHPBarHeight takes unit whichUnit returns real
        return MHUnit_GetData(whichUnit, UNIT_DATA_HPBAR_HEIGHT)
    endfunction
    private function GetUnitZ takes unit whichUnit returns real
        return MHUnit_GetData(whichUnit, UNIT_DATA_POSITION_Z)
    endfunction
    private function GetTerrainZ takes real x, real y returns real
        return MHGame_GetAxisZ(x, y)
    endfunction
    private function GetUnitScale takes unit whichUnit returns real
        return MHUnit_GetData(whichUnit, UNIT_DATA_MODEL_SCALE)
    endfunction
    private function GetUnitModel takes unit whichUnit returns string
        return MHUnit_GetDefDataStr(GetUnitTypeId(whichUnit), UNIT_DEF_DATA_MODEL)
    endfunction

    private function CreateProgressBarEffect takes unit whichUnit, real r returns effect
        set bj_lastCreatedEffect = AddSpecialEffect("Progressbar.mdx", GetUnitX(whichUnit), GetUnitY(whichUnit))
        call MHEffect_SetTimeScale(bj_lastCreatedEffect, 1. / r)
        call MHEffect_SetScale(bj_lastCreatedEffect, 1.5)
        call MHEffect_SetZ(bj_lastCreatedEffect, GetUnitHPBarHeight(whichUnit) + GetUnitZ(whichUnit) + 25.)
        if not (IsPlayerAlly(LocalPlayer, GetOwningPlayer(whichUnit)) or IsPlayerObserverEx(LocalPlayer)) then
            call MHEffect_Hide(bj_lastCreatedEffect, true)
        endif
        return bj_lastCreatedEffect
    endfunction

    
    globals
        // MaxTargetingDistance
        // MinTargetingDistance
	    constant real MaxTargetingDistance = 575.
        constant real MinTargetingDistance = 70.

        player array DEV
        real array DXV
        real array DOV
        real array DRV
        integer DIV =-1
        region DNV
    endglobals

    function NWO takes integer id, real x, real y returns integer
        local real startTime =(GetGameTime())
        local integer i = 0
        local integer count = 0
        if IsPointInRegion(DNV, x, y) then
            return count
        endif
        loop
        exitwhen i > DIV
            if (startTime < DRV[i] + 25) and(GetDistanceBetween(x, y, DXV[i], DOV[i])< MaxTargetingDistance * 2 + 50) and IsPlayerAlly(Player(id), DEV[i]) then
                set count = count + 1
            endif
            set i = i + 1
        endloop
        return count
    endfunction

    function NUO takes integer id, real x, real y returns nothing
        if IsPointInRegion(DNV, x, y) == false then
            set DIV = DIV + 1
            set DEV[DIV] = Player(id)
            set DXV[DIV] = x
            set DOV[DIV] = y
            set DRV[DIV]=(GetGameTime())
        endif
    endfunction

    // 范围内的友军播放TP提示声音

    function B_X takes nothing returns boolean
        return((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) and IsUnitEnemy(TempUnit, GetOwningPlayer(GetFilterUnit())) == false))
    endfunction
    function B0X takes nothing returns nothing
        call BYX(WJ, GetOwningPlayer(GetEnumUnit()))
    endfunction
    function B1X takes unit whichUnit, sound whichSound, real x, real y, real r returns nothing
        local group g = AllocationGroup(3)
        set TempUnit = whichUnit
        set WJ = whichSound
        call GroupEnumUnitsInRange(g, x, y, r, Condition(function B_X))
        call GroupRemoveUnit(g, whichUnit)
        call ForGroup(g, function B0X)
        call DeallocateGroup(g)
        set g = null
    endfunction

    function PlayerSetTeleportRequires takes player whichPlayer, boolean flag returns nothing
        local integer pid = GetPlayerId(whichPlayer)
        if PlayerSettings(pid).IsTeleportRequiresHoldOrStop() and whichPlayer == LocalPlayer then
            call SelectUnit(CirclesUnit[pid], flag)
        endif
    endfunction

    function TownPortalScrollOnUpdate takes nothing returns boolean
        local trigger   trig                      = GetTriggeringTrigger()
        local integer   h                         = GetHandleId(trig)
        local unit      whichUnit                 = (LoadUnitHandle(HY, h, 14))
        local real      sx
        local real      sy
        local real      tx                        = (LoadReal(HY, h, 6))
        local real      ty                        = (LoadReal(HY, h, 7))
        local unit      teleportEffectFromUnit    = (LoadUnitHandle(HY, h, 448))
        local unit      teleportEffectColoredUnit = (LoadUnitHandle(HY, h, 447))
        local ubersplat teleportEffectUbersplat   = (LoadUbersplatHandle(HY, h, 131))
        local effect    teleportUnitEffect        = (LoadEffectHandle(HY, h, 178))
        local effect    progressBarEffect         = (LoadEffectHandle(HY, h, 179))

        local real      duration  = (LoadReal(HY, h, 57))
        local real      startTime = (LoadReal(HY, h, 442))
        local real      remaining
        local integer   id        = GetPlayerId(GetOwningPlayer(whichUnit))
        local real      angle
        if (GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED) then
            set remaining = duration - ( GetGameTime() - startTime )

            set angle = bj_RADTODEG * Atan2(MHEffect_GetVectorY(teleportUnitEffect), MHEffect_GetVectorX(teleportUnitEffect)) + ( 360. / ( duration / 0.02 ) ) * 0.5
            call MHEffect_ResetMatrix(teleportUnitEffect)
            call MHEffect_SetYaw(teleportUnitEffect, angle)

            set sx = GetUnitX(whichUnit)
            set sy = GetUnitY(whichUnit)
            call MHEffect_SetPosition(progressBarEffect, sx, sy, GetUnitHPBarHeight(whichUnit) + GetUnitZ(whichUnit) + 25.)
            call SetUnitX(teleportEffectFromUnit, sx)
            call SetUnitY(teleportEffectFromUnit, sy)

            if remaining < 3. then
                call SetUnitAnimationByIndex(teleportEffectFromUnit, 1)
                call SetUnitAnimationByIndex(teleportEffectColoredUnit, 1)
            endif

            if ModuloInteger(GetTriggerEvalCount(trig), 25) == 0 and ( remaining > 0. ) then
                set bj_lastCreatedTextTag = CreateTextTag()
                call SetTextTagText(bj_lastCreatedTextTag, R2SW(remaining, 1, 1), .03)
                call SetTextTagPosUnit(bj_lastCreatedTextTag, whichUnit, 0)
                call SetTextTagColorBJ(bj_lastCreatedTextTag, 150, 75, 255, 15)
                call SetTextTagVelocity(bj_lastCreatedTextTag, 0, .035)
                call SetTextTagFadepoint(bj_lastCreatedTextTag, 3)
                call SetTextTagLifespan(bj_lastCreatedTextTag, .5)
                call SetTextTagPermanent(bj_lastCreatedTextTag, false)
                call SetTextTagVisibility(bj_lastCreatedTextTag, ( IsUnitAlly(whichUnit, LocalPlayer) or IsPlayerObserverEx(LocalPlayer) ))
            endif
            
            if remaining <= 0. then
                call SetUnitX(whichUnit, tx)
                call SetUnitY(whichUnit, ty)
                call UnitIncStunCount(whichUnit)
                call UnitDecStunCount(whichUnit)
                call KillTreeByCircle(tx, ty, 240)
            endif
        elseif GetSpellAbilityId() == TOWN_PORTAL_SCROLL_ABILITY_ID then
            call PlayerSetTeleportRequires(GetOwningPlayer(whichUnit), false)

            call UnitSubTownPortalScrollCharges(whichUnit, 1)

            call MHEffect_Hide(teleportUnitEffect, true)
            call DestroyEffect(teleportUnitEffect)
            call MHEffect_Hide(progressBarEffect, true)
            call DestroyEffect(progressBarEffect)

            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl", whichUnit, "origin"))
            call DestroyEffect(AddSpecialEffect(GetScrollOfTeleportEffectModelNameByPlayerId(id), tx, ty))
            call DestroyEffect((LoadEffectHandle(HY, h, 176)))

            call KillUnit(teleportEffectFromUnit)
            call KillUnit(teleportEffectColoredUnit)
            call DestroyUbersplat(teleportEffectUbersplat)

            call FlushChildHashtable(HY, h)
            call DestroyTrigger(trig)
        endif
        set trig = null
        set whichUnit = null

        set teleportUnitEffect        = null
        set teleportEffectFromUnit    = null
        set teleportEffectColoredUnit = null
        set teleportEffectUbersplat   = null
        set progressBarEffect         = null
        return false
    endfunction
    function BootsOfTravelOnUpdate takes nothing returns boolean
        local trigger   trig                    = GetTriggeringTrigger()
        local integer   h                       = GetHandleId(trig)
        local unit      whichUnit               = (LoadUnitHandle(HY, h, 14))
        local unit      targetUnit              = (LoadUnitHandle(HY, h, 17))
        local real      sx
        local real      sy
        local real      tx                      = GetUnitX(targetUnit)
        local real      ty                      = GetUnitY(targetUnit)
        local ubersplat teleportEffectUbersplat = (LoadUbersplatHandle(HY, h, 131))
        local effect    teleportUnitEffect      = (LoadEffectHandle(HY, h, 178))
        local effect    progressBarEffect       = (LoadEffectHandle(HY, h, 179))

        local integer   id        = GetPlayerId(GetOwningPlayer(whichUnit))
        local real      duration  = (LoadReal(HY, h, 57))
        local real      startTime = (LoadReal(HY, h, 442))
        local real      remaining
        local real      angle
        if (GetTriggerEventId() == EVENT_GAME_TIMER_EXPIRED) then
            set remaining = duration - ( GetGameTime() - startTime )

            set angle = bj_RADTODEG * Atan2(MHEffect_GetVectorY(teleportUnitEffect), MHEffect_GetVectorX(teleportUnitEffect)) + ( 360. / ( duration / 0.02 ) ) * 0.5
            call MHEffect_ResetMatrix(teleportUnitEffect)
            call MHEffect_SetYaw(teleportUnitEffect, angle)

            set sx = GetUnitX(whichUnit)
            set sy = GetUnitY(whichUnit)
            call MHEffect_SetPosition(progressBarEffect, sx, sy, GetUnitHPBarHeight(whichUnit) + GetUnitZ(whichUnit) + 25.)
            call MHEffect_SetPosition(teleportUnitEffect, tx, ty, GetUnitHPBarHeight(targetUnit) + GetUnitZ(targetUnit) + 25.)
            
            if ModuloInteger(GetTriggerEvalCount(trig), 25) == 0 and ( remaining ) > 0. then
                set bj_lastCreatedTextTag = CreateTextTag()
                call SetTextTagText(bj_lastCreatedTextTag, R2SW(remaining, 1, 1), .03)
                call SetTextTagPosUnit(bj_lastCreatedTextTag, whichUnit, 0)
                call SetTextTagColorBJ(bj_lastCreatedTextTag, 150, 75, 255, 15)
                call SetTextTagVelocity(bj_lastCreatedTextTag, 0, .035)
                call SetTextTagFadepoint(bj_lastCreatedTextTag, 3)
                call SetTextTagLifespan(bj_lastCreatedTextTag, .5)
                call SetTextTagPermanent(bj_lastCreatedTextTag, false)
                call SetTextTagVisibility(bj_lastCreatedTextTag, ( IsUnitAlly(whichUnit, LocalPlayer) or IsPlayerObserverEx(LocalPlayer) ))
            endif
            
            if remaining <=0. then
                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", sx, sy))

                call SetUnitPositionEx(whichUnit, tx, ty)
                call UnitIncStunCount(whichUnit)
                call UnitDecStunCount(whichUnit)
                call KillTreeByCircle(tx, ty, 240)

                call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", sx, sy))
            endif
        elseif GetTriggerEventId() == EVENT_WIDGET_DEATH or GetSpellAbilityId() == TOWN_PORTAL_SCROLL_ABILITY_ID then
            call PlayerSetTeleportRequires(GetOwningPlayer(whichUnit), false)
            
            call MHEffect_Hide(teleportUnitEffect, true)
            call DestroyEffect(teleportUnitEffect)
            call MHEffect_Hide(progressBarEffect, true)
            call DestroyEffect(progressBarEffect)

            call DestroyEffect((LoadEffectHandle(HY, h, 175)))
            call DestroyEffect((LoadEffectHandle(HY, h, 176)))
            call DestroyEffect((LoadEffectHandle(HY, h, 177)))
            call DestroyUbersplat(teleportEffectUbersplat)
            
            call UnitRemoveType(targetUnit, UNIT_TYPE_PEON)
            
            if GetTriggerEventId() == EVENT_WIDGET_DEATH then
                call IssueImmediateOrderById(whichUnit, 851972)
            endif

            call FlushChildHashtable(HY, h)
            call DestroyTrigger(trig)
        endif
        set trig                    = null
        set whichUnit               = null
        set targetUnit              = null
        set teleportEffectUbersplat = null
        set teleportUnitEffect      = null
        set progressBarEffect       = null
        return false
    endfunction

    function TownPortalScrollOnSpellEffect takes nothing returns nothing
        local unit      whichUnit  = GetTriggerUnit()
        local unit      targetUnit = GetSpellTargetUnit()
        local real      tx
        local real      ty
        local real      sx
        local real      sy
        local trigger   trig
        local integer   h
        local unit      teleportEffectFromUnit
        local unit      teleportEffectColoredUnit
        local ubersplat teleportEffectUbersplat
        local effect    teleportUnitEffect

        local integer   id = GetPlayerId(GetOwningPlayer(whichUnit))
        local integer   count
        local real      duration
        local real      angle
        local real      distance
        
        set trig = CreateTrigger()
        set h = GetHandleId(trig)

        call PlayerSetTeleportRequires(GetOwningPlayer(whichUnit), true)

        if targetUnit == null then
            set tx = GetSpellTargetX()
            set ty = GetSpellTargetY()
            set targetUnit = GetTownPortalScrollTargetUnit(whichUnit, tx, ty)
        else
            set tx = GetUnitX(targetUnit)
            set ty = GetUnitY(targetUnit)
        endif

        // 如果对自己施法
        if whichUnit == targetUnit then
            if IsPlayerSentinel(GetOwningPlayer(whichUnit)) then
                set tx = GetUnitX(SentinelFountainOfLifeUnit)
                set ty = GetUnitY(SentinelFountainOfLifeUnit)
                set targetUnit = SentinelFountainOfLifeUnit
            else
                set tx = GetUnitX(ScourgeFountainOfLifeUnit)
                set ty = GetUnitY(ScourgeFountainOfLifeUnit)
                set targetUnit = ScourgeFountainOfLifeUnit
            endif
        endif

        set sx = GetUnitX(whichUnit)
        set sy = GetUnitY(whichUnit)
        if GetDistanceBetween(tx, ty, GetUnitX(targetUnit), GetUnitY(targetUnit)) > MaxTargetingDistance then
            // 计算目标单位到施法XY的坐标
            set angle = Atan2(ty -GetUnitY(targetUnit), tx - GetUnitX(targetUnit))
            set tx = GetUnitX(targetUnit) + MaxTargetingDistance * Cos(angle)
            set ty = GetUnitY(targetUnit) + MaxTargetingDistance * Sin(angle)
        elseif GetDistanceBetween(tx, ty, GetUnitX(targetUnit), GetUnitY(targetUnit)) < MinTargetingDistance then
            set angle = Atan2(ty -GetUnitY(targetUnit), tx - GetUnitX(targetUnit))
            set tx = GetUnitX(targetUnit) + MinTargetingDistance * Cos(angle)
            set ty = GetUnitY(targetUnit) + MinTargetingDistance * Sin(angle)
        endif

        set tx = CoordinateX50(tx)
        set ty = CoordinateY50(ty)
        if (IsUnitAlly(whichUnit, LocalPlayer) and LocalPlayer != GetOwningPlayer(whichUnit)) or (IsPlayerObserverEx(LocalPlayer)) then
            call PingMinimapEx(tx, ty, 3, 255, 255, 255, false)
        endif

        set teleportEffectColoredUnit = CreateUnit(GetOwningPlayer(whichUnit), GetScrollOfTeleportEffectUnitTypeByPlayerId(id), tx, ty, 0)
        set teleportEffectFromUnit    = CreateUnit(GetOwningPlayer(whichUnit), 'h0AX', sx, sy, 0)
        
        set teleportEffectUbersplat   = CreateUbersplat(sx, sy, "SCTP", 255, 255, 255, 255, false, false)
        call SetUbersplatRenderAlways(teleportEffectUbersplat, IsUnitVisibleToPlayer(whichUnit, LocalPlayer))
       
        set teleportUnitEffect        = AddSpecialEffect(GetUnitModel(whichUnit), tx, ty)
        call MHEffect_SetAnimationByName(teleportUnitEffect, "Stand", MHSlk_ReadStr(SLK_TABLE_UNIT, GetUnitTypeId(whichUnit), "attachmentlinkprops"))
        call MHEffect_SetScale(teleportUnitEffect, GetUnitScale(whichUnit))
        call MHEffect_SetZ(teleportUnitEffect, MHEffect_GetZ(teleportUnitEffect) + GetUnitDefaultFlyHeight(whichUnit))
        call MHEffect_SetYaw(teleportUnitEffect, bj_RADTODEG * Atan2(ty - sy, tx - sx))
        call MHEffect_SetColorEx(teleportUnitEffect, 128, 128, 128, 128)
        call MHEffect_SetTeamColor(teleportUnitEffect, GetPlayerColor(GetOwningPlayer(whichUnit)))
        call MHEffect_SetTeamGlow(teleportUnitEffect, GetPlayerColor(GetOwningPlayer(whichUnit)))

        call NUO(GetPlayerId(GetOwningPlayer(whichUnit)), tx, ty)
        set count = NWO(GetPlayerId(GetOwningPlayer(whichUnit)), tx, ty)
        
        set duration = 3.
        if count > 0 then
            set duration = 4.5 + .5 * count
        	call SetUnitAnimationByIndex(teleportEffectFromUnit, 2)
        	call SetUnitAnimationByIndex(teleportEffectColoredUnit, 2)
        endif

        // tp 持续施法
        call TriggerRegisterTimerEvent(trig, .02, true)
        call TriggerRegisterUnitEvent(trig, whichUnit, EVENT_UNIT_SPELL_ENDCAST)
        call TriggerAddCondition(trig, Condition(function TownPortalScrollOnUpdate))
    
        call SaveEffectHandle(HY, h, 178, teleportUnitEffect)
        call SaveEffectHandle(HY, h, 179, CreateProgressBarEffect(whichUnit, duration))
        call SaveEffectHandle(HY, h, 176,(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl", whichUnit, "origin")))
        call SaveUnitHandle(HY, h, 447,(teleportEffectColoredUnit))
        call SaveUnitHandle(HY, h, 448,(teleportEffectFromUnit))
        call SaveUbersplatHandle(HY, h, 131,(teleportEffectUbersplat))
        
        call SaveReal(HY, h, 6,((tx)* 1.))
        call SaveReal(HY, h, 7,((ty)* 1.))
        call SaveReal(HY, h, 442,(((GetGameTime()))* 1.))
        call SaveReal(HY, h, 57,((duration)* 1.))
        call SaveUnitHandle(HY, h, 14,(whichUnit))

        call CreateFogModifierTimedForPlayer(GetOwningPlayer(whichUnit), duration, tx, ty, 200)
        call B1X(whichUnit, HintSound, tx, ty, 2400)

        set whichUnit  = null
        set targetUnit = null
        set teleportUnitEffect        = null
        set teleportEffectFromUnit    = null
        set teleportEffectColoredUnit = null
        set teleportEffectUbersplat   = null
        set trig = null
    endfunction

    function BootsOfTravelOnSpellEffect takes boolean isUpgraded returns nothing
        local unit      whichUnit = GetTriggerUnit()
        local unit      targetUnit = GetSpellTargetUnit()
        local player    whichPlayer = GetOwningPlayer(whichUnit)
        local real      sx
        local real      sy
        local real      tx
        local real      ty
        local trigger   trig
        local integer   h
        local ubersplat teleportEffectUbersplat
        local effect    teleportUnitEffect
        local integer   playerId      
        local real      duration
    
        set playerId = GetPlayerId(whichPlayer)
        set trig = CreateTrigger()
        set h = GetHandleId(trig)

        call PlayerSetTeleportRequires(whichPlayer, true)

        if targetUnit == null then
            set tx    = GetSpellTargetX()
            set ty    = GetSpellTargetY()
            set targetUnit = GetBootsOfTravelTargetUnit(whichUnit, tx, ty, isUpgraded)
        endif
        if whichUnit == targetUnit then
            if IsPlayerSentinel(whichPlayer) then
                set tx = GetUnitX(SentinelFountainOfLifeUnit)
                set ty = GetUnitY(SentinelFountainOfLifeUnit)
                set targetUnit = SentinelFountainOfLifeUnit
            else
                set tx = GetUnitX(ScourgeFountainOfLifeUnit)
                set ty = GetUnitY(ScourgeFountainOfLifeUnit)
                set targetUnit = ScourgeFountainOfLifeUnit
            endif
        endif
        
        set sx = GetUnitX(whichUnit)
        set sy = GetUnitY(whichUnit)
        set tx = GetUnitX(targetUnit)
        set ty = GetUnitY(targetUnit)
        if (IsUnitAlly(whichUnit, LocalPlayer) and LocalPlayer!= whichPlayer) or (IsPlayerObserverEx(LocalPlayer)) then
            call PingMinimapEx(tx, ty, 3, 255, 255, 255, false)
        endif

        set teleportUnitEffect = AddSpecialEffect(GetUnitModel(whichUnit), tx, ty)
        call MHEffect_SetAnimationByName(teleportUnitEffect, "Stand", MHSlk_ReadStr(SLK_TABLE_UNIT, GetUnitTypeId(whichUnit), "attachmentlinkprops"))
        call MHEffect_SetScale(teleportUnitEffect, GetUnitScale(whichUnit))
        call MHEffect_SetZ(teleportUnitEffect, GetUnitHPBarHeight(targetUnit) + GetUnitZ(targetUnit) + 25.)
        call MHEffect_SetYaw(teleportUnitEffect, bj_RADTODEG * Atan2(ty - sy, tx - sx))
        call MHEffect_SetColorEx(teleportUnitEffect, 128, 128, 128, 128)
        call MHEffect_SetTeamColor(teleportUnitEffect, GetPlayerColor(whichPlayer))
        call MHEffect_SetTeamGlow(teleportUnitEffect, GetPlayerColor(whichPlayer))

        set teleportEffectUbersplat = CreateUbersplat(sx, sy, "SCTP", 255, 255, 255, 255, false, false)
        call SetUbersplatRenderAlways(teleportEffectUbersplat, IsUnitVisibleToPlayer(whichUnit, LocalPlayer))
        
        set duration = 3
        call UnitAddType(targetUnit, UNIT_TYPE_PEON)
        // 飞鞋tp 持续施法 恒定三秒
        call TriggerRegisterTimerEvent(trig, .02, true)
        call TriggerRegisterUnitEvent(trig, whichUnit, EVENT_UNIT_SPELL_ENDCAST)
        call TriggerRegisterDeathEvent(trig, targetUnit)
        call TriggerAddCondition(trig, Condition(function BootsOfTravelOnUpdate))

        call SaveEffectHandle(HY, h, 178, teleportUnitEffect)
        call SaveEffectHandle(HY, h, 179, CreateProgressBarEffect(whichUnit, duration))

        call SaveReal(HY, h, 57, duration)
        call SaveReal(HY, h, 442, GetGameTime())
        call SaveReal(HY, h, 6,((tx)* 1.))
        call SaveReal(HY, h, 7,((ty)* 1.))
        call SaveUbersplatHandle(HY, h, 131,(teleportEffectUbersplat))
        call SaveUnitHandle(HY, h, 14,(whichUnit))
        call SaveUnitHandle(HY, h, 17,(targetUnit))
        call SaveEffectHandle(HY, h, 175,(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", whichUnit, "origin")))
        call SaveEffectHandle(HY, h, 176,(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl", whichUnit, "origin")))
        call SaveEffectHandle(HY, h, 177,(AddSpecialEffectTarget("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl", targetUnit, "origin")))
        call CreateFogModifierTimedForPlayer(whichPlayer, duration, tx, ty, 200.)
        call B1X(whichUnit, HintSound, tx, ty, 2400)

        set whichUnit               = null
        set targetUnit              = null
        set teleportUnitEffect      = null
        set teleportEffectUbersplat = null
        set trig                    = null
    endfunction
    function ItemTownPortalScrollOnSpellEffect takes nothing returns nothing
        local integer level = GetAbilityLevel(GetSpellAbility())
        if level == 1 and not IsUnitCourier(GetTriggerUnit()) then
            call TownPortalScrollOnSpellEffect()
        elseif level > 1 then
            call BootsOfTravelOnSpellEffect(level == 3)
        endif
    endfunction

    // 刷新技能
    private function UnitUpdateAbilityLevel takes unit whichUnit returns nothing
        local integer bootsOfTravelCount
        local integer bootsOfTravelUpgradedCount

        if whichUnit == null or IsUnitCourier(whichUnit) then
            return
        endif

        set bootsOfTravelCount         = GetUnitItemCountById(whichUnit, ItemRealId[Item_BootsOfTravel])
        set bootsOfTravelUpgradedCount = GetUnitItemCountById(whichUnit, ItemRealId[Item_BootsOfTravelUpgraded])
    
        if bootsOfTravelUpgradedCount > 0 then
            call SetUnitTownPortalScrollLevel(whichUnit, 3)
        elseif bootsOfTravelCount > 0 then
            call SetUnitTownPortalScrollLevel(whichUnit, 2)
        else
            call SetUnitTownPortalScrollLevel(whichUnit, 1)
        endif
    endfunction

    private function DelayAddChargesOnExpired takes nothing returns nothing
        local SimpleTick tick      = SimpleTick.GetExpired()
        local unit       whichUnit = SimpleTickTable[tick].unit['u']
        
        call UnitAddTownPortalScrollCharges(whichUnit, tick.data)

        call tick.Destroy()
        set whichUnit = null
    endfunction
    // 拿tp
    function ItemTownPortalScrollOnPickup takes nothing returns nothing
        local unit       whichUnit = Event.GetTriggerUnit()
        local item       whichItem
        //local SimpleTick tick
        if whichUnit == null then
            return
        endif
        set whichItem = Event.GetManipulatedItem()

        //set tick = SimpleTick.Create(GetItemCharges(whichItem))
        //call tick.Start(0., false, function DelayAddChargesOnExpired)
        //set SimpleTickTable[tick].unit['u'] = whichUnit
        call UnitAddTownPortalScrollCharges(whichUnit, GetItemCharges(whichItem))
        call SilentRemoveItem(whichItem)
  
        set whichUnit = null
        set whichItem = null
    endfunction

    function ItemBootsOfTravelOnPickup takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        if whichUnit == null then
            return
        endif
        call UnitUpdateAbilityLevel(whichUnit)
        
        set whichUnit = null
    endfunction
    function ItemBootsOfTravelOnDrop takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        if whichUnit == null then
            return
        endif
        call UnitUpdateAbilityLevel(whichUnit)
        
        set whichUnit = null
    endfunction
    function ItemBootsOfTravelUpgradedOnPickup takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        if whichUnit == null then
            return
        endif
        call UnitUpdateAbilityLevel(whichUnit)
        
        set whichUnit = null
    endfunction
    function ItemBootsOfTravelUpgradedOnDrop takes nothing returns nothing
        local unit    whichUnit = Event.GetTriggerUnit()
        if whichUnit == null then
            return
        endif
        call UnitUpdateAbilityLevel(whichUnit)
        
        set whichUnit = null
    endfunction

endscope
