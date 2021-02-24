--[[
    module:  StudentController
    author:  DylanYang
    time:    2021-02-24 13:45:46
	idea:    
	advance: 
]]
local _M = Class("StudentController")
local public = _M.public

_M.model = nil
_M.view = nil

function _M:ctor(model, view)
    self.model = model
    self.view = view
end

function public.set:studentName(name)
    self.model.name = name
end

function public.get:studentName()
    return self.model.name
end

function public.set:studentRollNo(rollNo)
    self.model.rollNo = rollNo
end

function public.get:studentRollNo()
    return self.model.rollNo
end

function public:UpdateView()
    self.view:PrintStudentDetails(self.studentName, self.studentRollNo)
end

return _M