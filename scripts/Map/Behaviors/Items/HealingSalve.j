
scope HealingSalve 
    
    // 50 * 8 = 400
    function HealingSalveBuffOnAdd takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        call UnitAddLifeRegen(whichUnit, 50.)
        set whichUnit    = null
    endfunction

    function HealingSalveBuffOnRemove takes nothing returns nothing
        local unit       whichUnit    = Event.GetTriggerUnit()
        call UnitAddLifeRegen(whichUnit, - 50.)
        set whichUnit    = null
    endfunction

    function ItemHealingSalveOnSpellEffect takes nothing returns nothing
        local unit whichUnit  = GetTriggerUnit()
        local unit targetUnit = GetSpellTargetUnit()

        if targetUnit == null then
            set targetUnit = whichUnit
        endif

        call UnitAddBuffByPolarity(whichUnit, targetUnit, 'B02Z', 1, 8., true, BUFF_LEVEL1)

        set whichUnit = null
    endfunction

endscope
