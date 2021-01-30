--[[
    Module:Coke
    Author:DylanYang
    Time:2021-01-30 22:32:24
]]
local super = require("examples.builder.ColdDrink")
local _M = Class("Coke", super)

function _M.public.get:price()
    return 30.0;
end

function _M.public.get:name()
    return "Coke";
end

return _M