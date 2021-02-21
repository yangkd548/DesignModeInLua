--[[
    module:  CareTaker
    author:  DylanYang
    time:    2021-02-20 17:52:27
    idea:    The Caretaker is responsible for storing the list of Memento objects from and providing the specified Memento object.
    advance: This class abstracts out an interface class.
]]
local Memento = require("patterns.behavioral.memento.Memento")

local _M = Class("CareTaker")
local public = _M.public

_M.index = 0
_M.mementoList = {}

function public:Create()
    return self:Add(Memento.new())
end

function public:Add(memento)
    if not table.indexof(self.mementoList, memento) then
        --回退后，再添加，可用于撤销的回退部分，就会被舍弃
        if self.index < #self.mementoList then
            table.sub(self.mementoList, self.index + 1)
        end
        table.insert(self.mementoList, memento)
        self.index = #self.mementoList
    end
    return memento
end

function public:GetMemento(index)
    self.index = index
    return self.mementoList[index]
end

function public.get:last()
    return self:GetMemento(#self.mementoList)
end

function public:RestoreRandom()
    return self:GetMemento(random.nextInt(#self.mementoList))
end

return _M