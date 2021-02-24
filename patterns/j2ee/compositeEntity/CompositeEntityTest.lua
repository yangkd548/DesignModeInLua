--[[
    module:  CompositeEntityTest
    author:  DylanYang
    time:    2021-02-24 13:04:53
	idea:    
	advance: 
]]
local Client = require("patterns.j2ee.compositeEntity.Client")

local super = require("patterns.BaseTest")
local _M = Class("CompositeEntityTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    local client = Client.new()
    client:SetData("Test", "Data")
    client:PrintData()
    client:SetData("Second Test", "Data1")
    client:PrintData()
end

return _M