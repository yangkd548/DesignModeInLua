--[[
    module:  Target
    author:  DylanYang
    time:    2021-02-25 11:42:22
	idea:    
	advance: 
]]
local _M = Class("Target")
local public = _M.public

function public:Execute(request)
    print("Executing request: " .. request)
end

return _M