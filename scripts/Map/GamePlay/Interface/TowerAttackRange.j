library TowerAttackRange requires Base, PlayerSettingsLib
    
    globals
        effect array TowerAttackRangeIndicator
        integer TowerAttackRangeIndicatorCount = 0
        private boolean IsHidden = true

        private key TOWNER_ATTACK_RANGE_INDICATOR_KEY
    endglobals
    
    function CreateTowerAttackRangeIndicator takes unit tower returns nothing
        debug call ThrowWarning(Table[TOWNER_ATTACK_RANGE_INDICATOR_KEY].effect.has(GetHandleId(tower)), /*
        */ "TowerAttackRange", "CreateTowerAttackRangeIndicator", GetUnitName(tower), 0, "重复创建的攻击范围指示器")

        set TowerAttackRangeIndicatorCount = TowerAttackRangeIndicatorCount + 1
        set TowerAttackRangeIndicator[TowerAttackRangeIndicatorCount] = AddSpecialEffect("tower_range.mdx", GetUnitX(tower), GetUnitY(tower))
        set Table[TOWNER_ATTACK_RANGE_INDICATOR_KEY].integer[GetHandleId(tower)] = TowerAttackRangeIndicatorCount
        call MHEffect_Hide(TowerAttackRangeIndicator[TowerAttackRangeIndicatorCount], true)
    endfunction
    function DestroyTowerRangeIndicator takes unit tower returns nothing
        local integer index = Table[TOWNER_ATTACK_RANGE_INDICATOR_KEY].integer[GetHandleId(tower)]

        call DestroyEffect(TowerAttackRangeIndicator[index])
        if index != TowerAttackRangeIndicatorCount then
            set TowerAttackRangeIndicator[index] = TowerAttackRangeIndicator[TowerAttackRangeIndicatorCount]
        endif
        set TowerAttackRangeIndicator[TowerAttackRangeIndicatorCount] = null
        set TowerAttackRangeIndicatorCount = TowerAttackRangeIndicatorCount - 1
    endfunction

    globals
        private boolean prevAlt  = false
        private boolean prevShow = false
    endglobals

    function TowerAttackRangeUpdate takes nothing returns nothing
        local integer i
        local boolean showSetting = PlayerSettings(User.LocalId).IsHoldingALTShowsTowerAttackRange()
        local boolean currentAlt  = MHMsg_IsKeyDown(OSKEY_ALT)

        if showSetting != prevShow or (showSetting and currentAlt != prevAlt) then
            set i = 1
            loop
                exitwhen i > TowerAttackRangeIndicatorCount
                call MHEffect_Hide(TowerAttackRangeIndicator[i], not (showSetting and currentAlt))
                set i = i + 1
            endloop
            
            set prevAlt  = currentAlt
            set prevShow = showSetting
        endif
    endfunction

endlibrary

