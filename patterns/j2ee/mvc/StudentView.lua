--[[
    module:  StudentView
    author:  DylanYang
    time:    2021-02-24 13:43:55
	idea:    
	advance: 
]]
local _M = Class("StudentView")
local public = _M.public

function public:PrintStudentDetails(studentName, studentRollNo)
    print("Student: ")
    printlt("Name: " .. studentName)
    printl("Roll No: " .. studentRollNo)
    print()
end

return _M