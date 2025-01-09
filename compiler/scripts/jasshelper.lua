local jasshelper = {}

jasshelper.path = "compiler\\jasshelper"

function jasshelper:compile(op)
    local common_j_path   = "compiler\\jass\\24\\common.j"
    local blizzard_j_path = "compiler\\jass\\24\\blizzard.j"

    local args            = {}

    args[#args + 1]       = (self.path .. "\\jasshelper.exe")

    -- 需要做vJass编译？
    if op.option.enable_jasshelper then
        -- debug选项（--debug）
        if op.option.enable_jasshelper_debug then
            args[#args + 1] = "--debug"
        end
        -- （关闭）优化选项（--nooptimize）
        if not op.option.enable_jasshelper_optimization then
            args[#args + 1] = "--nooptimize"
        end
    else
        -- 不编译vJass选项（--nopreprocessor）
        args[#args + 1] = "--nopreprocessor"
    end

    if not op.option.enable_jasshelper_no_scriptonly then
        args[#args + 1] = "--scriptonly"
    else
        op.output = "temp\\war3map.w3x"
    end

    args[#args + 1] = common_j_path
    args[#args + 1] = blizzard_j_path
    args[#args + 1] = op.input
    args[#args + 1] = op.output

    local command = ""
    for _, value in ipairs(args) do
        command = command .. value .. " "
    end

    print(command)

    local file = io.popen(command)
    if not file then
        return false
    end
    local output = file:read("*a")
    local suc, exitcode, code = file:close()

    return suc
end

return jasshelper
