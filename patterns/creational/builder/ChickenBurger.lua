--[[
    Module:ChickenBurger
    Author:DylanYang
    Time:2021-01-30 22:31:07
]]
local super = require("patterns.creational.builder.Burger")
local _M = Class("ChickenBurger", super)

function _M.public.get:price()
    return 50.5
end

function _M.public.get:name()
    return "Chicken Burger"
end

return _M