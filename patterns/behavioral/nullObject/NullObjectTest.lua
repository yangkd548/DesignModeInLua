--[[
    module:  NullObjectTest
    author:  DylanYang
    time:    2021-02-23 16:08:51
	idea:    
	advance: 
]]
local CustomerFactory = require("patterns.behavioral.nullObject.CustomerFactory")

local super = require("patterns.BaseTest")
local _M = Class("NullObjectTest", super)

function _M.protected:DoExecTest()
    local customer1 = CustomerFactory:GetCustomer("Rob")
    local customer2 = CustomerFactory:GetCustomer("Bob")
    local customer3 = CustomerFactory:GetCustomer("Julie")
    local customer4 = CustomerFactory:GetCustomer("Laura")

    print("Customers:")
    printlt(customer1.name)
    printl(customer2.name)
    printl(customer3.name)
    printl(customer4.name)
    printlb()
end

return _M