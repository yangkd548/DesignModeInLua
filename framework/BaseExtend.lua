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

--Avoid overwriting global variables by disabed the definition of global variables.
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

luaVersion = _VERSION

--Unify the differences in the 'loadstring' function in the different versions of Lua.
loadstring = loadstring or load

local cacheStr = nil
local tab = "\t"
local tabs = nil
local tabCount = 0

local rawPrint = print

local function printCache()
    local temp = cacheStr
    cacheStr = nil
    rawPrint(temp)
end

local function doPrint(...)
    if cacheStr then
        printCache()
    end
    local args = {...}
    if #args == 0 then
        rawPrint("")
    else
        local temps = {}
        for i,v in ipairs(args) do
            table.insert(temps, v and IsTable(v) and v.ToString and v:ToString() or v)
        end
        rawPrint(unpack(temps))
    end
end

function print(...)
    tabs = nil
    doPrint(...)
end

function println(...)
    doPrint(...)
end

local function printf(args)
    local f = table.remove(args, 1)
    if f then
        if IsString(f) then
            local ss = string.split(f, "\n")
            if #ss > 1 then
                for i,v in ipairs(ss) do
                    --避免v是nil
                    v = v or ""
                    println(tabs..v)
                end
                if #args > 1 then
                    println(unpack(args))
                end
            else
                if #args > 1 then
                    println(tabs..f, unpack(args))
                else
                    println(tabs..f)
                end
            end
        elseif IsTable(f) then
            println(tabs..(f.ToString and f:ToString() or tostring(f)), unpack(args))
        end
    else
        println("nil", unpack(args))
    end
end

function printlt(...)
    local args = {...}
    tabs = tabs == nil and tab or tabs..tab
    if #args > 0 then
        printl(...)
    end
end

function printlb(...)
    local args = {...}
    if not string.isempty(tabs) then
        if #tabs == 1 then
            tabs = nil
        else
            tabs = string.sub(tabs, -#tabs + 1)
        end
    end
    if #args > 0 then
        printl(...)
    end
end

function printl(...)
    local args = {...}
    if #args == 0 then
        --Don't reset 'tabs', don't print 'tabs', just print a blank line.
        doPrint()
    else
        tabs = tabs or ""
        printf(args)
    end
end

function prints(str, todo)
    cacheStr = cacheStr and (cacheStr..str) or str
    if todo then
        printCache()
    end
end

--@TODO print相关扩展 说明：
--printlt   增加缩进，并进行打印
--printlb   减少缩进，并进行打印
--printl    保持缩进，并进行打印
--print     常规打印，重置缩进
--println   常规打印，不重置缩进
--prints    缓存打印，第二个参数，表示是否输出