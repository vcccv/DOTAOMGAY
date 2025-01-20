
library BuffUtils requires Table

    globals
        private buff Temp = null
        constant integer BUFF_LEVEL1 = 1
        constant integer BUFF_LEVEL2 = 2
        constant integer BUFF_LEVEL3 = 2
    endglobals

    // positive为正面负面，polarity以后再说
    function CreateBuffByPolarity takes unit whichUnit, integer buffId, real duration, boolean positive, integer polarity returns buff
        set Temp = MHBuff_Create(whichUnit, buffId, BUFF_TEMPLATE_BNAB, duration)
        call MHBuff_SetPolarity(whichUnit, buffId, BUFF_POLARITY_POSITIVE, positive)
        call MHBuff_SetPolarity(whichUnit, buffId, BUFF_POLARITY_NEGATIVE, not positive)
        return Temp
    endfunction

endlibrary
