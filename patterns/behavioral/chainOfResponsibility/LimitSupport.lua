--[[
    module:LimitSupport
    author:DylanYang
    time:2021-02-11 17:38:27
]]local super = require("patterns.behavioral.chainOfResponsibility.Support")
local _M = Class("LimitSupport", super)

_M.limit = nil

function _M:ctor(name, limit)
    self.super:ctor(name)
    self.limit = limit
end

function _M.protected:Resolve(trouble)
    return trouble.number < self.limit
end

return _M