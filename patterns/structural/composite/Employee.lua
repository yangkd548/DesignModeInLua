--[[
    module:Employee
    author:DylanYang
    time:2021-02-09 15:53:22
]]
local _M = Class("Employee")
local public = _M.public

_M.private.name = nil
_M.dept = nil
_M.salary = nil
_M.private.subordinates = nil

function _M:ctor(name, dept, sal)
    self.name = name
    self.dept = dept
    self.salary = sal
    self.subordinates = {}
end

function public:Add(emp)
    table.insert(self.subordinates, emp)
end

function public:Remove(emp)
    local i = table.indexof(self.subordinates, emp)
    if i then
        table.remove(self.subordinates, i)
    end
end

function public:GetSubordinates()
    return self.subordinates
end

function public:ToString()
    return string.format("Employee : [ Name : %s, dept : %s, salary : %s ]", self.name, self.dept, self.salary)
end

return _M