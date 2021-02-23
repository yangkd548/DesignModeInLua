--[[
    module:  IContext
    author:  DylanYang
    time:    2021-02-23 14:23:03
	idea:    
	advance: 
]]
local _M = Class("IContext")
_M.abstract = true
local public = _M.public

function public:SetClock(hour)                -- 设置时间
end

function public:ChangeState(state)          -- 改变状态
end

function public:CallSecurityCenter(msg)    -- 联系警报中心
end

function public:RecordLog(msg)             -- 在警报中心留下记录
end

return _M