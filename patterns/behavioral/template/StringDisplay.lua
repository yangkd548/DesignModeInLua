--[[
    module:  StringDisplay
    author:  DylanYang
    time:    2021-02-23 23:38:49
	idea:    
	advance: 
]]
local super = require("patterns.behavioral.template.AbstractDisplay")
local _M = Class("StringDisplay", super)
local public = _M.public

_M.string = nil
_M.width = nil

function _M:ctor(string)
    self.string = string
    self.width = #string
end

function public:Open()
    self:PrintLine()
end

function public:Print()
    print(string.format("|%s|", self.string))
end

function public:Close()
    self:PrintLine()
    print()
end

function _M:PrintLine()
    prints("+")
    for i = 0, self.width do
        prints("-")
    end
    prints("+", true)
end

return _M