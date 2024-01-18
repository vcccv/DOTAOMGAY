
//! import "UnitWeapon.j"
globals
    hashtable UnitDataHashTable = InitHashtable()
endglobals

function FlushUnitData takes unit whichUnit returns nothing
    if whichUnit == null then
        return
    endif
    call FlushChildHashtable(UnitDataHashTable, GetHandleId(whichUnit))
endfunction
