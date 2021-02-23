--[[
    module:  Mouse
    author:  DylanYang
    time:    2021-02-24 24:37:55
	idea:    
	advance: 
]]
local interface = require("patterns.behavioral.visitor.IElement")
local _M = Class("Mouse", interface)
local public = _M.public

function public:Accept(visitor)
    visitor:Visit(self)
end

function public.get:name()
    return self.__name
end

return _M