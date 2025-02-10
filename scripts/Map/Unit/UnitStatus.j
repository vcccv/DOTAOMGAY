
library UnitStatus
    
    // types
    function IsUnitNecronomicon takes unit u returns boolean
        local integer id = GetUnitTypeId(u)
        return id =='n00J' or id =='n00H' or id =='n00A' or id =='n00G' or id =='n006' or id =='n00K'
    endfunction
    function IsUnitSpiritBear takes unit u returns boolean
        local integer i = GetUnitTypeId(u)
        return i =='n004' or i =='n018' or i =='n01C' or i =='n01G'
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

endlibrary
