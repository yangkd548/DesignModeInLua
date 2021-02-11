--[[
    module:Broker
    author:DylanYang
    time:2021-02-11 18:38:02
]]
local _M = Class("Broker")
local public = _M.public

_M.orderList = {}

function public:TakeOrder(order)
    table.insert(self.orderList, order)
end

function public:PlaceOrders()
    for i, v in pairs(self.orderList) do
        v:Execute()
    end
    self.orderList = {}
end

return _M