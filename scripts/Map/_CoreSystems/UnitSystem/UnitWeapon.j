
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
            
           // call BJDebugMsg("目标允许：" + MHMath_ToHex(GetAbilityTargetAllow(whichAbility)))
            if MHUnit_CheckTargetAllow(AttackReadySource, AttackReadyTarget, GetAbilityTargetAllow(whichAbility)) then
                set probability = R2I(GetAbilityRealLevelFieldById(abilId, GetAbilityLevel(whichAbility), ABILITY_LEVEL_DEF_DATA_DATA_A))
             //   call BJDebugMsg("目标允许过了,probability:" + I2S(probability))
                if GetUnitPseudoRandom(AttackReadySource, abilId, probability) then
              //      call BJDebugMsg("加了")
                    call AbilityAdd0x20Flag(whichAbility, 0x200)
                else
               //     call BJDebugMsg("没了")
                    call AbilityRemove0x20Flag(whichAbility, 0x200)
                endif
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
