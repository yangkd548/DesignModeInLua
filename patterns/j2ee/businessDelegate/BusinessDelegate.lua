--[[
    module:  BusinessDelegate
    author:  DylanYang
    time:    2021-02-24 16:24:59
	idea:    
	advance: 
]]
local BusinessLookUp = require("patterns.j2ee.businessDelegate.BusinessLookUp")

local _M = Class("BusinessDelegate")
local public = _M.public

_M.lookupService = nil
_M._serviceType = nil
-- _M.businessService = nil

function _M:ctor()
    self.lookupService = BusinessLookUp.new()
end

function public.set:serviceType(serviceType)
    self._serviceType = serviceType
end

function public:DoTask()
    -- self.businessService = 
    local service = self.lookupService:GetBusinessService(self._serviceType)
    service:DoProcessing()
end

return _M