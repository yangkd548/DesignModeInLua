--[[
    module:ShapeDecorator
    author:DylanYang
    time:2021-02-09 17:19:26
]]
local _M = Class("ShapeDecorator")
_M.shape = nil

function _M:ctor(shape)
    self.shape = shape
end

function _M.public:Draw()
    self.shape:Draw()
end

return _M