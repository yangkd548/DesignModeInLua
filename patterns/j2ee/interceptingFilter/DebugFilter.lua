--[[
    module:  DebugFilter
    author:  DylanYang
    time:    2021-02-25 11:55:44
	idea:    
	advance: 
]]
local interface = require("patterns.j2ee.interceptingFilter.IFilter")
local _M = Class("DebugFilter", interface)
local public = _M.public

function public:Execute(request)
    print(string.format("Filter : debug log - request [%s]", request))
end

return _M