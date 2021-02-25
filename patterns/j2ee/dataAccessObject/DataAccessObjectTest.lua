--[[
    module:  DataAccessObjectTest
    author:  DylanYang
    time:    2021-02-24 13:04:38
	idea:    For the current example, it is only running in simulation.
	advance: 
]]
local StudentDaoImpl = require("patterns.j2ee.dataAccessObject.StudentDaoImpl")

local super = require("patterns.BaseTest")
local _M = Class("DataAccessObjectTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    local studentDao = StudentDaoImpl.new()

    --print all students
    for i, student in pairs(studentDao:GetAllStudents()) do
        print(string.format("Student: [RollNo : %s, Name : %s ]", student.rollNo, student.name))
    end

    --update student
    local student =studentDao:GetAllStudents()[1]
    student.name = "Michael"
    --Emulation: From memory, update to database
    studentDao:UpdateStudent(student)

    --get student
    local student = studentDao:GetStudent(1)
    print(string.format("Student: [RollNo : %s, Name : %s ]", student.rollNo, student.name))
end

return _M