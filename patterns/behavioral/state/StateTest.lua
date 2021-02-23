--[[
    module:  StateTest
    author:  DylanYang
    time:    2021-02-23 01:10:45
	idea:    
	advance: 
]]
local TheContext = require("patterns.behavioral.state.TheContext")

local super = require("patterns.BaseTest")
local _M = Class("StateTest", super)

function _M.protected:DoExecTest()
    local context = TheContext.new()
    for hour = 0, 23 do
        context:SetClock(hour)
        printlt(string.format("%2d : %02d", hour, 0))
        context:RandomTest()
        printlb()
    end
end

return _M