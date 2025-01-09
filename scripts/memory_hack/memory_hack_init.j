// by vcccv, Asphodelus
#pragma once

library zMHInit

    globals
        private boolean     MEMHACK_INITIALIZED     = false
    endglobals

    function memhack_init takes nothing returns nothing
        call ExecuteFunc("DoNothing")
        call StartCampaignAI(Player(PLAYER_NEUTRAL_AGGRESSIVE), "tiara.ai")
        call ExecuteFunc("DoNothing")

    endfunction

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

#include "API/python.j"
