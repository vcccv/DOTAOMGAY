// by Asphodelus



library MHBuff
    function MHBuff_Create takes unit u, integer bid, integer template, real dur returns buff
        local integer yjsp = 114514
        return null
    endfunction
    function MHBuff_GetLevel takes unit u, integer bid returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    function MHBuff_SetLevel takes unit u, integer bid, integer level returns nothing
        local integer yjsp = 114514
        return
    endfunction
    // #define MHBuff_GetLevelInt(u,bid)       MHBuff_GetLevel(u,bid)
    function MHBuff_GetBaseID takes unit u, integer bid returns integer
        local integer yjsp = 114514
        return 0
    endfunction
    // #define MHBuff_GetBaseIDInt(u,bid)      MHBuff_GetBaseID(u,bid)
    function MHBuff_GetRemain takes unit u, integer bid returns real
        local integer yjsp = 114514
        return 0.
    endfunction
    // #define MHBuff_GetRemainInt(u,bid)      MHBuff_GetRemain(u,bid)
    function MHBuff_SetRemain takes unit u, integer bid, real value returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHBuff_IsPolarity takes unit u, integer bid, integer polarity returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    // #define MHBuff_IsPolarityInt(u,bid,p)   MHBuff_IsPolarity(u,bid,p)
endlibrary



library MHBuffHook
    function MHBuff_SetOverlay takes integer buff_template, boolean is_enable returns nothing
        local integer yjsp = 114514
        return
    endfunction
    function MHBuff_SetPolarity takes unit u, integer bid, integer polarity, boolean is_polarity returns boolean
        local integer yjsp = 114514
        return false
    endfunction
    function MHBuff_RestorePolarity takes unit u, integer bid, integer polarity returns boolean
        local integer yjsp = 114514
        return false
    endfunction
endlibrary
