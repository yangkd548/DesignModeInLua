--[[
    Module:Square
    Author:DylanYang
    Time:2021-01-26 19:22:09
]]
local interface = require("patterns.creational.factory.Shape")
local _M = Class("Square", interface)
local public = _M.public

function public:Draw()
    print(string.format("Factory Test: I'm a %s%s !", self.__name, "（正方形）"))
end

return _M