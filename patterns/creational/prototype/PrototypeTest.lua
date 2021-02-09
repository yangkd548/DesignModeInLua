--[[
    Module:PrototypeTest
    Author:DylanYang
    Time:2021-01-31 18:33:30
]]
local ShapeCache = require("patterns.creational.prototype.ShapeCache")

local super = require("patterns.BaseTest")
local _M = Class("PrototypeTest", super)

function _M.protected:DoExecTest()
    ShapeCache:LoadCache()

    local clonedShape1 = ShapeCache:GetShape(1)
    print("Shape : "..clonedShape1.type)
    clonedShape1:Draw()

    local clonedShape2 = ShapeCache:GetShape(2)
    print("Shape : "..clonedShape2.type)
    clonedShape2:Draw()

    local clonedShape3 = ShapeCache:GetShape(3)
    print("Shape : "..clonedShape3.type)
    clonedShape3:Draw()
end

return _M