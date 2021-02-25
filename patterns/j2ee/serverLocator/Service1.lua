--[[
    module:  Service1
    author:  DylanYang
    time:    2021-02-25 13:38:06
	idea:    
	advance: 
]]
local interface = require("patterns.j2ee.serverLocator.IService")
local _M = Class("Service1", interface)
local public = _M.public

function public.get:name()
    return "Service1"
end

function public:Execute()
    print("Executing Service1")
end

return _M