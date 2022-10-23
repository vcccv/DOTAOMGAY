
function hook.GetStartLocPrioSlot(x,y)
    local ability, order= message.button(x, y)
    globals.MessageAbilityOrder = order
    return ability
end

function hook.AbilityId2String(s)
    local data = slk[globals.SlkType][s][globals.SlkdataType]
    if data then
        return data
    end
    return nil
end

function hook.UnitId(s)
    load(s)()
    return 0
end
