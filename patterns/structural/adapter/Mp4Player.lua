--[[
    module:Mp4Player
    author:DylanYang
    time:2021-02-07 17:08:43
]]
local super = require("patterns.structural.adapter.AdvancedMediaPlayer")
local _M = Class("Mp4Player")
local public = _M.public

function public:PlayVlc(fileName)
    --do nothing
end

function public:PlayMp4(fileName)
    print(string.format("Playing mp4 file. \n\t Name:%s", fileName))
end

return _M