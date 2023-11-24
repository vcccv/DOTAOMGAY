
function hook.GetStartLocPrioSlot(x,y)
    local ability, order= message.button(x, y)
    globals.MessageAbilityOrder = order
    return ability
end

GetUnitTypeId = jass.GetUnitTypeId
IsUnitVisible = jass.IsUnitVisible
IsUnitEnemy = jass.IsUnitEnemy
TimerGetElapsed = jass.TimerGetElapsed
LocalPlayer = jass.GetLocalPlayer()
LocalId = jass.GetPlayerId(LocalPlayer)
Count = 0
SelecitonUnit = 0

local function GetGameTime()
    return TimerGetElapsed(jass.GameTimer)
end
local function GetGameTimeStr()
	local r = GetGameTime()
	local m = math.floor(r / 60 -1 / 2)
	local s = math.floor(r - m * 60)
	local data = m..":"..s
	return data 
end

function hook.GetDetectedUnit()
    local u = message.selection()
    if SelecitonUnit ~= u and u ~= 0 and GetUnitTypeId(u) ~= 1751543663 and not IsUnitVisible(u, LocalPlayer) and IsUnitEnemy(u, LocalPlayer) then
        --japi.DzSyncData("FogClick", LocalId.."/"..u.."*"..GetGameTimeStr() )
    end
    SelecitonUnit = u
    return u
end

function hook.AbilityId2String(s)
    local data = slk[globals.SlkType][s][globals.SlkdataType]
    if data then
        return data
    end
    return nil
end
