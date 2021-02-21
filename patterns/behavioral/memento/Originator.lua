--[[
    module:Originator
    author:DylanYang
    time:2021-02-20 19:47:38
	idea:Originator creates and stores state in the Memento object.
]]
local CareTaker = require("patterns.behavioral.memento.CareTaker")

local interface = require("patterns.behavioral.memento.IMementoUser")
local _M = Class("Originator", interface)
local public = _M.public

_M.readonly.fruitNames = {"苹果", "葡萄", "香蕉", "橘子"}

_M._money = nil
_M._fruit = {}
_M.taker = nil
_M.index = 0

function _M:ctor(money)
    self.money = money
    self.taker = CareTaker.new()
    self.index = 0
end

function public.get:money(value)
    return self._money
end

function public.set:money(value)
    self._money = value
end

function public.get:fruits()
    return self._fruit
end

function public.set:fruits(value)
    self._fruit = value
end

function public:CreateMemento(index)
    local memento = self.taker:Create()
    memento.money = self.money
    memento.fruits = self.fruits
    memento.index = index
    memento:SetSealed()
    return memento
end

function public:RestoreMemento(memento)
    self.money = memento.money
    self.fruits = memento.fruits
    self.index = memento.index
    if IsNumber(self.index) then
        print("------")
    end
end

function public:RestoreLast()
    self:RestoreMemento(self.taker.last)
end

function public:RestoreRandom()
    self:RestoreMemento(self.taker:RestoreRandom())
end

function public:Bet(index)
    self.index = index
    local betInto
    -- 掷骰子
    local dice = random.nextInt(6)
    if dice == 1 then
        -- 骰子结果为1…增加所持金钱
        self.money  = self.money + 100
        betInto = "所持金钱增加了。"
    elseif dice == 2 then
        -- 骰子结果为2…所持金钱减半
        self.money = self.money / 2
        betInto = "所持金钱减半了。"
    elseif dice == 6 then
        -- 骰子结果为6…获得水果
        local fruit = self:GetFruit()
        betInto = string.format("获得了水果(%s)。", fruit)
        table.insert(self.fruits, fruit)
    else
        -- 骰子结果为3、4、5则什么都不会发生
    end
    return betInto
end

function _M:GetFruit()
    local prefix = random.nextBoolean() and "好吃的" or ""
    return prefix .. self.fruitNames[random.nextInt(#self.fruitNames)]
end

function public:ToString()
    return string.format("money = %s 元, \nfruits = %s 个\n\t[%s]", self.money, #self.fruits, table.tostring(self.fruits))
end

return _M