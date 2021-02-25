--[[
    module:  InterceptingFilterTest
    author:  DylanYang
    time:    2021-02-24 13:04:04
	idea:    
	advance: 
]]
local FilterManager = require("patterns.j2ee.interceptingFilter.FilterManager")
local Target = require("patterns.j2ee.interceptingFilter.Target")
local AuthenticationFilter = require("patterns.j2ee.interceptingFilter.AuthenticationFilter")
local DebugFilter = require("patterns.j2ee.interceptingFilter.DebugFilter")
local Client = require("patterns.j2ee.interceptingFilter.Client")

local super = require("patterns.BaseTest")
local _M = Class("InterceptingFilterTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    local filterManager = FilterManager.new(Target.new())
    filterManager:SetFilter(AuthenticationFilter.new())
    filterManager:SetFilter(DebugFilter.new())

    local client = Client.new();
    client:SetFilterManager(filterManager)
    client:SendRequest("HOME")
end

return _M