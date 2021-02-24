--[[
    module:  EJBService
    author:  DylanYang
    time:    2021-02-24 16:15:25
	idea:    
	advance: 
]]
local interface = require("patterns.j2ee.businessDelegate.IBusinessService")
local _M = Class("EJBService", interface)
local public = _M.public

function public:DoProcessing()
    print("Processing task by invoking EJB Service.")
end

return _M