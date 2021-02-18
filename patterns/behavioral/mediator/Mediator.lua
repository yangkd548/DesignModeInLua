--[[
    module:Mediator
    author:DylanYang
    time:2021-02-18 11:34:34
]]
local _M = Class("Mediator")
_M.abstract = true
local public = _M.public

function public:CreateColleagues()
end

function public:ShowMessage(user, msg)
end

return _M