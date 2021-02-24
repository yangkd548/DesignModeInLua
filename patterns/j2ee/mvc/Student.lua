--[[
    module:  Student
    author:  DylanYang
    time:    2021-02-24 12:28:31
	idea:    
	advance: 
]]
local _M = Class("Student")
local public = _M.public

_M._rollNo = nil
_M._name = nil

function public.get:rollNo()
    return self._rollNo
end

function public.set:rollNo(rollNo)
    self._rollNo = rollNo
end

function public.get:name()
    return self._name
end

function public.set:name(name)
    self._name = name
end

return _M