--[[
    Module:Rectangle
    Author:DylanYang
    Time:2021-01-26 19:22:00
]]
local interface = require("examples.factory.Shape")
local _M = Class("Rectangle", interface)
local public = _M.public

function public:Draw()
    print(string.format("Factory Test: I'm a %s%s !", self.__name, "（矩形）"))
end

return _M