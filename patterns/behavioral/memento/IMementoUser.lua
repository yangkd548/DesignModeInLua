--[[
    module:  IMementoUser
    author:  DylanYang
    time:    2021-02-20 20:06:00
	idea:    
	advance: 
]]
local _M = Class("IMementoUser")
_M.abstract = true
local public = _M.public

function public:CreateMemento()
end

function public:RestoreMemento(memento)
end

return _M