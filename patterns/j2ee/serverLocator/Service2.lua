--[[
    module:  Service2
    author:  DylanYang
    time:    2021-02-25 13:38:58
	idea:    
	advance: 
]]
local interface = require("patterns.j2ee.serverLocator.IService")
local _M = Class("Service2", interface)
local public = _M.public

function public.get:name()
    return "Service2"
end

function public:Execute()
    print("Executing Service2")
end

return _M