--[[
    module:  IState
    author:  DylanYang
    time:    2021-02-23 13:56:47
	idea:    
	advance: 
]]
local _M = Class("IState")
_M.abstract = true
local public = _M.public

function public:DoClock(context, hour)    -- 设置时间
end

function public:DoUse(context)                -- 使用金库
end

function public:DoAlarm(context)              -- 按下警铃
end

function public:DoPhone(context)              -- 正常通话
end

return _M