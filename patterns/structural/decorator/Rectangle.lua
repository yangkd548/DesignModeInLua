--[[
    module:Rectangle
    author:DylanYang
    time:2021-02-09 17:14:32
]]
local super = require("patterns.structural.decorator.Shape")
local _M = Class("Rectangle")

function _M.public:Draw()
    print(string.format("The shape that was just drawn is a %s.", self.name))
end

function _M.public.get:name()
    return "Rectangle"
end

return _M