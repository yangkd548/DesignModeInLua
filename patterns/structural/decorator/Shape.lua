--[[
    module:Shape
    author:DylanYang
    time:2021-02-09 17:13:11
]]
local _M = Class("Shape")
_M.abstract = true

function _M.public:Draw()
end

function _M.public.get:name()
end

return _M