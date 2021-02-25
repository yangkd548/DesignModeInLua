--[[
    module:  IService
    author:  DylanYang
    time:    2021-02-25 13:35:44
	idea:    
	advance: 
]]
local _M = Class("IService")
_M.abstract = true
local public = _M.public

function public.get:name()
end

function public:Execute()
end

return _M