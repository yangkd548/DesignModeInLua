--[[
    module:  RealCustomer
    author:  DylanYang
    time:    2021-02-23 16:42:15
	idea:    
	advance: 
]]
local super = require("patterns.behavioral.nullObject.BaseCustomer")
local _M = Class("RealCustomer", super)
local public = _M.public

function _M:ctor(name)
    self._name = name
end

function public:IsNil()
    return false
end

function public.get:name()
    return self._name
end

return _M