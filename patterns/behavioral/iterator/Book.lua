--[[
    module:Book
    author:DylanYang
    time:2021-02-18 10:51:26
]]
local _M = Class("Book")
local public = _M.public

_M._name = nil

function _M:ctor(name)
    self._name = name
end

function public.get:name()
    return self._name
end

return _M