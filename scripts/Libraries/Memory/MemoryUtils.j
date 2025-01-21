
library MemoryUtils initializer Init
    
    globals
        integer pGameDLL = 0
    endglobals

    private function Init takes nothing returns nothing
        set pGameDLL = MHGame_GetGameDLL()
    endfunction

    function BitwiseAnd takes integer op1, integer op2 returns integer
        return MHMath_BitwiseAnd(op1, op2)
    endfunction

    function ReadRealMemory takes integer addr returns integer
        return MHTool_ReadInt(addr)
    endfunction

    function WriteRealMemory takes integer addr, integer value returns integer
        return MHTool_WriteInt(addr, value)
    endfunction

    function ConvertHandle takes handle h returns integer
        return MHTool_ToObject(u)
    endfunction

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


    function UnitEnableTruesightImmunity takes unit u returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = pData + 0x16C
            set pData = GetAddressLocustFlags( ReadRealMemory( pData ), ReadRealMemory( pData + 4 ) )

            if pData > 0 then
                call WriteRealMemory( pData + 0x34, MHMath_AddBit(ReadRealMemory( pData + 0x34 )), 0x08000000 )
            endif
        endif
    endfunction

    function UnitDisableTruesightImmunity takes unit u returns nothing
        local integer pData = ConvertHandle( u )

        if pData > 0 then
            set pData = pData + 0x16C
            set pData = GetAddressLocustFlags( ReadRealMemory( pData ), ReadRealMemory( pData + 4 ) )

            if pData > 0 then
                call WriteRealMemory( pData + 0x34, MHMath_RemoveBit(ReadRealMemory( pData + 0x34 )), 0x08000000 )
            endif
        endif
    endfunction

endlibrary

