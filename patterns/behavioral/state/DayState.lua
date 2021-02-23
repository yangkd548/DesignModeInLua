--[[
    module:  DayState
    author:  DylanYang
    time:    2021-02-23 14:13:03
	idea:    
	advance: 
]]
local NightState = require("patterns.behavioral.state.NightState")

local interface = require("patterns.behavioral.state.IState")
local _M = Class("DayState", interface)
_M.singleton = true
local public = _M.public

function public:DoClock(context, hour)    -- 设置时间
    if hour < 9 or hour >= 17 then
        return context:ChangeState(NightState.new())
    end
end

function public:DoUse(context)                -- 使用金库
    context:RecordLog("使用金库(白天)")
end

function public:DoAlarm(context)              -- 按下警铃
    context:CallSecurityCenter("按下警铃(白天)")
end

function public:DoPhone(context)              -- 正常通话
    context:CallSecurityCenter("正常通话(白天)")
end

function public:ToString()
    return "[白天]"
end

function public:RandomTest()
    if random.nextFloat() < 0.1 then
        return 0
    else
        local ran = random.nextFloat()
        if ran < 0.3 then
            return 1
        elseif ran < 0.7 then
            return 2
        else
            return 3
        end
    end
end

return _M