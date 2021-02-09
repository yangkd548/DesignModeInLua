--[[
    module:CriteriaMale
    author:DylanYang
    time:2021-02-09 14:20:52
]]
local Person = require("patterns.structural.filter.Person")

local super = require("patterns.structural.filter.Criteria")
local _M = Class("CriteriaMale", super)

function _M.public:MeetCriteria(persons)
    local malePersons = {}
    for i, v in pairs(persons) do
        if v.gender == Person.GenderType.Male then
            table.insert(malePersons, v)
        end
    end
    return malePersons
end

return _M