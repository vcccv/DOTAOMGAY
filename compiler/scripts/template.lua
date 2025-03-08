local load = load
local string = string
local table = table
local cEqual = string.byte('=', 1)

local function do_precompile(code)
    local c = {"local __JASS__={} "}
    local startPos
    local endPos = -1
    while true do
        startPos = code:find('<?', endPos + 2, true)
        if not startPos then
            break
        end
        c[#c+1] = ("__JASS__[#__JASS__+1]=%q "):format(code:sub(endPos + 2, startPos - 1))

        endPos = code:find('?>', startPos + 2, true)
        if not endPos then
            endPos = startPos
            break
        end
        if code:byte(startPos + 2) ~= cEqual then
            c[#c+1] = ("%s "):format(code:sub(startPos + 2, endPos - 1))
        else
            c[#c+1] = ("__JASS__[#__JASS__+1]=%s "):format(code:sub(startPos + 3, endPos - 1)) 
        end
    end
    c[#c+1] = ("__JASS__[#__JASS__+1]=%q "):format(code:sub(endPos + 2))
    c[#c+1] = "return table.concat(__JASS__)"
    return table.concat(c)
end

local function do_compile(code)
	local ok, res = pcall(do_precompile, code)
	if not ok then
		return false, res
	end
	local f, err = load(res, '@3_wave.j', 't')
	if not f then
		return f, err
	end
	ok, res = xpcall(f, debug.traceback)
	if not ok then
		local pos = res:find("[C]: in function 'xpcall'", 1, true)
		if pos then
			res = res:sub(1, pos-1)
		end
    	return false, res
	end
    return true, res
end

local template = {}

function template:compile(op)
	local code, err = io.load(op.input)
	if not code then
		print("Template read " .. op.input .. ". Error: " .. err)
		return false
	end
	local ok, res = do_compile(code)
	if not ok then
		print("Template error processing: " .. tostring(res))
		return false
	end

---@diagnostic disable-next-line: redefined-local
	local ok, err = io.save(op.output, res)
	if not ok then
		print("Template write " .. op.output .. ". Error: " .. err)
		return false
	end

	return true
end

return template
