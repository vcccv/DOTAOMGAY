
scope UIBase 

    globals 
        hashtable UIHashTable = InitHashtable() 
    endglobals 

    function SetFrameIndex takes integer frame, integer key, integer index returns nothing 
        call SaveInteger(UIHashTable, frame, key, index) 
    endfunction 
    function GetFrameIndex takes integer frame, integer key returns integer 
        return LoadInteger(UIHashTable, frame, key) 
    endfunction 

    function GetFrameToolTipStr takes integer frame, integer typeId returns string 
        return LoadStr(ExtraHT, frame, typeId) 
    endfunction 
    function FrameToolTip__MouseEnter takes nothing returns nothing 
        local integer frame = DzGetTriggerUIEventFrame() 
        call DzFrameShow(UIFrame__ToolTip, true) 
        call DzFrameSetText(UIText__ToolTip, GetFrameToolTipStr(frame, HTKEY_UI_TOOLTIP_STR)) 
        call DzFrameSetText(UIText__ToolUberTip, GetFrameToolTipStr(frame, HTKEY_UI_TOOLTIP_UBERSTR)) 
    endfunction 
    function FrameToolTip__MouseLeave takes nothing returns nothing 
        call DzFrameShow(UIFrame__ToolTip, false) 
    endfunction 
    function SetFrameToolTip takes integer frame, string tip, string uberTip returns nothing 
        call SaveStr(ExtraHT, frame, HTKEY_UI_TOOLTIP_STR, tip) 
        call SaveStr(ExtraHT, frame, HTKEY_UI_TOOLTIP_UBERSTR, uberTip) 
        call DzFrameSetScriptByCode(frame, 2, function FrameToolTip__MouseEnter, false) 
        call DzFrameSetScriptByCode(frame, 3, function FrameToolTip__MouseLeave, false) 
    endfunction 

endscope 

