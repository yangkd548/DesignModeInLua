--[[
    module:  StudentBO
    author:  DylanYang
    time:    2021-02-25 14:14:20
	idea:    
	advance: 
]]
local StudentVO = require("patterns.j2ee.transferObject.StudentVO")

local _M = Class("StudentBO")
local public = _M.public

--The following list is used as a database.
_M.students = nil

function _M:ctor()
    self.students = {}
    local student1 = StudentVO.new("Robert", 1)
    local student2 = StudentVO.new("John", 2)
    table.insert(self.students, student1)
    table.insert(self.students, student2)
end

function public:DeleteStudent(student)
    students.remove(student.rollNo)
    print(string.format("Student: Roll No %s, deleted from database", student.rollNo))
end

--Retrieve the list of students from the database
function public:GetAllStudents()
    return self.students
end

function public:GetStudent(rollNo)
    return self.students[rollNo]
end

function public:UpdateStudent(student)
    self.students[student.rollNo].name = student.name
    print(string.format("Student: Roll No %s, updated in the database", student.rollNo))
end

return _M