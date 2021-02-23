--[[
    module:  Strategy
    author:  DylanYang
    time:    2021-02-23 18:04:48
	idea:    
	advance: 
]]
local _M = Class("Strategy")
_M.abstract = true
local public = _M.public

function public.get:nextHand()
end

function public:Study(win)
end

return _M