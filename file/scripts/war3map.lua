
local runtime	= require 'jass.runtime'
--将句柄等级设置为0(number)
runtime.handle_level = 0

--关闭等待
runtime.sleep = false

japi = require 'jass.japi'
jass = require 'jass.common'

message = require 'jass.message'
globals = require 'jass.globals'
hook = require "jass.hook"
slk = require "jass.slk"

--require "jass.console".enable = true

Config = {}
Config.showCoolDown = true
Config.showHotKey = false
Config.showManaCost = false

local function InitUpdateLogStr()
	
	globals.UpdateLogStr = [[ Dota OMG 1.34
	最大规模的改动，完全重写伤害流程，统一幻象系统，但绝对会有前所未有的大量bug。
	重写一些技能，并优化和合并函数，尽量让状态和效果都统一而不是互相冲突排斥。
	- 现在近战变成远程，如果目标在射程范围并且处于攻击命令时将会直接攻击。
	- 修正了|Cffffff00魔龙枪|r拆分后，会永久提供射程的bug。
	- 修正了在使用分身技能时，携带射程增加的物品时会导致本体射程错误的bug。
	- 修正了无法获取幻象单位主属性的bug，连带修正一系列bug。
	- 重写了|Cffffff00飓风长戟|r，现在逻辑正确了。
	- |Cffffff00幽灵权杖|r现在不能在魔法免疫状态下使用。
	- 重写|CFFFF8000噬魂|r，现在噬魂会抽取拥有魔法免疫的友军生命值(对敌人依旧计算魔免)，并可以奶队友的墓碑了。        -- 参考Dota2Wiki
	- 重写|CFFFF8000奔袭冲撞|r，现在可以对玩家可以控制的单位生效，而不是之前的仅对英雄。        -- 参考Dota2Wiki
	- 重写|CFFFF8000獠牙冲刺|r，现在不再会打断命令队列，不再拥有高台限制。        -- 参考Dota2Wiki
	- 重写|CFFFF8000决斗|r，不再强制解除目标的缴械状态(例如|CFFFF8000锯齿飞轮|r和|CFFFF8000烈日炙烤|r)。
	- 重写|CFFFF8000黑洞|r，不再会打断命令队列，现在目标将沿等角螺线被黑洞往中心牵引，牵引速度为30，每秒的牵引角度为11.25°（以黑洞中心为坐标原点），并且会摧毁强制位移单位200范围内的树木。 -- 参考Dota2Wiki
	- 现在|CFFFF8000超震声波|r的缴械方式更改，修复了永久缴械bug。
	- 重写|CFFFF8000月刃|r。
	- 重写|CFFFF8000连击|r，现在该技能不再需要主动攻击才能触发，并且会触发所有攻击特效了。
	- 修正了|CFFFF8000神行百变|r在技能释放期间，作用单位依旧能攻击的bug。
	- 重写|CFFFF8000并列|r，现在本体攻击的分裂概率使用伪随机分布。
	- |CFFFF8000X标记|r现在不再能送回无敌和隐藏的单位。        -- 参考Dota2Wiki
	- |CFFFF8000无敌斩|r提供的无敌效果和|CFFFF8000相位转移|r，|CFFFF8000无影拳|r不再互相冲突。
	- 重写锁闭、沉默、缴械、相位移动、无视地形和无敌等状态，现在大部分相关技能拥有正确的计数。
	- |Cffffff00斯嘉蒂之眼|r不再强制单位的射弹速度为1500，以及射弹弧度为0.15。
	- |CFFFF8000窒息之刃|r现在可以附带一次即时攻击。
	- |CFFFF8000分裂箭|r现在范围以单位的攻击范围为标准。
	- 修复了|CFFFF8000倒影|r创造的镜像单位|CFFFF8000并列|r技能无法正确生效的问题。
	- 现在|CFFFF8000超新星|r可以正确播放降落动作。
	- 现在|CFFFF8000元素分离|r的元素都是英雄攻击与英雄护甲，并修复了神杖升级火焰没有醉拳的BUG。
	- 现在幻象的技能等级是根据被复制者而不是玩家英雄的技能等级。
	- 现在地卜师不再会有额外魔法抗性。
	- 修正了|CFFFF8000洪流|r延迟时间描述，正确延迟时间为1.6秒。
	- 现在|CFFFF8000隐匿|r的减甲效果多个独立计时，可叠加，不再有相位效果。
	- 重写全部隐身，现在可以选择多个隐身类技能。|CFFFF8000标记|r现在可以在隐身状态下释放不破隐。
	- 现在分身不再会继承|CFFFF8000永久隐身|r。
	- 现在部分有相位移动状态的隐身技能，在渐隐期间不会获得相位移动状态。
	- 统一幻象系统，并重写以下技能
	{
	  |CFFFF8000灵魂之矛|r, |CFFFF8000神行百变|r, |CFFFF8000并列|r
	  |CFFFF8000镜像|r, |CFFFF8000幻象|r, |CFFFF8000倒影|r, |CFFFF8000魔法镜像|r
	  |CFFFF8000复制|r, |CFFFF8000复制之墙|r, |CFFFF8000崩裂禁锢|r
	}
	- 一些被动技能享受冷却缩减
	{
	  |CFFFF8000勇气之霎|r, |CFFFF8000连击|r, |CFFFF8000潮汐使者|r, |CFFFF8000忍术|r
	  |CFFFF8000余震|r, |CFFFF8000星落|r, |Cffffff00回音战刃|r
	}
	- 现在部分范围性技能会计算单位的碰撞体积。
	- 现在一些对敌方作用的技能判断会有'英雄级单位'的判断。        -- 参考Dota2Wiki
	{
	 - 元素分离单位 大地 - 风暴 - 火焰
	 - 地狱火
	 - 佣兽
	 - 幻象
	}
	- 更改溅射逻辑，现在不在会有中伤害范围和小伤害范围，而是统一大伤害范围。
	{
	 - 现在单位闪避溅射主目标伤害时，不再是减少50%伤害，而是闪避。
	 - 群蛇守卫现在对175范围内造成75%的溅射伤害。
	 - 真龙形态(红龙，蓝龙)现在对300范围内造成100%的溅射伤害。
	}
	- |CFFFF8000陵卫斗篷|r现在不再提供额外护甲和魔法抗性，而是每层减少8%/12%/16%/20%的伤害，一层恢复时间4→3。
	- 现在|CFFFF8000幽冥爆轰|r和|CFFFF8000火焰雨|r不再能一起选择，因为同命令Id。
	- 幻象现在对塔伤害减少从25%增加至60%。
	- 模拟并重写全部幻象，现在不再会清除变身进度条。
	{
	 - 现在|Cffffff00幻影斧|r在使用时将提供1000码的高空视野。
	}
	- 现在单位的护甲类型将不再影响单位的魔法抗性，部分单位拥有了基础魔法抗性。
	- 基本重写伤害结算流程，绝大部分伤害流程都被改变。
	- 关于伤害结算流程后导致的一部分更改请查看专栏。
	
	- |CFFFF8000属性附加|r的跳级等级从2更改为3。
   
	游戏体验更改：
	- 增加了开局顶部信息提示。
	]]
	

