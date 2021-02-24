--[[
    module:  CoarseGrainedObject
    author:  DylanYang
    time:    2021-02-24 21:23:13
	idea:    Combine two objects into a single coarse-grained object for unified management.
	advance: 
]]
local DependentA = require("patterns.j2ee.compositeEntity.DependentA")
local DependentB = require("patterns.j2ee.compositeEntity.DependentB")

local _M = Class("CoarseGrainedObject")
local public = _M.public

_M.do1 = DependentA.new()
_M.do2 = DependentB.new()

function public:SetData(data1, data2)
    self.do1.data = data1
    self.do2.data = data2
end

function public:GetData()
    return {self.do1.data, self.do2.data}
end

return _M