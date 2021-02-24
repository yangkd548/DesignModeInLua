--[[
    module:  BusinessLookUp
    author:  DylanYang
    time:    2021-02-24 16:17:57
	idea:    
	advance: 
]]
local EJBService = require("patterns.j2ee.businessDelegate.EJBService")
local JMSService = require("patterns.j2ee.businessDelegate.JMSService")

local _M = Class("BusinessLookUp")
local public = _M.public

function public:GetBusinessService(serviceType)
    if string.upper(serviceType) == "EJB" then
        return EJBService.new()
    else
        return JMSService.new()
    end
end

return _M