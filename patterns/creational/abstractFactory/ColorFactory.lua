--[[
    module:ColorFactory
    author:DylanYang
    time:2021-01-28 15:10:59
]]
local Red = require("patterns.creational.abstractFactory.Red")
local Green = require("patterns.creational.abstractFactory.Green")
local Blue = require("patterns.creational.abstractFactory.Blue")

local _M = Class("ColorFactory")

function _M.public:GetColor(typeStr)
    typeStr = string.upper(typeStr)
    if typeStr == "RED" then
        return Red.new()
    elseif typeStr == "GREEN" then
        return Green.new()
    elseif typeStr == "BLUE" then
        return Blue.new()
    else
        return nil
    end
end

function _M.public:GetShape(typeStr)
    return nil
end

return _M