--[[
    Module:Meal
    Author:DylanYang
    Time:2021-01-30 22:35:57
]]
local _M = Class("Meal")
local public = _M.public

_M.private.items = {}

function public:AddItem(item)
    table.insert(self.items, item)
end

function public.get:cost()
    local result = 0
    for i, item in pairs(self.items) do
        result = result + item.price
    end
    return result
end

function public.get:count()
    return #self.items
end

function public:ShowItems()
    for i, item in pairs(self.items) do
        print(string.format("\t%d. Item : %s", i, item.name))
        print("\t\t Packing : "..item.packing:Pack())
        print("\t\t Price : "..item.price)
    end
end

return _M