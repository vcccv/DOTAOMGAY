
library BuffSystem requires Base
    
    // 蝙蝠燃油层数
    function SetStickyNapalmStack takes unit whichUnit, integer level, integer FBX returns nothing
        local integer i
        if K2V[1]== 0 then
            return
        endif
        set i = 1
        loop
        exitwhen i > 10
            call UnitRemoveAbility(whichUnit, K2V[i])
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > 10
            call UnitRemoveAbility(whichUnit, K3V[i])
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > 10
            call UnitRemoveAbility(whichUnit, K4V[i])
            set i = i + 1
        endloop
        set i = 1
        loop
        exitwhen i > 10
            call UnitRemoveAbility(whichUnit, K5V[i])
            set i = i + 1
        endloop
        call UnitRemoveAbility(whichUnit,'B0BS')
        if level == 0 and FBX == 0 then
            call SaveInteger(HY, GetHandleId(whichUnit), 281, 0)
        endif
        if level == 1 then
            call UnitAddAbility(whichUnit, K2V[FBX])
        elseif level == 2 then
            call UnitAddAbility(whichUnit, K3V[FBX])
        elseif level == 3 then
            call UnitAddAbility(whichUnit, K4V[FBX])
        elseif level == 4 then
            call UnitAddAbility(whichUnit, K5V[FBX])
        endif
    endfunction

    // 注册一个Buff 
    function SetBuffAbilityId takes integer buffId, integer buffType returns nothing
        call SaveInteger(AbilityDataHashTable, buffType, LoadInteger(AbilityDataHashTable, buffType, 0)+ 1, buffId)
        call SaveInteger(AbilityDataHashTable, buffType, 0, LoadInteger(AbilityDataHashTable, buffType, 0)+ 1)
    endfunction

    // 注册物理Buff
    function SetStunBuffId takes integer id returns nothing
        set A4 = A4 + 1
        set I4[A4] = id
    endfunction

    globals
        constant integer DISABLE_MOVE_BUFF_KEY = 'PRGN'
        constant integer DISARM_BUFF_KEY 	   = 'PRGH'
        constant integer SILENCE_BUFF_KEY 	   = 'PRGI'
        constant integer SLOW_BUFF_KEY		   = 'PRGS'
        constant integer POSITIVE_BUFF_KEY     = 'PRGA'
        constant integer NEGATIVE_BUFF_KEY     = 'PRGE'
    endglobals

    // 移除缠绕类效果
    function UnitDispelDisableMoveBuff takes unit u returns nothing
        local integer i = 1
        loop
        exitwhen HaveSavedInteger(AbilityDataHashTable, DISABLE_MOVE_BUFF_KEY, i) == false
            call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable, DISABLE_MOVE_BUFF_KEY, i))
            set i = i + 1
        endloop
    endfunction

    // 移除缴械类状态
    function UnitDispelDisarmBuff takes unit u returns nothing
        local integer i = 1
        loop
        exitwhen not HaveSavedInteger(AbilityDataHashTable, DISARM_BUFF_KEY, i)
            call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable, DISARM_BUFF_KEY, i))
            set i = i + 1
        endloop
    endfunction

    // 驱散Buff
    function UnitDispelBuffs takes unit u, boolean dispelPositive returns nothing
        local integer i = 1
        loop
        exitwhen not HaveSavedInteger(AbilityDataHashTable,'PRGC', i)
            call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable,'PRGC', i))
            set i = i + 1
        endloop
        // 普通驱散
        if dispelPositive then
            set i = 1
            // 仅驱散正面buff
            loop
            exitwhen not HaveSavedInteger(AbilityDataHashTable,POSITIVE_BUFF_KEY, i)
                call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable,POSITIVE_BUFF_KEY, i))
                set i = i + 1
            endloop
            call RemoveSavedInteger(HY, GetHandleId(u),'A2SG')
        else
            // 这里可能是强驱散
            set i = 1
            loop
            exitwhen not HaveSavedInteger(AbilityDataHashTable, NEGATIVE_BUFF_KEY, i)
                call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable, NEGATIVE_BUFF_KEY, i))
                set i = i + 1
            endloop
            set i = 1
            loop
            exitwhen not HaveSavedInteger(AbilityDataHashTable, SILENCE_BUFF_KEY, i)
                call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable, SILENCE_BUFF_KEY, i))
                set i = i + 1
            endloop
            set i = 1
            loop
            exitwhen not HaveSavedInteger(AbilityDataHashTable, SLOW_BUFF_KEY, i)
                call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable, SLOW_BUFF_KEY, i))
                set i = i + 1
            endloop
            set i = 1
            loop
            exitwhen not HaveSavedInteger(AbilityDataHashTable, DISABLE_MOVE_BUFF_KEY, i)
                call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable, DISABLE_MOVE_BUFF_KEY, i))
                set i = i + 1
            endloop
            call SetStickyNapalmStack(u, 0, 0)
            call RemoveSavedReal(HY, GetHandleId(u),'AItb')
            if LoadInteger(HY, GetHandleId(u), 627)> 0 then
                call SaveInteger(HY, GetHandleId(u), 627, 0)
            endif
        endif
        call UnitRemoveAbility(u, 'Bblo')
        call UnitRemoveAbility(u, 'B016')
        // 嗜血Buff删除
        if HaveSavedHandle( ExtraHT, GetHandleId(u), HTKEY_SCALE_BLOODLUST_TRIGGER ) then
            // debug call SingleDebug( " 强制运行缩放触发器 " )
            call TriggerEvaluate( LoadTriggerHandle( ExtraHT, GetHandleId(u), HTKEY_SCALE_BLOODLUST_TRIGGER ) )
        endif
        // 狂猛Buff删除
        if HaveSavedHandle( ExtraHT, GetHandleId(u), HTKEY_SCALE_RABID_TRIGGER ) then
            // debug call SingleDebug( " 强制运行缩放触发器 " )
            call TriggerEvaluate( LoadTriggerHandle( ExtraHT , GetHandleId(u) , HTKEY_SCALE_RABID_TRIGGER ) )
        endif
    endfunction

    function InitItemBuffId takes nothing returns nothing
        call SetBuffAbilityId('A3K2', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3K3', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('BIcb', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A2EC', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0F5', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B08N', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B02I', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3FL', POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B01P', POSITIVE_BUFF_KEY)
    endfunction

    function BuffSystem_Init takes nothing returns nothing
        call InitItemBuffId()
        // 初始化晕眩BUFF表
        call SetStunBuffId('BPSE')
        call SetStunBuffId('BSTN')
        call SetStunBuffId('B0BM')
        call SetStunBuffId('B0CF')
        call SetStunBuffId('B07N')
        call SetStunBuffId('B00Q')
        call SetStunBuffId('B095')
        call SetStunBuffId('B0C2')
        call SetStunBuffId('B02S')
        call SetStunBuffId('B02F')
        call SetStunBuffId('BUsp')
        call SetStunBuffId('Bust')
        call SetStunBuffId('B0AQ')
        call SetStunBuffId('BUan')
        call SetStunBuffId('B0GG')
        call SetBuffAbilityId('A44Y','PRGC')
        call SetBuffAbilityId('B44Y','PRGC')
    
        call SetBuffAbilityId('C033', DISARM_BUFF_KEY)
        call SetBuffAbilityId('D033', DISARM_BUFF_KEY)
        call SetBuffAbilityId('A3KC', DISARM_BUFF_KEY)
        call SetBuffAbilityId('B033', DISARM_BUFF_KEY)
    
    
        // 衰老
        call SetBuffAbilityId('B01N','PRGC')
        call SetBuffAbilityId('A30D','PRGC')
        call SetBuffAbilityId('A44I','PRGC')
        call SetBuffAbilityId('A30E','PRGC')
        call SetBuffAbilityId('A3C0','PRGC')
        call SetBuffAbilityId('A3C1','PRGC')
        call SetBuffAbilityId('A3C2','PRGC')
        call SetBuffAbilityId('A3C3','PRGC')
        call SetBuffAbilityId('B38G','PRGC')
        call SetBuffAbilityId('Aetl','PRGC')
    
        
        call SetBuffAbilityId('C010', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('D010', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A45O', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A45P', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A45Q', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A45R', NEGATIVE_BUFF_KEY)
    
        call SetBuffAbilityId('A3KE', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B3KE', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3KD', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A2T4', NEGATIVE_BUFF_KEY)
        
        call SetBuffAbilityId('B090', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B008', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B04B', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B01N', NEGATIVE_BUFF_KEY)
        //call SetBuffAbilityId('B033', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B00H', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('BOhx', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3B8', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B3B8', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B02W', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A37T', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B37T', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A42R', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0HI', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B00L', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A30Y', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B307', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0GR', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('Bdet', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3EK', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3EL', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3EM', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3EN', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B38B', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B03I', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0AE', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0AD', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B08O', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0BF', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0BE', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0CC', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B00T', NEGATIVE_BUFF_KEY)
    
        call SetBuffAbilityId('A45Y', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A45Z', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B45Y', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A32F', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B32F', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3A0', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3A1', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3A2', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3A3', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3A4', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3A5', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3A6', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3A7', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B079', SLOW_BUFF_KEY)
        call SetBuffAbilityId('C016', SLOW_BUFF_KEY)
        call SetBuffAbilityId('D016', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B09Q', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B06Q', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B06Z', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B08Q', SLOW_BUFF_KEY)
        call SetBuffAbilityId('BHca', SLOW_BUFF_KEY)
        call SetBuffAbilityId('Bcsd', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0BQ', SLOW_BUFF_KEY)
        call SetBuffAbilityId('Bprg', SLOW_BUFF_KEY)
        call SetBuffAbilityId('Bcri', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B03J', SLOW_BUFF_KEY)
        call SetBuffAbilityId('Bslo', SLOW_BUFF_KEY)
        call SetBuffAbilityId('BNdh', SLOW_BUFF_KEY)
        call SetBuffAbilityId('Bpoi', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B06D', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0BN', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B071', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A294', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A295', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A296', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A297', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B05Q', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0GT', SLOW_BUFF_KEY)
        call SetBuffAbilityId('QH00', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A1W2', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0DO', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A334', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B083', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B079', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A335', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B08B', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0GK', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B06Q', SLOW_BUFF_KEY)
        call SetBuffAbilityId('BHtc', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0BR', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A37U', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A37V', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A37W', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A37X', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 0, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 1, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 2, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 3, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 4, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 5, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 6, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 7, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 8, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 9, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 10, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 11, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 12, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 13, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 14, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3F0'+ 15, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3EO'+ 0, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3EO'+ 1, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3EO'+ 2, SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3EO'+ 3, SLOW_BUFF_KEY)
        call SetBuffAbilityId('B386', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B37Y', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B07E', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B02V', SLOW_BUFF_KEY)
        call SetBuffAbilityId('BNab', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B063', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B03C', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B08M', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B02G', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B01D', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B092', SLOW_BUFF_KEY)
        call SetBuffAbilityId('BEsh', SLOW_BUFF_KEY)
        call SetBuffAbilityId('Bfro', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B05H', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3QU', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3QV', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3QW', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A3QX', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0BS', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B00P', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B043', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B04Q', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0AM', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B38I', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B09Q', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0DI', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0BB', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B08N', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B02I', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0EP', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0ET', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0FY', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A1PS', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0CQ', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A0OW', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A204', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B0DY', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A30B', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B30A', SLOW_BUFF_KEY)
        call SetBuffAbilityId('A304', SLOW_BUFF_KEY)
        call SetBuffAbilityId('B304', SLOW_BUFF_KEY)
    
        call SetBuffAbilityId('B0C1', DISABLE_MOVE_BUFF_KEY)
        call SetBuffAbilityId('BEer', DISABLE_MOVE_BUFF_KEY)
        call SetBuffAbilityId('B017', DISABLE_MOVE_BUFF_KEY)
        call SetBuffAbilityId('B078', DISABLE_MOVE_BUFF_KEY)
        call SetBuffAbilityId('B0FU', DISABLE_MOVE_BUFF_KEY)	//阿托斯缠绕
        call SetBuffAbilityId('B08F', DISABLE_MOVE_BUFF_KEY)
        call SetBuffAbilityId('B08E', DISABLE_MOVE_BUFF_KEY)
        call SetBuffAbilityId('B0ER', DISABLE_MOVE_BUFF_KEY)
        call SetBuffAbilityId('B0FN', DISABLE_MOVE_BUFF_KEY)
        call SetBuffAbilityId('Bena', DISABLE_MOVE_BUFF_KEY)
        call SetBuffAbilityId('Beng', DISABLE_MOVE_BUFF_KEY)
        
    
        call SetBuffAbilityId('B031', SILENCE_BUFF_KEY)
        // 血棘 - 灵魂撕裂
        call SetBuffAbilityId('A4TP', SILENCE_BUFF_KEY)
        call SetBuffAbilityId('B07U', SILENCE_BUFF_KEY)
        call SetBuffAbilityId('BNsi', SILENCE_BUFF_KEY)
        call SetBuffAbilityId('BNso', SILENCE_BUFF_KEY)
        call SetBuffAbilityId('B07V', SILENCE_BUFF_KEY)
        call SetBuffAbilityId('B02M', SILENCE_BUFF_KEY)
        call SetBuffAbilityId('B0BY', SILENCE_BUFF_KEY)
        call SetBuffAbilityId('B0FT', SILENCE_BUFF_KEY)
        call SetBuffAbilityId('B0G0', SILENCE_BUFF_KEY)
    
        call SetBuffAbilityId('B00C', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B09K', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('C009', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('D009', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0AF', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B02P', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A39F', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3QU', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3QV', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3QW', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3QX', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3Q2', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3Q1', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B3DJ', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3Q0', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3PZ', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3PV', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3PW', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3PX', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3PY', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3PR', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3PS', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3PT', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3PU', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A42Q', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0HH', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A17K', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0AP', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B307', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A10Z', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A111', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A10Y', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A110', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B09M', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B09N', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B09O', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B09L', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A42S', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0HJ', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A0RC', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A228', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B0E8', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A264', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B02I', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A263', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B08N', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3W0', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B3W0', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('A3W9', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('B3W9', NEGATIVE_BUFF_KEY)

        call SetBuffAbilityId('A3Y9', NEGATIVE_BUFF_KEY)
        call SetBuffAbilityId('a3Y9', NEGATIVE_BUFF_KEY)

    
    
        call SetBuffAbilityId('A1HN',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0CJ',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A0QO',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B080',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A0VJ',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A109',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A0P0',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B073',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('C025',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('D025',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A2J4',POSITIVE_BUFF_KEY)
        
        call SetBuffAbilityId('Broa',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B014',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B00G',POSITIVE_BUFF_KEY)
        // 狂猛
        call SetBuffAbilityId('B016',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B077',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0FP',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0FQ',POSITIVE_BUFF_KEY)
        // 嗜血术
        call SetBuffAbilityId('Bblo',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B013',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A308',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B308',POSITIVE_BUFF_KEY)
        
        call SetBuffAbilityId('C000',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('D000',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('C108',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('C109',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('C10:',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('C10;',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('D105',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A2IB',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0FV',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A0WR',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B01E',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A3K9',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A3KA',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B00S',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A3KB',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B07W',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('Broa',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A3DU',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A3DV',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A3DW',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A3DX',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B3DU',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('C020',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('D020',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0H6',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B016',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B019',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B00U',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A1Q0',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A1Q1',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A1Q2',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A1Q3',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A1CO',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B1CO',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A46F',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B46F',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A24G',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0EC',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A23N',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0E9',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A1GA',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B021',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A3KF',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B3KF',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A1N3',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A1N7',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0CH',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B02H',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A1ZY',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0DX',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0CG',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('Bcyc',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('Bcy2',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('Aetl',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A42L',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A42N',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B0HG',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B07S',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('A3KI',POSITIVE_BUFF_KEY)
        call SetBuffAbilityId('B3KI',POSITIVE_BUFF_KEY)
    endfunction

endlibrary
