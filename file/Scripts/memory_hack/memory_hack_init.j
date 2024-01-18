library ZMHInit

    globals
        boolean is_initialized = false
    endglobals

    function memhack_init takes nothing returns nothing
        if (not is_initialized) then

            call ExecuteFunc("DoNothing")
            call StartCampaignAI(Player(PLAYER_NEUTRAL_AGGRESSIVE), "MemHackLoader")
            call ExecuteFunc("DoNothing")

            set is_initialized = true
        endif
    endfunction

endlibrary


//! import "memory_hack_constant.j"

//! import "API/game.j"
//! import "API/event.j"

//! import "API/tool.j"
//! import "API/debug.j"

//! import "API/math.j"
//! import "API/string.j"
//! import "API/constant.j"
//! import "API/game_ui.j"
//! import "API/game_ui_data.j"

//! import "API/unit.j"
//! import "API/hero.j"
//! import "API/ability.j"
//! import "API/buff.j"
//! import "API/player.j"
//! import "API/group.j"
//! import "API/effect.j"
//! import "API/item.j"

//! import "API/damage.j"
//! import "API/missile.j"

//! import "API/message.j"
//! import "API/sync.j"
//! import "API/frame.j"

//! import "API/trigger.j"
