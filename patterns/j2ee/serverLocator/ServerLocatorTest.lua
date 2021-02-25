--[[
    module:  ServerLocatorTest
    author:  DylanYang
    time:    2021-02-24 13:05:29
	idea:    
	advance: 
]]
local ServiceLocator = require("patterns.j2ee.serverLocator.ServiceLocator")

local super = require("patterns.BaseTest")
local _M = Class("ServerLocatorTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    local service = ServiceLocator:GetService("Service1");
    service:Execute();
    print()
    service = ServiceLocator:GetService("Service2");
    service:Execute();
    print()
    service = ServiceLocator:GetService("Service1");
    service:Execute();
    print()
    service = ServiceLocator:GetService("Service2");
    service:Execute();
end

return _M