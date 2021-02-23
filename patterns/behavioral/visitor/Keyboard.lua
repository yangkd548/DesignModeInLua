--[[
    module:  Keyboard
    author:  DylanYang
    time:    2021-02-24 24:36:57
	idea:    
	advance: 
]]
local interface = require("patterns.behavioral.visitor.IElement")
local _M = Class("Keyboard", interface)
local public = _M.public

function public:Accept(visitor)
    visitor:Visit(self)
end

function public.get:name()
    return self.__name
end

return _M