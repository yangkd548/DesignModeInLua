--[[
    module:NoSupport
    author:DylanYang
    time:2021-02-11 17:37:01
]]
local super = require("patterns.behavioral.chainOfResponsibility.Support")
local _M = Class("NoSupport", super)
local protected = _M.protected

function protected:Resolve(trouble)
    return false
end

return _M