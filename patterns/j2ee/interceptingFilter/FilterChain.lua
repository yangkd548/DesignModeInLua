--[[
    module:  FilterChain
    author:  DylanYang
    time:    2021-02-25 11:43:15
	idea:    
	advance: 
]]
local _M = Class("FilterChain")
local public = _M.public

_M.filters = {}
_M._target = nil

function public:AddFilter(filter)
    table.insert(self.filters, filter)
end

function public:Execute(request)
    for i, filter in ipairs(self.filters) do
        filter:Execute(request)
    end
    self._target:Execute(request)
end

function public.set:target(target)
    self._target = target
end

return _M