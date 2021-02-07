--[[
    module:AirConditon
    author:DylanYang
    time:2021-02-07 19:44:13
]]
local super = require("patterns.structural.bridge.IEquipRun")
local _M = Class("AirConditon")
local public = _M.public

_M.private.name = nil
_M.private.type = "coding" -- "heating"

function _M:ctor(name)
    self.name = name
end

function public:PowerOn()
    print(string.format("After power on, the '%s' will run in setting of last.", self.name))
    self.Start()
end

function public:PowerOff()
    print(string.format("The '%s' will power off.", self.name))
end

function public:Setting(type)
    self.type = type
    print(string.format("Mode of runing had changed to %s.", self.type))
    self:Start()
end

function public:Start()
    print(string.format("Start runing ! pattern : %s .", self.type))
end

function public:Pause()
    print(string.format("The '%s' had paused.", self.name))
end

return _M