--[[
    module:OddSupport
    author:DylanYang
    time:2021-02-11 17:42:07
]]
local super = require("patterns.behavioral.chainOfResponsibility.Support")
local _M = Class("OddSupport", super)

function _M.protected:Resolve(trouble)
    return trouble.number % 2 == 1
end

return _M