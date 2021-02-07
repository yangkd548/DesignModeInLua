--[[
    Module:Rectangle
    Author:DylanYang
    Time:2021-01-31 18:27:15
]]
local super = require("patterns.creational.prototype.Shape")
local _M = Class("Rectangle", super)
local public = _M.public

function _M:ctor(id)
    self.super:ctor(id)
    self._type = self.__name
end

function public:Draw()
    print(string.format("Factory Test: I'm a %s%s !", self.type, "（矩形）"))
end

return _M