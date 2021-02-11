--[[
    module:Stock
    author:DylanYang
    time:2021-02-11 18:37:36
]]
local _M = Class("Stock")
local public = _M.public

_M.name = "ABC"
_M.quantity = 10

function public:Buy()
    print(string.format("Stock [ Name: %s, Quantity: %s ] bought.", self.name, self.quantity))
end

function public:Sell()
    print(string.format("Stock [ Name: %s, Quantity: %s ] sold", self.name, self.quantity))
end

return _M