end


--- 输出详尽内容
---@param value any 输出的table
---@param description string 调试信息格式
---@param nesting number | nil 输出时的嵌套层级，默认为 10
function dump(value, description, nesting)
    if type(nesting) ~= "number" then nesting = 10 end
    local lookup  = {}
    local result  = {}
    -- local traceback = string.explode("\n", debug.traceback("", 2))
    -- local str = "- dump from: " .. string.trim(traceback[3])
    local str     = "";
    local _format = function(v)
        if type(v) == "string" then
            v = "\"" .. v .. "\""
        end
        return tostring(v)
    end
    local _dump
    _dump         = function(val, desc, indent, nest, keyLen)
        desc = desc or "<var>"
        local spc = ""
        if type(keyLen) == "number" then
            spc = string.rep(" ", keyLen - string.len(_format(desc)))
        end
        if type(val) ~= "table" then
            result[#result + 1] = string.format("%s%s%s = %s", indent, _format(desc), spc, _format(val))
        elseif lookup[tostring(val)] then
            result[#result + 1] = string.format("%s%s%s = *REF*", indent, _format(desc), spc)
        else
            lookup[tostring(val)] = true
            if nest > nesting then
                result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, _format(desc))
            else
                result[#result + 1] = string.format("%s%s = {", indent, _format(desc))
                local indent2 = indent .. "    "
                local keys = {}
                local kl = 0
                local vs = {}
                for k, v in pairs(val) do
                    if k ~= "___message" then
                        keys[#keys + 1] = k
                        local vk = _format(k)
                        local vkl = string.len(vk)
                        if vkl > kl then kl = vkl end
                        vs[k] = v
                    end
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for _, k in ipairs(keys) do
                    _dump(vs[k], k, indent2, nest + 1, kl)
                end
                result[#result + 1] = string.format("%s}", indent)
            end
        end
    end
    _dump(value, description, " ", 1)
    str = str .. "\n" .. table.concat(result, "\n")
    print(str)
end

local function main()
	--dump(japi)
	globals.CurrentMonth = tonumber( os.date('%m') )
	InitUpdateLogStr()
	require 'scripts.message'
	require 'scripts.hook'
	require 'scripts.command_button_ui'
end

main()
