--[[
    module:FactoryProducer
    author:DylanYang
    time:2021-01-28 15:09:02
]]
local ShapeFactory = require("examples.abstractFactory.ShapeFactory2")
local ColorFactory = require("examples.abstractFactory.ColorFactory")

local _M = Class("FactoryProducer")

function _M.public:GetFactory(choice)
    if choice == "SHAPE" then
        return ShapeFactory.new()
    elseif choice == "COLOR" then
        return ColorFactory.new()
    end
    return nil
end

return _M