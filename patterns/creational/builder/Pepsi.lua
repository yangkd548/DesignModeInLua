--[[
    Module:Pepsi
    Author:DylanYang
    Time:2021-01-30 22:34:21
]]
local super = require("patterns.creational.builder.ColdDrink")
local _M = Class("Pepsi", super)

function _M.public.get:price()
    return 35.0
end

function _M.public.get:name()
    return "Pepsi"
end

return _M