
library MemoryUtils

    function GetTempestThread takes nothing returns integer
        return pGameDLL + 0xBE40A8
    endfunction

    function GetCObjectFromHash takes integer pHash1, integer pHash2 returns integer // Jass Variant of sub_6F03FA30 (126a)
        local integer addr  = GetTempestThread()
        local integer pOff1 = 0x2C

        if addr != 0 then
            if BitwiseAnd(pHash1, pHash2) == -1 then
                return 0
            endif

            if pHash1 >= 0 then
                set pOff1 = 0xC
            endif

            set pOff1 = ReadRealMemory( addr ) + pOff1
            set pOff1 = ReadRealMemory( pOff1 )

            if pOff1 == 0 then
                return 0
            endif

            set pOff1 = ReadRealMemory( pOff1 + 0x8 * pHash1 + 0x4 )

            if pOff1 == 0 or ReadRealMemory( pOff1 + 0x18 ) != pHash2 then
                return 0
            endif

            return pOff1
        endif

        return 0
    endfunction

    function GetAddressLocustFlags takes integer pHash1, integer pHash2 returns integer
        local integer pObj = GetCObjectFromHash( pHash1, pHash2 )

        if pObj > 0 then
            return ReadRealMemory( pObj + 0x94 )
        endif

        return 0
    endfunction

    function GetAbilityTargetAllow takes ability whichAbility returns integer
        local integer pData = ConvertHandle(whichAbility)

        if pData != 0 then
            return ReadRealMemory(pData + 0x4C)
        endif

        return 0
    endfunction

    function AbilityAdd0x20Flag takes ability whichAbility, integer bit returns nothing
        local integer pData = ConvertHandle(whichAbility)

        if pData > 0 then
            set pData = pData + 0x20
            
            if pData > 0 then
                //call BJDebugMsg("改之前"+MHMath_ToHex(ReadRealMemory(pData)))
                call WriteRealMemory(pData, MHMath_AddBit(ReadRealMemory(pData), bit))
                //call BJDebugMsg("改之后"+MHMath_ToHex(ReadRealMemory(pData)))
            endif
        endif
    endfunction
    function AbilityRemove0x20Flag takes ability whichAbility, integer bit returns nothing
        local integer pData = ConvertHandle(whichAbility)

        if pData > 0 then
            set pData = pData + 0x20
            
            if pData > 0 then
                call WriteRealMemory(pData, MHMath_RemoveBit(ReadRealMemory(pData), bit))
            endif
        endif
    endfunction


    function UnitAdd0x60Flag takes unit whichUnit, integer bit returns nothing
        local integer pData = ConvertHandle(whichUnit)

        if pData > 0 then
            set pData = pData + 0x60
            
            if pData > 0 then
                //call BJDebugMsg("改之前"+MHMath_ToHex(ReadRealMemory(pData)))
                debug call ThrowWarning(MHMath_IsBitSet(ReadRealMemory(pData), bit), "MemoryUtils", "UnitAdd0x60Flag", "unit", GetHandleId(whichUnit), "has flag " + MHMath_ToHex(bit))
                call WriteRealMemory(pData, MHMath_AddBit(ReadRealMemory(pData), bit))
                //call BJDebugMsg("改之后"+MHMath_ToHex(ReadRealMemory(pData)))
            endif
        endif
    endfunction
    function UnitRemove0x60Flag takes unit whichUnit, integer bit returns nothing
        local integer pData = ConvertHandle(whichUnit)

        if pData > 0 then
            set pData = pData + 0x60
            
            if pData > 0 then
                //call BJDebugMsg("改之前"+MHMath_ToHex(ReadRealMemory(pData)))
                debug call ThrowWarning(not MHMath_IsBitSet(ReadRealMemory(pData), bit), "MemoryUtils", "UnitRemove0x60Flag", "unit", GetHandleId(whichUnit), "not flag " + MHMath_ToHex(bit))
                call WriteRealMemory(pData, MHMath_RemoveBit(ReadRealMemory(pData), bit))
                //call BJDebugMsg("改之后"+MHMath_ToHex(ReadRealMemory(pData)))
            endif
        endif
    endfunction
    
    function UnitEnableTruesightImmunity takes unit u returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = pData + 0x16C
            set pData = GetAddressLocustFlags( ReadRealMemory( pData ), ReadRealMemory( pData + 4 ) )

            if pData > 0 then
                call WriteRealMemory( pData + 0x34, MHMath_AddBit(ReadRealMemory( pData + 0x34 ), 0x08000000) )
            endif
        endif
    endfunction

    function UnitDisableTruesightImmunity takes unit u returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = pData + 0x16C
            set pData = GetAddressLocustFlags( ReadRealMemory( pData ), ReadRealMemory( pData + 4 ) )

            if pData > 0 then
                call WriteRealMemory( pData + 0x34, MHMath_RemoveBit(ReadRealMemory( pData + 0x34 ), 0x08000000) )
            endif
        endif
    endfunction

    /*
    function GetAbilityId takes ability whichAbility returns integer
        local integer pAbility = ConvertHandle(whichAbility)
        if pAbility > 0 then
            return ReadRealMemory(pAbility + 0x34)
        endif
        return 0
    endfunction
    */

    function GetAbilityLevel takes ability whichAbility returns integer
        local integer pAbility = ConvertHandle(whichAbility)
        if pAbility > 0 then
            return (ReadRealMemory(pAbility + 0x50) + 1)
        endif
        return 0
    endfunction

    function UIData_GetCommandButtonRequireTip takes integer commandbutton returns string
        local integer commandButtonData = ReadRealMemory(commandbutton + 0x190)
        if commandButtonData != 0 then
            return MHTool_ReadStr(commandButtonData + 0x8C)
        endif

        return ""
    endfunction

    function UnitShareInvisVision takes unit whichUnit, player whichPlayer, integer shareType returns integer
        local integer addr     = pGameDLL + 0x66B260
        local integer pUnit    = ConvertHandle(whichUnit)
        local integer playerId = GetPlayerId(whichPlayer)

        if pUnit == 0 or whichPlayer == null then
            return 0
        endif

        return this_call_3(addr, pUnit, playerId, shareType)
    endfunction

    function UnitUnShareInvisVision takes unit whichUnit, player whichPlayer, integer shareType returns integer
        local integer addr     = pGameDLL + 0x65AA20
        local integer pUnit    = ConvertHandle(whichUnit)
        local integer playerId = GetPlayerId(whichPlayer)

        if pUnit == 0 or whichPlayer == null then
            return 0
        endif

        return this_call_3(addr, pUnit, playerId, shareType)
    endfunction

    // 0x66B470
    function UnitShareVisionEx takes unit whichUnit, player whichPlayer returns integer
        local integer addr     = pGameDLL + 0x66B470
        local integer pUnit    = ConvertHandle(whichUnit)
        local integer playerId = GetPlayerId(whichPlayer)

        if pUnit == 0 or whichPlayer == null then
            return 0
        endif

        return this_call_2(addr, pUnit, playerId)
    endfunction
    // 0x65AB10
    function UnitUnShareVisionEx takes unit whichUnit, player whichPlayer returns integer
        local integer addr     = pGameDLL + 0x65AB10
        local integer pUnit    = ConvertHandle(whichUnit)
        local integer playerId = GetPlayerId(whichPlayer)

        if pUnit == 0 or whichPlayer == null then
            return 0
        endif

        return this_call_2(addr, pUnit, playerId)
    endfunction
    
endlibrary
