
local runtime        = require 'jass.runtime'
--将句柄等级设置为0(number)
runtime.handle_level = 0

--关闭等待
runtime.sleep        = false

local globals              = require 'jass.globals'

--require "jass.console".enable = true

local function InitUpdateLogStr()
	globals.UpdateLogStr = [[
	 Dota OMG 1.33
	 - 更改|CFFFF8000属性附加|r。
	 - 修正|CFFFF8000肉钩|r和|Cffffff00回音战刃|r的bug。
	 - 现在反补信使不再获得经验。

	 Dota OMG 1.34
	 - 修复刷钱BUG
	 - 修复变身技能触发2次玲珑心的BUG
	 - 修复|CFFFF8000幽冥爆轰|r和|CFFFF8000火焰风暴|r命令ID相同的错误
	 - 因为改变了命令ID现在|CFFFF8000幽冥爆轰|r和|CFFFF8000寄生种子|r可以一起选择
	 - 修复|CFFFF8000战斗饥渴|r在某些情况下导致地图崩溃
	 - 尝试修复|CFFFF8000刚毛后背|r某些情况下导致的地图崩溃
	 - 现在-ikey指令对|CFFFF8000伤残恐惧生效|r
	 - 新增一个与迷你修理者对应的信使

	 Dota OMG 1.35
	 - 修复因为修复上版本bug导致的bug
	 ]]
end


local function main()
	globals.CurrentMonth = tonumber(os.date('%m'))
	InitUpdateLogStr()
	require 'scripts.message'
	require 'scripts.hook'
end

main()
