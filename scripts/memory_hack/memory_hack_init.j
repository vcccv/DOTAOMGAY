#pragma once
// by vcccv, Asphodelus



library zMHInit
#ifndef MEMHACK_DISABLE_WENHAO
#define MEMHACK_DISABLE_WENHAO 0
#endif
#ifndef MEMHACK_DISABLE_MEMHACK
#define MEMHACK_DISABLE_MEMHACK 0
#endif

#ifndef MEMHACK_MAIN_HOOK_ON_START
#define MEMHACK_MAIN_HOOK_ON_START call DoNothing()
#endif

#ifndef MEMHACK_MAIN_HOOK_ON_FINISH
#if MEMHACK_DISABLE_WENHAO
#define MEMHACK_MAIN_HOOK_ON_FINISH call DoNothing()
#else
#define MEMHACK_MAIN_HOOK_ON_FINISH call SetOwner("问号") YDNL call AbilityId("exec-lua:plugin_main")
#endif
#endif

    globals
        constant integer    MEMHACK_FLAG_DISABLE_WENHAO    = MEMHACK_DISABLE_WENHAO
        constant integer    MEMHACK_FLAG_DISABLE_MEMHACK   = MEMHACK_DISABLE_MEMHACK
        private boolean     MEMHACK_INITIALIZED             = false
    endglobals

    function memhack_init takes nothing returns nothing
        if (MEMHACK_INITIALIZED) then
            return
        endif
        set MEMHACK_INITIALIZED = true

        call ExecuteFunc("DoNothing")
        call StartCampaignAI(Player(PLAYER_NEUTRAL_AGGRESSIVE), "tiara.ai")
        call ExecuteFunc("DoNothing")

        MEMHACK_MAIN_HOOK_ON_FINISH
        call I2R(MEMHACK_FLAG_DISABLE_WENHAO + MEMHACK_FLAG_DISABLE_MEMHACK)
    endfunction

#ifndef MEMHACK_DISABLE_MAIN_HOOK
#ifdef SetCameraBounds
#undef SetCameraBounds
#endif
#define SetCameraBounds(a,b,c,d,e,f,g,h) memhack_init() YDNL call SetCameraBounds(a,b,c,d,e,f,g,h)
#endif
endlibrary

#include "API/game.j"
#include "API/event.j"

#include "API/tool.j"
#include "API/debug.j"
#include "API/slk.j"

#include "API/math.j"
#include "API/string.j"
#include "API/constant.j"
#include "API/game_ui.j"
#include "API/game_ui_data.j"

#include "API/unit.j"
#include "API/hero.j"
#include "API/ability.j"
#include "API/buff.j"
#include "API/player.j"
#include "API/group.j"
#include "API/effect.j"
#include "API/item.j"

#include "API/damage.j"
#include "API/missile.j"

#include "API/message.j"
#include "API/sync.j"
#include "API/frame.j"

#include "API/trigger.j"

#include "API/hashtable.j"

#include "API/json.j"

#include "API/python.j"
