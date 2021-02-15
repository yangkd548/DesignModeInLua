--[[
    module:StringTokenizer
    author:DylanYang
    time:2021-02-16 24:26:25
]]
local _M = Class("StringTokenizer")
local public = _M.public

_M.tokens = {}
_M.index = 0

function _M:ctor(str)
    self.tokens = string.split(str, " ")
end

function public:NextToken()
    self.index = self.index + 1
    return self.tokens[self.index]
end

function public:Reset()
    self.index = 0
end

return _M