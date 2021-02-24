--[[
    module:  DependentB
    author:  DylanYang
    time:    2021-02-24 21:20:35
	idea:    
	advance: 
]]
local _M = Class("DependentB")
local public = _M.public

_M._data = nil

function public.set:data(data)
    self._data = data
end

function public.get:data()
    return self._data
end

return _M