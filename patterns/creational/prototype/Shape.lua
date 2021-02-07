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
    --@TODO 实现业务层面的拷贝，看来需要在框架层，提供一个“深拷贝”和一个“浅拷贝”的工具方法
    --@TODO 临时直接返回当前实例
    return self
end

return _M