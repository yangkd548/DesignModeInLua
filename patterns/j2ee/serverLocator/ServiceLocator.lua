--[[
    module:  ServiceLocator
    author:  DylanYang
    time:    2021-02-25 13:47:46
	idea:    
	advance: 
]]
local Cache = require("patterns.j2ee.serverLocator.Cache")
local InitialContext = require("patterns.j2ee.serverLocator.InitialContext")

local _M = Class("ServiceLocator")
local static = _M.static.public

static.cache = Cache.new()

function static:GetService(jndiName)
    local service = self.cache:GetService(jndiName)
    if service ~= nil then
        return service
    else
        --Every time you look up a server, a class of service loactor will be created. 
        --This is not very reasonable and it should be reused.
        local context = InitialContext.new()
        local service1 = context:Lookup(jndiName)
        self.cache:AddService(service1)
        return service1
    end
end

return _M