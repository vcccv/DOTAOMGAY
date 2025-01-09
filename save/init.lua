local compiler = require "compiler.scripts"

local function init()
    local folder_path = "temp"
    if not folder_exists(folder_path) then
        os.execute("mkdir " .. folder_path)
    end
    copy_file("war3map.w3x", "temp\\war3map.w3x")

    compiler:compile("scripts")

    local args      = {}

    args[#args + 1] = ("bin\\YDWEConfig.exe")
    args[#args + 1] = "-launchwar3"
    args[#args + 1] = "-loadfile"
    args[#args + 1] = "temp\\war3map.w3x"

    local command   = ""
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

init()
