--[[
    module:FileReader
    author:DylanYang
    time:2021-02-09 22:29:05
]]
local _M = Class("FileReader")
local public = _M.public

_M._string = nil

function _M:ctor(filename)
    --
    self._string = "xxxxxx"
end

function public.get:string()
    return self._string
end

return _M