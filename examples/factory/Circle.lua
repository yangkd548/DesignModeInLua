--[[
    Module:Circle
    Author:DylanYang
    Time:2021-01-26 19:22:20
]]
local interface = require("examples.factory.Shape")
local _M = Class("Circle", interface)
local public = _M.public

function public:Draw()
    print(string.format("Factory Test: I'm a %s%s !", self.__name, "（圆形）"))
end

return _M