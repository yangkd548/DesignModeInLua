--[[
    Module:ColdDrink
    Author:DylanYang
    Time:2021-01-30 22:22:32
]]
local Bottle = require("patterns.creational.builder.Bottle")

local super = require("patterns.creational.builder.Item")
local _M = Class("ColdDrink", super)
_M.abstract = true

function _M.public.get:packing()
    return Bottle.new()
end

return _M