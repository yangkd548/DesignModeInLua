--[[
    module:  Monitor
    author:  DylanYang
    time:    2021-02-24 24:37:46
	idea:    
	advance: 
]]
local interface = require("patterns.behavioral.visitor.IElement")
local _M = Class("Monitor", interface)
local public = _M.public

function public:Accept(visitor)
    visitor:Visit(self)
end

function public.get:name()
    return self.__name
end

return _M