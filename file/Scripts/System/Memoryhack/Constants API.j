//----------------------------------------------------------------------MH Constants API----------------------------------------------------------------------//

//! nocjass
library MemoryHackConstantsAPI
    function IsOPLimitRemoved takes nothing returns boolean
        local integer addr = LoadInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr1") )

        if addr != 0 then
            return ReadRealMemory( addr ) == 0x7FFFFFFF // 6A570004 -> 0x6A570FFF
        endif

        return false
    endfunction

    function EnableOPLimitEx takes boolean flag, integer id returns nothing
        local integer addr           = LoadInteger( MemHackTable, StringHash("OPLimit"), StringHash( "Addr" + I2S( id ) ) )
        local integer oldvalue       = LoadInteger( MemHackTable, StringHash("OPLimit"), StringHash( "Value" + I2S( id ) ) )
        local integer value          = 0
        local integer oldprotection1 = 0

        if addr != 0 then
            if oldvalue == 0 then
                set oldvalue = ReadRealMemory( addr )
                call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash( "Value" + I2S( id ) ), oldvalue )
            endif

            if oldvalue != 0 then
                if flag then
                    set value = oldvalue
                else
                    set value = 0x2DC6C0 // 0x6A570FFF
                endif

                set oldprotection1 = ChangeOffsetProtection( addr, 0x4, 0x40 )
                call WriteRealMemory( addr, value )
                //call BJDebugMsg( "ReadRealMemory( addr " + I2S( id ) + " ) = " + IntToHex( ReadRealMemory( addr ) ) )
                call ChangeOffsetProtection( addr, 0x4, oldprotection1 )
            endif
        endif
    endfunction
    
    function EnableOPLimit takes boolean flag returns nothing
        local integer i = 1

        loop
            exitwhen i > 9
            call EnableOPLimitEx( flag, i )
            set i = i + 1
        endloop
    endfunction

    function Init_MemHackConstantsAPI takes nothing returns nothing
        call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr1"), pGameDLL + 0x1BFB49 )
        call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr2"), pGameDLL + 0x1E99FF )
        call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr3"), pGameDLL + 0x1EF711 )
        call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr4"), pGameDLL + 0x1F224B )
        call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr5"), pGameDLL + 0x7F1973 )
        call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr6"), pGameDLL + 0x7F2A1A )
        call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr7"), pGameDLL + 0x8909F5 )
        call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr8"), pGameDLL + 0x890A05 )
        call SaveInteger( MemHackTable, StringHash("OPLimit"), StringHash("Addr9"), pGameDLL + 0x8920A4 )
        call SaveInteger( MemHackTable, StringHash("SpeedLimit"), StringHash("ConsMoveSpeed"),    pGameDLL + 0xBEC454 )       // Added By Asphodelus
        call SaveInteger( MemHackTable, StringHash("SpeedLimit"), StringHash("UnitMoveSpeed"),    pGameDLL + 0xBEC464 )
        call SaveInteger( MemHackTable, StringHash("SpeedLimit"), StringHash("MoveSpeedLimiter"), pGameDLL + 0xBB82BC )
        call SaveInteger( MemHackTable, StringHash("SpeedLimit"), StringHash("AttackSpeed"),      pGameDLL + 0xBE7A04 )
        call SaveInteger( MemHackTable, StringHash("SpeedLimit"), StringHash("AttackTime"),       pGameDLL + 0xB593A0)
    endfunction
endlibrary
//! endnocjass

//----------------------------------------------------------------------MH Constants API END----------------------------------------------------------------------//
