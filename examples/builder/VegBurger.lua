--[[
    Module:VegBurger
    Author:DylanYang
    Time:2021-01-30 22:27:54
]]
local super = require("examples.builder.Burger")
local _M = Class("VegBurger", super)

function _M.public.get:price()
    return 25.0
end

function _M.public.get:name()
    return "Veg Burger"
end

return _M