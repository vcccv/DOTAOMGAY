local compiler = require "compiler.scripts"

local function execute_cmd(args)
    local command = ""
    print("execute_cmd")
    for _, value in ipairs(args) do
        command = command .. value .. " "
    end
    print(command)
    return os.execute(command)
end

local function init()
    compiler:compile("scripts")

    -- 打包地图

    local args

    local resource_dir = [["resource"]]
    local map_dir      = [["map"]]
    local temp_dir     = [["logs\\TempWar3Map"]]

    ---- 复制资源文件
    --args = {}
    --args[#args + 1] = ("robocopy ")
    --args[#args + 1] = resource_dir
    --args[#args + 1] = temp_dir
    --args[#args + 1] = "/XD"
    --args[#args + 1] = map_dir
    --args[#args + 1] = "/E /NFL /NDL /NJH /NJS"
    --print(execute_cmd(args))
--
    ---- 复制脚本/配置文件
    --args = {}
    --args[#args + 1] = ("robocopy ")
    --args[#args + 1] = map_dir
    --args[#args + 1] = temp_dir
    --args[#args + 1] = "/E /NFL /NDL /NJH /NJS"
    --print(execute_cmd(args))

    args = {}
    args[#args + 1] = ("copy")
    args[#args + 1] = [["war3map.w3x"]]
    args[#args + 1] = [["logs\\temp.w3x"]]
    if not execute_cmd(args) then
        print("返回了2")
        return
    end

    --args = {}
    --args[#args + 1] = ("copy")
    --args[#args + 1] = [["logs\\outputwar3map.j"]]
    --args[#args + 1] = [["logs\\war3map.j"]]
    --if not execute_cmd(args) then
    --    print("返回了2")
    --    return
    --end

    args = {}
    args[#args + 1] = ("compiler\\mpqeditorhhb\\MPQEditor.exe")
    args[#args + 1] = "add"
    args[#args + 1] = [["logs\\temp.w3x"]]
    args[#args + 1] = resource_dir
    args[#args + 1] = "/c"
    args[#args + 1] = "/auto"
    args[#args + 1] = "/r"

    args[#args + 1] = "&&"

    args[#args + 1] = ("compiler\\mpqeditorhhb\\MPQEditor.exe")
    args[#args + 1] = "add"
    args[#args + 1] = [["logs\\temp.w3x"]]
    args[#args + 1] = map_dir
    args[#args + 1] = "/c"
    args[#args + 1] = "/auto"
    args[#args + 1] = "/r"

    args[#args + 1] = "&&"
    args[#args + 1] = ("compiler\\mpqeditorhhb\\MPQEditor.exe")
    args[#args + 1] = "add"
    args[#args + 1] = [["logs\\temp.w3x"]]
    args[#args + 1] = [["logs\\outputwar3map.j"]]
    args[#args + 1] = [["war3map.j"]]
    args[#args + 1] = "/c"
    args[#args + 1] = "/auto"
    --args[#args + 1] = "/r"

    if not execute_cmd(args) then
        print("[error] MPQEditor -add")
        return
    end

    args = {}
    args[#args + 1] = ("bin\\YDWEConfig.exe")
    args[#args + 1] = "-launchwar3"
    args[#args + 1] = "-loadfile"
    args[#args + 1] = [["logs\\temp.w3x"]]

    local command = ""
    for _, value in ipairs(args) do
        command = command .. value .. " "
    end
    print(command)
    return os.execute(command)
end

init()
