--[[
    module:  TransferObjectTest
    author:  DylanYang
    time:    2021-02-24 13:05:43
	idea:    
	advance: 
]]
local StudentBO = require("patterns.j2ee.transferObject.StudentBO")

local super = require("patterns.BaseTest")
local _M = Class("TransferObjectTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    local studentBusinessObject = StudentBO.new()

    --Output all students
    for i, student in ipairs(studentBusinessObject:GetAllStudents()) do
        print(string.format("Student: [RollNo : %s, Name : %s ]", student.rollNo, student.name))
    end

    --This code can't do a real simulation.
    
    --Update student
    local student = studentBusinessObject:GetAllStudents()[1]
    student.name = "Michael"
    studentBusinessObject:UpdateStudent(student)

    --get a student
    local student = studentBusinessObject:GetStudent(1)
    print(string.format("Student: [RollNo : %s, Name : %s ]", student.rollNo, student.name))
end

return _M