--[[
    module:  BusinessDelegateTest
    author:  DylanYang
    time:    2021-02-24 13:05:12
	idea:    
	advance: 
]]
local BusinessDelegate = require("patterns.j2ee.businessDelegate.BusinessDelegate")
local Client = require("patterns.j2ee.businessDelegate.Client")

local super = require("patterns.BaseTest")
local _M = Class("BusinessDelegateTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    local businessDelegate = BusinessDelegate.new()

    businessDelegate.serviceType = "EJB"
    local client = Client.new(businessDelegate)
    client:DoTask()

    businessDelegate.serviceType = "JMS"
    client:DoTask()
end

return _M