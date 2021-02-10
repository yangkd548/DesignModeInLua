--[[
    module:Database
    author:DylanYang
    time:2021-02-09 21:28:58
]]
local Properties = require("patterns.structural.facade.Properties")
local FileReader = require("patterns.structural.facade.FileReader")

local _M = Class("Database")

function _M.private:ctor()
end

function _M.static.public:GetProperties(dbname)
    local filename = string.format("%s.txt", dbname)
    local prop = Properties.new()
    prop:Load(FileReader.new(filename))
    return prop
end

return _M