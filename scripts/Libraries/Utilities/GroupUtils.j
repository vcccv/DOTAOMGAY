
library GroupUtils

    globals
        group ENUM_GROUP = CreateGroup()
    endglobals
   
    function GroupGetSize takes group whichGroup returns integer
        return MHGroup_GetSize(whichGroup)
    endfunction

    function GroupUnitAt takes group whichGroup, integer index returns unit
        return MHGroup_GetUnit(whichGroup, index)
    endfunction

    function GroupAddGroupFast takes group whichGroup, group addGroup returns nothing
        call MHGroup_AddGroup(addGroup, whichGroup)
    endfunction
    function GroupRemoveGroupFast takes group whichGroup, group removeGroup returns nothing
        call MHGroup_RemoveGroup(removeGroup, whichGroup)
    endfunction

endlibrary
