--[[
    module:ShapeFactory
    author:DylanYang
    time:2021-01-28 15:03:25
]]
local Circle = require("examples.factory.Circle")
local Rectangle = require("examples.factory.Rectangle")
local Square = require("examples.factory.Square")

local super = require("examples.abstractFactory.AbstractFactory")
local _M = Class("ShapeFactory", super)

function _M.public:GetShape(typeStr)
    typeStr = string.upper(typeStr)
    if typeStr == "CIRCLE" then
        return Circle.new()
    elseif typeStr == "RECTANGLE" then
        return Rectangle.new()
    elseif typeStr == "SQUARE" then
        return Square.new()
    else
        return nil
    end
end

function _M.public:GetColor(typeStr)
    return nil
end

return _M