--[[
    module:RedShapeDecorator
    author:DylanYang
    time:2021-02-09 17:21:26
]]
local super = require("patterns.structural.decorator.ShapeDecorator")
local _M = Class("RedShapeDecorator", super)

function _M.public:Draw()
    self:SetRedBorder()
    self.shape:Draw()
end

function _M:SetRedBorder()
    print(string.format("A %s wireframe has been prepared for the shape (%s) to be drawn.", "red", self.shape.name))
end

return _M