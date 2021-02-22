--[[
    module:  ObserverTest
    author:  DylanYang
    time:    2021-02-21 21:09:42
	idea:    
	advance: 1. In the Observer pattern, the use of Iterator pattern is also added. 2. Also used an extension of print and fixed the bug that its internal method printf would print an extra nil.
]]
local NumberGenerator = require("patterns.behavioral.observer.NumberGenerator")
local RandomNumberGenerator = require("patterns.behavioral.observer.RandomNumberGenerator")
local DigitObserver = require("patterns.behavioral.observer.DigitObserver")
local GraphObserver = require("patterns.behavioral.observer.GraphObserver")

local super = require("patterns.BaseTest")
local _M = Class("ObserverTest", super)

function _M.protected:DoExecTest()
    self:TestObserver(NumberGenerator)
    printl()
    self:TestObserver(RandomNumberGenerator)
end

function _M:TestObserver(observerCls)
    local generator = observerCls.new()
    local observer1 = DigitObserver.new()
    local observer2 = GraphObserver.new()
    generator:AddObserver(observer1)
    generator:AddObserver(observer2)
    generator:Execute()
end

return _M