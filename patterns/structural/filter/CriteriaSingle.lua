--[[
    module:CriteriaSingle
    author:DylanYang
    time:2021-02-09 14:31:24
]]
local Person = require("patterns.structural.filter.Person")

local super = require("patterns.structural.filter.Criteria")
local _M = Class("CriteriaSingle", super)

function _M.public:MeetCriteria(persons)
    local singles = {}
    for i, v in pairs(persons) do
        if v.marital == Person.MaritalType.Single then
            table.insert(singles, v)
        end
    end
    return singles
end

return _M