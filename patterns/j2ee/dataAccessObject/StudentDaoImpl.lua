--[[
    module:  StudentDaoImpl
    author:  DylanYang
    time:    2021-02-24 22:15:20
	idea:    
	advance: 
]]
local Student = require("patterns.j2ee.dataAccessObject.Student")

local interface = require("patterns.j2ee.dataAccessObject.IStudentDao")
local _M = Class("StudentDaoImpl", interface)
local public = _M.public

--The following list is used as a database.
_M.students = {}

function _M:ctor()
    local student1 = Student.new("Robert", 1)
    local student2 = Student.new("John", 2)
    table.insert(self.students, student1)
    table.insert(self.students, student2)
end

function public:GetAllStudents()
    return self.students
end

function public:GetStudent(rollNo)
    return self.students[rollNo]
end

function public:UpdateStudent(student)
    --这里的作用，是否有问题？
    self.students[student.rollNo].name = student.name
    print(string.format("Student: Roll No %s, updated in the database", student.rollNo))
end

function public:DeleteStudent(student)
    students.remove(student.rollNo)
    print(string.format("Student: Roll No %s, deleted from database.", student.rollNo))
end

return _M