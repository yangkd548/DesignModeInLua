--[[
    Module:Circle
    Author:DylanYang
    Time:2021-01-31 18:28:06
]]
local super = require("patterns.creational.prototype.Shape")
local _M = Class("Circle", super)
local public = _M.public

function _M:ctor(id)
    local s = self.super
    self.super:ctor(id)
    self._type = self.__name
end

function public:Draw()
    print(string.format("Factory Test: I'm a %s%s !", self.type, "（圆形）"))
end

return _M