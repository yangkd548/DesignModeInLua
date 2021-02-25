--[[
    module:  StudentVO
    author:  DylanYang
    time:    2021-02-25 14:13:42
	idea:    
	advance: 
]]
local _M = Class("StudentVO")
local public = _M.public

_M._rollNo = nil
_M._name = nil

function _M:ctor(name, rollNo)
    self._rollNo = rollNo
    self._name = name
end

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