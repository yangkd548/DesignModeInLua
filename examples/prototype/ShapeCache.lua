--[[
    Module:ShapeCache
    Author:DylanYang
    Time:2021-01-31 18:32:40
]]
local Circle = require("examples.prototype.Circle")
local Square = require("examples.prototype.Square")
local Rectangle = require("examples.prototype.Rectangle")

local _M = Class("ShapeCache")

_M.static.private.shapeMap = {}

function _M.static.public:GetShape(id)
    local shape = self.shapeMap[id]
    return shape:Clone()
end

function _M.static.public:LoadCache()
    self:CacheShape(Circle.new(1))
    self:CacheShape(Square.new(2))
    self:CacheShape(Rectangle.new(3))
end

function _M.static:CacheShape(shape)
    self.shapeMap[shape.id] = shape
    print(string.format("\n%s", shape.type))
    for i, v in pairs(shape) do
        print(i, v)
    end
end

return _M