--[[
    module:CompositeTest
    author:DylanYang
    time:2021-02-09 15:24:18
]]
local Employee = require("patterns.structural.composite.Employee")

local super = require("patterns.BaseTest")
local _M = Class("CompositeTest", super)

function _M.protected:DoExecTest()
    local CEO = Employee.new("John","CEO", 30000)
    --sale team
    local headSales = Employee.new("Robert","Head Sales", 20000)
    --market team
    local headMarketing = Employee.new("Michel","Head Marketing", 20000)
    CEO:Add(headSales)
    CEO:Add(headMarketing)
    
    local salesExecutive1 = Employee.new("Richard","Sales", 10000)
    local salesExecutive2 = Employee.new("Rob","Sales", 10000)
    headSales:Add(salesExecutive1)
    headSales:Add(salesExecutive2)
    
    local clerk1 = Employee.new("Laura","Marketing", 10000)
    local clerk2 = Employee.new("Bob","Marketing", 10000)
    headMarketing:Add(clerk1)
    headMarketing:Add(clerk2)

    --打印该组织的所有员工
    print(CEO:ToString()) 
    for i, header in pairs(CEO:GetSubordinates()) do
        print(header:ToString())
        for j, employee in pairs(header:GetSubordinates()) do
            print(employee:ToString())
        end
    end
end

return _M