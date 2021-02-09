--[[
    module:Banner
    author:DylanYang
    time:2021-02-09 10:19:08
]]
local _M = Class("Banner")

_M.str = nil

function _M:ctor(str)
    self.str = str
end

function _M.public:ShowWithParen()
    print(string.format("(%s)", self.str))
end

function _M.public:ShowWithAstar()
    print(string.format("*%s*", self.str))
end

return _M