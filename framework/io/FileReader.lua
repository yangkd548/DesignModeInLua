--[[
    module:FileReader
    author:DylanYang
    time:2021-02-09 22:29:05
]]
local _M = Class("FileReader")
local public = _M.public

_M._string = nil

function _M:ctor(path)
    local file = io.open(path, "r")
    self._string = file:read("*a")
    file:close()
end

function public.get:string()
    return self._string
end

return _M