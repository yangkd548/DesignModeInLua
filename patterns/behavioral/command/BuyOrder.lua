--[[
    module:BuyOrder
    author:DylanYang
    time:2021-02-11 18:36:36
]]
local super = require("patterns.behavioral.command.IOrder")
local _M = Class("BuyOrder", super)
local public = _M.public

_M.abcStock = nil

function _M:ctor(abcStock)
    self.abcStock = abcStock
end

function public:Execute()
    self.abcStock:Buy()
end

return _M