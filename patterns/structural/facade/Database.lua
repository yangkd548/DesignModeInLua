--[[
    module:Database
    author:DylanYang
    time:2021-02-09 21:28:58
]]
local Properties = require("patterns.structural.facade.Properties")
local FileReader = require("framework.io.FileReader")

local _M = Class("Database")

function _M.private:ctor()
end

function _M.static.public:GetProperties(dbname)
    local filename = string.format("%s.txt", dbname)
    local path = string.format("%s/%s", os.GetCurDir(), filename)
    local prop = Properties.new()
    prop:Load(FileReader.new(path))
    return prop
end

return _M