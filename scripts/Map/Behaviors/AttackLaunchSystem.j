scope AttackLaunchSystem

    globals
	    trigger AnyUnitAttackLaunchTrig
    endglobals

    // 先用地图内的分发
    private function OnLaunch takes nothing returns boolean
        set DESource = MHEvent_GetUnit()
        set DETarget = MHUnitAttackLaunchEvent_GetTargetUnit()
        call ExecuteAttackEvent(-3)
        return false
    endfunction

    function AttackLaunchSystem_Init takes nothing returns nothing
        set AnyUnitAttackLaunchTrig = CreateTrigger()
        call TriggerAddCondition(AnyUnitAttackLaunchTrig, Condition(function OnLaunch))
        call MHUnitAttackLaunchEvent_Register(AnyUnitAttackLaunchTrig)
    endfunction

endscope
