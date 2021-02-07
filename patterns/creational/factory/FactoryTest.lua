--[[
    Module:FactoryTest
    Author:DylanYang
    Time:2021-01-26 19:32:54
]]
local ShapeFactory = require("patterns.creational.factory.ShapeFactory")

local super = require("patterns.BaseTest")
local _M = Class("FactoryTest", super)

function _M.protected:DoExecTest()
    local factory = ShapeFactory.new()
    local shape = factory:CreateShape("Circle")
    shape:Draw()
    factory:CreateShape("Rectangle"):Draw()
    factory:CreateShape("Square"):Draw()
end

return _M