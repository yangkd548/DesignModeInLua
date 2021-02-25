--[[
    module:  InitialContext
    author:  DylanYang
    time:    2021-02-25 13:40:17
	idea:    
	advance: 
]]
local Service1 = require("patterns.j2ee.serverLocator.Service1")
local Service2 = require("patterns.j2ee.serverLocator.Service2")

local _M = Class("InitialContext")
local public = _M.public

function public:Lookup(jndiName)
    if string.upper(jndiName) == "SERVICE1" then
        print("Looking up and creating a new Service1 object")
        return Service1.new()
    elseif string.upper(jndiName) == "SERVICE2" then
        print("Looking up and creating a new Service2 object")
        return Service2.new()
    end
    return nil
end

return _M