--[[
    module:  IObserver
    author:  DylanYang
    time:    2021-02-21 23:17:48
	idea:    
	advance: 
]]
local _M = Class("IObserver")
_M.abstract = true
local public = _M.public

function public:Update(generator)
end

return _M