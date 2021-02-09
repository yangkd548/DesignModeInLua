--[[
    module:Display
    author:DylanYang
    time:2021-02-09 11:01:17
]]
local _M = Class("Display")
local public = _M.public

_M.private.impl = nil

function _M:ctor(impl)
    self.impl = impl
end

function public:Open()
    self.impl:RawOpen()
end

function public:Print(index)
    self.impl:RawPrint(index)
end

function public:Close()
    self.impl:RawClose()
end

function public:Display()
    self:Open()
    self:Print()
    self:Close()
end

return _M