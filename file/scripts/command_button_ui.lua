
local frame_is_show = {}
local ability_cool_text = {}
local ability_cost_text = {}
local unit_cost_text = {}
local unit_cost_backdrop = {}
local ability_cost_backdrop = {}
local hotkey_text = {}
local hotkey_backdrop = {}
local item_cool_text = {}

LocalHashTable = globals.LocalHashTable
HotKeyStringHash = globals.HotKeyStringHash

local command_hotkey = {}
command_hotkey[851983] = 'A'
command_hotkey[851972] = 'S'
command_hotkey[851993] = 'H'
command_hotkey[851986] = 'M'
command_hotkey[851990] = 'P'
command_hotkey[852000] = 'O'
command_hotkey[851975] = 'ESC'
command_hotkey[851976] = 'ESC'

local function init()
    local game_ui = japi.DzGetGameUI()
    japi.DzLoadToc("ui\\command_ui.toc")
    for i=0, 11 do
        local x = math.floor(i / 3)
        local y = math.floor(i % 3)
        local ability_relative_frame = japi.DzFrameGetCommandBarButton(y, x)
        ability_cool_text[i] = japi.DzCreateFrame("CommandButtonCoolDownText", game_ui, i)
        ability_cost_backdrop[i] = japi.DzCreateFrame("CommandButtonManaCostBackDrop", game_ui, i)
        ability_cost_text[i] = japi.DzCreateFrame("CommandButtonManaCostText", ability_cost_backdrop[i], i)
        unit_cost_backdrop[i] = japi.DzCreateFrame("CommandButtonUnitCostBackDrop", game_ui, i)
        unit_cost_text[i] = japi.DzCreateFrame("CommandButtonUnitCostText", unit_cost_backdrop[i], i)
        hotkey_backdrop[i] = japi.DzCreateFrame("CommandButtonHotKeyBackDrop", game_ui, i)
        hotkey_text[i] = japi.DzCreateFrame("CommandButtonHotKeyText", hotkey_backdrop[i], i)

        japi.DzFrameSetPoint(ability_cool_text[i], 4, ability_relative_frame, 4, 0., 0.)
        japi.DzFrameSetPoint(ability_cost_backdrop[i], 6, ability_relative_frame, 6, - 0.001, - 0.001)
        japi.DzFrameSetPoint(unit_cost_backdrop[i], 6, ability_relative_frame, 6, - 0.001, - 0.001)
        japi.DzFrameSetPoint(hotkey_backdrop[i], 0, ability_relative_frame, 0, - 0.001, 0.001)

        japi.DzFrameSetPoint(ability_cost_text[i], 4, ability_cost_backdrop[i], 4, 0., 0.)
        japi.DzFrameSetPoint(unit_cost_text[i], 4, unit_cost_backdrop[i], 4, 0., 0.)
        japi.DzFrameSetPoint(hotkey_text[i], 4, hotkey_backdrop[i], 4, 0., 0.)

        japi.DzFrameSetTexture(ability_cost_backdrop[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0)
        japi.DzFrameSetTexture(unit_cost_backdrop[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0)
        japi.DzFrameSetTexture(hotkey_backdrop[i], "ui\\widgets\\console\\human\\commandbutton\\human-button-lvls-overlay.blp", 0)

        japi.DzFrameShow(ability_cool_text[i], false)
        japi.DzFrameShow(ability_cost_backdrop[i], false)
        japi.DzFrameShow(unit_cost_backdrop[i], false)
        japi.DzFrameShow(hotkey_backdrop[i], false)
        
    end

    for i=0, 5 do
        local item_relative_frame = japi.DzFrameGetItemBarButton(i)
        item_cool_text[i] = japi.DzCreateFrame("ItemButtonCoolDownText", game_ui, i)
        japi.DzFrameSetPoint(item_cool_text[i], 4, item_relative_frame, 4, 0., 0.)
        japi.DzFrameShow(item_cool_text[i], false)
    end

end

local function show_frame(frame, flag)
    if flag and not frame_is_show[frame] then
        japi.DzFrameShow(frame, true)
        frame_is_show[frame] = true
    elseif not flag and frame_is_show[frame] then
        japi.DzFrameShow(frame, false)
        frame_is_show[frame] = false
    end
end

--获取物编数据
--	数据项名称
--	[如果未找到,返回的默认值]
local function get_slk(name, id, default)
	local unit_data = slk.unit[id]
	if not unit_data then
		return default
	end
	local data = unit_data[name]
	if data == nil then
		return default
	end
	if type(default) == 'number' then
		return tonumber(data) or default
	end
	return data
end

local function get_ability_slk(name, id, default)
    local ability_data = slk.ability[id]
    if not ability_data then
		return default
	end
    local data = ability_data[name]
    if data == nil then
        return default
    end
    if type(default) == 'number' then
		return tonumber(data) or default
	end
    return data
end

local function get_item_slk(name, id, default)
    local item_data = slk.item[id]
    if not item_data then
		return default
	end
    local data = item_data[name]
    if data == nil then
        return default
    end
    if type(default) == 'number' then
		return tonumber(data) or default
	end
    return data
end

function hook.GetDetectedUnit()
    local u = message.selection()
    if not u then
        return nil
    end
    for i=0, 11 do 
        local x = math.floor(i / 3)
        local y = math.floor(i % 3)
        local id, order = message.button(x, y)
        if Config.showHotKey and id == 1098081644 then -- 购买
            --[[local cost = get_slk("goldcost", order, 0)
            if cost > 0 then
                show_frame(unit_cost_backdrop[i], true)
                japi.DzFrameSetText(unit_cost_text[i], cost)
            else
                show_frame(unit_cost_backdrop[i], false)
            end]]--
            local hotkey = get_slk("Hotkey", order, false)
            if hotkey then
                show_frame(hotkey_backdrop[i], true)
                japi.DzFrameSetText(hotkey_text[i], hotkey)
            else
                show_frame(hotkey_backdrop[i], false)
            end
        elseif Config.showHotKey and command_hotkey[order] then
            show_frame(hotkey_backdrop[i], true)
            show_frame(ability_cool_text[i], false)
            show_frame(ability_cost_backdrop[i], false)
            japi.DzFrameSetText(hotkey_text[i], command_hotkey[order])
        elseif Config.showHotKey and id == 1095263602 then
            local ability = EXGetUnitAbility(u, order)
            if ability ~= 0 then
                local hotkey = EXGetAbilityDataInteger(ability, 1, 202)
                if hotkey ~= 0 then
                    show_frame(hotkey_backdrop[i], true)
                    japi.DzFrameSetText(hotkey_text[i], string.char(hotkey))
                else
                    show_frame(hotkey_backdrop[i], false)
                end
            else
                local hotkey = LoadInteger(LocalHashTable, order, HotKeyStringHash)
                if hotkey ~= 0 then
                    show_frame(hotkey_backdrop[i], true)
                    japi.DzFrameSetText(hotkey_text[i], string.char(hotkey))
                else
                    local hotkey = get_ability_slk("ResearchHotkey", order, false)
                    if hotkey ~= 0 then
                        show_frame(hotkey_backdrop[i], true)
                        japi.DzFrameSetText(hotkey_text[i], hotkey)
                    else
                        show_frame(hotkey_backdrop[i], false)
                    end
                end
            end
            show_frame(ability_cool_text[i], false)
            show_frame(ability_cost_backdrop[i], false)
        elseif id ~= 0 then
            local ability = EXGetUnitAbility(u, id)
            if ability ~= 0 then
                if Config.showManaCost then
                    local cost = EXGetAbilityDataInteger(ability, GetUnitAbilityLevel(u, id), 104)
                    if cost > 0 then
                        show_frame(ability_cost_backdrop[i], true)
                        japi.DzFrameSetText(ability_cost_text[i], cost)
                    else
                        show_frame(ability_cost_backdrop[i], false)
                    end
                else
                    show_frame(ability_cost_backdrop[i], false)
                end
                if Config.showCoolDown then
                    local cool = EXGetAbilityState(ability, 1)
                    if cool > 0 then
                        show_frame(ability_cool_text[i], true)
                        if cool < 10 then
                            japi.DzFrameSetText(ability_cool_text[i], string.format("%.1f", cool))
                        else
                            japi.DzFrameSetText(ability_cool_text[i], math.floor(cool) + 1)
                        end
                    else
                        show_frame(ability_cool_text[i], false)
                    end
                else
                    show_frame(ability_cool_text[i], false)
                end
                if Config.showHotKey then
                    local hotkey = EXGetAbilityDataInteger(ability, 1, 200)
                    if hotkey ~= 0 then
                        show_frame(hotkey_backdrop[i], true)
                        japi.DzFrameSetText(hotkey_text[i], string.char(hotkey))
                    else
                        show_frame(hotkey_backdrop[i], false)
                    end
                    show_frame(unit_cost_backdrop[i], false)
                else
                    show_frame(hotkey_backdrop[i], false)
                end
            else
                show_frame(ability_cool_text[i], false)
                show_frame(ability_cost_backdrop[i], false)
                show_frame(unit_cost_backdrop[i], false)
                show_frame(hotkey_backdrop[i], false)
            end
        else
            show_frame(ability_cool_text[i], false)
            show_frame(ability_cost_backdrop[i], false)
            show_frame(unit_cost_backdrop[i], false)
            show_frame(hotkey_backdrop[i], false)
        end
    end
    --[[-- 物品技能
    local size = jass.UnitInventorySize(u)
    for i = 0, size do
        local id = get_item_slk('cooldownID', jass.GetItemTypeId(jass.UnitItemInSlot(u, i)), false)
        if id then
            local ability = EXGetUnitAbility(u, id)
            print(ability)
            if ability ~= 0 then
                local cool = EXGetAbilityState(ability, 1)
                if cool > 0 then
                    show_frame(item_cool_text[i], true)
                    japi.DzFrameSetText(item_cool_text[i], math.floor(cool) + 1)
                else
                    show_frame(item_cool_text[i], false)
                end
            end
        else
            show_frame(item_cool_text[i], false)
        end
    end]]--
    
    return u
end

init()
