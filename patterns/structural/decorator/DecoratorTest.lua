--[[
    module:DecoratorTest
    author:DylanYang
    time:2021-02-09 16:58:49
]]
local Circle = require("patterns.structural.decorator.Circle")
local Rectangle = require("patterns.structural.decorator.Rectangle")
local RedShapeDecorator = require("patterns.structural.decorator.RedShapeDecorator")

local super = require("patterns.BaseTest")
local _M = Class("DecoratorTest", super)

function _M.protected:DoExecTest()
    local circle = Circle.new()
    print("Circle with normal border.")
    circle:Draw()

    local redCircle = RedShapeDecorator.new(Circle.new())
    print("\nCircle of red border.")
    redCircle:Draw()
    
    local redRectangle = RedShapeDecorator.new(Rectangle.new())
    print("\nRectangle of red border.")
    redRectangle:Draw()
end

return _M