--[[
    module:Memento
    author:DylanYang
    time:2021-02-20 17:49:59
    idea:This class provides methods to write and get all state properties.
]]
local _M = Class("Memento")
local public = _M.public
local private = _M.private

_M.sealed = false

_M._money = nil
_M._fruits = {}

function public:SetSealed()
    self.sealed = true
end

function public.get:money()
    return self._money
end

function public.set:money(value)
    if not self.sealed then
        self._money = value
    else
        self:ErrorSealed()
    end
end

--The 'array objects' obtained through 'get' is a copy.
function public.get:fruits()
    return table.copy(self._fruits)
end

--The 'array objects' is stored internally as a copy.
function public.set:fruits(value)
    if not self.sealed then
        self._fruits = table.copy(value)
    else
        self:ErrorSealed()
    end
end

function private:ErrorSealed()
    error("This product has been sealed and no further modification is allowed.")
end

return _M