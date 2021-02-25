--[[
    module:  AuthenticationFilter
    author:  DylanYang
    time:    2021-02-25 11:41:11
	idea:    
	advance: 
]]
local interface = require("patterns.j2ee.interceptingFilter.IFilter")
local _M = Class("AuthenticationFilter", interface)
local public = _M.public

function public:Execute(request)
    print(string.format("Filter : Authenticating - request [%s] ", request))
end

return _M