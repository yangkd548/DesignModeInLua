--[[
    module:  TheContext
    author:  DylanYang
    time:    2021-02-23 14:26:36
	idea:    
	advance: 
]]
local DayState = require("patterns.behavioral.state.DayState")

local interface = require("patterns.behavioral.state.IContext")
local _M = Class("TheContext", interface)
local public = _M.public

_M.state = nil

function public:SetClock(hour)                -- 设置时间
    if self.state == nil then
        if not DayState.new():DoClock(self, hour) then
            self:ChangeState(self.state)
        end
    else
        self.state:DoClock(self, hour)
    end
end

function public:ChangeState(state)          -- 改变状态
    self.state = state
    printlb(string.format("进入新状态：%s", self.state))
    return true
end

function public:CallSecurityCenter(msg)    -- 联系警报中心
    printl(string.format("record : %s", msg))
end

function public:RecordLog(msg)             -- 在警报中心留下记录
    printl(string.format("record : %s", msg))
end

function public:RandomTest()
    local index = self.state:RandomTest()
    if index == 1 then
        self.state:DoUse(self)
    elseif index == 2 then
        self.state:DoPhone(self)
    elseif index == 3 then
        self.state:DoAlarm(self)
    else
        printlt("...")
    end
    printlb()
end

return _M