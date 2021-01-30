--[[
    Module:ColdDrink
    Author:DylanYang
    Time:2021-01-30 22:22:32
]]
local Bottle = require("examples.builder.Bottle")

local super = require("examples.builder.Item")
local _M = Class("ColdDrink", super)
_M.abstract = true

function _M.public.get:packing()
    return Bottle.new()
end

return _M