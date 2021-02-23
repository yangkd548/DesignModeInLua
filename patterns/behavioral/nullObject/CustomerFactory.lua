--[[
    module:  CustomerFactory
    author:  DylanYang
    time:    2021-02-23 16:46:17
	idea:    
	advance: 
]]
local RealCustomer = require("patterns.behavioral.nullObject.RealCustomer")
local NullCustomer = require("patterns.behavioral.nullObject.NullCustomer")

local _M = Class("CustomerFactory")
local public = _M.public

local static = _M.static

static.public.readonly.names = {"Rob", "Joe", "Julie"}

function static.public:GetCustomer(name)
    for i = 1, #self.names do
        if self.names[i] == name then
            return RealCustomer.new(name)
        end
    end
    return NullCustomer.new()
end

return _M