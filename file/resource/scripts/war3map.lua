
local runtime        = require 'jass.runtime'
--将句柄等级设置为0(number)
runtime.handle_level = 0

--关闭等待
runtime.sleep        = false

local globals              = require 'jass.globals'

--require "jass.console".enable = true

local function InitUpdateLogStr()
	globals.UpdateLogStr = [[
	 Dota OMG 2.00
	 - 现在近战变身为远程，如果目标在射程范围并且处于攻击命令时将会直接攻击。
	 - 修正了|Cffffff00魔龙枪|r拆分后，会永久提供射程的bug。
	 - 修正了在使用分身技能时，携带射程增加的物品时会导致本体射程错误的bug。
	 - 修正了无法获取幻象单位主属性的bug，连带修正一系列bug。
	 
	 - 添加查看友军单位技能功能，现在Alt点击物品也可以发送提示信息了。
	 - 修正|CFFFF8000月刃|r弹射逻辑问题。
	 - |CFFFF8000窒息之刃|r附带一次普通攻击效果(暂不触发暴击 以后再说)。
	 - |CFFFF8000幽鬼之刃|r和|CFFFF8000织网|r寻路Bug修复。

	 - 修复天灾下路远程兵营被拆后 近卫上路也会刷新高级投刃车的bug
	 - 偷塔保护每秒回血90/s > 180/s
	 - 基地现在能正确防偷塔 基地回血 20/s > 5/s
	 - 修复|CFFFF8000血棘|rBUFF不能驱散
	 - |Cffffff00阿托斯之棍|r增加弹道 弹道速度为1900
	 
	 - 现在默认指令为-sdd3s6fnabborcdusculsp
	 ]]
end


local function main()
	globals.CurrentMonth = tonumber(os.date('%m'))
	InitUpdateLogStr()
	require 'scripts.message'
	require 'scripts.hook'
end

main()
