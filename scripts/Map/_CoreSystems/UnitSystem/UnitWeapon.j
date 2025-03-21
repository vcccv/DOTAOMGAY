
library UnitWeapon requires Base, UnitUtils, UnitStateBonus
    
    globals
        unit AttackReadySource
        unit AttackReadyTarget
    endglobals

    // 激活暴击
    private function ActivatePassive takes nothing returns nothing
        local ability whichAbility = MHUnit_GetEnumAbility()
        local integer baseId       = GetAbilityBaseId(whichAbility)
        local integer abilId       = GetAbilityId(whichAbility)
        local integer probability

        // 暴击则看情况激活
        if baseId == 'AOcr' or baseId == 'ANdb' then
            // 手动排列允许的暴击，等到完全重构暴击实现再说
            if (      abilId == 'P047'   /* 剑舞
                */ or abilId == 'P240'   /* 恩赐解脱
                */ or abilId == 'P119'   /* 醉拳
                */ or abilId == 'A1OY'   /* 头狼暴击
                */ or abilId == 'AOcr'   /* 致命一击(骷髅王) 
                */ or abilId == 'A09O'   /* 暴雪弩炮
                */ or abilId == 'A207' ) /* 水晶剑
                
                */ and MHUnit_CheckTargetAllow(AttackReadySource, AttackReadyTarget, GetAbilityTargetAllow(whichAbility)) then
                set probability = R2I(GetAbilityRealLevelFieldById(abilId, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_DATA_A))

                if GetUnitPseudoRandom(AttackReadySource, abilId, probability) then
                    call AbilityAdd0x20Flag(whichAbility, 0x200)
                endif
            else
                call AbilityRemove0x20Flag(whichAbility, 0x200)
            endif

        endif

        set whichAbility = null
    endfunction

    function UnitLaunchAttack takes unit source, unit target returns nothing
        set AttackReadySource = source
        set AttackReadyTarget = target
        call MHUnit_EnumAbility(source, function ActivatePassive)

        call MHGame_ExecuteFunc("ExecteAttackReady")
        call UnitAddAttackRangeBonus(source, 99999)
        call MHUnit_LaunchAttack(source, 1, target)
        call UnitAddAttackRangeBonus(source, - 99999)
    endfunction
    // 忍不了了 先这样调
    function ExecteAttackReady takes nothing returns nothing
        call TZA.evaluate(AttackReadySource, AttackReadyTarget, false)
    endfunction

endlibrary