globals 
    // 框架相对锚点(UI) 左上
    constant integer FRAMEPOINT_TOPLEFT = (0)
    // 框架相对锚点(UI) 上
    constant integer FRAMEPOINT_TOP = (1)
    // 框架相对锚点(UI) 右上
    constant integer FRAMEPOINT_TOPRIGHT = (2)
    // 框架相对锚点(UI) 左
    constant integer FRAMEPOINT_LEFT = (3)
    // 框架相对锚点(UI) 中
    constant integer FRAMEPOINT_CENTER = (4)
    // 框架相对锚点(UI) 右
    constant integer FRAMEPOINT_RIGHT = (5)
    // 框架相对锚点(UI) 左下
    constant integer FRAMEPOINT_BOTTOMLEFT = (6)
    // 框架相对锚点(UI) 下
    constant integer FRAMEPOINT_BOTTOM = (7)
    // 框架相对锚点(UI) 右下
    constant integer FRAMEPOINT_BOTTOMRIGHT = (8)
    constant integer FRAMEEVENT_CONTROL_CLICK          = 1
    constant integer FRAMEEVENT_MOUSE_ENTER            = 2
    constant integer FRAMEEVENT_MOUSE_LEAVE            = 3
    constant integer FRAMEEVENT_MOUSE_UP               = 4
    constant integer FRAMEEVENT_MOUSE_DOWN             = 5
    constant integer FRAMEEVENT_MOUSE_WHEEL            = 6
    constant integer FRAMEEVENT_CHECKBOX_CHECKED       = 7
    constant integer FRAMEEVENT_CHECKBOX_UNCHECKED     = 8
    constant integer FRAMEEVENT_EDITBOX_TEXT_CHANGED   = 9
    constant integer FRAMEEVENT_POPUPMENU_ITEM_CHANGED = 10
    constant integer FRAMEEVENT_MOUSE_DOUBLECLICK      = 11
    constant integer FRAMEEVENT_SPRITE_ANIM_UPDATE     = 12
    constant integer FRAMEEVENT_SLIDER_VALUE_CHANGED   = 13
    // OS Key constants 
	
    // 键盘 退格键 
    constant integer OSKEY_BACKSPACE = ($08) 
    // 键盘 TAB 键 
    constant integer OSKEY_TAB = ($09) 
    // 键盘 CLEAR 键(Num Lock关闭时的数字键盘5) 
    constant integer OSKEY_CLEAR = ($0C) 
    // 键盘 回车键 
    constant integer OSKEY_RETURN = ($0D) 
    // 键盘 SHIFT 键 
    constant integer OSKEY_SHIFT = ($10) 
    // 键盘 ctrl 键 
    constant integer OSKEY_CONTROL = ($11) 
    // 键盘 ALT 键 
    constant integer OSKEY_ALT = ($12) 
    // 键盘 PAUSE (暂停)键 
    constant integer OSKEY_PAUSE = ($13) 
    // 键盘 CAPS LOCK 键 
    constant integer OSKEY_CAPSLOCK = ($14) 
  
    // 键盘 ESC 键 
    constant integer OSKEY_ESCAPE = ($1B) 
    // 键盘 Caps lock 键(开启状态) 
    constant integer OSKEY_CONVERT = ($1C) 
    // 键盘 Caps lock 键(关闭状态) 
    constant integer OSKEY_NONCONVERT = ($1D) 
    // 键盘 ACCEPT 键 
    constant integer OSKEY_ACCEPT = ($1E) 
    // 键盘 变更模式键 
    constant integer OSKEY_MODECHANGE = ($1F) 
    // 键盘 空格键 
    constant integer OSKEY_SPACE = ($20) 
    // 键盘 向上翻页键 
    constant integer OSKEY_PAGEUP = ($21) 
    // 键盘 向下翻页键 
    constant integer OSKEY_PAGEDOWN = ($22) 
    // 键盘 结束键 
    constant integer OSKEY_END = ($23) 
    // 键盘 HOME 键 
    constant integer OSKEY_HOME = ($24) 
    // 键盘 方向键 左 
    constant integer OSKEY_LEFT = ($25) 
    // 键盘 方向键 上 
    constant integer OSKEY_UP = ($26) 
    // 键盘 方向键 右 
    constant integer OSKEY_RIGHT = ($27) 
    // 键盘 方向键 下 
    constant integer OSKEY_DOWN = ($28) 
    // 键盘 选择键(右SHIFT) 
    constant integer OSKEY_SELECT = ($29) 
    // 键盘 PRINT 键 
    constant integer OSKEY_PRINT = ($2A) 
    // 键盘 EXECUTE 键 
    constant integer OSKEY_EXECUTE = ($2B) 
    // 键盘 截图键 
    constant integer OSKEY_PRINTSCREEN = ($2C) 
    //建盘 INSERT键 
    constant integer OSKEY_INSERT = ($2D) 
    //建盘 DELETE键 
    constant integer OSKEY_DELETE = ($2E) 
    // 键盘 帮助键(F1) 
    constant integer OSKEY_HELP = ($2F) 
    // 键盘 0键(非小/数字键盘) 
    constant integer OSKEY_0 = ($30) 
    // 键盘 1键(非小/数字键盘) 
    constant integer OSKEY_1 = ($31) 
    // 键盘 2键(非小/数字键盘) 
    constant integer OSKEY_2 = ($32) 
    // 键盘 3键(非小/数字键盘) 
    constant integer OSKEY_3 = ($33) 
    // 键盘 4键(非小/数字键盘) 
    constant integer OSKEY_4 = ($34) 
    // 键盘 5键(非小/数字键盘) 
    constant integer OSKEY_5 = ($35) 
    // 键盘 6键(非小/数字键盘) 
    constant integer OSKEY_6 = ($36) 
    // 键盘 7键(非小/数字键盘) 
    constant integer OSKEY_7 = ($37) 
    // 键盘 8键(非小/数字键盘) 
    constant integer OSKEY_8 = ($38) 
    // 键盘 9键(非小/数字键盘) 
    constant integer OSKEY_9 = ($39) 
    // 键盘 A键 
    constant integer OSKEY_A = ($41) 
    // 键盘 B键 
    constant integer OSKEY_B = ($42) 
    // 键盘 C键 
    constant integer OSKEY_C = ($43) 
    // 键盘 D键 
    constant integer OSKEY_D = ($44) 
    // 键盘 E键 
    constant integer OSKEY_E = ($45) 
    // 键盘 F键 
    constant integer OSKEY_F = ($46) 
    // 键盘 G键 
    constant integer OSKEY_G = ($47) 
    // 键盘 H键 
    constant integer OSKEY_H = ($48) 
    // 键盘 I键 
    constant integer OSKEY_I = ($49) 
    // 键盘 J键 
    constant integer OSKEY_J = ($4A) 
    // 键盘 K键 
    constant integer OSKEY_K = ($4B) 
    // 键盘 L键 
    constant integer OSKEY_L = ($4C) 
    // 键盘 M键 
    constant integer OSKEY_M = ($4D) 
    // 键盘 N键 
    constant integer OSKEY_N = ($4E) 
    // 键盘 O键 
    constant integer OSKEY_O = ($4F) 
    // 键盘 P键 
    constant integer OSKEY_P = ($50) 
    // 键盘 Q键 
    constant integer OSKEY_Q = ($51) 
    // 键盘 R键 
    constant integer OSKEY_R = ($52) 
    // 键盘 S键 
    constant integer OSKEY_S = ($53) 
    // 键盘 T键 
    constant integer OSKEY_T = ($54) 
    // 键盘 U键 
    constant integer OSKEY_U = ($55) 
    // 键盘 V键 
    constant integer OSKEY_V = ($56) 
    // 键盘 W键 
    constant integer OSKEY_W = ($57) 
    // 键盘 X键 
    constant integer OSKEY_X = ($58) 
    // 键盘 Y键 
    constant integer OSKEY_Y = ($59) 
    // 键盘 Z键 
    constant integer OSKEY_Z = ($5A) 
    // 键盘 LMETA 键 
    constant integer OSKEY_LMETA = ($5B) 
    // 键盘 RMETA 键 
    constant integer OSKEY_RMETA = ($5C) 
    // 键盘 APPS 键 
    constant integer OSKEY_APPS = ($5D) 
    // 键盘 休眠键 
    constant integer OSKEY_SLEEP = ($5F) 
    // 小/数字键盘 0键 
    constant integer OSKEY_NUMPAD0 = ($60) 
    // 小/数字键盘 1键 
    constant integer OSKEY_NUMPAD1 = ($61) 
    // 小/数字键盘 2键 
    constant integer OSKEY_NUMPAD2 = ($62) 
    // 小/数字键盘 3键 
    constant integer OSKEY_NUMPAD3 = ($63) 
    // 小/数字键盘 4键 
    constant integer OSKEY_NUMPAD4 = ($64) 
    // 小/数字键盘 5键 
    constant integer OSKEY_NUMPAD5 = ($65) 
    // 小/数字键盘 6键 
    constant integer OSKEY_NUMPAD6 = ($66) 
    // 小/数字键盘 7键 
    constant integer OSKEY_NUMPAD7 = ($67) 
    // 小/数字键盘 8键 
    constant integer OSKEY_NUMPAD8 = ($68) 
    // 小/数字键盘 9键 
    constant integer OSKEY_NUMPAD9 = ($69) 
    // 小/数字键盘 乘号键 
    constant integer OSKEY_MULTIPLY = ($6A) 
    // 小/数字键盘 加号键 
    constant integer OSKEY_ADD = ($6B) 
    // 小/数字键盘 分离键/分隔符键 
    constant integer OSKEY_SEPARATOR = ($6C) 
    // 小/数字键盘 减号键 
    constant integer OSKEY_SUBTRACT = ($6D) 
    // 小/数字键盘 小数点键 
    constant integer OSKEY_DECIMAL = ($6E) 
    // 小/数字键盘 除号键 
    constant integer OSKEY_DIVIDE = ($6F) 
    // 键盘 F1键 
    constant integer OSKEY_F1 = ($70) 
    // 键盘 F2键 
    constant integer OSKEY_F2 = ($71) 
    // 键盘 F3键 
    constant integer OSKEY_F3 = ($72) 
    // 键盘 F4键 
    constant integer OSKEY_F4 = ($73) 
    // 键盘 F5键 
    constant integer OSKEY_F5 = ($74) 
    // 键盘 F6键 
    constant integer OSKEY_F6 = ($75) 
    // 键盘 F7键 
    constant integer OSKEY_F7 = ($76) 
    // 键盘 F8键 
    constant integer OSKEY_F8 = ($77) 
    // 键盘 F9键 
    constant integer OSKEY_F9 = ($78) 
    // 键盘 F10键 
    constant integer OSKEY_F10 = ($79) 
    // 键盘 F11键 
    constant integer OSKEY_F11 = ($7A) 
    // 键盘 F12键 
    constant integer OSKEY_F12 = ($7B) 
    // 键盘 F13键 
    constant integer OSKEY_F13 = ($7C) 
    // 键盘 F14键 
    constant integer OSKEY_F14 = ($7D) 
    // 键盘 F15键 
    constant integer OSKEY_F15 = ($7E) 
    // 键盘 F16键 
    constant integer OSKEY_F16 = ($7F) 
    // 键盘 F17键 
    constant integer OSKEY_F17 = ($80) 
    // 键盘 F18键 
    constant integer OSKEY_F18 = ($81) 
    // 键盘 F19键 
    constant integer OSKEY_F19 = ($82) 
    // 键盘 F20键 
    constant integer OSKEY_F20 = ($83) 
    // 键盘 F21键 
    constant integer OSKEY_F21 = ($84) 
    // 键盘 F22键 
    constant integer OSKEY_F22 = ($85) 
    // 键盘 F23键 
    constant integer OSKEY_F23 = ($86) 
    // 键盘 F24键 
    constant integer OSKEY_F24 = ($87) 
    // 小/数字键盘 开关键 
    constant integer OSKEY_NUMLOCK = ($90) 
    // 键盘 SCROLL LOCK键 
    constant integer OSKEY_SCROLLLOCK = ($91) 
    // 小/数字键盘 等号键(OEM 键) 
    constant integer OSKEY_OEM_NEC_EQUAL = ($92) 
    // 键盘 字典键(OEM 键) 
    constant integer OSKEY_OEM_FJ_JISHO = ($92) 
    // 键盘 取消注册 Word 键(OEM 键) 
    constant integer OSKEY_OEM_FJ_MASSHOU = ($93) 
    // 键盘 注册 Word 键(OEM 键) 
    constant integer OSKEY_OEM_FJ_TOUROKU = ($94) 
    // 键盘 左 OYAYUBI 键(OEM 键) 
    constant integer OSKEY_OEM_FJ_LOYA = ($95) 
    // 键盘 右 OYAYUBI 键(OEM 键) 
    constant integer OSKEY_OEM_FJ_ROYA = ($96) 
    // 键盘 左 SHIFT 键 
    constant integer OSKEY_LSHIFT = ($A0) 
    // 键盘 右 SHIFT 键 
    constant integer OSKEY_RSHIFT = ($A1) 
    // 键盘 左 Ctrl 键 
    constant integer OSKEY_LCONTROL = ($A2) 
    // 键盘 右 Ctrl 键 
    constant integer OSKEY_RCONTROL = ($A3) 
    // 键盘 左 Alt 键 
    constant integer OSKEY_LALT = ($A4) 
    // 键盘 右 Alt 键 
    constant integer OSKEY_RALT = ($A5) 
    // 键盘 浏览器后退键 
    constant integer OSKEY_BROWSER_BACK = ($A6) 
    // 键盘 浏览器前进键 
    constant integer OSKEY_BROWSER_FORWARD = ($A7) 
    // 键盘 浏览器刷新键 
    constant integer OSKEY_BROWSER_REFRESH = ($A8) 
    // 键盘 浏览器停止键 
    constant integer OSKEY_BROWSER_STOP = ($A9) 
    // 键盘 浏览器搜索键 
    constant integer OSKEY_BROWSER_SEARCH = ($AA) 
    // 键盘 浏览器收藏键 
    constant integer OSKEY_BROWSER_FAVORITES = ($AB) 
    // 键盘 浏览器“开始”和“主页”键 
    constant integer OSKEY_BROWSER_HOME = ($AC) 
    // 键盘 静音键 
    constant integer OSKEY_VOLUME_MUTE = ($AD) 
    // 键盘 减小音量键 
    constant integer OSKEY_VOLUME_DOWN = ($AE) 
    // 键盘 增大音量键 
    constant integer OSKEY_VOLUME_UP = ($AF) 
    // 键盘 下一曲键 
    constant integer OSKEY_MEDIA_NEXT_TRACK = ($B0) 
    // 键盘 上一曲键 
    constant integer OSKEY_MEDIA_PREV_TRACK = ($B1) 
    // 键盘 停止播放键 
    constant integer OSKEY_MEDIA_STOP = ($B2) 
    // 键盘 暂停播放键 
    constant integer OSKEY_MEDIA_PLAY_PAUSE = ($B3) 
    // 键盘 打开邮箱键 
    constant integer OSKEY_LAUNCH_MAIL = ($B4) 
    // 键盘 选择媒体键 
    constant integer OSKEY_LAUNCH_MEDIA_SELECT = ($B5) 
    // 键盘 启动应用程序1键 
    constant integer OSKEY_LAUNCH_APP1 = ($B6) 
    // 键盘 启动应用程序2键 
    constant integer OSKEY_LAUNCH_APP2 = ($B7) 
    // 小/数字键盘 1键(OEM 键) 
    constant integer OSKEY_OEM_1 = ($BA) 
    // 键盘 加号键(OEM 键) 
    constant integer OSKEY_OEM_PLUS = ($BB) 
    // 键盘 逗号键(OEM 键) 
    constant integer OSKEY_OEM_COMMA = ($BC) 
    // 键盘 减号键(OEM 键) 
    constant integer OSKEY_OEM_MINUS = ($BD) 
    // 键盘 句号键(OEM 键) 
    constant integer OSKEY_OEM_PERIOD = ($BE) 
    // 小/数字键盘 2键(OEM 键) 
    constant integer OSKEY_OEM_2 = ($BF) 
    // 小/数字键盘 3键(OEM 键) 
    constant integer OSKEY_OEM_3 = ($C0) 
    // 小/数字键盘 4键(OEM 键) 
    constant integer OSKEY_OEM_4 = ($DB) 
    // 小/数字键盘 5键(OEM 键) 
    constant integer OSKEY_OEM_5 = ($DC) 
    // 小/数字键盘 6键(OEM 键) 
    constant integer OSKEY_OEM_6 = ($DD) 
    // 小/数字键盘 7键(OEM 键) 
    constant integer OSKEY_OEM_7 = ($DE) 
    // 小/数字键盘 8键(OEM 键) 
    constant integer OSKEY_OEM_8 = ($DF) 
    // 键盘 AX 键(OEM 键) 
    constant integer OSKEY_OEM_AX = ($E1) 
    // 键盘 102 键(OEM 键) 
    constant integer OSKEY_OEM_102 = ($E2) 
    // 键盘  Ico帮助键 
    constant integer OSKEY_ICO_HELP = ($E3) 
    // 键盘  Ico00 键 
    constant integer OSKEY_ICO_00 = ($E4) 
    // 键盘 Process 键 
    constant integer OSKEY_PROCESSKEY = ($E5) 
    // 键盘 IcoClr 键 
    constant integer OSKEY_ICO_CLEAR = ($E6) 
    // 键盘 格式化键(OEM 键) 
    constant integer OSKEY_PACKET = ($E7) 
    // 键盘 重置键(OEM 键) 
    constant integer OSKEY_OEM_RESET = ($E9) 
    // 键盘 ATTN 键(OEM 键) 
    constant integer OSKEY_OEM_JUMP = ($EA) 
    // 键盘 PA1 键(OEM 键) 
    constant integer OSKEY_OEM_PA1 = ($EB) 
    // 键盘 PA2 键(OEM 键) 
    constant integer OSKEY_OEM_PA2 = ($EC) 
    // 键盘 ATTN 键(OEM 键) 
    constant integer OSKEY_OEM_PA3 = ($ED) 
    // 键盘 WSCTRL 键(OEM 键，似乎是联想杀毒软件定制按键) 
    constant integer OSKEY_OEM_WSCTRL = ($EE) 
    // 键盘 ATTN 键(OEM 键) 
    constant integer OSKEY_OEM_CUSEL = ($EF) 
    // 键盘 ATTN 键(OEM 键) 
    constant integer OSKEY_OEM_ATTN = ($F0) 
    // 键盘 完成键(OEM 键) 
    constant integer OSKEY_OEM_FINISH = ($F1) 
    // 键盘 复制键(OEM 键) 
    constant integer OSKEY_OEM_COPY = ($F2) 
    // 键盘 自动键(OEM 键) 
    constant integer OSKEY_OEM_AUTO = ($F3) 
    // 键盘 ENLW 键(OEM 键) 
    constant integer OSKEY_OEM_ENLW = ($F4) 
    // 键盘 BACKTAB 键(OEM 键) 
    constant integer OSKEY_OEM_BACKTAB = ($F5) 
    // 键盘 ATTN 键 
    constant integer OSKEY_ATTN = ($F6) 
    // 键盘 CRSEL 键 
    constant integer OSKEY_CRSEL = ($F7) 
    // 键盘 CRSEL 键 
    constant integer OSKEY_EXSEL = ($F8) 
    // 键盘 CRSEL 键 
    constant integer OSKEY_EREOF = ($F9) 
    // 键盘 播放键 
    constant integer OSKEY_PLAY = ($FA) 
    // 键盘 缩放键 
    constant integer OSKEY_ZOOM = ($FB) 
    // 键盘 留待将来使用的常数键 
    constant integer OSKEY_NONAME = ($FC) 
    // 键盘 PA1 键 
    constant integer OSKEY_PA1 = ($FD) 
    // 键盘 清理键(OEM 键) 
    constant integer OSKEY_OEM_CLEAR = ($FE) 
endglobals 

