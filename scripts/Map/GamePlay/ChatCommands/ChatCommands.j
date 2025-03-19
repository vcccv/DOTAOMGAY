
library ChatCommands requires Table, Base
    
    globals
        private constant key CHAT_COMMANDS_KEY
        private constant key CHAT_OPTION_KEY
        private string ChatString   = ""
        private string OptionString = ""
    endglobals

    // debug指令
    function WCO takes string s returns nothing
        local boolean WDO = SubString(s, 0, 4) == "-aa "
        local boolean WFO = SubString(s, 0, 4) == "-au "
        local boolean WGO = SubString(s, 0, 4) == "-sa "
        local boolean WHO = SubString(s, 0, 4) == "-at "
        local boolean WJO = SubString(s, 0, 4) == "-ra "
        local boolean WKO = s == "-r"
        local boolean WLO = SubString(s, 0, 4) == "-ga "
        local boolean WMO = SubString(s, 0, 4) == "-ha "
        local boolean WPO = SubString(s, 0, 4) == "-ai "
        local boolean WQO = SubString(s, 0, 3) == "-o "
        local boolean WSO = SubString(s, 0, 4) == "-et "
        local boolean WTO = SubString(s, 0, 4) == "-ep "
        local boolean WUO = SubString(s, 0, 7) == "-setms "
        local boolean WWO = SubString(s, 0, 6) == "-anim "
        local boolean WYO = SubString(s, 0, 4) == "-hp "
        local boolean WZO = s == "-hp"
        local boolean W_O = SubString(s, 0, 4) == "-mp "
        local boolean W0O = SubString(s, 0, 4) == "-ar "
        local boolean W1O = SubString(s, 0, 4) == "-ip "
        local boolean W2O = s == "-nerf"
        local boolean W3O = SubString(s, 0, 4) == "-or "
        local boolean W4O = SubString(s, 0, 7) == "-mytry "
        local boolean W5O = s == "-cc"
        local boolean W6O = s == "-b"
        local boolean W7O = s == "-control" or s == "-c"
        local boolean W8O = s == "-xy"
        local boolean gi = s == "-gi"
        local boolean W9O = SubString(s, 0, 5) == "-sxy "
        local boolean YVO = SubString(s, 0, 6) == "-tint "
        local boolean YEO = s == "-ms "
        local boolean YXO = s == "-path"
        local boolean YOO = s == "-k"
        local boolean YRO = s == "-br"
        local boolean YIO = s == "-path on"
        local boolean YAO = s == "-path off"
        local boolean YNO = s == "-path"
        local boolean YBO = SubString(s, 0, 7) == "-souls "
        local boolean YCO = SubString(s, 0, 7) == "-scale "
        local boolean YDO = s == "-fog"
        local boolean getId = s == "-all"
        local boolean testEfficiency = s == "-效率"
        local boolean gct = s == "-gct"
        local boolean img = s == "-img"
        if YDO then
            call Cheat("iseedeadpeople")
        endif

        call ExecuteFunctionConditionally("DebugIllusionUnitData", img)
        call ExecuteFunctionConditionally("DebugUnitCollisionType", gct)
        call ExecuteFunctionConditionally("EXGetUnitAllAbilityId", getId)
        call ExecuteFunctionConditionally("TestEfficiency", testEfficiency)

        call ExecuteFunctionConditionally("WNO", YCO)
        call ExecuteFunctionConditionally("WNO", YCO)
        call ExecuteFunctionConditionally("WRO", YBO)
        call ExecuteFunctionConditionally("WAO", YNO)
        call ExecuteFunctionConditionally("WXO", YIO)
        call ExecuteFunctionConditionally("WOO", YAO)
        call ExecuteFunctionConditionally("UYO", W6O)
        call ExecuteFunctionConditionally("WEO", YRO)
        call ExecuteFunctionConditionally("WEO", YRO)
        call ExecuteFunctionConditionally("WVO", YXO)
        call ExecuteFunctionConditionally("YFO", YEO)
        call ExecuteFunctionConditionally("U9O", W9O)
        call ExecuteFunctionConditionally("U2O", WTO)
        call ExecuteFunctionConditionally("U3O", WSO)
        call ExecuteFunctionConditionally("SKO", W7O)
        call ExecuteFunctionConditionally("TLO", W8O)
        call ExecuteFunctionConditionally("T1O", gi)
        call ExecuteFunctionConditionally("UYO", W6O)
        call ExecuteFunctionConditionally("U0O", YVO)
        call ExecuteFunctionConditionally("UWO", W5O)
        call ExecuteFunctionConditionally("UTO", W3O)
        call ExecuteFunctionConditionally("ULO", W4O)
        call ExecuteFunctionConditionally("UQO", WKO)
        call ExecuteFunctionConditionally("UJO", W2O)
        call ExecuteFunctionConditionally("UGO", WFO)
        call ExecuteFunctionConditionally("UFO", WGO)
        call ExecuteFunctionConditionally("TAO", WYO)
        call ExecuteFunctionConditionally("TBO", WZO)
        call ExecuteFunctionConditionally("TDO", YOO)
        call ExecuteFunctionConditionally("TJO", W0O)
        call ExecuteFunctionConditionally("TGO", W_O)
        call ExecuteFunctionConditionally("TRO", WWO)
        call ExecuteFunctionConditionally("TOO", WHO)
        call ExecuteFunctionConditionally("S9O", WUO)
        call ExecuteFunctionConditionally("TEO", W1O)
        call ExecuteFunctionConditionally("STO", WDO)
        call ExecuteFunctionConditionally("SYO", WJO)
        call ExecuteFunctionConditionally("S_O", WLO)
        call ExecuteFunctionConditionally("S1O", WMO)
        call ExecuteFunctionConditionally("S5O", WQO)
        call ExecuteFunctionConditionally("S3O", WPO)
    endfunction

    // 对于有参数的指令
    function YLO takes string s returns nothing
        local string s5 = SubString(s, 0, 5)
        local boolean YMO = SubString(s, 0, 5) == "-swap"
        local boolean YPO = SubString(s, 0, 5) == "-roll"
        local boolean YQO = SubString(s, 0, 8) == "-kickafk"
        local boolean YSO = SubString(s, 0, 6) == "-music"
        local boolean YTO = SubString(s, 0, 6) == "-water"
        local boolean YUO = SubString(s, 0, 9) == "-rickroll"
        local boolean YWO = SubString(s, 0, 7) == "-switch"
        local boolean YYO = SubString(s, 0, 18) == "-removeiteminslot "
        local boolean YZO = SubString(s, 0, 2) == "-r" and(SubString(s, 2, 3) == " " or S2I(SubString(s, 2, 3))> 0)
        local boolean Y_O = SubString(s, 0, 4) == "-cam"
        local boolean Y0O = SubString(s, 0, 9) == "-itemswap"
        // if s5 == "-ikey" then
        //     call ExecuteFunc("IKY")
        // elseif s5 == "-hkey" then
        //     call ExecuteFunc("HKY")
        // endif
        call ExecuteFunctionConditionally("TMO", Y_O)
        call ExecuteFunctionConditionally("Y1O", YMO)
        call ExecuteFunctionConditionally("Y2O", YPO)
        call ExecuteFunctionConditionally("Y3O", YQO)
        call ExecuteFunctionConditionally("Y4O", YZO)
        call ExecuteFunctionConditionally("S7O", YYO)
        call ExecuteFunctionConditionally("Y5O", YSO)
        call ExecuteFunctionConditionally("Y6O", YTO)
        call ExecuteFunctionConditionally("Y7O", YUO)
        call ExecuteFunctionConditionally("Y8O", YWO)
        call ExecuteFunctionConditionally("YKO", Y0O)
        if (bj_isSinglePlayer) then
            call WCO(s)
        endif
    endfunction

    function GetChatCommandArgAt takes integer index returns string
        local string cmdHead
        local string paramStr

        if StringLength(ChatString) == 0 then
            return ""
        endif
        if MHString_GetCount(ChatString, " ") < index then
            return ""
        endif
        return MHString_Split(ChatString, " ", index + 1)
    endfunction
    function GetChatCommandArgsCount takes nothing returns integer
        return MHString_GetCount(ChatString, " ")
    endfunction

    private function OnPlayerCaht takes nothing returns nothing
        local string  s
        local integer h

        // 连续的空格替换为单一空格，并去掉右边空格
        set ChatString = MHString_RegexReplace(MHString_RTrim(GetEventPlayerChatString()), " +", " ")

        set s = StringCase(ChatString, false)
        set h = StringHash(s)
        if Table[CHAT_COMMANDS_KEY].string.has(h) then
            set OptionString = Table[CHAT_OPTION_KEY].string[h]
            call ExecuteFunc(Table[CHAT_COMMANDS_KEY].string[h])

            if (s != "-c") then
                return
            endif
        endif

        if (SubString(s, 0, 1) == "-") then
            call YLO(s)
        endif

        set s = MHString_Split(s, " ", 1)
        set h = StringHash(s)
        if Table[CHAT_COMMANDS_KEY].string.has(h) then
            set OptionString = Table[CHAT_OPTION_KEY].string[h]
            call ExecuteFunc(Table[CHAT_COMMANDS_KEY].string[h])
            return
        endif
    endfunction

    // 无参数的指令
    function ResgiterSimpleCommand takes string cmd, string handler returns nothing
        set Table[CHAT_OPTION_KEY  ].string[StringHash(cmd)] = cmd
        set Table[CHAT_COMMANDS_KEY].string[StringHash(cmd)] = handler
    endfunction
    // 带参数的指令 如果不检查参数数量则写-1
    function RegisterParamCommand takes string cmd, string handler, integer paramCount returns nothing
        set Table[CHAT_OPTION_KEY  ].string [StringHash(cmd)] = cmd
        set Table[CHAT_COMMANDS_KEY].string [StringHash(cmd)] = handler
        set Table[CHAT_COMMANDS_KEY].integer[StringHash(cmd)] = paramCount
    endfunction
    function ChatCommands_Init takes nothing returns nothing
        local trigger t
        set t = CreateTrigger()
        call TriggerRegisterPlayerChatEvent(t, SentinelPlayers[1], "", false)
        call TriggerRegisterPlayerChatEvent(t, SentinelPlayers[2], "", false)
        call TriggerRegisterPlayerChatEvent(t, SentinelPlayers[3], "", false)
        call TriggerRegisterPlayerChatEvent(t, SentinelPlayers[4], "", false)
        call TriggerRegisterPlayerChatEvent(t, SentinelPlayers[5], "", false)
        call TriggerRegisterPlayerChatEvent(t, ScourgePlayers[1], "", false)
        call TriggerRegisterPlayerChatEvent(t, ScourgePlayers[2], "", false)
        call TriggerRegisterPlayerChatEvent(t, ScourgePlayers[3], "", false)
        call TriggerRegisterPlayerChatEvent(t, ScourgePlayers[4], "", false)
        call TriggerRegisterPlayerChatEvent(t, ScourgePlayers[5], "", false)
        call TriggerAddAction(t, function OnPlayerCaht)
    endfunction

endlibrary
