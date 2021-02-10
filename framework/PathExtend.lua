--[[
    module : BaseExtend
    author : DylanYang
    time : 2020-11-10 10:54
    purpose : Is is used to expand the function of path.
]]
local NullFunc = function() end
function os.GetCurDir()
    local path = debug.getinfo(2).source
    path = string.sub(path, 2, -1)
    path = string.match(path, "^(.*)\\")
    return string.gsub(path,'\\','/')
end

function os.GetRunDir()
    os.execute("cd > cd.tmp")
    local f = io.open("cd.tmp", r)
    local cwd = f:read("*a")
    f:close()
    os.remove("cd.tmp")
    --Remove the last "\n"
    return string.sub(cwd, 1, -2)
end