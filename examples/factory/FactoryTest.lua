--[[
    Module:FactoryTest
    Author:DylanYang
    Time:2021-01-26 19:32:54
]]
local ShapeFactory = require("examples.factory.ShapeFactory")

local super = require("examples.BaseTest")
local _M = Class("FactoryTest", super)

function _M.protected:DoExecTest()
    local factory = ShapeFactory.new()
    local shape = factory:CreateShape("Circle")
    shape:Draw()
    factory:CreateShape("Rectangle"):Draw()
    factory:CreateShape("Square"):Draw()
end

return _M