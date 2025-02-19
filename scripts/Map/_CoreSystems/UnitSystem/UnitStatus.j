
library UnitStatus
    
    // types

    // 亡灵巫师
    function IsUnitNecronomicon takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='n00J' or id =='n00H' or id =='n00A' or id =='n00G' or id =='n006' or id =='n00K'
    endfunction
    // 熊灵伙伴
    function IsUnitSpiritBear takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='n004' or id =='n018' or id =='n01C' or id =='n01G'
    endfunction

    // status

    // 该单位是否是守卫单位
    function IsUnitWard takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit, 'A04R') > 0
    endfunction
    // 该单位是否是马甲单位
    function IsUnitDummy takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit, 'Aloc') > 0
    endfunction
    // 该单位是否处于被破坏状态(禁用被动)
    function IsUnitBroken takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit, 'A36D') > 0
    endfunction
    // 该单位是否处于晕眩状态
    function IsUnitStunned takes unit whichUnit returns boolean
        return MHUnit_GetStunCount(whichUnit) > 0
    endfunction
    // 该单位是否处于妖术状态
    function IsUnitHexed takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit, 'BOhx')> 0 or GetUnitAbilityLevel(whichUnit, 'B00H')> 0
    endfunction
    // 该单位是否处于隐身状态
    function IsUnitCloaked takes unit whichUnit returns boolean
        return MHUnit_GetInvisionCount(whichUnit) > 0
    endfunction
    // 该单位是否处于沉默状态
    function IsUnitSilenced takes unit whichUnit returns boolean
        return MHUnit_GetSilenceCount(whichUnit) > 0
    endfunction
    // 该单位是否处于虚无状态
    function IsUnitEthereal takes unit whichUnit returns boolean
        return MHUnit_GetEtherealCount(whichUnit) > 0
    endfunction
    // 该单位是否处于攻击被禁用状态
    function IsUnitAttackDisabled takes unit whichUnit returns boolean
        return MHAbility_GetDisableCount(whichUnit, 'Aatk') > 0
    endfunction
    // 该单位是否处于无敌状态
    function IsUnitInvulnerable takes unit whichUnit returns boolean
        return MHUnit_IsInvulnerable(whichUnit)
    endfunction
    // 英雄级单位 计算镜像或熊灵
    function IsUnitHeroLevel takes unit whichUnit returns boolean
        return IsHeroUnitId(GetUnitTypeId(whichUnit)) or IsUnitSpiritBear(whichUnit)
    endfunction
    // 近战
    function IsUnitMeleeAttacker takes unit whichUnit returns boolean
        return IsUnitType(whichUnit, UNIT_TYPE_MELEE_ATTACKER)
    endfunction

    // 地面信使
    function IsUnitGroundCourierById takes integer id returns boolean
        return id =='np00' or id =='n00I' or id =='n022' or id =='n021' or id =='n0KY' or id =='n0KZ' or id =='n0LE' or id =='n023' or id =='n024' or id =='n025' or id =='n0L0' or id =='n0L1' or id =='n0M4' or id =='n00M' or id =='n0HV' or id =='n0LS'
    endfunction
    function IsUnitGroundCourier takes unit whichUnit returns boolean
        return IsUnitGroundCourierById(GetUnitTypeId(whichUnit))
    endfunction

    // 飞行信使
    function IsUnitFlyingCourierById takes integer id returns boolean
        return id =='np01' or id =='e01H' or id =='e01Z' or id =='e02R' or id =='e02T' or id =='e02S' or id =='e030'
    endfunction
    function IsUnitFlyingCourier takes unit whichUnit returns boolean
        return IsUnitFlyingCourierById(GetUnitTypeId(whichUnit))
    endfunction

    // 是信使单位
    function IsUnitCourier takes unit whichUnit returns boolean
        return IsUnitGroundCourier(whichUnit) or IsUnitFlyingCourier(whichUnit)
    endfunction
    // 是魔法免疫单位
    function IsUnitMagicImmune takes unit whichUnit returns boolean
        return IsUnitType(whichUnit, UNIT_TYPE_MAGIC_IMMUNE) or LoadInteger(HY, GetHandleId(whichUnit), 4252) == 1
    endfunction
    function IsUnitModelFlying takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='H00F' or id =='H00E' or id =='H00G' or id =='O017' or id =='N0MA' or id =='N0MB' or id =='N0MC' or id =='N0MO'
    endfunction

    // 佣兽
    function IsUnitFamiliarById takes integer id returns boolean
        return id =='u014' or id =='u015' or id =='u016' or id =='u01D' or id =='u01E' or id =='u01F' or id =='u01R' or id =='u01S' or id =='u01T' or id =='u017' or id =='u019' or id =='u018' or id =='u01A' or id =='u01B' or id =='u01C' or id =='u01U' or id =='u01V' or id =='u01W'
    endfunction
    // 墓碑
    function IsUnitTombstoneById takes integer id returns boolean
        return id =='n0FJ' or id =='n0FI' or id =='n0F6' or id =='n0FH'
    endfunction
    function IsUnitTombstone takes unit whichUnit returns boolean
        return IsUnitTombstoneById(GetUnitTypeId(whichUnit))
    endfunction

    // 遥控炸弹
    function IsUnitRemoteMines takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='o018' or id =='o002' or id =='o00B' or id =='o01B'
    endfunction
    // 地精地雷
    function IsUnitGoblinLandMine takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='n00Q' or id =='n00O' or id =='n00P' or id =='n00N'
    endfunction
    // 是地精工程师的召唤物
    function IsUnitGoblinSummonedWard takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return IsUnitRemoteMines(whichUnit) or IsUnitGoblinLandMine(whichUnit) or id =='otot'
    endfunction

    // 幽冥守卫
    function IsUnitNetherWardById takes integer id returns boolean
        return id =='o00L' or id =='o00M' or id =='o00N' or id =='o00O'
    endfunction
    function IsUnitNetherWard takes unit whichUnit returns boolean
        return IsUnitNetherWardById(GetUnitTypeId(whichUnit))
    endfunction
    
    // 超新星
    function IsUnitPhoenixSunById takes integer id returns boolean
        return id =='h0CV' or id =='h0CX' or id =='h0CW'
    endfunction

    // 瘟疫守卫
    function IsUnitPlagueWard takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='o00V' or id =='o00T' or id =='o00W' or id =='o00U'
    endfunction

    // 死亡守卫
    function IsUnitDeathWard takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='o000' or id =='o001' or id =='o00A' or id =='o00X' or id =='n12O'
    endfunction
    
    // 毒蛇守卫
    function IsUnitSerpentWard takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='o01C' or id =='o01D' or id =='o01E' or id =='osp4' or id =='o008' or id =='o009'
    endfunction

    // 是城甲单位
    function IsUnitDefenseTypeFort takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='umtw' or id =='ebal' or id =='u00R' or id =='e026' or id == 'n003'
    endfunction
    // 非移动类守卫？
    function R_X takes unit whichUnit returns boolean
        return IsUnitNetherWard(whichUnit) or IsUnitPlagueWard(whichUnit) or IsUnitDeathWard(whichUnit) or IsUnitSerpentWard(whichUnit) or IsUnitGoblinSummonedWard(whichUnit)
    endfunction
    // 飞行单位，枚举了英雄的飞行变身类型和所有飞行信使类型
    function IsUnitFlying takes unit whichUnit returns boolean
        local integer id = GetUnitTypeId(whichUnit)
        return id =='O017' or id =='QTW8' or id =='N0MA' or id =='N0MB' or id =='N0MC' or id =='N0MO' or IsUnitFamiliarById(id) or IsUnitFlyingCourier(whichUnit)
    endfunction
    // 能量齿轮
    function IsUnitPowerCogById takes integer id returns boolean
        return id =='u00S'
    endfunction
    // 蝗虫
    function IsUnitBeetleById takes integer id returns boolean
        return id =='u01K' or id =='u01H' or id =='u01J' or id =='u01L'
    endfunction
    // 追踪导弹
    function IsUnitHomingMissileById takes integer id returns boolean
        return id =='h0CH' or id =='h0CF' or id =='h0C1' or id =='h0CG'
    endfunction
    // 不会攻击的召唤物单位?
    function R4X takes unit whichUnit returns boolean
        return IsUnitType(whichUnit, UNIT_TYPE_SUMMONED) and not IsUnitType(whichUnit, UNIT_TYPE_MELEE_ATTACKER) and not IsUnitType(whichUnit, UNIT_TYPE_RANGED_ATTACKER)
    endfunction

    // 吹风
    function IsUnitCyclone takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit,'Bcyc')> 0 or GetUnitAbilityLevel(whichUnit,'Bcy2')> 0
    endfunction
    // 睡着了
    function IsUnitSleeping takes unit whichUnit returns boolean
        return(GetUnitAbilityLevel(whichUnit,('B02F'))> 0) or(GetUnitAbilityLevel(whichUnit,('BUsp'))> 0) or(GetUnitAbilityLevel(whichUnit,('BUst'))> 0)
    endfunction
    // 吹风和睡
    function RFX takes unit whichUnit returns boolean
        return GetUnitAbilityLevel(whichUnit,'B02J')> 0 or IsUnitCyclone(whichUnit) or IsUnitSleeping(whichUnit) or GetUnitAbilityLevel(whichUnit,'Avul')> 0
    endfunction

endlibrary
