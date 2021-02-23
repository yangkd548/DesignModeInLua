--[[
    module:  NightState
    author:  DylanYang
    time:    2021-02-23 14:20:25
	idea:    
	advance: 
]]
local DayState = require("patterns.behavioral.state.DayState")

local interface = require("patterns.behavioral.state.IState")
local _M = Class("NightState", interface)
_M.singleton = true
local public = _M.public

function public:DoClock(context, hour)    -- 设置时间
    if hour >= 9 and hour < 17 then
        return context:ChangeState(DayState.new())
    end
end

function public:DoUse(context)                -- 使用金库
    context:RecordLog("紧急：晚上使用金库！")
end

function public:DoAlarm(context)              -- 按下警铃
    context:CallSecurityCenter("按下警铃(晚上)")
end

function public:DoPhone(context)              -- 正常通话
    context:CallSecurityCenter("晚上的通话录音")
end

function public:ToString()
    return "[晚上]"
end

function public:RandomTest()
    if random.nextFloat() < 0.5 then
        return 0
    else
        local ran = random.nextFloat()
        if ran < 0.35 then
            return 1
        elseif ran < 0.7 then
            return 2
        else
            return 3
        end
    end
end

return _M