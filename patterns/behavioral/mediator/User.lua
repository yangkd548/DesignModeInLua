--[[
    module:User
    author:DylanYang
    time:2021-02-18 22:47:27
]]
local super = require("patterns.behavioral.mediator.Colleague")
local _M = Class("User", super)
local public = _M.public

_M._name = nil
_M.mediator = nil

function _M:ctor(name)
    self._name = name
end

function public.get:name()
    return self._name
end

function public.set:name(value)
    self._name = value
end

function public:SetMediator(mediator)
    self.mediator = mediator
end

function public:SendMessage(msg)
    self.mediator:ShowMessage(self, msg)
end

return _M