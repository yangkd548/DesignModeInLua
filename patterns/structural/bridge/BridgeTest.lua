--[[
    module:BridgeTest
    author:DylanYang
    time:2021-02-09 11:23:58
]]
local StringDisplayImpl = require("patterns.structural.bridge.StringDisplayImpl")
local Display = require("patterns.structural.bridge.Display")
local CountDisplay = require("patterns.structural.bridge.CountDisplay")

local super = require("patterns.BaseTest")
local _M = Class("BridgeTest", super)

function _M.protected:DoExecTest()
    --On the Display side, you have the function hierarchy.
    --On the DisplayImpl side, there's the implementation hierarchy.
    --The Dispaly side, using 'impl side' for functional modification and assembly.
    local d1 = Display.new(StringDisplayImpl.new("Hello, China."))
    local d2 = CountDisplay.new(StringDisplayImpl.new("Hello, World."))
    local d3 = CountDisplay.new(StringDisplayImpl.new("Hello, Universe."))
    d1:Display()
    d2:Display()
    d3:Display()
    d3:MultiDisplay(5)
end

return _M