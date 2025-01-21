
library UnitUtils
    
    function UnitAddPermanentAbility takes unit whichUnit, integer ab returns boolean
        return UnitAddAbility(whichUnit, ab) and UnitMakeAbilityPermanent(whichUnit, true, ab)
    endfunction

endlibrary

