
library OMemoryHackMissileHook

    globals
        
    endglobals

    function MHMissileGetTarget takes nothing returns unit
        return I2U(ReadRealMemory(LoadInteger(MemHackTable, 0xB208D986, 0xAE432876)))
    endfunction
    // 投射物目标点的X坐标
    function MHMissileGetTargetX takes nothing returns real
        return ReadRealFloat(LoadInteger(MemHackTable, 0xB208D986, 0xAE432876) + 0x4)
    endfunction
    // 投射物目标点的Y坐标
    function MHMissileGetTargetY takes nothing returns real
        return ReadRealFloat(LoadInteger(MemHackTable, 0xB208D986, 0xAE432876) + 0x8)
    endfunction
    // 任意单位发射投射物
    function MHTriggerMissileHook takes trigger trig returns nothing
        local integer pJumpIn       = LoadInteger(MemHackTable, 0xB208D986, 0x2E9D96F1)
        local integer pESPData
        local integer pCUnitTojUnit = LoadInteger(MemHackTable, 0x69E5EBF6, 0x4FB8C725)
    
        local integer pHook
        local integer pTriggerEvaluate = LoadInteger(MemHackTable, 0xD7BF80F4, 0xC6DAB358)
        local integer pTriggerExecute  = LoadInteger(MemHackTable, 0xD7BF80F4, 0xC7478E41)
        local integer array oldValue
        local integer pJumpBack
        local integer protSize= 0
        local integer oldProt
        local integer count
        local integer i= 2
        
        if PatchVersion == "1.24e" then
            set protSize=0x7
        elseif PatchVersion == "1.26a" then
            set protSize=0x7
        elseif PatchVersion == "1.27a" then
            set protSize=0x5
        endif

        if protSize != 0 then
            set pESPData=Malloc(0xC)
                    
            set pJumpBack=pJumpIn + protSize
            set oldValue[1]=ReadRealMemory(pJumpIn)
            set count=1 + protSize / 4
            set pHook=AllocateExecutableMemory(0x100 + 0x4 * count)
            set oldProt=ChangeOffsetProtection(pJumpIn , protSize , 0x40)
            loop
            exitwhen i > count
            set oldValue[i]=MHUtils_GetOldValue(pJumpIn + 0x4 * ( i - 2 ) , protSize - 0x4 * ( i - 2 ))
            set i=i + 1
            endloop
            call MHUtils_CreateJump(pJumpIn , pHook , protSize)
                    
            call WriteRealMemory(pHook + 0 , 0xAC918D60)           // pushad; lea edx, dword ptr ds:[ecx + 0x2AC] -> pX
            call WriteRealMemory(pHook + 4 , 0xBB000002)           // 0xBB↓
            call WriteRealMemory(pHook + 8 , pESPData + 0x4)       // mov ebx, pESPData + 0x4
            call WriteRealMemory(pHook + 12 , 0x028B33FF)          // push dword ptr ds:[edx] -> ESPData.oldValue2; mov eax, dword ptr ds:[edx] -> X;
            call WriteRealMemory(pHook + 16 , 0xC2830389)          // mov dword ptr ds:[ebx], eax; add edx, 0x8 -> pY
            call WriteRealMemory(pHook + 20 , 0xBB028B08)          // mov eax, dword ptr ds:[edx] -> Y; 0xBB↓
            call WriteRealMemory(pHook + 24 , pESPData + 0x8)      // mov ebx, pESPData + 0x8
            call WriteRealMemory(pHook + 28 , 0x038933FF)          // push dword ptr ds:[ebx] -> ESPData.oldValue3; mov dword ptr ds:[ebx], eax
            call WriteRealMemory(pHook + 32 , 0xB830498B)          // mov ecx, dword ptr ds:[ecx + 0x30] -> pSource; 0xB8↓
            call WriteRealMemory(pHook + 36 , pCUnitTojUnit)       // mov eax, pCUnitTojUnit
            call WriteRealMemory(pHook + 40 , 0xBAD0FF50)          // push eax; call eax; 0xBA↓
            call WriteRealMemory(pHook + 44 , MHEventData_Handle)  // mov edx, MHEventData_Handle
            call WriteRealMemory(pHook + 48 , 0x8932FF5B)          // pop ebx -> pCUnitTojUnit; push dword ptr ds:[edx] -> MHEventData_Handle.oldValue
            call WriteRealMemory(pHook + 52 , 0x244C8B02)          // mov dword ptr ds:[edx], eax; mov ecx, dword ptr ss:[esp + 0x30] -> pTarget
            call WriteRealMemory(pHook + 56 , 0xBBD3FF30)          // call ebx; 0xBB↓
            call WriteRealMemory(pHook + 60 , pESPData)            // mov ebx, pESPData
            call WriteRealMemory(pHook + 64 , 0x038933FF)          // push dword ptr ds:[ebx] -> ESPData.oldValue1; mov dword ptr ds:[ebx], eax
            call WriteRealMemory(pHook + 68 , 0x6890C08B)          // mov eax, eax; 0x68↓
            call WriteRealMemory(pHook + 72 , GetHandleId(trig))   // push triggerHandleId
            call WriteRealMemory(pHook + 76 , 0xB890C08B)          // mov eax, eax; 0xB8↓
            call WriteRealMemory(pHook + 80 , pTriggerEvaluate)    // mov eax, pTriggerEvaluate
            call WriteRealMemory(pHook + 84 , 0xC085D0FF)          // call eax; test eax, eax;
            call WriteRealMemory(pHook + 88 , 0xB8900874)          // je 0x8; 0xB8↓
            call WriteRealMemory(pHook + 92 , pTriggerExecute)     // mov eax, pTriggerExecute
            call WriteRealMemory(pHook + 96 , 0xC483D0FF)          // call eax; add esp, 4
            call WriteRealMemory(pHook + 100 , 0xBB905804)         // pop eax -> pESPData.oldValue1; 0xBB↓
            call WriteRealMemory(pHook + 104 , pESPData)           // mov ebx, pESPData
            call WriteRealMemory(pHook + 108 , 0xBB580389)         // mov dword ptr ds:[ebx], eax; pop eax -> MHEventData_Handle.oldValue; 0xBB↓
            call WriteRealMemory(pHook + 112 , MHEventData_Handle) // mov edx, MHEventData_Handle
            call WriteRealMemory(pHook + 116 , 0xBB580389)         // mov dword ptr ds:[ebx], eax; pop eax -> ESPData.oldValue3; 0xBB↓
            call WriteRealMemory(pHook + 120 , pESPData + 0x8)     // mov ebx, pESPData + 0x8
            call WriteRealMemory(pHook + 124 , 0xBB580389)         // mov dword ptr ds:[ebx], eax; pop eax -> ESPData.oldValue2; 0xBB↓
            call WriteRealMemory(pHook + 128 , pESPData + 0x4)     // mov ebx, pESPData + 0x4
            call WriteRealMemory(pHook + 132 , 0x61900389)         // mov dword ptr ds:[ebx], eax; popad

            set i=1
            loop
            exitwhen i > count
            call WriteRealMemory(pHook + 132 + 0x4 * i , oldValue[i])
            set i=i + 1
            endloop
            call WriteRealMemory(pHook + ( 132 + 4 ) + 0x4 * count , pJumpBack - ( pHook + ( 132 + 4 ) + 0x4 * count ) - 4)
            call ChangeOffsetProtection(pJumpIn , protSize , oldProt)

            call SaveInteger(MemHackTable, 0xB208D986, 0x46B95B3E, pHook)
            call SaveInteger(MemHackTable, 0xB208D986, 0xAE432876, pESPData)

        endif
    endfunction

    function Init_MemoryHackMissileHook takes nothing returns nothing
        if PatchVersion != "" then
            if PatchVersion == "1.24e" then
                call SaveInteger(MemHackTable, 0xB208D986, 0x2E9D96F1, pGameDLL + 0x0D0290)
                call SaveInteger(MemHackTable, 0xB208D986, 0x54A8F10E, pGameDLL + 0x2BF3D0)
            elseif PatchVersion == "1.26a" then
                call SaveInteger(MemHackTable, 0xB208D986, 0xF845304D, pGameDLL + 0xAB4CD8)
                call SaveInteger(MemHackTable, 0xB208D986, 0x2E9D96F1, pGameDLL + 0x0CF660)
                call SaveInteger(MemHackTable, 0xB208D986, 0x54A8F10E, pGameDLL + 0x2BE8B0)
            elseif PatchVersion == "1.27a" then
                call SaveInteger(MemHackTable, 0xB208D986, 0xF845304D, pGameDLL + 0xBED23C)
                call SaveInteger(MemHackTable, 0xB208D986, 0x2E9D96F1, pGameDLL + 0x476F80)
                call SaveInteger(MemHackTable, 0xB208D986, 0x5FFE75E9, pGameDLL + 0x6B5D20)
                call SaveInteger(MemHackTable, 0xB208D986, 0x0AEDC1BD, pGameDLL + 0x6B4DE0)
                call SaveInteger(MemHackTable, 0xB208D986, 0x54A8F10E, pGameDLL + 0x6B1500)
            elseif PatchVersion == "1.27b" then

            elseif PatchVersion == "1.28f" then

            endif

            call SaveInteger(MemHackTable, 0xB208D986, 0xAD7D6846, Malloc(4))
            call SaveInteger(MemHackTable, 0xB208D986, 0xCDDFE119, Malloc(4))
            call SaveInteger(MemHackTable, 0xB208D986, 0xCBA52A2D, Malloc(4))
            call SaveInteger(MemHackTable, 0xB208D986, 0xD8872E72, Malloc(4))
            call SaveInteger(MemHackTable, 0xB208D986, 0x886EEF7B, AllocateExecutableMemory(64))
            call SaveInteger(MemHackTable, 0xB208D986, 0x0FAD6E8D, AllocateExecutableMemory(64))
        endif
    endfunction

endlibrary
