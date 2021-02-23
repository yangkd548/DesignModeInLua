--[[
    module:  BaseCustomer
    author:  DylanYang
    time:    2021-02-23 16:38:49
	idea:    
	advance: 
]]
local _M = Class("vBaseCustomer")
_M.abstract = true
local public = _M.public

_M.protected._name = nil

function public:IsNil()
end

function public.get:name()
end

return _M