--[[
    module:  NullCustomer
    author:  DylanYang
    time:    2021-02-23 16:44:04
	idea:    
	advance: 
]]
local super = require("patterns.behavioral.nullObject.BaseCustomer")
local _M = Class("NullCustomer", super)
local public = _M.public

function public:IsNil()
    return false
end

function public.get:name()
    return "Warning: An empty object is being used."
end

return _M