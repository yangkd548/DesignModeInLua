--[[
    module:ColorObj
    author:DylanYang
    time:2021-02-18 16:26:05
]]
local _M = Class("ColorObj")
local readonly = _M.readonly

readonly.r = nil
readonly.g = nil
readonly.b = nil

function _M:ctor(r, g, b)
    self.r = r
    self.g = g
    self.b = b
end

function _M.public:ToString()
    return string.format("r: %s, g: %s, b: %s", self.r, self.g, self.b)
end

return _M