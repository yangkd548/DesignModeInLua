--[[
    Module:Readonly
    Author:DylanYang
    Time:2020-11-03 11:37:34
]]
local function errorUpdateReadonly(k, level)
    error(string.format("attempt to update a read-only table : (%s)", k), 4)
end

function RepeatReadOnly(  )
    print("Notice : This table is read-only!")
end

function Readonly(tbl)
    local mt = getmetatable(tbl)
    if mt ~= nil and mt.__readonly then
        --__readonly作为只读处理的内部标记，且不允许修改
        RepeatReadOnly()
    else
        local mt = {
            __index = function(t, k)
                if k == "__readonly" then
                    return true
                else
                    return tbl[k]
                end
            end,
            __newindex = function(t, k, v)
                errorUpdateReadonly(k)
            end,
            __pairs = function(t)
                return pairs(tbl)
            end,
            __len = function(t)
                return #tbl
            end,
            __metatable = "The metatable of readonly is hidden!"
        }
        return setmetatable({}, mt)
    end
    return tbl
end

function readOnlyDeep(tbl)
    local tempTables = {}
    local function _readOnlyDeep(tbl)
        if not tempTables[tbl] then
            local mt = getmetatable(tbl)
            if mt == nil then
                mt = {}
                setmetatable(tbl, mt)
            end

            local proxy = mt.__proxy
            if not proxy then
                proxy = {}
                local mt = {
                    __index = tbl,
                    __newindex = function(t, k, v)
                        errorUpdateReadonly(k)
                    end,
                    __pairs = function(t)
                        return pairs(tbl)
                    end,
                    __len = function(t)
                        return #tbl
                    end,
                    __proxy = proxy,
                    __metatable = "The metatable of readonly is hidden!"
                }
                setmetatable(proxy, mt)
            end
            tempTables[tbl] = proxy

            for k, v in pairs(tbl) do
                if type(v) == "table" then
                    tbl[k] = _readOnlyDeep(v)
                end
            end
        end
        return tempTables[tbl]
    end
    return _readOnlyDeep(tbl)
end