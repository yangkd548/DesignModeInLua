--[[
    Module:Shape
    Author:DylanYang
    Time:2021-01-31 13:27:36
]]
local interface = require("patterns.Cloneable")
local _M = Class("Shape", interface)
_M.abstract = true
local public = _M.public

_M._id = nil
_M.protected._type = nil

function _M:ctor(id)
    self._id = id
end

function public.get:id()
    return self._id
end

function public.get:type()
    return self._type
end

function public:Draw()
end

function public:Clone()
    --@使用了Class模块，为其实例，提供的浅拷贝功能
    return self.__copy
end

return _M