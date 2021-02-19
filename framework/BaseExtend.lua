--[[
    module : BaseExtend
    author : DylanYang
    time : 2020-11-10 10:54
    purpose : Is is used to expand the function of base.
]]
require("framework.Readonly")

INNER_MT_TYPES = Readonly {module = "OOP_module", inst = "OOP_inst", shell = "OOP_shell", class = "OOP_class", super = "OOP_super", member = "OOP_member", domain = "OOP_domain"}

DataTypes = {Func = "function", Tbl = "table", Str = "string", Num = "number"}
function IsFunction(v)
    return type(v) == DataTypes.Func
end
function IsTable(v)
    return type(v) == DataTypes.Tbl
end
function IsString(v)
    return type(v) == DataTypes.Str
end
function IsNumber(v)
    return type(v) == DataTypes.Num
end


local function printRequire(path, n, a)
    local str = " "
    for i = 1, n do
        str = str .. "\t"
    end
    str = n..str..string.format("require : %s:", a)
    print(str, path)
end

local tCount = 0
local isRunBusiness = false
--Whether to print the require structure of the framework
local tempPrint = false
local rawRequire = require
local function newRrequire(...)
    local args = {...}
    local path = args[1]
    if isRunBusiness or not tempPrint then
        rawRequire(path)
    else
        printRequire(path, tCount, ">>>")
        tCount = tCount + 1
        rawRequire(path)
        tCount = tCount - 1
        printRequire(path, tCount, "<<<")
        if tCount == 0 then print("") end
    end
    return package.loaded[path]
end

--The following code is used to solve the Lua language cyclic dependency problem.
function require(path)
    if isRunBusiness then
        return setmetatable({__type = INNER_MT_TYPES.module}, {
            __index = function(t, k)
                t = newRrequire(path)
                if k == "shell" then
                    return t
                end
                return t[k]
            end
        })
    else
        return newRrequire(path)
    end
end

--限制错误的定义全局数据
function Limit_G()
    isRunBusiness = true
    local __g = _G
    lgv = {}
    setmetatable(lgv, {
        __newindex = function(_, name, value)
            rawset(__g, name, value)
        end,
        __index = function(_, name)
            return rawget(__g, name)
        end
    })
    setmetatable(__g, {
        __newindex = function(_, name, value)
            error(string.format("USE \" lgv.%s = value \" INSTEAD OF SET GLOBAL VARIABLE", name), 0)
        end
    })
end

function handler(obj, method)
    return function(...)
        return method(obj, ...)
    end
end

function handlerPlus(obj, method, ...)
    local args = {...}
    return function(...)
        return method(obj, unpack(args), ...)
    end
end

function luaVersion()
    return _VERSION
end

--Unify the differences in the 'loadstring' function in the different versions of Lua.
loadstring = loadstring or load