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
    --从数据库获取学生记录
    local model = self:RetrieveStudentFromDatabase()

    --创建一个视图：把学生详细信息输出到控制台
    local view = StudentView.new()
    local controller = StudentController.new(model, view)
    controller:UpdateView()

    --更新模型数据
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