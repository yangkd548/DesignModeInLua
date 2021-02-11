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
    --"Stock" is an stock info. It is a request message.
    local abcStock = Stock.new()
    --Here are two commands.
    local buyStockOrder = BuyOrder.new(abcStock)
    local sellStockOrder = SellOrder.new(abcStock)
    --The broker is in charge of the inventory. It is the caller of the command.
    local broker = Broker.new()
    --Below are the buy and sell orders taken respectively.
    broker:TakeOrder(buyStockOrder)
    broker:TakeOrder(sellStockOrder)
    --The broker handles the commands. Or, it hands the command to the appropriate object for processing.
    broker:PlaceOrders()
end

return _M