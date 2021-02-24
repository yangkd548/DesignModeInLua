--[[
    module:  JMSService
    author:  DylanYang
    time:    2021-02-24 16:17:10
	idea:    
	advance: 
]]
local interface = require("patterns.j2ee.businessDelegate.IBusinessService")
local _M = Class("JMSService")
local public = _M.public

function public:DoProcessing()
    print("Processing task by invoking JMS Service.");
end

return _M