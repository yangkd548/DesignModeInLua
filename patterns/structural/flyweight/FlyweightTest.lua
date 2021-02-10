--[[
    module:FlyweightTest
    author:DylanYang
    time:2021-02-10 22:08:35
]]
local ShapeFactory = require("patterns.structural.flyweight.ShapeFactory")

local super = require("patterns.BaseTest")
local _M = Class("FlyweightTest", super)
local static = _M.static

_M.static.readonly.colors = { "Red", "Green", "Blue", "White", "Black" }

function _M.protected:DoExecTest()
    for i = 1, 20 do
        local circle = ShapeFactory:GetCircle(self:GetRandomColor())
        circle.x = self:GetRandomX()
        circle.y = self:GetRandomY()
        circle.radius = 100
        circle:Draw()
    end
end

function _M:GetRandomColor()
    return self.colors[math.ceil(math.random() * #self.colors)]
end

function _M:GetRandomX()
    return math.random() * 100
end

function _M:GetRandomY()
    return math.random() * 100
end

return _M