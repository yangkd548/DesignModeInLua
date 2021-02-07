--[[
    Module:Burger
    Author:DylanYang
    Time:2021-01-30 22:18:53
]]
local Wrapper = require("patterns.creational.builder.Wrapper")

local super = require("patterns.creational.builder.Item")
local _M = Class("Burger", super)
_M.abstract = true
local public = _M.public

function public.get:packing()
    return Wrapper.new()
end

return _M