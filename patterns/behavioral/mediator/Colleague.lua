--[[
    module:Colleague
    author:DylanYang
    time:2021-02-18 11:55:51
]]
local _M = Class("Colleague")
_M.abstract = true
local public = _M.public

function public:SetMediator(mediator)
end

function public:SendMessage(msg)
end

return _M