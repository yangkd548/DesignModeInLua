--[[
    module:Support
    author:DylanYang
    time:2021-02-11 17:23:44
]]
local _M = Class("Support")
_M.abstract = true
local public = _M.public
local protected = _M.protected

_M.name = nil
_M.next = nil

function _M:ctor(name)
    self.name = name
end

function public:SetNext(next)
    self.next = next
    return next
end

function public:Support(trouble)
    if self:Resolve(trouble) then
        self:Done(trouble)
    elseif self.next ~= nil then
        self.next:Support(trouble)
    else
        self:Fail(trouble)
    end
end

function protected:Resolve(trouble)
end

function protected:Done(trouble)
    print(string.format("%s is resolved by %s.", trouble.number, self.name))
end

function protected:Fail(trouble)
    print(string.format("%s can't be resolved.", trouble.number))
end

return _M