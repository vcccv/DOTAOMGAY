
library BuffUtils requires Table

    globals
        private  buff    Temp = null
        constant integer BUFF_LEVEL1 = 1
        constant integer BUFF_LEVEL2 = 2
        constant integer BUFF_LEVEL3 = 3
        constant key BUFF_SOURCE_KEY
    endglobals

    function GetBuffSource takes ability whichAbility returns unit
        return Table[GetHandleId(whichAbility)].unit[BUFF_SOURCE_KEY]
    endfunction

    // positive为正面负面，polarity以后再说
    function UnitAddBuffByPolarity takes unit source, unit target, integer buffId, integer level, real duration, boolean positive, integer polarity returns buff
        set Event.BUFF_INDEX = Event.BUFF_INDEX + 1
        set Event.BuffSource[Event.BUFF_INDEX] = source

        set Temp = MHBuff_CreateEx(target, buffId, BUFF_TEMPLATE_BBLO, level, 0, duration)
        set Table[GetHandleId(Temp)].unit[BUFF_SOURCE_KEY] = source
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_POSITIVE, positive)
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_NEGATIVE, not positive)
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_MAGIC, false)
        if polarity == BUFF_LEVEL3 then
            call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_AURA, true)
        endif

        set Event.BuffSource[Event.BUFF_INDEX] = null
        set Event.BUFF_INDEX = Event.BUFF_INDEX - 1
        return Temp
    endfunction

    // 添加光环buff
    function UnitAddAreaBuff takes unit source, unit target, integer buffId, integer level, real duration, boolean positive returns buff
        set Event.BUFF_INDEX = Event.BUFF_INDEX + 1
        set Event.BuffSource[Event.BUFF_INDEX] = source

        set Temp = MHBuff_CreateEx(target, buffId, BUFF_TEMPLATE_BBLO, level, 0, duration)
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_POSITIVE, positive)
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_NEGATIVE, not positive)
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_MAGIC, false)
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_AURA, true)

        set Event.BuffSource[Event.BUFF_INDEX] = null
        set Event.BUFF_INDEX = Event.BUFF_INDEX - 1
        return Temp
    endfunction
    function UnitAddAreaBuffEx takes unit source, unit target, integer buffId, integer level, real duration, real herodur, boolean positive returns buff
        if herodur == 0. then
            set herodur = duration
        endif
        if IsHeroUnitId(GetUnitTypeId(target)) then
            set Temp = MHBuff_CreateEx(target, buffId, BUFF_TEMPLATE_BBLO, level, 0, herodur )
        else
            set Temp = MHBuff_CreateEx(target, buffId, BUFF_TEMPLATE_BBLO, level, 0, duration)
        endif
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_POSITIVE, positive)
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_NEGATIVE, not positive)
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_MAGIC, false)
        call MHBuff_SetPolarity(target, buffId, BUFF_POLARITY_AURA, true)
        return Temp
    endfunction

    function CreateBuffByTemplate takes unit source, unit target, integer buffId, real duration, integer template returns buff
        return MHBuff_Create(target, buffId, template, duration)
    endfunction

endlibrary
