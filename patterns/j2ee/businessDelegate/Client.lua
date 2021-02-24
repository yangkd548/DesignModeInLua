--[[
    module:  Client
    author:  DylanYang
    time:    2021-02-24 16:33:59
	idea:    
	advance: 
]]
local _M = Class("Client")
local public = _M.public

_M.businessService = nil

function _M:ctor(businessService)
    self.businessService  = businessService
end

function public:DoTask()
    self.businessService:DoTask()
end

return _M