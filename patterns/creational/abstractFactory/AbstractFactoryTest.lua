--[[
    module:AbstractFactoryTest
    author:DylanYang
    time:2021-01-28 15:14:57
]]
local ShapeFactory = require("patterns.creational.abstractFactory.ShapeFactory")
local ColorFactory = require("patterns.creational.abstractFactory.ColorFactory")
local FactoryProducer = require("patterns.creational.abstractFactory.FactoryProducer")

local super = require("patterns.BaseTest")
local _M = Class("AbstractFactoryTest", super)

function _M.protected:DoExecTest()
    local factoryProducer = FactoryProducer.new()
    
    local shapeFactory = factoryProducer:GetFactory("SHAPE")
    shapeFactory:GetShape("CIRCLE"):Draw()
    shapeFactory:GetShape("RECTANGLE"):Draw()
    shapeFactory:GetShape("SQUARE"):Draw()

    local colorFactory = factoryProducer:GetFactory("COLOR")
    colorFactory:GetColor("RED"):Fill()
    colorFactory:GetColor("Green"):Fill()
    colorFactory:GetColor("BLUE"):Fill()
end

return _M