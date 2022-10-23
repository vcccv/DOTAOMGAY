
library base

    // yd japi ==================================================================
    // 技能----------------------------------------------------

    ///<summary>技能属性 [JAPI]</summary>
    function YDWEGetUnitAbilityState takes unit u, integer abilcode, integer state_type returns real
        return EXGetAbilityState(EXGetUnitAbility(u, abilcode), state_type)
    endfunction
    ///<summary>技能数据 (整数) [JAPI]</summary>
    function YDWEGetUnitAbilityDataInteger takes unit u, integer abilcode, integer level, integer data_type returns integer
        return EXGetAbilityDataInteger(EXGetUnitAbility(u, abilcode), level, data_type)
    endfunction
    ///<summary>技能数据 (实数) [JAPI]</summary>
    function YDWEGetUnitAbilityDataReal takes unit u, integer abilcode, integer level, integer data_type returns real
        return EXGetAbilityDataReal(EXGetUnitAbility(u, abilcode), level, data_type)
    endfunction
    ///<summary>技能数据 (字符串) [JAPI]</summary>
    function YDWEGetUnitAbilityDataString takes unit u, integer abilcode, integer level, integer data_type returns string
        return EXGetAbilityDataString(EXGetUnitAbility(u, abilcode), level, data_type)
    endfunction
    ///<summary>设置技能属性 [JAPI]</summary>
    function YDWESetUnitAbilityState takes unit u, integer abilcode, integer state_type, real value returns boolean
        return EXSetAbilityState(EXGetUnitAbility(u, abilcode), state_type, value)
    endfunction
    ///<summary>设置技能数据 (整数) [JAPI]</summary>
    function YDWESetUnitAbilityDataInteger takes unit u, integer abilcode, integer level, integer data_type, integer value returns boolean
        return EXSetAbilityDataInteger(EXGetUnitAbility(u, abilcode), level, data_type, value)
    endfunction
    ///<summary>设置技能数据 (实数) [JAPI]</summary>
    function YDWESetUnitAbilityDataReal takes unit u, integer abilcode, integer level, integer data_type, real value returns boolean
        return EXSetAbilityDataReal(EXGetUnitAbility(u, abilcode), level, data_type, value)
    endfunction
    ///<summary>设置技能数据 (字符串) [JAPI]</summary>
    function YDWESetUnitAbilityDataString takes unit u, integer abilcode, integer level, integer data_type, string value returns boolean
        return EXSetAbilityDataString(EXGetUnitAbility(u, abilcode), level, data_type, value)
    endfunction

    function GetParabolaZEx takes real x, real d, real h, real z0, real zd returns real
        return 4 * h * x * (d -x) / (d * d) + x * (zd-z0) / d + z0
    endfunction

    function RadianBetweenUnit takes unit a, unit b returns real
        return Atan2(GetUnitY(b)-GetUnitY(a), GetUnitX(b)-GetUnitX(a))
    endfunction
    
    function AngleBetweenUnit takes unit a, unit b returns real
        return bj_RADTODEG * Atan2(GetUnitY(b)-GetUnitY(a), GetUnitX(b)-GetUnitX(a))
    endfunction
    
    function AngleBetweenXY takes real x1, real y1, real x2, real y2 returns real
        return bj_RADTODEG * Atan2(y2 -y1, x2 -x1)
    endfunction
    
    // 弧度
    function RadianBetweenXY takes real x1, real y1, real x2, real y2 returns real
        return Atan2(y2 -y1, x2 -x1)
    endfunction

    function GetDistanceBetween takes real x1, real y1, real x2, real y2 returns real
        return SquareRoot((x1 -x2) * (x1 -x2) + (y1 -y2) * (y1 -y2))
    endfunction

    //========================================坐标修正
    function CoordinateX50 takes real x returns real
        local real dx = GetRectMinX(bj_mapInitialPlayableArea)+ 50
        if(x < dx) then
            return dx
        endif
        set dx = GetRectMaxX(bj_mapInitialPlayableArea)-50
        if(x > dx) then
            return dx
        endif
        return x
    endfunction
    function CoordinateX75 takes real x returns real
        local real dx = GetRectMinX(bj_mapInitialPlayableArea)+ 75
        if(x < dx) then
            return dx
        endif
        set dx = GetRectMaxX(bj_mapInitialPlayableArea)-75
        if(x > dx) then
            return dx
        endif
        return x
    endfunction
    function CoordinateY50 takes real y returns real
        local real dy = GetRectMinY(bj_mapInitialPlayableArea)+ 50
        if(y < dy) then
            return dy
        endif
        set dy = GetRectMaxY(bj_mapInitialPlayableArea)-50
        if(y > dy) then
            return dy
        endif
        return y
    endfunction
    function CoordinateY75 takes real y returns real
        local real dy = GetRectMinY(bj_mapInitialPlayableArea)+ 75
        if(y < dy) then
            return dy
        endif
        set dy = GetRectMaxY(bj_mapInitialPlayableArea)-75
        if(y > dy) then
            return dy
        endif
        return y
    endfunction

    function GetGameTime takes nothing returns real
        return TimerGetElapsed(GameTimer)
    endfunction

    function EIX takes string s returns nothing
        if OY == false and FQV == false then
            call DisplayTimedTextToPlayer(LocalPlayer, 0, 0, 120, "|c00ff0303内部检验失败|r")
            call DisplayTimedTextToPlayer(LocalPlayer, 0, 0, 120, "|c00ff0303这可能不是一个严重的故障，但对我来说这个信息十分重要|r")
            call DisplayTimedTextToPlayer(LocalPlayer, 0, 0, 120, "|c00ff0303Error code: " + s + "|r")
            set FQV = true
        endif
    endfunction

    // 将触发器加入销毁队列
    function CleanCurrentTrigger takes trigger t returns nothing
        call DisableTrigger(t)
        set IJ = IJ + 1
        set QY[IJ]= t
        set UY[IJ]=(GetGameTime())+ 60
        if IJ > 8000 then
            call EIX("8k")
        endif
    endfunction

    function UnitAddPermanentAbility takes unit triggerUnit, integer ab returns boolean
        return UnitAddAbility(triggerUnit, ab) and UnitMakeAbilityPermanent(triggerUnit, true, ab)
    endfunction
    
    function UnitAddPermanentAbilitySetLevel takes unit u, integer id, integer lv returns nothing
        if GetUnitAbilityLevel(u, id) == 0 then
            call UnitAddPermanentAbility(u, id)
        endif
        call SetUnitAbilityLevel(u, id, lv)
    endfunction

    // 与lua交互获得Slk数据
    function GetObjectDataBySlk takes integer objectId, string tableName, string dataType returns string
        set SlkType = tableName
        set SlkdataType = dataType
        return AbilityId2String(objectId) // lua hook了此函数 调用slk库
    endfunction

    // 默认 动画伤害点 即 攻击前摇
    function GetUnitDefaultDamagePoint1 takes unit whichUnit returns real
        local integer typeId = GetUnitTypeId(whichUnit)
        local real data = 0
        if not HaveSavedReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_DMAGE_POINT1, typeId ) then
            set data = S2R( GetObjectDataBySlk( typeId, "unit", "dmgpt1" ) )
            call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_DMAGE_POINT1, typeId, data )
        else
            set data = LoadReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_DMAGE_POINT1, typeId )
        endif
        return data
    endfunction

    // 默认攻击1 射程
    function GetUnitDefaultRangeN1 takes unit whichUnit returns real
        local integer typeId = GetUnitTypeId(whichUnit)
        local real data = 0
        if not HaveSavedReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_RANGEN1, typeId ) then
            set data = S2R( GetObjectDataBySlk( typeId, "unit", "rangeN1" ) )
            call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_RANGEN1, typeId, data )
        else
            set data = LoadReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_RANGEN1, typeId )
        endif
        return data
    endfunction

    function GetUnitLaunchXById takes integer typeId returns real
        local real data = 0
        if not HaveSavedReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_LAUNCH_X, typeId ) then
            set data = S2R( GetObjectDataBySlk( typeId, "unit", "launchX" ) )
            call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_LAUNCH_X, typeId, data )
        else
            set data = LoadReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_LAUNCH_X, typeId )
        endif
        return data
    endfunction

    function GetUnitLaunchYById takes integer typeId returns real
        local real data = 0
        if not HaveSavedReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_LAUNCH_Y, typeId ) then
            set data = S2R( GetObjectDataBySlk( typeId, "unit", "launchY" ) )
            call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_LAUNCH_Y, typeId, data )
        else
            set data = LoadReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_LAUNCH_Y, typeId )
        endif
        return data
    endfunction

    function GetUnitLaunchZById takes integer typeId returns real
        local real data = 0
        if not HaveSavedReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_LAUNCH_Z, typeId ) then
            set data = S2R( GetObjectDataBySlk( typeId, "unit", "launchZ" ) )
            call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_LAUNCH_Z, typeId, data )
        else
            set data = LoadReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_LAUNCH_Z, typeId )
        endif
        return data
    endfunction

    function GetUnitImpactZById takes integer typeId returns real
        local real data = 0
        if not HaveSavedReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_IMPACT_Z, typeId ) then
            set data = S2R( GetObjectDataBySlk( typeId, "unit", "impactZ" ) )
            call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_IMPACT_Z, typeId, data )
        else
            set data = LoadReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_IMPACT_Z, typeId )
        endif
        return data
    endfunction

    function GetSummonSourceUnit takes unit u returns unit
        return LoadUnitHandle(ExtraHT, GetHandleId(u), SUMMONING_SOURCE_UNIT)
    endfunction
    
    function IsBlinkAbilityId takes integer id returns boolean
        return id =='A0ME' or id =='AEbl' or id =='AIbk' or id =='QB08' or id =='A3FJ' or id =='A01O' or id =='A0FN' or id =='A14O'
    endfunction

    function GetUnitModelScale takes unit whichUnit returns real
        local integer unitTypeId = GetUnitTypeId(whichUnit)
        local real data = LoadReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_SCALE, unitTypeId )
        if data != 0 then
            return data
        else
            set data = EXGetUnitReal( unitTypeId, UNIT_REAL_MODEL_SCALE )
            call SaveReal( ObjectData, OBJ_HTKEY_UNIT_ORIGIN_SCALE, unitTypeId, data )
            if data == 0 then
                //call BJDebugMsg("错误， " + GetUnitName(whichUnit) + " 没有被保存缩放")
                return 1.
            endif
            return data
        endif
        return 1.
    endfunction

    // 设置并保存单位当前缩放值
    function SetUnitCurrentScaleEx takes unit whichUnit, real unitScale returns real
        local real modelScale = GetUnitModelScale(whichUnit) * unitScale + LoadReal( ExtraHT, GetHandleId(whichUnit), HTKEY_UNIT_CURRENT_ADDSCALE )
        // debug call SingleDebug( R2S( modelScale )  + " unitScale" + R2S(unitScale))
        call SetUnitScale(whichUnit, modelScale, modelScale, modelScale)
        call SaveReal( ExtraHT, GetHandleId(whichUnit), HTKEY_UNIT_CURRENT_PERCENT_SCALE, unitScale )
        return modelScale
    endfunction

    // 获取单位当前缩放值
    function GetUnitCurrentScale takes unit whichUnit returns real
        local real data = LoadReal( ExtraHT, GetHandleId(whichUnit), HTKEY_UNIT_CURRENT_PERCENT_SCALE )
        if data == 0 then
            return 1.
        endif
        return data
    endfunction

    function RCX takes unit u returns boolean
        return GetUnitAbilityLevel(u,'Bcyc')> 0 or GetUnitAbilityLevel(u,'Bcy2')> 0
    endfunction
    function RDX takes unit u returns boolean
        return(GetUnitAbilityLevel(u,('B02F'))> 0) or(GetUnitAbilityLevel(u,('BUsp'))> 0) or(GetUnitAbilityLevel(u,('BUst'))> 0)
    endfunction
    
    function RFX takes unit u returns boolean
        return GetUnitAbilityLevel(u,'B02J')> 0 or RCX(u) or RDX(u) or GetUnitAbilityLevel(u,'Avul')> 0
    endfunction

    function IsFortDefenseTypeUnit takes unit u returns boolean
        local integer i = GetUnitTypeId(u)
        return i =='umtw' or i =='ebal' or i =='u00R' or i =='e026' or i == 'n003'
    endfunction

    function GetUnitAbilityCoolDown takes unit whichUnit, integer abilcode returns real
        local integer level = GetUnitAbilityLevel(whichUnit, abilcode)
        local real coolDown = EXGetAbilityDataReal(EXGetUnitAbility(whichUnit, abilcode), level, ABILITY_DATA_COOL)
        if GetUnitAbilityLevel(whichUnit,'A39S')== 1 then
            set coolDown = coolDown * 0.75
        endif
        return coolDown
    endfunction

    // 源伤害类型反弹
    function UnitTransmittedSourceTypeDamage takes unit sourceUnit, unit targetUnit, real value returns nothing
        set TransmittedDamage = true
        //call BJDebugMsg("反弹源类型伤害"+R2S(value))
        call UnitDamageTarget(sourceUnit, targetUnit, value, DEIsAttackDamage[DEI], true, ConvertAttackType(DESourceAttackType[DEI]), ConvertDamageType(DESourceDamageType[DEI]), WEAPON_TYPE_WHOKNOWS)
        set TransmittedDamage = false
    endfunction

    // 攻击伤害代表是否计算护甲
    // 远程伤害代表是否属技能伤害
    function UnitDamageTargetEx takes unit u, unit t, integer damageType, real d returns nothing
        if damageType == 0 or d < 0 then
            return
        endif
        set AD = AD + 1
        //set GX = damageType
        if damageType == 1 then
            // 法术攻击 魔法伤害
            call UnitDamageTarget(u, t, d, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
        elseif damageType == 2 then
            // 英雄攻击 普通伤害
            call UnitDamageTarget(u, t, d, true, true, ATTACK_TYPE_HERO, DAMAGE_TYPE_ENHANCED, WEAPON_TYPE_WHOKNOWS)
        elseif damageType == 3 then
            // 纯粹伤害
            if IsFortDefenseTypeUnit(t) then
                set d = d * 2
            endif
            call UnitDamageTarget(u, t, d, false, true, ATTACK_TYPE_HERO, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
        elseif damageType == 4 then
            // 穿刺攻击 普通伤害
            call UnitDamageTarget(u, t, d, true, true, ATTACK_TYPE_PIERCE, DAMAGE_TYPE_ENHANCED, WEAPON_TYPE_WHOKNOWS)
        elseif damageType == 5 then
            // 法术攻击 普通伤害
            call UnitDamageTarget(u, t, d, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_ENHANCED, WEAPON_TYPE_WHOKNOWS)
        elseif damageType == 6 or damageType == 11 then
            // 生命移除
            // 类型6会致死
            call SetWidgetLife(t, RMaxBJ(GetWidgetLife(t)-d, 1))
            if IsUnitType(t, UNIT_TYPE_HERO) then
                call UnitDamageTarget(u, t, 0, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_FIRE, WEAPON_TYPE_WHOKNOWS)
            endif
            if damageType == 6 or GetUnitAbilityLevel(t,'B07D')== 0 and GetWidgetLife(t)< 2 and RFX(t)== false then
                if IsUnitType(t, UNIT_TYPE_SUMMONED)== false then
                    call UnitRemoveBuffs(t, false, false)
                endif
                call UnitRemoveAbility(t,'Aetl')
                call UnitDamageTarget(CreateUnit(GetOwningPlayer(u),'e00E', 0, 0, 0), t, 100000000., true, false, ATTACK_TYPE_MELEE, DAMAGE_TYPE_ENHANCED, WEAPON_TYPE_WHOKNOWS)
            endif
        elseif damageType == 7 then
            // 神圣伤害
            if GetUnitAbilityLevel(t,'Aetl')> 0 or GetUnitAbilityLevel(t,'B01N')> 0 then
                // 英雄攻击 魔法伤害
                call UnitDamageTarget(u, t, d, false, true, ATTACK_TYPE_HERO, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            else
                // 英雄攻击 通用伤害
                call UnitDamageTarget(u, t, d, false, true, ATTACK_TYPE_HERO, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
            endif
        elseif damageType == 8 then
            // 英雄攻击
            call UnitDamageTarget(u, t, d, false, true, ATTACK_TYPE_HERO, DAMAGE_TYPE_ENHANCED, WEAPON_TYPE_WHOKNOWS)
        elseif damageType == 9 then
            call UnitDamageTarget(u, t, d, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)
        elseif damageType == 10 then // 分裂伤害
            call UnitDamageTarget(u, t, d, false, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_ENHANCED, WEAPON_TYPE_WHOKNOWS)
        elseif damageType == 12 then // 溅射伤害
            call UnitDamageTarget(u, t, d, true, false, ATTACK_TYPE_HERO, DAMAGE_TYPE_ENHANCED, WEAPON_TYPE_WHOKNOWS)
        endif
        //set GX = 0
        set AD = AD -1
    endfunction

    function LaunchAnAttack takes unit sourceUnit, unit targetUnit returns nothing
        local real damage = GetUnitState(sourceUnit, UNIT_STATE_ATTACK1_DAMAGE_BONUS) + GetUnitState(sourceUnit, UNIT_STATE_ATTACK1_DAMAGE_BASE) + GetUnitState(sourceUnit, UNIT_STATE_ATTACK1_DAMAGE_DICE) * GetRandomInt(1, R2I(GetUnitState(sourceUnit, UNIT_STATE_ATTACK1_DAMAGE_SIDE)) )
        set IsAnAttack = true
        call UnitDamageTargetEx(sourceUnit, targetUnit, 12, damage)
        set IsAnAttack = false
    endfunction

    function GetAllDamage takes nothing returns real
        return ( DEDamageValue[DEI] + DEPhysicsDamage[DEI] + DEMagicalDamage[DEI] + DEPureDamage[DEI] )
    endfunction
    
    // 恢复单位生命值
    function UnitRestoreHealth takes unit whichUnit, real value returns nothing
        call SetWidgetLife(whichUnit, GetWidgetLife(whichUnit) + value)
    endfunction

    function RefreshUnitPhaseMove takes unit whichUnit returns nothing
        local integer h = GetHandleId(whichUnit)
        local integer count = LoadInteger(ExtraHT, h, HTKEY_UNIT_PHASE_MOVE_COUINT)
        if not IsUnitType(whichUnit, UNIT_TYPE_FLYING) then
            if count > 0 then
                call EXSetUnitMoveType(whichUnit, MOVE_TYPE_WINDWALK )
                call EXSetUnitCollisionType(true, whichUnit, COLLISION_TYPE_UNIT)
            else // 计数等于0 时 重置移动类型
                call EXSetUnitMoveType(whichUnit, MOVE_TYPE_FOOT )
                call EXSetUnitCollisionType(false, whichUnit, COLLISION_TYPE_UNIT)
                // 重新设置位置 防止模型消失
                call SetUnitX( whichUnit, GetUnitX(whichUnit) )
                call SetUnitY( whichUnit, GetUnitY(whichUnit) )
            endif
        endif
    endfunction

    // 相位移动
    function SetUnitPhaseMove takes unit whichUnit, boolean flag returns nothing
        local integer h = GetHandleId(whichUnit)
        local integer count = LoadInteger(ExtraHT, h, HTKEY_UNIT_PHASE_MOVE_COUINT)
        if flag then
            set count = count + 1
        else
            set count = count - 1
        endif
        call SaveInteger(ExtraHT, h, HTKEY_UNIT_PHASE_MOVE_COUINT, count)
        if not IsUnitType(whichUnit, UNIT_TYPE_FLYING) then
            if count > 0 then
                call EXSetUnitMoveType(whichUnit, MOVE_TYPE_WINDWALK )
                call EXSetUnitCollisionType(true, whichUnit, COLLISION_TYPE_UNIT)
            else // 计数等于0 时 重置移动类型
                call EXSetUnitMoveType(whichUnit, MOVE_TYPE_FOOT )
                call EXSetUnitCollisionType(false, whichUnit, COLLISION_TYPE_UNIT)
                // 重新设置位置 防止模型消失
                call SetUnitX( whichUnit, GetUnitX(whichUnit) )
                call SetUnitY( whichUnit, GetUnitY(whichUnit) )
            endif
        endif
        //call BJDebugMsg("相位移动" + I2S(count))
    endfunction

    // 设置单位无视地形 计数 同时会施加相位移动
    function EXSetUnitPathing takes unit whichUnit, boolean flag returns nothing
        local integer h = GetHandleId(whichUnit)
        local integer count = LoadInteger(ExtraHT, h, HTKEY_UNIT_PATHING_COUINT)
        if flag then
            set count = count + 1
        else
            set count = count - 1
        endif
        //call BJDebugMsg("无视地形")
        call SaveInteger(ExtraHT, h, HTKEY_UNIT_PATHING_COUINT, count)
        if count == 0 then
            call SetUnitPathing(whichUnit, true)
            call SetUnitPhaseMove(whichUnit, false)
        elseif count == -1 then
            call SetUnitPathing(whichUnit, false)
            call SetUnitPhaseMove(whichUnit, true)
        endif
    endfunction

    function AddAttackLaunchingTrigCount takes unit whichUnit returns nothing
        local integer h = GetHandleId(whichUnit)
        call SaveInteger(ExtraHT, h, HTKEY_ATTACK_LAUNCHING_COUNT, LoadInteger(ExtraHT, h, HTKEY_ATTACK_LAUNCHING_COUNT) + 1)
    endfunction
    
    function ReduceAttackLaunchingTrigCount takes unit whichUnit returns nothing
        local integer h = GetHandleId(whichUnit)
        call SaveInteger(ExtraHT, h, HTKEY_ATTACK_LAUNCHING_COUNT, LoadInteger(ExtraHT, h, HTKEY_ATTACK_LAUNCHING_COUNT) - 1)
    endfunction
    
    // 设置单位无敌 计数
    function SetUnitInvulnerableEx takes unit whichUnit, boolean flag returns nothing
        local integer h = GetHandleId(whichUnit)
        local integer count = LoadInteger(ExtraHT, h, HTKEY_UNIT_INVELNERABLE_COUINT)
        if flag then
            set count = count + 1
        else
            set count = count - 1
        endif
        call SaveInteger(ExtraHT, h, HTKEY_UNIT_INVELNERABLE_COUINT, count)
        if count > 0 then
            call SetUnitInvulnerable(whichUnit, true)
        else
            call SetUnitInvulnerable(whichUnit, false)
        endif
    endfunction
    
    // 设置单位无敌 计数
    function SetUnitPeonType takes unit whichUnit, boolean flag returns nothing
        local integer h = GetHandleId(whichUnit)
        local integer count = LoadInteger(ExtraHT, h, HTKEY_UNIT_PEON_COUINT)
        if flag then
            set count = count + 1
        else
            set count = count - 1
        endif
        call SaveInteger(ExtraHT, h, HTKEY_UNIT_PEON_COUINT, count)
        if count == 1 then
            call UnitAddType(whichUnit, UNIT_TYPE_PEON)
        elseif count == 0 then
            call UnitRemoveType(whichUnit, UNIT_TYPE_PEON)
        endif
    endfunction
    
    function IsUnitInvulnerable takes unit whichUnit returns boolean
        return LoadInteger(ExtraHT, GetHandleId(whichUnit), HTKEY_UNIT_INVELNERABLE_COUINT) > 0
    endfunction

    function UnitRemoveAbilityToTimedEnd takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer h = GetHandleId(t)
        call UnitRemoveAbility(LoadUnitHandle(HY, h, 0), LoadInteger(HY, h, 0))
        call FlushChildHashtable(HY, h)
        call DestroyTimer(t)
        set t = null
    endfunction
    function UnitRemoveAbilityToTimed takes unit u, integer i, real dur returns nothing
        local timer t = CreateTimer()
        local integer h = GetHandleId(t)
        call SaveUnitHandle(HY, h, 0, u)
        call SaveInteger(HY, h, 0, i)
        call TimerStart(t, dur, false, function UnitRemoveAbilityToTimedEnd)
        set t = null
    endfunction

    function IsNotShowAbilityId takes integer id returns boolean
        return LoadBoolean(ObjectData, OBJ_HTKEY_IS_NOT_SHOW_ABILITY, id)
    endfunction
    function SetNotShowAbilityId takes integer id returns nothing
        call SaveBoolean( ObjectData, OBJ_HTKEY_IS_NOT_SHOW_ABILITY, id, true )
    endfunction

    // 立即停止一次单位的动作
    function EXStopUnit takes unit u returns nothing
        call EXPauseUnit(u, true)
        call IssueImmediateOrderById(u,$D0004)
        call EXPauseUnit(u, false)
    endfunction

endlibrary
