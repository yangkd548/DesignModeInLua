--[[
    module:  FilterManager
    author:  DylanYang
    time:    2021-02-25 11:47:02
	idea:    
	advance: 
]]
local FilterChain = require("patterns.j2ee.interceptingFilter.FilterChain")

local _M = Class("FilterManager")
local public = _M.public

_M.filterChain = nil

function _M:ctor(target)
    self.filterChain = FilterChain.new()
    self.filterChain.target = target
end

function public:SetFilter(filter)
    self.filterChain:AddFilter(filter)
end

function public:FilterRequest(request)
    self.filterChain:Execute(request)
end

return _M