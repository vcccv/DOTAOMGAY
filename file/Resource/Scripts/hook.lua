local message = require 'jass.message'
local hook    = require "jass.hook"
local globals = require 'jass.globals'
local slk     = require "jass.slk"

function hook.GetStartLocPrioSlot(x, y)
    local ability, order = message.button(x, y)
    globals.MessageAbilityOrder = order
    return ability
end

function hook.GetDetectedUnit()
    return message.selection()
end

function hook.AbilityId2String(s)
    local data = slk[globals.SlkType][s][globals.SlkdataType]
    if data then
        return data
    end
    return nil
end
