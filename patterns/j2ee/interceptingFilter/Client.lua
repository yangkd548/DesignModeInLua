--[[
    module:  Client
    author:  DylanYang
    time:    2021-02-25 11:50:02
	idea:    
	advance: 
]]
local _M = Class("Client")
local public = _M.public

_M.filterManager = nil

function public:SetFilterManager(filterManager)
    self.filterManager = filterManager
end

function public:SendRequest(request)
    self.filterManager:FilterRequest(request)
end

return _M