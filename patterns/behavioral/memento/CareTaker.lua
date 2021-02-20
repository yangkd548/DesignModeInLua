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

_M.mementoList = {}

function public:Create()
    return self:Add(Memento.new())
end

function public:Add(memento)
    if not table.indexof(self.mementoList, memento) then
        table.insert(self.mementoList, memento)
    end
    return memento
end

function public:GetMemento(index)
    return self.mementoList[index]
end

function public.get:last()
    return self:GetMemento(#self.mementoList)
end

return _M