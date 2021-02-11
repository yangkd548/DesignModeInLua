--[[
    module:CommandTest
    author:DylanYang
    time:2021-02-11 18:35:06
]]
local Stock = require("patterns.behavioral.command.Stock")
local BuyOrder = require("patterns.behavioral.command.BuyOrder")
local SellOrder = require("patterns.behavioral.command.SellOrder")
local Broker = require("patterns.behavioral.command.Broker")

local super = require("patterns.BaseTest")
local _M = Class("CommandTest", super)

function _M.protected:DoExecTest()
    local abcStock = Stock.new();
    local buyStockOrder = BuyOrder.new(abcStock);
    local sellStockOrder = SellOrder.new(abcStock);
    local broker = Broker.new();
    broker:TakeOrder(buyStockOrder);
    broker:TakeOrder(sellStockOrder);
    broker:PlaceOrders();
end

return _M