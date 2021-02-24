--[[
    module:  Student
    author:  DylanYang
    time:    2021-02-24 22:00:57
	idea:    
	advance: 
]]
local _M = Class("Student")
local public = _M.public

_M._name = nil
_M._rollNo = nil

function _M:ctor(name, rollNo)
    self._name = name
    self._rollNo = rollNo
end

function public.get:name()
    return self._name
end

function public.set:name(name)
    self._name = name
end

function public.get:rollNo()
    return self._rollNo
end

function public.set:rollNo(rollNo)
    self._rollNo = rollNo
end

return _M