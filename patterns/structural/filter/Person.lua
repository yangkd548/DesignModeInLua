--[[
    module:Person
    author:DylanYang
    time:2021-02-09 14:15:52
]]
local _M = Class("Person")
local public = _M.public

_M.static.public.readonly.GenderType = {
    Female = "female",
    Male = "male",
}

_M.static.public.readonly.MaritalType = {
    Single = "single",
    Married = "married",
    Widowed = "widowed",
    Divorced = "divorced"
}

_M._name = nil
_M._gender = nil
_M._marital = nil

function _M:ctor(name, gender, marital)
    self._name = name
    self._gender = gender
    self._marital = marital
end

function public.get:name()
    return self._name
end

function public.get:gender()
    return self._gender
end

function public.get:marital()
    return self._marital
end

return _M