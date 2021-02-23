--[[
    module:  AbstractDisplay
    author:  DylanYang
    time:    2021-02-23 23:39:22
	idea:    
	advance: 
]]
local _M = Class("AbstractDisplay")
local public = _M.public

function public:Open()
end

function public:Print()
end

function public:Close()
end

function public:Display()
    self:Open()
    for i=1, 5 do
        self:Print()
    end
    self:Close()
end

return _M