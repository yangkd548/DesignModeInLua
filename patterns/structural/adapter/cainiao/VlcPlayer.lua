--[[
    module:VlcPlayer
    author:DylanYang
    time:2021-02-07 17:03:17
]]
local super = require("patterns.structural.adapter.cainiao.AdvancedMediaPlayer")
local _M = Class("VlcPlayer", super)

local public = _M.public

function public:PlayVlc(fileName)
    print(string.format("Playing vlc file. \n\t Name:%s", fileName))
end

function public:PlayMp4(fileName)
    --do nothing
end

return _M