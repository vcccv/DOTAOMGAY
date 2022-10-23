
--本地命令
LoadInteger = jass.LoadInteger
GetUnitAbilityLevel = jass.GetUnitAbilityLevel
GetObjectName = jass.GetObjectName
GetUnitTypeId = jass.GetUnitTypeId
GetOwningPlayer = jass.GetOwningPlayer
GetPlayerName = jass.GetPlayerName
UNIT_STATE_MANA = jass.UNIT_STATE_MANA
GetPlayerState = jass.GetPlayerState

EXGetAbilityState = japi.EXGetAbilityState
EXGetUnitAbility = japi.EXGetUnitAbility
GetUnitState = japi.GetUnitState
EXGetAbilityDataInteger = japi.EXGetAbilityDataInteger

--是否是目标选择界面
local function is_select_ui()
	--检查右下角是不是取消键
	local ability, order = message.button(3, 2)
	return order == 0xD000B
end

--是否是魔法书界面
local function is_book_ui()
	--检查右下角是不是返回键
	local ability, order = message.button(3, 2)
	return order == 0xD0007
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


local function get_owning(u)
    return jass.GetLocalPlayer() == GetOwningPlayer(u)
end

local function pick_hero(ability ,order, u)
    local b = ability == 1098085732
    if b then
        if get_owning(u) then
            if order == 1747993652 then
                local i = jass.TimerGetRemaining(globals.PlayerBuyback_Timer)
                globals.tip_string = '买活 > 冷却中'..'( '..math.floor(i)..' )'
            elseif order >= 1747990841 and order <= 1747992922 then
                local gold = GetPlayerState(jass.GetLocalPlayer(), jass.PLAYER_STATE_RESOURCE_GOLD)
                local cost = get_slk("goldcost", order, 0)
                if gold > cost then
                    globals.tip_string = '买活 > 准备就绪'
                else
                    gold = cost - gold
                    globals.tip_string = '无法买活 > 我还需要 |c00FFFF00'..gold..'|r 黄金'  
                end
            else
                globals.tip_string = GetObjectName(order)..' > 已准备就绪'
            end
        else
            if order == 1747989059 or order == 1848718137 then
                globals.tip_string = '我想要购买 > '..GetObjectName(order)
            else
                globals.tip_string = GetPlayerName(GetOwningPlayer(u))..' > '..GetObjectName(order)..' > 已准备就绪'
            end
        end
    end
    return b
end



-- NeedHeroXP=200,500,900,1400,2000,2600,3200,4400,5400,6000,8200,9000,10400,11900,13500,15200,17000,18900,20900,23000,25200,27500,29900,32400
-- 简直是那没事了 直接穷举有点憨批
function Split(szFullString, szSeparator)  
    local nFindStartIndex = 1  
    local nSplitIndex = 1  
    local nSplitArray = {}  
    while true do
        local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
        if not nFindLastIndex then  
            nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
        break  
        end  
       nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
       nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
       nSplitIndex = nSplitIndex + 1  
    end  
    return nSplitArray  
end

-- 如果 英雄等级 > 25就拉倒吧 学不了技能就不管
local NeedHeroXPList = Split(slk.misc.Misc.NeedHeroXP, ',')

local function bCanLearnSkill(order,u, level)
    local s
    local reqLevel = get_ability_slk("reqLevel", order, 1)
    local levelSkip = get_ability_slk("levelSkip", order, 1)
    if levelSkip == 1 then
        levelSkip = 2
    end
    local heroLevel = jass.GetHeroLevel(u)
    local require = ( level * levelSkip + reqLevel ) - heroLevel
    if require > 0 then
        s = '我还需要升'..tostring(require)..'级才能学习 > '
    else
        if jass.GetHeroSkillPoints(u) > 0 then
            s = '我准备学习技能 > '
        else
            local exp = math.floor(NeedHeroXPList[heroLevel] - jass.GetHeroXP(u))
            s = '我还需要|c00FFFF00'..exp..'|r点经验才能学习 > '
        end
    end
    return s
end

