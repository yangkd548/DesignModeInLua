--[[
    module:  Client
    author:  DylanYang
    time:    2021-02-24 21:38:56
	idea:    
	advance: 
]]
local CompositeEntity = require("patterns.j2ee.compositeEntity.CompositeEntity")

local _M = Class("Client")
local public = _M.public

_M.compositeEntity = nil

function _M:ctor()
    self.compositeEntity = CompositeEntity.new()
end

function public:PrintData()
    local datas = self.compositeEntity:GetData()
    for i = 1, #datas do
        print("Data: " .. datas[i])
    end
end

function public:SetData(data1, data2)
    self.compositeEntity:SetData(data1, data2)
end

return _M