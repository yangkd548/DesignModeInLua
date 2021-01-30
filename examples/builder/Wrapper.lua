--[[
    Module:Wrapper
    Author:DylanYang
    Time:2021-01-30 22:05:41
]]
local super = require("examples.builder.Packing")
local _M = Class("Wrapper", super)

function _M.public:Pack()
    return "Wrapper";
end

return _M