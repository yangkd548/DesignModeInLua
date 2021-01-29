--[[
    module:AbstractFactoryTest
    author:DylanYang
    time:2021-01-28 15:14:57
]]
local ShapeFactory = require("examples.abstractFactory.ShapeFactory2")
local ColorFactory = require("examples.abstractFactory.ColorFactory")
local FactoryProducer = require("examples.abstractFactory.FactoryProducer")

local super = require("examples.BaseTest")
local _M = Class("AbstractFactoryTest", super)

function _M.protected:DoExecTest()
    local factoryProducer = FactoryProducer.new()
    
    local shapeFactory = factoryProducer:GetFactory("SHAPE")

    local circle = shapeFactory:GetShape("CIRCLE")
    circle:Draw()
    -- shapeFactory:GetShape("CIRCLE"):Draw()
    -- shapeFactory:GetShape("RECTANGLE"):Draw()
    -- shapeFactory:GetShape("SQUARE"):Draw()

    -- local colorFactory = factoryProducer:GetFactory("COLOR")
    -- colorFactory:GetColor("RED"):Fill()
    -- colorFactory:GetColor("Green"):Fill()
    -- colorFactory:GetColor("BLUE"):Fill()
end

return _M