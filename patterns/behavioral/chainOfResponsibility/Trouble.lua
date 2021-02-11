--[[
    module:Trouble
    author:DylanYang
    time:2021-02-11 17:33:47
]]
local _M = Class("Trouble")
local public = _M.public

_M._number = nil

function _M:ctor(number)
    self._number = number
end

function public.get:number()
    return self._number
end

return _M