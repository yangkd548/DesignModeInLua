--[[
    Module:Burger
    Author:DylanYang
    Time:2021-01-30 22:18:53
]]
local Wrapper = require("examples.builder.Wrapper")

local super = require("examples.builder.Item")
local _M = Class("Burger", super)
_M.abstract = true
local public = _M.public

function public.get:packing()
    return Wrapper.new()
end

return _M