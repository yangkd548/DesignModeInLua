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