--[[
    module : BaseExtend
    author : DylanYang
    time : 2020-11-10 10:54
    purpose : Is is used to expand the function of base.
]]
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

local rawRequire = require
function require(...)
    local args = {...}
    if package.loaded[args[1]] == nil then
        --@TODO 2020-11-12 16:41:35 做必要的检测处理
        --1.例如，创建一个对象，调用所有的public方法，检测方法内的错误？这需要合理的参数才行
        package.loaded[args[1]] = rawRequire(...)
    end
    return package.loaded[args[1]]
end

--限制错误的定义全局数据
function Limit_G()
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