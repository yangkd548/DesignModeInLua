--[[
    module:  MvcTest
    author:  DylanYang
    time:    2021-02-24 13:03:40
	idea:    
	advance: 
]]
local StudentView = require("patterns.j2ee.mvc.StudentView")
local StudentController = require("patterns.j2ee.mvc.StudentController")
local Student = require("patterns.j2ee.mvc.Student")

local super = require("patterns.BaseTest")
local _M = Class("MvcTest", super)
local public = _M.public

function _M.protected:DoExecTest()
    --Get student records from the database.
    local model = self:RetrieveStudentFromDatabase()

    --Create a view that outputs student details to the console.
    local view = StudentView.new()
    local controller = StudentController.new(model, view)
    controller:UpdateView()

    --Update model data
    controller.studentName = "John"
    controller:UpdateView()
end

function _M:RetrieveStudentFromDatabase()
    local student = Student.new()
    student.name = "Robert"
    student.rollNo = 10
    return student
 end

return _M