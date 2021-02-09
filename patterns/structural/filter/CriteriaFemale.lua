--[[
    module:CriteriaFemale
    author:DylanYang
    time:2021-02-09 14:24:28
]]
local Person = require("patterns.structural.filter.Person")

local super = require("patterns.structural.filter.Criteria")
local _M = Class("CriteriaFemale")

function _M.public:MeetCriteria(persons)
    local femalePersons = {}
    for i, v in pairs(persons) do
        if v.gender == Person.GenderType.Female then
            table.insert(femalePersons, v)
        end
    end
    return femalePersons
end

return _M