--[[
    module:  CompositeEntity
    author:  DylanYang
    time:    2021-02-24 21:35:14
	idea:    Compared to 'CoarseGrainedObject', it is only one more level and can contain other content.
	advance: 
]]
local CoarseGrainedObject = require("patterns.j2ee.compositeEntity.CoarseGrainedObject")

local _M = Class("CompositeEntity")
local public = _M.public

_M.cgo = nil

function _M:ctor()
    self.cgo = CoarseGrainedObject.new()
end

function public:SetData(data1, data2)
    self.cgo:SetData(data1, data2)
end

function public:GetData()
    return self.cgo:GetData()
end

return _M