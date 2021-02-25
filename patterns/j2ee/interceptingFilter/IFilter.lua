--[[
    module:  IFilter
    author:  DylanYang
    time:    2021-02-25 11:39:54
	idea:    
	advance: 
]]
local _M = Class("IFilter")
_M.abstract = true
local public = _M.public

function public:Execute(request)
end

return _M