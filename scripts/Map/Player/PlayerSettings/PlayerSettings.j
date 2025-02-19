
library PlayerSettingsLib requires PlayerUtils

    struct PlayerSettings extends array

        // 双击对己施法
        private boolean doubleTapAbilityToSelfCast
        method IsDoubleTapAbilityToSelfCast takes nothing returns boolean
            return this.doubleTapAbilityToSelfCast
        endmethod
        method EnableDoubleTapAbilityToSelfCast takes boolean enable returns nothing
            set this.doubleTapAbilityToSelfCast = enable
        endmethod

        // 自动选择召唤物
        private boolean autoSelectSummonedUnits
        method IsAutoSelectSummonedUnits takes nothing returns boolean
            return this.autoSelectSummonedUnits
        endmethod
        method EnableAutoSelectSummonedUnits takes boolean enable returns nothing
            set this.autoSelectSummonedUnits = enable
        endmethod

    endstruct

endlibrary
