--[[
    module:  VisitorTest
    author:  DylanYang
    time:    2021-02-24 24:31:56
	idea:    
	advance: 
]]
local Computer = require("patterns.behavioral.visitor.Computer")
local ComputerVisitor = require("patterns.behavioral.visitor.ComputerVisitor")

local super = require("patterns.BaseTest")
local _M = Class("VisitorTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    local computer = Computer.new()
    computer:Accept(ComputerVisitor.new())
end

return _M