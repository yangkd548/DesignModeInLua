--[[
    Module:Bottle
    Author:DylanYang
    Time:2021-01-30 22:07:24
]]
local super = require("examples.builder.Packing")
local _M = Class("Bottle", super)

function _M.public:Pack()
    return "Bottle";
end

return _M