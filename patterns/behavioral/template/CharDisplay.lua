--[[
    module:  CharDisplay
    author:  DylanYang
    time:    2021-02-23 23:38:39
	idea:    
	advance: 
]]
local super = require("patterns.behavioral.template.AbstractDisplay")
local _M = Class("CharDisplay", super)
local public = _M.public

_M.ch = nil

function _M:ctor(ch)
    self.ch = ch
end

function public:Open()
    prints("<<")
end

function public:Print()
    prints(self.ch)
end

function public:Close()
    prints(">>", true)
    print()
end

return _M