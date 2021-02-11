--[[
    module:SpecialSupport
    author:DylanYang
    time:2021-02-11 17:43:59
]]
local super = require("patterns.behavioral.chainOfResponsibility.Support")
local _M = Class("SpecialSupport", super)

_M.number = nil

function _M:ctor(name, number)
    self.super:ctor(name)
    self.number = number
end

function _M.protected:Resolve(trouble)
    return trouble.number == self.number
end

return _M