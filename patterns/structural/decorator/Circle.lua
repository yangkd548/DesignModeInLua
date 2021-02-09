--[[
    module:Circle
    author:DylanYang
    time:2021-02-09 17:17:40
]]
local super = require("patterns.structural.decorator.Shape")
local _M = Class("Circle", super)

function _M.public:Draw()
    print(string.format("The shape that was just drawn is a %s.", self.name))
end

function _M.public.get:name()
    return "Circle"
end

return _M