local function learn_skill(ability,order,u)
    local b = ability == 1095263602 
    if b then
        local s = ' [1]'
        local i = GetUnitAbilityLevel(u,order)
        if i > 0 then
            s = ' ['..tostring(i+1)..']'
        end
        if get_owning(u) then

            globals.tip_string = bCanLearnSkill(order, u, i)..GetObjectName(order)..s
        else
            globals.tip_string = GetPlayerName(GetOwningPlayer(u))..' > 应该学习 > '..GetObjectName(order)..s
        end
    end
    return b
end

local function buy_item(ability,order)
    local b = ability == 1098081644 
    if b then
        local gold = GetPlayerState(jass.GetLocalPlayer(), jass.PLAYER_STATE_RESOURCE_GOLD)
        local cost = get_slk("goldcost", order, 0)
        if gold > cost then
            globals.tip_string = '我想要购买 > '..GetObjectName(order)
        else
            gold = cost - gold
            globals.tip_string = '我还需要 |c00FFFF00'..gold..'|r 黄金购买 > '..GetObjectName(order)
        end
    end
    return b
end

--技能名字和技能等级
local function get_ability_str(u,ability)
    local i = get_ability_slk("levels",ability, 1)
    local s = ''
    local s2 = ''
    if not get_owning(u) then
        s2 = GetPlayerName(GetOwningPlayer(u))..' > '
    end
    --如果最大技能等于大于1则显示等级
    if i > 1 then
        s = s..' ['..tostring(GetUnitAbilityLevel(u,ability))..']'
    end
    return s2..GetObjectName(ability)..s..' > '
end

local function GetUnitMana (u)
    local i = GetUnitState(u,UNIT_STATE_MANA)
    return math.floor(i)
end

local function get_d (u,ability)
    if ability == 1364209990 then
        local i = LoadInteger( globals.K, u, 31 )
        if i > 0 then
            return '已窃取敏捷 ( '..math.abs(i)..' )'
        end
    elseif ability == 1364209971 then
        local i = LoadInteger( globals.P, u, 1093678660 )
        if i > 0  then
            return '已堆积力量 ( '..math.abs(i)..' )'
        end
    elseif ability == 1364210000 then
        local i = LoadInteger( globals.HY, u, 1093813557 )
        if i > 0 then
            return '已叠加次数 ( '..math.abs(i)..' )'
        end
    end
    return '已准备就绪'
end

--提示字符
local function ability_tip(u,ability)
    local ab = EXGetUnitAbility(u,ability)
    local i = EXGetAbilityState(ab,1)
    local ability_string = get_ability_str(u,ability)
    local mana = GetUnitMana(u) - EXGetAbilityDataInteger(ab,GetUnitAbilityLevel(u,ability),104)
    if i > 0 then
        globals.tip_string = ability_string..'冷却中 ( '..math.floor(i)..' )'
    elseif mana < 0 then
        globals.tip_string = ability_string..'魔法不足 ( 还需要'..math.abs(mana)..'点 )'
    elseif mana >= 0 and i == 0 then
        globals.tip_string = ability_string..get_d(u,ability)
    end
    return true
end

--本地消息
function message.hook(msg)
    if msg.type == 'mouse_ability' then
        if globals.DownAlt then
            return false
        end
        local ability = msg.ability
        if ability == 1364209990 then
            return false
        end
        if ability == 1364209971 then
            return false
        end
        if ability == 1364210000 then
            return false
        end
    end
    return true
end

function hook.SetStartLocPrioCount(x,y)

    local ability, order = message.button(x, y)
    globals.tip_string = ''

    if ability == 0 then
        return
    end

    local u = message.selection()
    if u == 0 then
        return
    end

    if order == 0xD000B or order == 852000 then
        return
    end

    -- 学习技能
    if learn_skill(ability, order, u) then
        return
    end

    -- 购买物品
    if buy_item(ability, order) then
        return
    end

    -- 选择英雄
    if pick_hero(ability, order, u) then
        return
    end

    -- 技能提示
    if ability_tip(u, ability) then
        return
    end

end

