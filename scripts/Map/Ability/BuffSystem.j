
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
        set I4[A4]= id
    endfunction

    globals
        constant integer DISABLE_MOVE_BUFF_KEY = 'PRGN'
        constant integer DISARM_BUFF_KEY 	   = 'PRGH'
        constant integer SILENCE_BUFF_KEY 	   = 'PRGI'
        constant integer SLOW_BUFF_KEY		   = 'PRGS'
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
    function UnitDispelBuffs takes unit u, boolean basicDispel returns nothing
        local integer i = 1
        loop
        exitwhen not HaveSavedInteger(AbilityDataHashTable,'PRGC', i)
            call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable,'PRGC', i))
            set i = i + 1
        endloop
        // 普通驱散
        if basicDispel then
            set i = 1
            // 仅普通驱散？ 为什么会有这个类别
            loop
            exitwhen not HaveSavedInteger(AbilityDataHashTable,'PRGA', i)
                call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable,'PRGA', i))
                set i = i + 1
            endloop
            call RemoveSavedInteger(HY, GetHandleId(u),'A2SG')
        else
            // 这里可能是强驱散
            set i = 1
            loop
            exitwhen not HaveSavedInteger(AbilityDataHashTable,'PRGE', i)
                call UnitRemoveAbility(u, LoadInteger(AbilityDataHashTable,'PRGE', i))
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
        call SetBuffAbilityId('A3K2','PRGE')
        call SetBuffAbilityId('A3K3','PRGE')
        call SetBuffAbilityId('BIcb','PRGE')
        call SetBuffAbilityId('A2EC','PRGE')
        call SetBuffAbilityId('B0F5','PRGE')
        call SetBuffAbilityId('B08N','PRGE')
        call SetBuffAbilityId('B02I','PRGE')
        call SetBuffAbilityId('A3FL','PRGA')
        call SetBuffAbilityId('B01P','PRGA')
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
    
        
        call SetBuffAbilityId('C010','PRGE')
        call SetBuffAbilityId('D010','PRGE')
        call SetBuffAbilityId('A45O','PRGE')
        call SetBuffAbilityId('A45P','PRGE')
        call SetBuffAbilityId('A45Q','PRGE')
        call SetBuffAbilityId('A45R','PRGE')
    
        call SetBuffAbilityId('A3KE','PRGE')
        call SetBuffAbilityId('B3KE','PRGE')
        call SetBuffAbilityId('A3KD','PRGE')
        call SetBuffAbilityId('A2T4','PRGE')
        
        call SetBuffAbilityId('B090','PRGE')
        call SetBuffAbilityId('B008','PRGE')
        call SetBuffAbilityId('B04B','PRGE')
        call SetBuffAbilityId('B01N','PRGE')
        //call SetBuffAbilityId('B033','PRGE')
        call SetBuffAbilityId('B00H','PRGE')
        call SetBuffAbilityId('BOhx','PRGE')
        call SetBuffAbilityId('A3B8','PRGE')
        call SetBuffAbilityId('B3B8','PRGE')
        call SetBuffAbilityId('B02W','PRGE')
        call SetBuffAbilityId('A37T','PRGE')
        call SetBuffAbilityId('B37T','PRGE')
        call SetBuffAbilityId('A42R','PRGE')
        call SetBuffAbilityId('B0HI','PRGE')
        call SetBuffAbilityId('B00L','PRGE')
        call SetBuffAbilityId('A30Y','PRGE')
        call SetBuffAbilityId('B307','PRGE')
        call SetBuffAbilityId('B0GR','PRGE')
        call SetBuffAbilityId('Bdet','PRGE')
        call SetBuffAbilityId('A3EK','PRGE')
        call SetBuffAbilityId('A3EL','PRGE')
        call SetBuffAbilityId('A3EM','PRGE')
        call SetBuffAbilityId('A3EN','PRGE')
        call SetBuffAbilityId('B38B','PRGE')
        call SetBuffAbilityId('B03I','PRGE')
        call SetBuffAbilityId('B0AE','PRGE')
        call SetBuffAbilityId('B0AD','PRGE')
        call SetBuffAbilityId('B08O','PRGE')
        call SetBuffAbilityId('B0BF','PRGE')
        call SetBuffAbilityId('B0BE','PRGE')
        call SetBuffAbilityId('B0CC','PRGE')
        call SetBuffAbilityId('B00T','PRGE')
    
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
    
        call SetBuffAbilityId('B00C','PRGE')
        call SetBuffAbilityId('B09K','PRGE')
        call SetBuffAbilityId('C009','PRGE')
        call SetBuffAbilityId('D009','PRGE')
        call SetBuffAbilityId('B0AF','PRGE')
        call SetBuffAbilityId('B02P','PRGE')
        call SetBuffAbilityId('A39F','PRGE')
        call SetBuffAbilityId('A3QU','PRGE')
        call SetBuffAbilityId('A3QV','PRGE')
        call SetBuffAbilityId('A3QW','PRGE')
        call SetBuffAbilityId('A3QX','PRGE')
        call SetBuffAbilityId('A3Q2','PRGE')
        call SetBuffAbilityId('A3Q1','PRGE')
        call SetBuffAbilityId('B3DJ','PRGE')
        call SetBuffAbilityId('A3Q0','PRGE')
        call SetBuffAbilityId('A3PZ','PRGE')
        call SetBuffAbilityId('A3PV','PRGE')
        call SetBuffAbilityId('A3PW','PRGE')
        call SetBuffAbilityId('A3PX','PRGE')
        call SetBuffAbilityId('A3PY','PRGE')
        call SetBuffAbilityId('A3PR','PRGE')
        call SetBuffAbilityId('A3PS','PRGE')
        call SetBuffAbilityId('A3PT','PRGE')
        call SetBuffAbilityId('A3PU','PRGE')
        call SetBuffAbilityId('A42Q','PRGE')
        call SetBuffAbilityId('B0HH','PRGE')
        call SetBuffAbilityId('A17K','PRGE')
        call SetBuffAbilityId('B0AP','PRGE')
        call SetBuffAbilityId('B307','PRGE')
        call SetBuffAbilityId('A10Z','PRGE')
        call SetBuffAbilityId('A111','PRGE')
        call SetBuffAbilityId('A10Y','PRGE')
        call SetBuffAbilityId('A110','PRGE')
        call SetBuffAbilityId('B09M','PRGE')
        call SetBuffAbilityId('B09N','PRGE')
        call SetBuffAbilityId('B09O','PRGE')
        call SetBuffAbilityId('B09L','PRGE')
        call SetBuffAbilityId('A42S','PRGE')
        call SetBuffAbilityId('B0HJ','PRGE')
        call SetBuffAbilityId('A0RC','PRGE')
        call SetBuffAbilityId('A228','PRGE')
        call SetBuffAbilityId('B0E8','PRGE')
        call SetBuffAbilityId('A264','PRGE')
        call SetBuffAbilityId('B02I','PRGE')
        call SetBuffAbilityId('A263','PRGE')
        call SetBuffAbilityId('B08N','PRGE')
        call SetBuffAbilityId('A3W0','PRGE')
        call SetBuffAbilityId('B3W0','PRGE')
        call SetBuffAbilityId('A3W9','PRGE')
        call SetBuffAbilityId('B3W9','PRGE')
    
        // PRGA 可能是普通驱散
    
        // 猛犸波神杖升级致残
        call SetBuffAbilityId('A3Y9','PRGA')
        call SetBuffAbilityId('a3Y9','PRGA')
    
        call SetBuffAbilityId('A1HN','PRGA')
        call SetBuffAbilityId('B0CJ','PRGA')
        call SetBuffAbilityId('A0QO','PRGA')
        call SetBuffAbilityId('B080','PRGA')
        call SetBuffAbilityId('A0VJ','PRGA')
        call SetBuffAbilityId('A109','PRGA')
        call SetBuffAbilityId('A0P0','PRGA')
        call SetBuffAbilityId('B073','PRGA')
        call SetBuffAbilityId('C025','PRGA')
        call SetBuffAbilityId('D025','PRGA')
        call SetBuffAbilityId('A2J4','PRGA')
        
        call SetBuffAbilityId('Broa','PRGA')
        call SetBuffAbilityId('B014','PRGA')
        call SetBuffAbilityId('B00G','PRGA')
        // 狂猛
        call SetBuffAbilityId('B016','PRGA')
        call SetBuffAbilityId('B077','PRGA')
        call SetBuffAbilityId('B0FP','PRGA')
        call SetBuffAbilityId('B0FQ','PRGA')
        // 嗜血术
        call SetBuffAbilityId('Bblo','PRGA')
        call SetBuffAbilityId('B013','PRGA')
        call SetBuffAbilityId('A308','PRGA')
        call SetBuffAbilityId('B308','PRGA')
        
        call SetBuffAbilityId('C000','PRGA')
        call SetBuffAbilityId('D000','PRGA')
        call SetBuffAbilityId('C108','PRGA')
        call SetBuffAbilityId('C109','PRGA')
        call SetBuffAbilityId('C10:','PRGA')
        call SetBuffAbilityId('C10;','PRGA')
        call SetBuffAbilityId('D105','PRGA')
        call SetBuffAbilityId('A2IB','PRGA')
        call SetBuffAbilityId('B0FV','PRGA')
        call SetBuffAbilityId('A0WR','PRGA')
        call SetBuffAbilityId('B01E','PRGA')
        call SetBuffAbilityId('A3K9','PRGA')
        call SetBuffAbilityId('A3KA','PRGA')
        call SetBuffAbilityId('B00S','PRGA')
        call SetBuffAbilityId('A3KB','PRGA')
        call SetBuffAbilityId('B07W','PRGA')
        call SetBuffAbilityId('Broa','PRGA')
        call SetBuffAbilityId('A3DU','PRGA')
        call SetBuffAbilityId('A3DV','PRGA')
        call SetBuffAbilityId('A3DW','PRGA')
        call SetBuffAbilityId('A3DX','PRGA')
        call SetBuffAbilityId('B3DU','PRGA')
        call SetBuffAbilityId('C020','PRGA')
        call SetBuffAbilityId('D020','PRGA')
        call SetBuffAbilityId('B0H6','PRGA')
        call SetBuffAbilityId('B016','PRGA')
        call SetBuffAbilityId('B019','PRGA')
        call SetBuffAbilityId('B00U','PRGA')
        call SetBuffAbilityId('A1Q0','PRGA')
        call SetBuffAbilityId('A1Q1','PRGA')
        call SetBuffAbilityId('A1Q2','PRGA')
        call SetBuffAbilityId('A1Q3','PRGA')
        call SetBuffAbilityId('A1CO','PRGA')
        call SetBuffAbilityId('B1CO','PRGA')
        call SetBuffAbilityId('A46F','PRGA')
        call SetBuffAbilityId('B46F','PRGA')
        call SetBuffAbilityId('A24G','PRGA')
        call SetBuffAbilityId('B0EC','PRGA')
        call SetBuffAbilityId('A23N','PRGA')
        call SetBuffAbilityId('B0E9','PRGA')
        call SetBuffAbilityId('A1GA','PRGA')
        call SetBuffAbilityId('B021','PRGA')
        call SetBuffAbilityId('A3KF','PRGA')
        call SetBuffAbilityId('B3KF','PRGA')
        call SetBuffAbilityId('A1N3','PRGA')
        call SetBuffAbilityId('A1N7','PRGA')
        call SetBuffAbilityId('B0CH','PRGA')
        call SetBuffAbilityId('B02H','PRGA')
        call SetBuffAbilityId('A1ZY','PRGA')
        call SetBuffAbilityId('B0DX','PRGA')
        call SetBuffAbilityId('B0CG','PRGA')
        call SetBuffAbilityId('Bcyc','PRGA')
        call SetBuffAbilityId('Bcy2','PRGA')
        call SetBuffAbilityId('Aetl','PRGA')
        call SetBuffAbilityId('A42L','PRGA')
        call SetBuffAbilityId('A42N','PRGA')
        call SetBuffAbilityId('B0HG','PRGA')
        call SetBuffAbilityId('B07S','PRGA')
        call SetBuffAbilityId('A3KI','PRGA')
        call SetBuffAbilityId('B3KI','PRGA')
    endfunction

endlibrary
