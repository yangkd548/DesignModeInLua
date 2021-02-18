--[[
    module:Iterator
    author:DylanYang
    time:2021-02-18 09:50:21
]]
local _M = Class("Iterator")
_M.abstract = true
local public = _M.public

function public.get:hasNext()
end

function public.get:next()
end

return _M