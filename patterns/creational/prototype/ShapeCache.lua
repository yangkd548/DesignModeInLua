--[[
    Module:ShapeCache
    Author:DylanYang
    Time:2021-01-31 18:32:40
]]
local Circle = require("patterns.creational.prototype.Circle")
local Square = require("patterns.creational.prototype.Square")
local Rectangle = require("patterns.creational.prototype.Rectangle")

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
end

return _M