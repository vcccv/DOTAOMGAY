
library UnitStatus
    
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

endlibrary
