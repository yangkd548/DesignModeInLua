--[[
    module:  BaseGenerator
    author:  DylanYang
    time:    2021-02-21 23:19:47
	idea:    
	advance: 
]]
local CommonIterator =  require("patterns.behavioral.iterator.CommonItetator")

local super = require("patterns.behavioral.iterator.Aggregate")
local _M = Class("BaseGenerator", super)
_M.abstract = true
local public = _M.public

_M.observers = {}

function public:AddObserver(observer)
    table.insert(self.observers, observer)
end

function public:RemoveObserver(observer)
    table.removeItem(self.observers, observer)
end

--Send notifications to the Observer.
function public:NotifyObservers()
    local it = self.iterator
    while it.hasNext do
        local o = it.next
        o:Update(self)
    end
end

function public:GetAt(index)
    return self.observers[index]
end

function public.get:length()
    return #self.observers
end

function public.get:iterator()
    return CommonIterator.new(self)
end

return _M