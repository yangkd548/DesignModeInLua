--[[
    module:Aggregate
    author:DylanYang
    time:2021-02-18 10:01:13
]]
local _M = Class("Aggregate")
_M.abstract = true
local public = _M.public

function public.get:iterator()
end

function public:GetAt(index)
end

function public.get:length()
end

return _M