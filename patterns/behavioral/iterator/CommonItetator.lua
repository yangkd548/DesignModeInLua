--[[
    module:CommonItetator
    author:DylanYang
    time:2021-02-18 09:55:41
]]
local interface = require("patterns.behavioral.iterator.Iterator")
local _M = Class("CommonItetator", interface)
local public = _M.public

_M.aggregate = nil
_M.index = nil

function _M:ctor(aggregate)
    self.aggregate = aggregate
    self.index = 0
end

function public.get:hasNext()
    return self.index < self.aggregate.length
end

function public.get:next()
    self.index  = self.index + 1
    return self.aggregate:GetAt(self.index)
end

return _M