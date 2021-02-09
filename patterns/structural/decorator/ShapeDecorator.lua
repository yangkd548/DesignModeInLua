--[[
    module:ShapeDecorator
    author:DylanYang
    time:2021-02-09 17:19:26
]]
--Interface of Decorator and Be decorations is Same.
local interface = require("patterns.structural.decorator.Shape")
local _M = Class("ShapeDecorator", interface)
_M.shape = nil

function _M:ctor(shape)
    self.shape = shape
end

function _M.public:Draw()
    self.shape:Draw()
end

return _M