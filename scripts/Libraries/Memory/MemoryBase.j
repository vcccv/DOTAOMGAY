
library MemoryBase initializer Init
    
    native IgnoredUnits takes integer unitid returns integer                                     // reserved native for call 1 integer function and return integer value

    globals
        integer pGameDLL = 0
        
        integer pJassEnvAddress             = 0
        integer RJassNativesBufferSize      = 0
        integer array RJassNativesBuffer
        
        integer pIgnoredUnitsOffset = 0
        integer pIgnoredUnits       = 0

        integer array fpCallAddressList
        integer fpCallSize = 0

        integer MemoryBlock_block
        integer array l__MemoryBlock_block
        integer s__MemoryBlock_pHead
        integer s__MemoryBlock_size
    endglobals

    function s__MemoryBlock_initSize takes nothing returns nothing
        local integer lastIndex= ( 0x1000 - 1 ) / 4
        set l__MemoryBlock_block[lastIndex]=0
    endfunction

    function s__MemoryBlock_typecast takes nothing returns nothing
        local integer MemoryBlock_block
    endfunction

    function BitwiseAnd takes integer op1, integer op2 returns integer
        return MHMath_BitwiseAnd(op1, op2)
    endfunction

    function ReadRealMemory takes integer addr returns integer
        return MHTool_ReadInt(addr)
    endfunction

    function ReadRealFloat takes integer addr returns real
        return MHTool_ReadReal(addr)
    endfunction

    function WriteRealMemory takes integer addr, integer value returns nothing
        call MHTool_WriteInt(addr, value)
    endfunction

    function WriteRealFloat takes integer addr, real value returns nothing
        call MHTool_WriteReal(addr, value)
    endfunction

    function ConvertHandle takes handle h returns integer
        return MHTool_ToObject(h)
    endfunction

    function ReadRealPointer1LVL takes integer addr, integer offset1 returns integer
        local integer retval = 0
        
        if addr > 0 then
            set retval = ReadRealMemory( addr )
            
            if addr > 0 then
                set retval = ReadRealMemory( retval + offset1 )
            else
                set retval = 0
            endif
        endif
        
        return retval
    endfunction

    function WriteRealPointer1LVL takes integer addr, integer offset1, integer val returns nothing
        local integer retval = 0

        if addr > 0 then 
            set retval = ReadRealMemory( addr )

            if addr > 0 then 
                call WriteRealMemory( retval + offset1, val )
            endif
        endif
    endfunction

    function ReadRealPointer2LVL takes integer addr, integer offset1, integer offset2 returns integer
        local integer retval = ReadRealPointer1LVL( addr, offset1 )
        
        if retval > 0 then
            set retval = ReadRealMemory( retval + offset2 )
        else
            set retval = 0
        endif
        
        return retval
    endfunction

    function WriteRealPointer2LVL takes integer addr, integer offset1, integer offset2, integer val returns nothing
        local integer retval = 0

        if addr > 0 then 
            set retval = ReadRealPointer1LVL( addr, offset1 )

            if addr > 0 then 
                call WriteRealMemory( retval + offset2, val )
            endif
        endif
    endfunction 

    function ReadRealPointer3LVL takes integer addr, integer offset1, integer offset2, integer offset3 returns integer
        local integer retval = ReadRealPointer2LVL( addr, offset1, offset2 )

        if retval > 0 then 
            set retval = ReadRealMemory( retval + offset3 )
        else
            set retval = 0
        endif

        return retval
    endfunction

    function WriteRealPointer3LVL takes integer addr, integer offset1, integer offset2, integer offset3, integer val returns nothing
        local integer retval = 0

        if addr > 0 then 
            set retval = ReadRealPointer2LVL( addr, offset1, offset2 )

            if addr > 0 then 
                call WriteRealMemory( retval + offset3, val )
            endif
        endif
    endfunction

    function ReadRealPointer4LVL takes integer addr, integer offset1, integer offset2, integer offset3, integer offset4 returns integer
        local integer retval = ReadRealPointer3LVL( addr, offset1, offset2, offset3 )

        if retval > 0 then 
            set retval = ReadRealMemory( retval + offset4 )
        else
            set retval = 0
        endif

        return retval
    endfunction

    function WriteRealPointer4LVL takes integer addr, integer offset1, integer offset2, integer offset3, integer offset4, integer val returns nothing
        local integer retval = 0

        if addr > 0 then 
            set retval = ReadRealPointer3LVL( addr, offset1, offset2, offset3 )

            if addr > 0 then 
                call WriteRealMemory( retval + offset4, val )
            endif
        endif
    endfunction

    function ReadRealPointer5LVL takes integer addr, integer offset1, integer offset2, integer offset3, integer offset4, integer offset5 returns integer
        local integer retval = ReadRealPointer4LVL( addr, offset1, offset2, offset3, offset4 )

        if retval > 0 then 
            set retval = ReadRealMemory( retval + offset5 )
        else
            set retval = 0
        endif

        return retval
    endfunction

    function WriteRealPointer5LVL takes integer addr, integer offset1, integer offset2,integer offset3, integer offset4,integer offset5, integer val returns nothing
        local integer retval = 0

        if addr > 0 then 
            set retval = ReadRealPointer4LVL( addr, offset1, offset2, offset3, offset4 )

            if addr > 0 then 
                call WriteRealMemory( retval + offset5, val )
            endif
        endif
    endfunction

    function IsJassNativeExists takes integer nativeaddress returns boolean
        local integer FirstAddress = ReadRealPointer2LVL( pJassEnvAddress, 0x14, 0x20 )
        local integer NextAddress = FirstAddress
        local integer i = 0

        loop 
            if ReadRealMemory( NextAddress + 0xC ) == nativeaddress then
                return NextAddress > 0
            endif
            
            set NextAddress = ReadRealMemory( NextAddress )
            if NextAddress == FirstAddress or NextAddress == 0 then
                return false
            endif
        endloop

        return false
    endfunction

    function CreateJassNativeHook takes integer oldaddress, integer newaddress returns integer
        local integer FirstAddress    = ReadRealPointer2LVL( pJassEnvAddress, 0x14, 0x20 )
        local integer NextAddress     = FirstAddress
        local integer i = 0
     
        if RJassNativesBufferSize > 0 then
            loop
                set i = i + 1
           
                if RJassNativesBuffer[ i * 3 - 0x3 ] == oldaddress or RJassNativesBuffer[ i * 3 - 0x2 ] == oldaddress or RJassNativesBuffer[ i * 3 - 0x3 ] == newaddress or RJassNativesBuffer[ i * 3 - 0x2 ] == newaddress then
                    call WriteRealMemory( RJassNativesBuffer[ i * 3 - 0x1 ], newaddress )
                    return RJassNativesBuffer[ i * 3 - 0x1 ]
                endif
           
                exitwhen i == RJassNativesBufferSize
            endloop
        endif
     
        loop
            if ReadRealMemory( NextAddress + 0xC ) < 0x3000 then
                return 0
            endif
            
            if ReadRealMemory( NextAddress + 0xC ) == oldaddress then
                call WriteRealMemory( NextAddress + 0xC, newaddress )

                if RJassNativesBufferSize < 100 then
                    set RJassNativesBufferSize = RJassNativesBufferSize + 1
                    set RJassNativesBuffer[ RJassNativesBufferSize * 3 - 0x1 ] = NextAddress + 0xC
                    set RJassNativesBuffer[ RJassNativesBufferSize * 3 - 0x2 ] = oldaddress
                    set RJassNativesBuffer[ RJassNativesBufferSize * 3 - 0x3 ] = newaddress
                endif
           
                return NextAddress + 0xC
            endif
       
            set NextAddress = ReadRealMemory( NextAddress )
            if NextAddress == FirstAddress or NextAddress == 0 then
                return 0
            endif
        endloop
        
        return 0
    endfunction

    function ExecuteBytecode takes integer memaddr returns integer
        local integer pOffset1 = 0

        if pIgnoredUnits != 0 and memaddr != 0 then

            if pIgnoredUnitsOffset == 0 then
                set pIgnoredUnitsOffset = CreateJassNativeHook( pIgnoredUnits, memaddr )
            endif

            if pIgnoredUnitsOffset != 0 then
                call WriteRealMemory( pIgnoredUnitsOffset, memaddr )
                set pOffset1 = IgnoredUnits( 0 )
                //call BJDebugMsg("IgnoredUnits:" + I2S(IgnoredUnits( 0 )))
                call WriteRealMemory( pIgnoredUnitsOffset, pIgnoredUnits )
            endif

        endif

        return pOffset1
    endfunction

    // Explanation:
    // We write assembler in a reversed order, since that is how our written memory will translate to machine code
    // Example: 0xB9F68B56 which is B9 F6 8B 56 => but in fact it will be 0x568BF6B9 or 56 8B F6 B9
    // To translate machine code to asm you can use: https://defuse.ca/online-x86-assembler.htm#disassembly2
    function fast_call_0 takes integer funcaddr returns integer
        local integer addr = fpCallAddressList[0]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x0, 0xBEF68B56 ) // push esi | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x8, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x4, funcaddr ) // mov esi, funcaddr
            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_1 takes integer funcaddr, integer arg1 returns integer
        local integer addr = fpCallAddressList[1]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr +  0x0, 0xB9F68B56 ) // push esi | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr +  0x8, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x10, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr +  0x4, arg1 )     // mov ecx arg1
            call WriteRealMemory( addr +  0xC, funcaddr ) // mov esi, funcaddr
            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_2 takes integer funcaddr, integer arg1, integer arg2 returns integer
        local integer addr = fpCallAddressList[2]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0xBAF68B56 ) // push esi | mov esi, esi | edx (arg2)
                call WriteRealMemory( addr + 0x08, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x10, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x18, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x04, arg2 )      // mov edx arg2
            call WriteRealMemory( addr + 0x0C, arg1 )      // mov ecx arg1
            call WriteRealMemory( addr + 0x14, funcaddr )  // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_3 takes integer funcaddr, integer arg1, integer arg2, integer arg3 returns integer
        local integer addr = fpCallAddressList[3]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg3
                call WriteRealMemory( addr + 0x08, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x10, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x18, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x20, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x04, arg3 )     // push arg3
            call WriteRealMemory( addr + 0x0C, arg2 )     // mov edx arg2
            call WriteRealMemory( addr + 0x14, arg1 )     // mov ecx arg1
            call WriteRealMemory( addr + 0x1C, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif
        
        return 0
    endfunction

    function fast_call_4 takes integer funcaddr, integer arg1, integer arg2, integer arg3 , integer arg4 returns integer
        local integer addr = fpCallAddressList[4]

        //call BJDebugMsg("fast_call_4:" + MHMath_ToHex(addr))
        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg4
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x10, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x18, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x20, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x28, 0xC35ED6FF ) // call esi | pop esi | ret
            endif
            
            call WriteRealMemory( addr + 0x04, arg4 )     // push arg4
            call WriteRealMemory( addr + 0x0C, arg3 )     // push arg3
            call WriteRealMemory( addr + 0x14, arg2 )     // mov edx arg2
            call WriteRealMemory( addr + 0x1C, arg1 )     // mov ecx arg1
            call WriteRealMemory( addr + 0x24, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_5 takes integer funcaddr, integer arg1, integer arg2, integer arg3 , integer arg4, integer arg5 returns integer
        local integer addr = fpCallAddressList[5]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg5
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg4
                call WriteRealMemory( addr + 0x10, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x18, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x20, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x28, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x30, 0xC35ED6FF ) // call esi | pop esi | ret
            endif
            
            call WriteRealMemory( addr + 0x04, arg5 )     // push arg5
            call WriteRealMemory( addr + 0x0C, arg4 )     // push arg4
            call WriteRealMemory( addr + 0x14, arg3 )     // push arg3
            call WriteRealMemory( addr + 0x1C, arg2 )     // mov edx arg2
            call WriteRealMemory( addr + 0x24, arg1 )     // mov ecx arg1
            call WriteRealMemory( addr + 0x2C, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_6 takes integer funcaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6 returns integer
        local integer addr = fpCallAddressList[6]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg6
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg5
                call WriteRealMemory( addr + 0x10, 0x68F68B90 ) // nop | move esi, esi | push arg4
                call WriteRealMemory( addr + 0x18, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x20, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x28, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x30, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x38, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x04, arg6 )     // push arg6
            call WriteRealMemory( addr + 0x0C, arg5 )     // push arg5
            call WriteRealMemory( addr + 0x14, arg4 )     // push arg4
            call WriteRealMemory( addr + 0x1C, arg3 )     // push arg3
            call WriteRealMemory( addr + 0x24, arg2 )     // mov edx arg2
            call WriteRealMemory( addr + 0x2C, arg1 )     // mov ecx arg1
            call WriteRealMemory( addr + 0x34, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_7 takes integer funcaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7 returns integer
        local integer addr = fpCallAddressList[7]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg7
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg6
                call WriteRealMemory( addr + 0x10, 0x68F68B90 ) // nop | move esi, esi | push arg5
                call WriteRealMemory( addr + 0x18, 0x68F68B90 ) // nop | move esi, esi | push arg4
                call WriteRealMemory( addr + 0x20, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x28, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x30, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x38, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x40, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x04, arg7 )     // push arg7
            call WriteRealMemory( addr + 0x0C, arg6 )     // push arg6
            call WriteRealMemory( addr + 0x14, arg5 )     // push arg5
            call WriteRealMemory( addr + 0x1C, arg4 )     // push arg4
            call WriteRealMemory( addr + 0x24, arg3 )     // push arg3
            call WriteRealMemory( addr + 0x2C, arg2 )     // mov edx arg2
            call WriteRealMemory( addr + 0x34, arg1 )     // mov ecx arg1
            call WriteRealMemory( addr + 0x3C, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_8 takes integer funcaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8 returns integer
        local integer addr = fpCallAddressList[8]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg8
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg7
                call WriteRealMemory( addr + 0x10, 0x68F68B90 ) // nop | move esi, esi | push arg6
                call WriteRealMemory( addr + 0x18, 0x68F68B90 ) // nop | move esi, esi | push arg5
                call WriteRealMemory( addr + 0x20, 0x68F68B90 ) // nop | move esi, esi | push arg4
                call WriteRealMemory( addr + 0x28, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x30, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x38, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x40, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x48, 0xC35ED6FF ) // call esi | pop esi | ret
            endif
            
            call WriteRealMemory( addr + 0x04, arg8 )     // push arg8
            call WriteRealMemory( addr + 0x0C, arg7 )     // push arg7
            call WriteRealMemory( addr + 0x14, arg6 )     // push arg6
            call WriteRealMemory( addr + 0x1C, arg5 )     // push arg5
            call WriteRealMemory( addr + 0x24, arg4 )     // push arg4
            call WriteRealMemory( addr + 0x2C, arg3 )     // push arg3
            call WriteRealMemory( addr + 0x34, arg2 )     // mov edx arg2
            call WriteRealMemory( addr + 0x3C, arg1 )     // mov ecx arg1
            call WriteRealMemory( addr + 0x44, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_9 takes integer funcaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8, integer arg9 returns integer
        local integer addr = fpCallAddressList[9]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg9
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg8
                call WriteRealMemory( addr + 0x10, 0x68F68B90 ) // nop | move esi, esi | push arg7
                call WriteRealMemory( addr + 0x18, 0x68F68B90 ) // nop | move esi, esi | push arg6
                call WriteRealMemory( addr + 0x20, 0x68F68B90 ) // nop | move esi, esi | push arg5
                call WriteRealMemory( addr + 0x28, 0x68F68B90 ) // nop | move esi, esi | push arg4
                call WriteRealMemory( addr + 0x30, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x38, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x40, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x48, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x50, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x04, arg9 )     // push arg9
            call WriteRealMemory( addr + 0x0C, arg8 )     // push arg8
            call WriteRealMemory( addr + 0x14, arg7 )     // push arg7
            call WriteRealMemory( addr + 0x1C, arg6 )     // push arg6
            call WriteRealMemory( addr + 0x24, arg5 )     // push arg5
            call WriteRealMemory( addr + 0x2C, arg4 )     // push arg4
            call WriteRealMemory( addr + 0x34, arg3 )     // push arg3
            call WriteRealMemory( addr + 0x3C, arg2 )     // mov edx arg2
            call WriteRealMemory( addr + 0x44, arg1 )     // mov ecx arg1
            call WriteRealMemory( addr + 0x4C, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_10 takes integer funcaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8, integer arg9, integer arg10 returns integer
        local integer addr = fpCallAddressList[10]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg10
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg9
                call WriteRealMemory( addr + 0x10, 0x68F68B90 ) // nop | move esi, esi | push arg8
                call WriteRealMemory( addr + 0x18, 0x68F68B90 ) // nop | move esi, esi | push arg7
                call WriteRealMemory( addr + 0x20, 0x68F68B90 ) // nop | move esi, esi | push arg6
                call WriteRealMemory( addr + 0x28, 0x68F68B90 ) // nop | move esi, esi | push arg5
                call WriteRealMemory( addr + 0x30, 0x68F68B90 ) // nop | move esi, esi | push arg4
                call WriteRealMemory( addr + 0x38, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x40, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x48, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x50, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x58, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x04, arg10 )    // push arg10
            call WriteRealMemory( addr + 0x0C, arg9  )    // push arg9
            call WriteRealMemory( addr + 0x14, arg8  )    // push arg8
            call WriteRealMemory( addr + 0x1C, arg7  )    // push arg7
            call WriteRealMemory( addr + 0x24, arg6  )    // push arg6
            call WriteRealMemory( addr + 0x2C, arg5  )    // push arg5
            call WriteRealMemory( addr + 0x34, arg4  )    // push arg4
            call WriteRealMemory( addr + 0x3C, arg3  )    // push arg3
            call WriteRealMemory( addr + 0x44, arg2  )    // mov edx arg2
            call WriteRealMemory( addr + 0x4C, arg1  )    // mov ecx arg1
            call WriteRealMemory( addr + 0x54, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_11 takes integer funcaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8, integer arg9, integer arg10, integer arg11 returns integer
        local integer addr = fpCallAddressList[11]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg11
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg10
                call WriteRealMemory( addr + 0x10, 0x68F68B90 ) // nop | move esi, esi | push arg9
                call WriteRealMemory( addr + 0x18, 0x68F68B90 ) // nop | move esi, esi | push arg8
                call WriteRealMemory( addr + 0x20, 0x68F68B90 ) // nop | move esi, esi | push arg7
                call WriteRealMemory( addr + 0x28, 0x68F68B90 ) // nop | move esi, esi | push arg6
                call WriteRealMemory( addr + 0x30, 0x68F68B90 ) // nop | move esi, esi | push arg5
                call WriteRealMemory( addr + 0x38, 0x68F68B90 ) // nop | move esi, esi | push arg4
                call WriteRealMemory( addr + 0x40, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x48, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x50, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x58, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x60, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x04, arg11 )    // push arg11
            call WriteRealMemory( addr + 0x0C, arg10 )    // push arg10
            call WriteRealMemory( addr + 0x14, arg9  )    // push arg9
            call WriteRealMemory( addr + 0x1C, arg8  )    // push arg8
            call WriteRealMemory( addr + 0x24, arg7  )    // push arg7
            call WriteRealMemory( addr + 0x2C, arg6  )    // push arg6
            call WriteRealMemory( addr + 0x34, arg5  )    // push arg5
            call WriteRealMemory( addr + 0x3C, arg4  )    // push arg4
            call WriteRealMemory( addr + 0x44, arg3  )    // push arg3
            call WriteRealMemory( addr + 0x4C, arg2  )    // mov edx arg2
            call WriteRealMemory( addr + 0x54, arg1  )    // mov ecx arg1
            call WriteRealMemory( addr + 0x5C, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif
        
        return 0
    endfunction

    function fast_call_12 takes integer funcaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8, integer arg9, integer arg10, integer arg11, integer arg12 returns integer
        local integer addr = fpCallAddressList[12]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg12
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg11
                call WriteRealMemory( addr + 0x10, 0x68F68B90 ) // nop | move esi, esi | push arg10
                call WriteRealMemory( addr + 0x18, 0x68F68B90 ) // nop | move esi, esi | push arg9
                call WriteRealMemory( addr + 0x20, 0x68F68B90 ) // nop | move esi, esi | push arg8
                call WriteRealMemory( addr + 0x28, 0x68F68B90 ) // nop | move esi, esi | push arg7
                call WriteRealMemory( addr + 0x30, 0x68F68B90 ) // nop | move esi, esi | push arg6
                call WriteRealMemory( addr + 0x38, 0x68F68B90 ) // nop | move esi, esi | push arg5
                call WriteRealMemory( addr + 0x40, 0x68F68B90 ) // nop | move esi, esi | push arg4
                call WriteRealMemory( addr + 0x48, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x50, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x58, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x60, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x68, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x04, arg12 )    // push arg12
            call WriteRealMemory( addr + 0x0C, arg11 )    // push arg11
            call WriteRealMemory( addr + 0x14, arg10 )    // push arg10
            call WriteRealMemory( addr + 0x1C, arg9  )    // push arg9
            call WriteRealMemory( addr + 0x24, arg8  )    // push arg8
            call WriteRealMemory( addr + 0x2C, arg7  )    // push arg7
            call WriteRealMemory( addr + 0x34, arg6  )    // push arg6
            call WriteRealMemory( addr + 0x3C, arg5  )    // push arg5
            call WriteRealMemory( addr + 0x44, arg4  )    // push arg4
            call WriteRealMemory( addr + 0x4C, arg3  )    // push arg3
            call WriteRealMemory( addr + 0x54, arg2  )    // mov edx arg2
            call WriteRealMemory( addr + 0x5C, arg1  )    // mov ecx arg1
            call WriteRealMemory( addr + 0x64, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function fast_call_13 takes integer funcaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8, integer arg9, integer arg10, integer arg11, integer arg12, integer arg13 returns integer
        local integer addr = fpCallAddressList[13]

        if addr != 0 then
            if ReadRealMemory( addr ) == 0 then
                call WriteRealMemory( addr + 0x00, 0x68F68B56 ) // push esi | mov esi, esi | push arg13
                call WriteRealMemory( addr + 0x08, 0x68F68B90 ) // nop | move esi, esi | push arg12
                call WriteRealMemory( addr + 0x10, 0x68F68B90 ) // nop | move esi, esi | push arg11
                call WriteRealMemory( addr + 0x18, 0x68F68B90 ) // nop | move esi, esi | push arg10
                call WriteRealMemory( addr + 0x20, 0x68F68B90 ) // nop | move esi, esi | push arg9
                call WriteRealMemory( addr + 0x28, 0x68F68B90 ) // nop | move esi, esi | push arg8
                call WriteRealMemory( addr + 0x30, 0x68F68B90 ) // nop | move esi, esi | push arg7
                call WriteRealMemory( addr + 0x38, 0x68F68B90 ) // nop | move esi, esi | push arg6
                call WriteRealMemory( addr + 0x40, 0x68F68B90 ) // nop | move esi, esi | push arg5
                call WriteRealMemory( addr + 0x48, 0x68F68B90 ) // nop | move esi, esi | push arg4
                call WriteRealMemory( addr + 0x50, 0x68F68B90 ) // nop | move esi, esi | push arg3
                call WriteRealMemory( addr + 0x58, 0xBAF68B90 ) // nop | mov esi, esi | mov edx (arg2)
                call WriteRealMemory( addr + 0x60, 0xB9F68B90 ) // nop | mov esi, esi | mov ecx (arg1)
                call WriteRealMemory( addr + 0x68, 0xBEF68B90 ) // nop | mov esi, esi | mov esi (funcaddr)
                call WriteRealMemory( addr + 0x70, 0xC35ED6FF ) // call esi | pop esi | ret
            endif

            call WriteRealMemory( addr + 0x04, arg13 )    // push arg13
            call WriteRealMemory( addr + 0x0C, arg12 )    // push arg12
            call WriteRealMemory( addr + 0x14, arg11 )    // push arg11
            call WriteRealMemory( addr + 0x1C, arg10 )    // push arg10
            call WriteRealMemory( addr + 0x24, arg9  )    // push arg9
            call WriteRealMemory( addr + 0x2C, arg8  )    // push arg8
            call WriteRealMemory( addr + 0x34, arg7  )    // push arg7
            call WriteRealMemory( addr + 0x3C, arg6  )    // push arg6
            call WriteRealMemory( addr + 0x44, arg5  )    // push arg5
            call WriteRealMemory( addr + 0x4C, arg4  )    // push arg4
            call WriteRealMemory( addr + 0x54, arg3  )    // push arg3
            call WriteRealMemory( addr + 0x5C, arg2  )    // mov edx arg2
            call WriteRealMemory( addr + 0x64, arg1  )    // mov ecx arg1
            call WriteRealMemory( addr + 0x6C, funcaddr ) // mov esi, funcaddr

            return ExecuteBytecode( addr )
        endif

        return 0
    endfunction

    function this_call_0 takes integer pfuncaddr, integer arg1 returns integer
        return fast_call_1( pfuncaddr, 0 )
    endfunction
    
    function this_call_1 takes integer pfuncaddr, integer arg1 returns integer
        return fast_call_2( pfuncaddr, arg1, 0 )
    endfunction

    function this_call_2 takes integer pfuncaddr, integer arg1, integer arg2 returns integer
        return fast_call_3( pfuncaddr, arg1, 0, arg2 )
    endfunction

    function this_call_3 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3 returns integer
        return fast_call_4( pfuncaddr, arg1, 0, arg2, arg3 )
    endfunction

    function this_call_4 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3, integer arg4 returns integer
        return fast_call_5( pfuncaddr, arg1, 0, arg2, arg3, arg4 )
    endfunction

    function this_call_5 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5 returns integer
        return fast_call_6( pfuncaddr, arg1, 0, arg2, arg3, arg4, arg5 )
    endfunction

    function this_call_6 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6 returns integer
        return fast_call_7( pfuncaddr, arg1, 0, arg2, arg3, arg4, arg5, arg6 )
    endfunction

    function this_call_7 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7 returns integer
        return fast_call_8( pfuncaddr, arg1, 0, arg2, arg3, arg4, arg5, arg6, arg7 )
    endfunction

    function this_call_8 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8 returns integer
        return fast_call_9( pfuncaddr, arg1, 0, arg2, arg3, arg4, arg5, arg6, arg7, arg8 )
    endfunction

    function this_call_9 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8, integer arg9 returns integer
        return fast_call_10( pfuncaddr, arg1, 0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 )
    endfunction

    function this_call_10 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8, integer arg9, integer arg10 returns integer
        return fast_call_11( pfuncaddr, arg1, 0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 )
    endfunction

    function this_call_11 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8, integer arg9, integer arg10, integer arg11 returns integer
        return fast_call_12( pfuncaddr, arg1, 0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11 )
    endfunction

    function this_call_12 takes integer pfuncaddr, integer arg1, integer arg2, integer arg3, integer arg4, integer arg5, integer arg6, integer arg7, integer arg8, integer arg9, integer arg10, integer arg11, integer arg12 returns integer
        return fast_call_13( pfuncaddr, arg1, 0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
    endfunction

    function AllocFunctionFastCall takes integer index, integer size returns nothing
        local integer i = 0
        set fpCallAddressList[index] = s__MemoryBlock_pHead + fpCallSize
        set fpCallSize = fpCallSize + size

        loop
            exitwhen i == size
            call WriteRealMemory( fpCallAddressList[index] + i, 0 )
            set i = i + 0x4
        endloop
    endfunction

    //# +nosemanticerror
    private function Init takes nothing returns nothing
        set pGameDLL = MHGame_GetGameDLL()

        set pJassEnvAddress = pGameDLL + 0xBE3740
        set pIgnoredUnits   = pGameDLL + 0x890FB0

        call s__MemoryBlock_initSize()
        set s__MemoryBlock_pHead = (MHTool_ReadInt(((l__MemoryBlock_block)) + ( (3) * 4 )))
        set s__MemoryBlock_size  = 0x1000
        //call BJDebugMsg(MHMath_ToHex(MHTool_VirtualProtect(s__MemoryBlock_pHead, s__MemoryBlock_size, 0x40)))
        call MHTool_VirtualProtect(s__MemoryBlock_pHead, s__MemoryBlock_size, 0x40)

        call AllocFunctionFastCall(0 , 0x0C)
        call AllocFunctionFastCall(1 , 0x14)
        call AllocFunctionFastCall(2 , 0x1C)
        call AllocFunctionFastCall(3 , 0x24)
        call AllocFunctionFastCall(4 , 0x2C)
        call AllocFunctionFastCall(5 , 0x34)
        call AllocFunctionFastCall(6 , 0x3C)
        call AllocFunctionFastCall(7 , 0x44)
        call AllocFunctionFastCall(8 , 0x4C)
        call AllocFunctionFastCall(9 , 0x5C)
        call AllocFunctionFastCall(10, 0x64)
        call AllocFunctionFastCall(11, 0x6C)
        call AllocFunctionFastCall(12, 0x74)
        call AllocFunctionFastCall(13, 0x7C)
    endfunction

endlibrary
