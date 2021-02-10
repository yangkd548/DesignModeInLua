--[[
    module:ShapeFactory
    author:DylanYang
    time:2021-02-10 23:56:26
]]
local Circle = require("patterns.structural.flyweight.Circle")

local _M = Class("ShapeFactory")

_M.static.circleMap = {}

function _M.static.public:GetCircle(color)
    local circle = self.circleMap[color]
    if circle == nil then
        circle = Circle.new(color)
        self.circleMap[color] = circle
        print("Creating circle of color : " .. color)
    end
    return circle
end

return _M