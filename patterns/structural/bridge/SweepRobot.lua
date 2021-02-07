--[[
    module:SweepRobot
    author:DylanYang
    time:2021-02-07 20:04:04
]]
local super = require("patterns.structural.bridge.IEquipRun")
local _M = Class("SweepRobot")
local public = _M.public

_M.private.name = nil
_M.private.type = "normal" -- "strong"

function _M:ctor(name)
    self.name = name
end

function public:PowerOn()
    print(string.format("The %s is starting up. Please wait a moment.", self.name))
    self.Start()
end

function public:PowerOff()
    print(string.format("Byebye! The '%s' is power off.", self.name))
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
    print(string.format("'%s' had paused.", self.name))
end

return _M