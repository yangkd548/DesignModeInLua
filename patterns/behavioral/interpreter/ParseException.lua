--[[
    module:ParseException
    author:DylanYang
    time:2021-02-12 21:43:46
]]
local _M = Class("ParseException")

function _M:ctor(msg)
    error("Exception : %s.", msg)
end

return _M