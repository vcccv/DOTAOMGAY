
library BuffUtils requires Table

    globals
        private buff Temp = null
        constant integer BUFF_LEVEL1 = 1
        constant integer BUFF_LEVEL2 = 2
        constant integer BUFF_LEVEL3 = 3
    endglobals

    // positive为正面负面，polarity以后再说
    function UnitAddBuffByPolarity takes unit source, unit target, integer buffId, integer level, real duration, boolean positive, integer polarity returns buff
        set Temp = MHBuff_Create(whichUnit, buffId, BUFF_TEMPLATE_BNAB, duration)
        call MHBuff_SetLevel(whichUnit, buffId, level)
        call MHBuff_SetPolarity(whichUnit, buffId, BUFF_POLARITY_POSITIVE, positive)
        call MHBuff_SetPolarity(whichUnit, buffId, BUFF_POLARITY_NEGATIVE, not positive)
        if polarity == BUFF_LEVEL3 then
            call MHBuff_SetPolarity(whichUnit, buffId, BUFF_POLARITY_AURA, true)
        endif
        return Temp
    endfunction

    function CreateBuffByTemplate takes unit source, unit target, integer buffId, real duration, integer template returns buff
        return MHBuff_Create(whichUnit, buffId, template, duration)
    endfunction

endlibrary
