--[[
    module:  Computer
    author:  DylanYang
    time:    2021-02-24 24:38:04
	idea:    
	advance: 
]]
local Mouse = require("patterns.behavioral.visitor.Mouse")
local Keyboard = require("patterns.behavioral.visitor.Keyboard")
local Monitor = require("patterns.behavioral.visitor.Monitor")

local interface = require("patterns.behavioral.visitor.IElement")
local _M = Class("Computer", interface)
local public = _M.public

_M.parts = nil

function _M:ctor()
    self.parts = {Mouse.new(), Keyboard.new(), Monitor.new()}
end

function public:Accept(visitor)
    for i,v in ipairs(self.parts) do
        v:Accept(visitor)
    end
    visitor:Visit(self)
end

function public.get:name()
    return self.__name
end

return _M