--[[
    module:  Cache
    author:  DylanYang
    time:    2021-02-25 13:42:54
	idea:    
	advance: 
]]
local _M = Class("Cache")
local public = _M.public

_M.services = {}

function public:GetService(serviceName)
    for i, service in ipairs(self.services) do
        if service.name == serviceName then
            print(string.format("Returning cached '%s' object", serviceName))
            return service
        end
    end
    return null
end

function public:AddService(newService)
    local exists = false
    for i, service in ipairs(self.services) do
        if service.name == newService.name then
            exists = true
            break
        end
    end
    if not exists then
        table.insert(self.services, newService)
    end
end

return _M