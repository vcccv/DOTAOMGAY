local wave = {}

wave.path = "compiler\\wave"

-- 预处理代码
-- op.input - 输入文件路径
-- op.option - 预处理选项，table，支持的值有
-- 	runtime_version - 表示魔兽版本
-- 	enable_jasshelper_debug - 布尔值，是否是调试模式
-- 返回：number, info, path - 子进程返回值；预处理输出信息；输出文件路径
function wave:do_compile(op)
    local args = {}
    args[#args + 1] = (self.path .. "\\Wave.exe")
    args[#args + 1] = string.format('--output=%s', op.output)
    args[#args + 1] = string.format('--include=%s', op.include)
    args[#args + 1] = string.format('--sysinclude=%s', "scripts\\")
    args[#args + 1] = "--extended"
    args[#args + 1] = "--c99"
    args[#args + 1] = "--preserve=2"
    args[#args + 1] = "--line=0"
    args[#args + 1] = "--timer"
    args[#args + 1] = op.input

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

    -- 打开文件以读取内容
    file = io.open(op.output, "r")
    if not file then
        return false
    end
    local content = file:read("a")
    file:close()

    ---- 使用 string.gsub 替换 YDNL 为换行符
    --local content, count = content:gsub("YDNL", "\n")

    -- 重新打开文件以写入修改后的内容
    file = io.open(op.output, "w")
    if not file then
        return false
    end
    file:write(content)
    file:close()

    return code
end

function wave:compile(op)
    local f = io.open(op.input, "a+b")
    if f then
        f:write("/**/\r\n")
        f:close()
    end
    local exit_code, out, err = self:do_compile(op)

    -- 退出码0代表成功
    if exit_code ~= 0 then
        return false
    end

    print("wave completed.")

    return true
end

return wave
