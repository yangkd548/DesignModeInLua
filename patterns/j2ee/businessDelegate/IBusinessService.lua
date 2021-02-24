--[[
    module:  IBusinessService
    author:  DylanYang
    time:    2021-02-24 16:13:53
	idea:    
	advance: 
]]
local _M = Class("IBusinessService")
_M.abstract = true
local public = _M.public

function public:DoProcessing()
end

return _M