--[[
    module:ShapeFactory
    author:DylanYang
    time:2021-01-26 19:26:46
]]
local Circle = require("examples.factory.Circle")
local Rectangle = require("examples.factory.Rectangle")
local Square = require("examples.factory.Square")

local _M = Class("ShapeFactory")
local public = _M.public

function public:CreateShape(typeStr)
    local shape = require("examples.factory.Circle").new()
    print("11111 : ", shape)
    return shape
    -- if typeStr == "Circle" then
    --     return require("examples.factory.Circle").new()
    -- elseif typeStr == "Rectangle" then
    --     return Rectangle.new()
    -- elseif typeStr == "Square" then
    --     return Square.new()
    -- else
    --     return nil
    -- end
end

return _M