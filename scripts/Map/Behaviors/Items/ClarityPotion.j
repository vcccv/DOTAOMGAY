
scope ClarityPotion

    // 50 * 8 = 400
    function ClarityPotionBuffOnAdd takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        call UnitAddManaRegen(whichUnit, 5.)
        set whichUnit    = null
    endfunction

    function ClarityPotionBuffOnRemove takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        call UnitAddManaRegen(whichUnit, - 5.)
        set whichUnit    = null
    endfunction

    function ItemClarityPotionOnSpellEffect takes nothing returns nothing
        local unit whichUnit  = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()

        if targetUnit == null then
            set targetUnit = whichUnit
        endif

        call UnitAddBuffByPolarity(whichUnit, targetUnit, 'BIrm', 1, 30., true, BUFF_LEVEL1)

        set whichUnit = null
    endfunction

endscope
