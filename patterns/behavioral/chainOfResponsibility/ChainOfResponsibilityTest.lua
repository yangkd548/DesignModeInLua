--[[
    module:ChainOfResponsibilityTest
    author:DylanYang
    time:2021-02-11 01:13:39
]]
local NoSupport = require("patterns.behavioral.chainOfResponsibility.NoSupport")
local LimitSupport = require("patterns.behavioral.chainOfResponsibility.LimitSupport")
local SpecialSupport = require("patterns.behavioral.chainOfResponsibility.SpecialSupport")
local OddSupport = require("patterns.behavioral.chainOfResponsibility.OddSupport")
local Trouble = require("patterns.behavioral.chainOfResponsibility.Trouble")

local super = require("patterns.BaseTest")
local _M = Class("ChainOfResponsibilityTest", super)

function _M.protected:DoExecTest()
    local alice   = NoSupport.new("Alice")
    local bob     = LimitSupport.new("Bob", 100)
    local charlie = SpecialSupport.new("Charlie", 429)
    local diana   = LimitSupport.new("Diana", 200)
    local elmo    = OddSupport.new("Elmo")
    local fred    = LimitSupport.new("Fred", 300)
    --Create Chain of Responsibility that resolve troubles.
    alice:SetNext(bob):SetNext(charlie):SetNext(diana):SetNext(elmo):SetNext(fred)
    --Create some troubles, then be resolved by chain of responsibility.
    for i = 0, 500, 33 do
        alice:Support(Trouble.new(i))
    end
end

return _M