--[[
    module:  IStudentDao
    author:  DylanYang
    time:    2021-02-24 22:04:52
	idea:    
	advance: 
]]
local _M = Class("IStudentDao")
_M.abstract = true
local public = _M.public

function public:GetAllStudents()
end

function public:GetStudent(rollNo)
end

function public:UpdateStudent(student)
end

function public:DeleteStudent(student)
end

return _M