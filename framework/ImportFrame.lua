--[[
    module : ImportFrame
    author : DylanYang
    time : 2021-1-27 21:50:46
    purpose : Import the required framework scripts
]]
--"BaseExtend" modifies the "require", but does not use the modified "require".
--@TODO 需要实现require方法，能够兼容，相对于当前文件的路径的require
require("framework.BaseExtend")
require("framework.PathExtend")
require("framework.TableExtend")
require("framework.StringExtend")
require("framework.math.Random")
require("framework.Class")
require("framework.Bit")
require("framework.config.PrimaryColor")
Limit_G()