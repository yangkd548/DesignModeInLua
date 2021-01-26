--[[
    module:FactoryTest
    author:DylanYang
    time:2021-01-26 19:32:54
]]
local ShapeFactory = require("examples.factory.ShapeFactory")

local _M = Class("FactoryTest")
local public = _M.public

function public:ExecTest()
    local factory = ShapeFactory.new()
    local circle = factory:CreateShape("Circle")
    print("factory:", circle)
    -- circle:Draw()

    print("direct -1:", require("examples.factory.Shape").new())
    print("direct -2:", require("examples.factory.Circle").new())
    -- factory:CreateShape("Rectangle"):Draw()
    -- factory:CreateShape("Square"):Draw()
end

return _M