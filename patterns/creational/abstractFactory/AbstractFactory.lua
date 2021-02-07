--[[
    module:AbstractFactory
    author:DylanYang
    time:2021-01-28 15:00:53
]]
local _M = Class("AbstractFactory")
_M.abstract = true

function _M.public:GetColor(colorType)
end

function _M.public:GetShape(shapeType)
end

return _M