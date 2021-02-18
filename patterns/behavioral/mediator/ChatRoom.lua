--[[
    module:ChatRoom
    author:DylanYang
    time:2021-02-18 22:38:25
]]
local User = require("patterns.behavioral.mediator.User")

local super = require("patterns.behavioral.mediator.Mediator")
local _M = Class("ChatRoom", super)
local public = _M.public

_M.isFirst = true
_M.colleagues = {}

function public:CreateColleague(name)
    local user = User.new(name)
    user:SetMediator(self)
    table.insert(self.colleagues, user)
    return user
end

function public:ShowMessage(user, msg)
    local gap = self.isFirst and "" or "\n"
    local time = os.date("%Y-%m-%d %H:%M:%S", os.time()/1000)
    print(string.format("%s%s\n%s :\n\t%s", gap, time, user.name, msg))
    self.isFirst = false
end

return _M