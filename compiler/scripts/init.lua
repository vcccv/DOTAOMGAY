---@diagnostic disable-next-line: lowercase-global
function copy_file(src, dest)
    local input = io.open(src, "rb") -- 以二进制模式打开源文件
    if not input then
        return false, "Failed to open source file"
    end

    local output = io.open(dest, "wb") -- 以二进制模式打开目标文件
    if not output then
        input:close()
        return false, "Failed to open destination file"
    end

    local content = input:read("*all") -- 读取源文件内容
    output:write(content)              -- 写入目标文件

    input:close()
    output:close()

    return true -- 文件复制成功
end

---@diagnostic disable-next-line: lowercase-global
function has_arg(arg, target)
    for _, v in ipairs(arg) do
        if v == target then
            return true
        end
    end
    return false
end

package.path = package.path .. ";.\\compiler\\scripts\\?.lua"
local wave = require "wave"
local jasshelper = require "jasshelper"

local function update_script(map_path, input, process_function)
    copy_file(map_path .. '\\war3map.j', input)
    local output = process_function(input)
    if not output then
        error("Compile failed.")
        return false
    end
    --copy_file(output, map_path .. '\\war3map.j')
    return true
end

local function make_option()
    local option = {}
    -- 是否启用JassHelper
    option.enable_jasshelper = has_arg(arg, "--jasshelper")
    -- 是否是调试模式
    option.enable_jasshelper_debug = has_arg(arg, "--jasshelper_debug")
    -- 是否优化地图
    option.enable_jasshelper_optimization = has_arg(arg, "--jasshelper_optimization")
    -- 是否直接测试
    option.enable_jasshelper_no_scriptonly = has_arg(arg, "--jasshelper_no_scriptonly")
    return option
end

local compiler = {}

function compiler:compile(map_path)
    local option = make_option()

    local compile_t = {
        option = option,
        map_path = map_path,
        log = "logs",
    }

    return update_script(map_path, compile_t.log .. "\\1_war3map.j",
        function(input)
            compile_t.input = input

            -- Wave预处理
            compile_t.output = compile_t.log .. "\\2_wave.j"
            if not wave:compile(compile_t) then
                return
            end
            compile_t.input = compile_t.output

            collectgarbage 'collect'

            compile_t.input = compile_t.output
            compile_t.output = compile_t.log .. "\\3_vjass.j"
            if not jasshelper:compile(compile_t) then
                return
            end
            return compile_t.output
        end
    )
end

if arg[1] == "script" then
    compiler:compile("scripts")
end

return compiler
