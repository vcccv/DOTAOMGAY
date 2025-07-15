
library MemoryUtils

    function GetTempestThread takes nothing returns integer
        return pGameDLL + 0xBE40A8
    endfunction

    function GetCObjectFromHash takes integer pHash1, integer pHash2 returns integer // Jass Variant of sub_6F03FA30 (126a)
        local integer addr = GetTempestThread()
        local integer pOff1 = 0x2C

        if addr != 0 then
            if BitwiseAnd(pHash1, pHash2) == - 1 then
                return 0
            endif

            if pHash1 >= 0 then
                set pOff1 = 0xC
            endif

            set pOff1 = ReadRealMemory(addr) + pOff1
            set pOff1 = ReadRealMemory(pOff1 )

            if pOff1 == 0 then
                return 0
            endif

            set pOff1 = ReadRealMemory(pOff1 + 0x8 * pHash1 + 0x4 )

            if pOff1 == 0 or ReadRealMemory(pOff1 + 0x18) != pHash2 then
                return 0
            endif

            return pOff1
        endif

        return 0
    endfunction

    function GetAddressLocustFlags takes integer pHash1, integer pHash2 returns integer
        local integer pObj = GetCObjectFromHash(pHash1, pHash2 )

        if pObj > 0 then
            return ReadRealMemory(pObj + 0x94 )
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
        local integer pData = ConvertHandle(u )

        if pData > 0 then
            set pData = pData + 0x16C
            set pData = GetAddressLocustFlags(ReadRealMemory(pData), ReadRealMemory(pData + 4) )

            if pData > 0 then
                call WriteRealMemory(pData + 0x34, MHMath_AddBit(ReadRealMemory(pData + 0x34), 0x08000000) )
            endif
        endif
    endfunction

    function UnitDisableTruesightImmunity takes unit u returns nothing
        local integer pData = ConvertHandle(u )

        if pData > 0 then
            set pData = pData + 0x16C
            set pData = GetAddressLocustFlags(ReadRealMemory(pData), ReadRealMemory(pData + 4) )

            if pData > 0 then
                call WriteRealMemory(pData + 0x34, MHMath_RemoveBit(ReadRealMemory(pData + 0x34), 0x08000000) )
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
            return(ReadRealMemory(pAbility + 0x50) + 1)
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

    function GetBuffIndicatorId takes integer buffIndicator returns integer
        local integer pAbility
        if buffIndicator != 0 then
            set pAbility = ReadRealMemory(buffIndicator + 0x978)
            if pAbility != 0 then
                return ReadRealMemory(pAbility + 0x34)
            endif
        endif
        return 0
    endfunction

    // 返回是否有效而不是定义
    //function GetBuffUIDataById takes integer buffId returns integer
    //    local integer addr = pGameDLL + 0x39C560
    //    return this_call_1(addr, buffId)
    //endfunction

    //------------------------------------------------------------------------------
    // 从全局表里查找并返回对应 buffID 的 BuffUIDef 指针
    // 如果查不到或出错，返回 0
    // 参数：
    //    flags   = ReadRealMemory(pGameDLL + 0xBE6DBC) 的值
    //    buffID  = 你想找的 buff 标识
    // 返回值：
    //    BuffUIDef 指针（整数形式），没找到或错误时返回 0
    //------------------------------------------------------------------------------

    function GetBuffUIDataById takes integer buffID returns integer
        local integer eax = ReadRealMemory(pGameDLL + 0xBE6DBC)
        local integer edx = buffID
        local integer ecx
        local integer baseAddr
        local integer tableEntryPtr
        local integer buffDef
        local integer altListBase

        // ——— 步骤 1：读 flags，如果是 -1，直接返回 0 ———
        if eax == -1 then
            return 0
        endif

        // flags & buffID
        set eax = BitwiseAnd(eax, edx)

        // ecx = eax * 3  （对应 lea ecx,[eax+eax*2]）
        set ecx = eax
        set ecx = ecx + eax * 2

        // ——— 步骤 2：从全局表 baseAddr = ReadRealMemory(0x79996DB4)  
        set baseAddr = ReadRealMemory(pGameDLL + 0xBE6DB4)

        // tableEntryPtr = baseAddr + ecx*4
        set tableEntryPtr = baseAddr + ecx * 4

        // buffDef = [tableEntryPtr + 0x8]
        set buffDef = ReadRealMemory(tableEntryPtr + 0x8)

        // 如果首选项 <= 0，直接返回 0
        if buffDef <= 0 then
            return 0
        endif

        // 如果 buffDef->id == buffID，则直接返回 buffDef
        if ReadRealMemory(buffDef) == edx then
            return buffDef
        endif

        // ——— 步骤 3：从二级链表里再找一次 ———
        // altListBase = [tableEntryPtr + 0x0]
        set altListBase = ReadRealMemory(tableEntryPtr)

        // 从 altListBase + buffDef + 4 开始遍历
        set buffDef = ReadRealMemory(altListBase + buffDef + 4)
        // 循环：只要 buffDef>0 且 id!=buffID，就继续
        loop
            exitwhen buffDef <= 0
            if ReadRealMemory(buffDef) == edx then
                return buffDef
            endif
            set buffDef = ReadRealMemory(altListBase + buffDef + 4)
        endloop

        // 找不到，返回 0
        return 0
    endfunction

    function GetBuffTipById takes integer buffId returns string
        local integer buffUIData = GetBuffUIDataById(buffId)
        if buffUIData != 0 then
            return MHTool_ReadStr(buffUIData + 0x11C)
        endif
        return ""
    endfunction

    function UnitShareInvisVision takes unit whichUnit, player whichPlayer, integer shareType returns integer
        local integer addr = pGameDLL + 0x66B260
        local integer pUnit = ConvertHandle(whichUnit)
        local integer playerId = GetPlayerId(whichPlayer)

        if pUnit == 0 or whichPlayer == null then
            return 0
        endif

        return this_call_3(addr, pUnit, playerId, shareType)
    endfunction

    function UnitUnShareInvisVision takes unit whichUnit, player whichPlayer, integer shareType returns integer
        local integer addr = pGameDLL + 0x65AA20
        local integer pUnit = ConvertHandle(whichUnit)
        local integer playerId = GetPlayerId(whichPlayer)

        if pUnit == 0 or whichPlayer == null then
            return 0
        endif

        return this_call_3(addr, pUnit, playerId, shareType)
    endfunction

    // 0x66B470
    function UnitShareVisionEx takes unit whichUnit, player whichPlayer returns integer
        local integer addr = pGameDLL + 0x66B470
        local integer pUnit = ConvertHandle(whichUnit)
        local integer playerId = GetPlayerId(whichPlayer)

        if pUnit == 0 or whichPlayer == null then
            return 0
        endif

        return this_call_2(addr, pUnit, playerId)
    endfunction
    // 0x65AB10
    function UnitUnShareVisionEx takes unit whichUnit, player whichPlayer returns integer
        local integer addr = pGameDLL + 0x65AB10
        local integer pUnit = ConvertHandle(whichUnit)
        local integer playerId = GetPlayerId(whichPlayer)

        if pUnit == 0 or whichPlayer == null then
            return 0
        endif

        return this_call_2(addr, pUnit, playerId)
    endfunction

    // 循环遍历商店u的物品id
    function StartSellUnitCooldown takes unit shopUnit, integer unitTypeId, real cooldown returns boolean
        local integer pAbility = ConvertHandle(MHUnit_GetAbility(shopUnit, 'Asel', false))
        local integer k
        local integer offset = 0xCC
        local integer i = 0
        local real    r
        if pAbility > 0 then
            loop
                set k = ReadRealMemory(pAbility + offset)
                if k != 0 then
                    if k == unitTypeId then
                        set k = ReadRealMemory(pAbility + 0x324 + 0x1C * i)
                        if k > 0 then
                            if k > 0 then
                                set r = ReadRealFloat(k + 0x4) + cooldown
                                call WriteRealFloat(k + 0x4, r)
                                return true
                            endif
                        else
                            return false
                        endif
                    endif
                endif
                set offset = offset + 4
                set i = i + 1
                exitwhen offset > 0xF8
            endloop
        endif
        return false
    endfunction
    
endlibrary
