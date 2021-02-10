--[[
    module:Circle
    author:DylanYang
    time:2021-02-10 23:49:14
]]
local super = require("patterns.structural.flyweight.Shape")
local _M = Class("Circle", super)
local public = _M.public

_M._color = nil
_M._x = nil
_M._y = nil
_M._radius = nil

function _M:ctor(color)
    self._color = color
end

function public.set:x(value)
    self._x = value
end

function public.set:y(value)
    self._y = value
end

function public.set:radius(value)
    self._radius = value
end

function public:Draw()
    print(string.format("Circle: Draw() [Color : %s, x : %s, y : %s, radius : %s]", self._color, self._x, self._y, self._radius))
end

return _M