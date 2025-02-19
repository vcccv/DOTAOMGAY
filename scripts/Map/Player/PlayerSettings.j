
library PlayerSettingsManager

    struct PlayerSettings extends array

        // 双击对己施法
        method IsDoubleTapAbilityToSelfCastEnabled takes nothing returns boolean
            return true
        endmethod

        // 自动选择召唤物
        method AutoSelectSummonedUnits takes nothing returns boolean
            return true
        endmethod
        

    endstruct

endlibrary
