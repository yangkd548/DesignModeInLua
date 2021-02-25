--[[
    module:  FrontControllerTest
    author:  DylanYang
    time:    2021-02-24 13:04:19
	idea:    
	advance: 
]]
local FrontController = require("patterns.j2ee.frontController.FrontController")

local super = require("patterns.BaseTest")
local _M = Class("FrontControllerTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    local frontController = FrontController.new()
    frontController:DispatchRequest("HOME")
    frontController:DispatchRequest("STUDENT")
end

return _M