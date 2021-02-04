--[[
    Module:ShapeFactory
    Author:DylanYang
    Time:2021-01-26 19:26:46
]]
local Circle = require("examples.factory.Circle")
local Rectangle = require("examples.factory.Rectangle")
local Square = require("examples.factory.Square")

local _M = Class("ShapeFactory")

function _M.public:CreateShape(typeStr, a, b, c, d)
    print("长度------： ", typeStr, self == typeStr)
    print("a:"..(a or "空"))
    print("b:"..(b or "空"))
    print("c:"..(c or "空"))
    print("d:"..(d or "空"))
    if typeStr == "Circle" then
        return require("examples.factory.Circle").new()
    elseif typeStr == "Rectangle" then
        return Rectangle.new()
    elseif typeStr == "Square" then
        return Square.new()
    else
        return nil
    end
end

return _M