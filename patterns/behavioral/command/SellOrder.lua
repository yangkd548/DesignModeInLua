--[[
    module:SellOrder
    author:DylanYang
    time:2021-02-11 18:36:22
]]
local super = require("patterns.behavioral.command.IOrder")
local _M = Class("SellOrder", super)
local public = _M.public

_M.abcStock = nil

function _M:ctor(abcStock)
    self.abcStock = abcStock
end

function public:Execute()
    self.abcStock:Sell()
end

return _M