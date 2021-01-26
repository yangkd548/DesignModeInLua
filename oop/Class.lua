--[[
    module:Class
    author:DylanYang
    time:2020-10-14 16:08:08
]]
require("oop.Readonly")
require("oop.Bit")
require("oop.BaseExtend")
require("oop.TableExtend")

function Import(moduleName, currentModuleName)
    local currentModuleNameParts
    local moduleFullName = moduleName
    local offset = 1
    while true do
        if string.byte(moduleName, offset) ~= 46 then -- .
            moduleFullName = string.sub(moduleName, offset)
            if currentModuleNameParts and #currentModuleNameParts > 0 then
                moduleFullName = table.concat(currentModuleNameParts, ".") .. "." .. moduleFullName
            end
            break
        end
        offset = offset + 1
        if not currentModuleNameParts then
            if not currentModuleName then
                local n, v = debug.getlocal(3, 1)
                currentModuleName = v
            end
            currentModuleNameParts = string.split(currentModuleName, ".")
        end
        table.remove(currentModuleNameParts, #currentModuleNameParts)
    end
    return require(moduleFullName)
end

--@region OOP base
local AllCls = {}
local SingleInsts = {}
local function GetShellClass(shell)
    return AllCls[shell and shell.__name or nil]
end
--增加Readonly，无法用于元表查找
local OOP_MT_NAMES = {inst = "OOP_inst", module = "OOP_module", class = "OOP_class", super = "OOP_super", member = "OOP_member"}
local Null = {__name = "Null"}
local NullFunc = function()
end
local function SetFilterNil(v)
    return v ~= nil and v or Null
end
local function GetFilterNull(v)
    return v ~= Null and v or nil
end
--下面4个属性表，在正式lua5.3运行环境下，可以加Readonly处理（lua5.1不支持__pairs，会报错）
local StorageType =  {default = nil, static = 2}  --------------------作为访问域前面的存储空间的控制
local DomainType =  {private = nil, public = 1, protected = 2}    ----访问域，在static和非static都有
local ReadType =  {default = nil, readonly = 1}  ---------------------仅对MemberType中default起作用
local MemberType =  {default = nil, set = 1, get = 2} ----------------成员类型，default包含function、variable

local MemberProperties = {domain = "d", readonly = "r", static = "s", type = "t", value = "v"}
local MemberPropertieTypes = {d = DomainType, r = ReadType, s = StorageType, t = MemberType}

local function GetKeyByValue(tbl, value)
    for k,v in pairs(tbl) do
        if v == value then
            return k
        end
    end
end

local function GetInstClass(inst)
    local shell = rawget(inst, "class")
    return shell and GetShellClass(shell) or inst
end
local function GetClassName(cls)
    return cls and cls.__name or ""
end
local function GetInstClassName(inst)
    local cls = GetInstClass(inst)
    return GetClassName(cls)
end
local function GetIndexInfo(cls, k)
    return cls.__name .. "." .. k
end

--类操作 相关
local function ErrorClassSuperType(name, type, level)
    error(string.format("The super class of current class (%s) you define is a '%s'", name, type), level or 3)
end
local function ErrorNoSuperCls(name, superName, level)
    error(string.format("The super class (%s) of the class (%s) you define is not exist!", superName or "nil", name), level or 3)
end
local function ErrorRepeatClass(__name, level)
    error(string.format("The class '%s' is already defined!", __name), level or 3)
end

--实例化 相关
local function ErrorAbstract(cls, level)
    --@TODO:new方法调用，为何不能显示正确行号
    error(string.format("Abstract class (%s) cannot be instantiated.", GetClassName(cls)), level or 4)
end

--成员定义 相关
local function ErrorRepeatQualifier(k, tbl, v, level)--修饰符重复
    local sKey = GetKeyByValue(tbl, v)
    local tbl = MemberPropertieTypes[sKey]
    local key = GetKeyByValue(tbl, v)
    error(string.format("attempt to repeat set keyward '%s' (existing：%s).", k, key), level or 4)
end
local function ErrorDefineKeyword(k, level)
    --@TODO:如果能通过debug代码，分析出Class外的首层代码的层级，是最好了；或者可以根据代码记录，最终得到
    error(string.format("attempt to use 'keyword' (%s) for member's name.", k), level or 5)
end
local function ErrorForbid__Property(k, level)
    error(string.format("The name (%s) of member beginning with '__' are forbidden to use.", k), level or 3)
end
local function ErrorMustFunction(k, level)
    error(string.format("The '%s' can only be a function!", k), level or 5)
end
local function ErrorRepeatDefine(cls, k, level)--成员定义重复
    --@TODO:如果能通过debug代码，分析出Class外的首层代码的层级，是最好了；或者可以根据代码记录，最终得到
    error(string.format("This member (%s) already exists in the '%s', cannot be repeatedly defined.", k, cls.__name), level or 5)
end
local function ErrorCtorProperties(cls, level)
    error(string.format("This member (%s) does not allow to setting properties.", GetIndexInfo(cls, "ctor")), level or 5)
end

--成员访问 相关
local function ErrorNoExist(cls, k, level)
    error(string.format("attempt to call member '%s' (no-exist).", GetIndexInfo(cls, k)), level or 3)
end
local function ErrorCallPrivate(cls, k, level)
    error(string.format("attempt to call member '%s' (private).", GetIndexInfo(cls, k)), level or 5)
end
local function ErrorCallProtected(cls, k, level)
    error(string.format("attempt to call member '%s' (protected).", GetIndexInfo(cls, k)), level or 5)
end
local function ErrorGet(cls, k, level)
    error(string.format("attempt to get accessor '%s' (set).", GetIndexInfo(cls, k)), level or 3)
end
local function ErrorSet(cls, k, level)
    error(string.format("attempt to set accessor '%s' (get).", GetIndexInfo(cls, k)), level or 3)
end
local function ErrorReadOnly(cls, k, level)
    error(string.format("attempt to call accessor '%s' (readonly), in non ctor.", GetIndexInfo(cls, k)), level or 3)
end
local function ErrorNotStatic(cls, k, level)
    error(string.format("attempt to call member '%s' (not-static).", GetIndexInfo(cls, k)), level or 3)
end
local function ErrorModifyInnerFunc(funcName, level)--尝试通过self修改ctor和dtor
    error(string.format("The '%s' member of class, which cannot be modify directly.", funcName), level or 3)
end

--成员覆盖 相关
local function ErrorCoverCurClassMember(cls, k, level)
    error(string.format("The member (%s) of the current class is repeatedly defined", GetIndexInfo(cls, k)), level or 5)
end
local function ErrorCoverSuperPrivateMember(k, superCls, curCls, level)
    error(string.format("This private member (%s) already exists in the '%s' (cur:'%s'), cannot be repeatedly defined.", k, GetClassName(superCls), GetClassName(curCls)), level or 5)
end
local function ErrorCoverSuperDiffDoamin(k, superCls, curCls, level)
    error(string.format("This domains of members (%s) in the '%s' and '%s'(cur) are different.", k, GetClassName(superCls), GetClassName(curCls)), level or 5)
end

--访问基类的成员（读取self.super的ctor和成员） 相关
local function ErrorAttemptCtor(cls, k, level)
    error(string.format("Class ctor method cannot be called outside (%s).", GetIndexInfo(cls, k)), level or 3)
end
local function ErrorAttemptSuper(cls, level)
    error(string.format("Access Super directly using 'self.super', not module (%s).", GetClassName(cls)), level or 3)
end
local function ErrorAttemptClassCtor(cls, level)
    error(string.format("Error: Accessing the 'ctor' mothed of the super class of '%s', the first argument is not 'self'(object of cur class)!", GetClassName(cls)), level or 3)
end
local function ErrorAssignSuperMember(cur, super, k, level)
    error(string.format("Access to the member (%s) of super class through 'self.super' is not allowed to write.", GetIndexInfo(super, k)), level or 3)
end
local function ErrorSuperNoExist(cls, k, level)
    error(string.format("attempt to call member '%s' (no-exist) of super class .", GetIndexInfo(cls, k)), level or 3)
end
local function ErrorAttemptSuperVar(cls, k, level)
    error(string.format("forbid to call variable '%s' by 'self.super'.", GetIndexInfo(cls, k)), level or 3)
end

--方法访问 相关
local function ErrorDotAttemptFunc(k, level)--限制只能用“:”(冒号)访问function
    error(string.format("Please use ':' access method (%s).", k), level or 3)
end

local function AddDomainProperty(member, k)
    member.d = DomainType[k]
end
local function AddStaticProperty(member, k)
    member.s = StorageType.static
end
local function AddReadonlyProperty(member, k)
    member.r = ReadType.readonly
end
local function AddTypeProperty(member, k)
    member.t = MemberType[k]
end
local function DoSetMemberValue(cls, k, member, v)
    member.v = SetFilterNil(v)
    member.c = cls
    rawset(cls, k, member)
end
local function SetMemberValue(cls, k, member, v)
    --get/set成员，必须是function，否则报错
    if member and (member.t == MemberType.get or member.t == MemberType.set) and not IsFunction(v) then
        ErrorMustFunction(string.format("%s.%s.%s", cls.__name, GetKeyByValue(MemberType, member.t), k), 5)
    end
    DoSetMemberValue(cls, k, member, v)
end

--禁止修改，并且字段也自动作为关键字
-- __index = true, __newindex = true, __pairs = true, __len = true, __metatable = true, __proxy = true,
-- __readonly = true, __shell = true, singleton = true, abstract = true, __ctype = true, __create = true, __inst = true
--__name表示类本身的名字，跟类模板和类实例的name，加以区分
local InnerProperty = {singleton = true, abstract = true}
local InnerFunction = {}
local ClsShellKeys = Readonly {super = true, new = true, dtor = true}--super用于self.super:XXXX访问父类的方法，避免歧义，用module缩写_M定义成员时禁用
local function IsClsShellKeys(k)
    return ClsShellKeys[k]
end
local ModifyKeyFunc = {
    public = AddDomainProperty, protected = AddDomainProperty, private = AddDomainProperty,
    static = AddStaticProperty,
    readonly = AddReadonlyProperty,
    set = AddTypeProperty, get = AddTypeProperty
}
local ModifyKeyProperty = {
    public = MemberProperties.domain, protected = MemberProperties.domain, private = MemberProperties.domain,
    static = MemberProperties.static,
    readonly = MemberProperties.readonly,
    set = MemberProperties.type, get = MemberProperties.type
}
local function IsModifyWord(key)
    return ModifyKeyFunc[key] ~= nil or false
end
local function IsKeyword(k)
    return ModifyKeyFunc[k] ~= nil or InnerProperty[k] or InnerFunction[k] or ClsShellKeys[k] or false
end
local function Is__Property(k)
    return IsString(k) and string.find(k, "__") == 1
end

--cls向shell、superCls、superShell，转换
local function GetSuperCls(cls)
    local mt = getmetatable(cls)
    return mt and mt.__index or nil
end
local function GetClsShell(cls)
    return cls.__shell
end
local function GetSuperShell(cls)
    return GetClsShell(GetSuperCls(cls))
end

--获取成员 相关
local function GetStaticMemberValue(cls, k)
    local member = cls[k]
    if member then
        --@TODO 考虑这里与运行时获取数据的逻辑，进行统一整合
        if member.t == MemberType.set then
            ErrorGet(cls, k)
        elseif member.t == MemberType.get then
            return member.v()
        elseif member.s == StorageType.static then
            return GetFilterNull(member.v)
        else
            ErrorNotStatic(cls, k)
        end
    else
        ErrorNoExist(cls, k)
    end
end
local function GetMemberValueAll(cls, k)
    local member = rawget(cls, k)
    if member then
        --@TODO member统一为table结构，这里的判断就可以省掉了
        return IsFunction(member) and GetFilterNull(member) or GetFilterNull(member.v)
    end
end

--获取super成员 相关
local function GetNearCtor(cls)
    local cur = cls
    while true do
        if cur.ctor.v ~= NullFunc then
            return cur.ctor
        end
        cur = GetSuperCls(cur)
        if cur == Null then
            break
        end
    end
    return cls.ctor
end
local function GetCurFuncCls(cls, k, func)
    local cur = cls
    while true do
        if GetMemberValueAll(cls, k) == func then
            return cls
        end
        cls = GetSuperCls(cls)
        if cls == Null then
            break
        end
    end
    ErrorNoExist(cur, k)
end
local function ChangeClass(inst, cls, newCls)
    cls.__metatable = nil
    setmetatable(inst, newCls)
    cls.__metatable = OOP_MT_NAMES.class
end
local SuperFuncFormat = "return function(inst, func, args) local %s = func; %s(inst, unpack(args)); end"
local function GetSuperFuncProxy(proxy, inst, cls, super, k)
    local member = super[k]
    local func = member.v
    if member.t == nil and not IsFunction(func) then
        ErrorAttemptSuperVar(super, k)
    end
    return function(...)
        local args = {...}
        if args[1] == proxy then
            ChangeClass(inst, cls, super)
            table.remove(args, 1)
            local tempFunc = loadstring(string.format(SuperFuncFormat, k, k)); 
            tempFunc()(inst, func, args)
            ChangeClass(inst, super, cls)
        else
            ErrorDotAttemptFunc(k)
        end
    end
end
local function GetSuperCtorProxy(fromK, k, t, inst, cls, cur, super)
    if fromK == k then
        return GetSuperFuncProxy(t, inst, cls, super, k)
    else
        ErrorAttemptCtor(cur, k)
    end
end
local function GetSuperMemberProxy(fromK, k, t, inst, cls, cur, super)
    --@TODO首先找到k所在的class
    local member = super[k]
    if member.d == DomainType.private then
        ErrorCallPrivate(cls, k, 4)
    else
        return GetSuperFuncProxy(t, inst, cls, super, k)
    end
end
local function GetNorFuncSuper(cls, k)
    local cur = cls
    cls = GetSuperCls(cls)
    local member = cls[k]
    if member then
        return member.c
    else
        ErrorSuperNoExist(cur, k)
    end
end
local function GetFuncSuper(cls, k)
    if k == "ctor" then
        return GetNearCtor(GetSuperCls(cls)).c
    else
        return GetNorFuncSuper(cls, k)
    end
end
local function CreateSuperProxy(inst, cls, fromK, func)
    local cur = GetCurFuncCls(cls, fromK, func)
    local super = GetFuncSuper(cur, fromK)
    return setmetatable({__type = OOP_MT_NAMES.super}, {
        __index = function(t, k)
            --如果当前是方法，则自动赋值第一个参数是????????
            if k == "ctor" then
                return GetSuperCtorProxy(fromK, k, t, inst, cls, cur, super)
            else
                return GetSuperMemberProxy(fromK, k, t, inst, cls, cur, super)
            end
        end,
        __newindex = function(t, k)
            ErrorAssignSuperMember(cur, super, k)
        end,
        __metatable = OOP_MT_NAMES.super
    })
end

local function CheckCoverError(cls, k, pMember)
    local cur = cls
    while true do
        local member = rawget(cls, k)
        if member ~= nil then
            if cur == cls then
                ErrorCoverCurClassMember(cur, k)
            end
            local domain = member.d
            --除了private都允许复写
            if domain == DomainType.private then
                ErrorCoverSuperPrivateMember(k, cls, cur)
            elseif domain ~= pMember.d then
                ErrorCoverSuperDiffDoamin(k, cls, cur)
            else
                return
            end
        end
        --使用最原始的获取基类的方法
        cls = GetSuperCls(cls)
        if cls == Null then
            return
        end
    end
end

local function CopyMember(member)
    return member and table.copyTable(member) or {}
end
local function CreateRealMember(member, cls)
    local result = CopyMember(member)
    result.c = cls
    return result
end

local function AddMember(cls, k, v, member)
    if IsKeyword(k) then
        ErrorDefineKeyword(k)
    end
    if k == "ctor" then
        if rawget(cls, k).v ~= NullFunc then
            ErrorRepeatDefine(cls, k)
        elseif not IsFunction(v) then
            ErrorMustFunction(string.format("%s.%s", cls.__name, k), 5)
        elseif member and #member > 1 then
            ErrorCtorProperties(cls)
        else
            DoSetMemberValue(cls, k, {}, v)
        end
    else
        CheckCoverError(cls, k, member)
        SetMemberValue(cls, k, CreateRealMember(member), v)
    end
end

local function GetMember(cls, k, member)
    local addPropertyFunc = ModifyKeyFunc[k]
    if addPropertyFunc then
        local mv = member and member[ModifyKeyProperty[k]]
        if mv ~= nil then
            ErrorRepeatQualifier(k, member, mv)
        else
            member = CopyMember(member)
            addPropertyFunc(member, k)
            return setmetatable({__type = OOP_MT_NAMES.member}, {
                __index = function(t, k)
                    return GetMember(cls, k, member)
                end,
                __newindex = function(t, k, v)
                    AddMember(cls, k, v, member)
                end,
                __metatable = OOP_MT_NAMES.member
            })
        end
    else
        return GetStaticMemberValue(cls, k)
    end
end
--@endregion

--@region shell function
--实现定义阶段，实现OOP
local function CreateClassShell(cls)
    if rawget(cls, "__shell") then
        return cls.__shell
    end
    if rawget(cls, "__readonly") then
        RepeatReadOnly()
    else
        --临时增加，调试字段：__type__temp
        local shell = setmetatable({__type = OOP_MT_NAMES.module}, {
            __index = function(t, k)
                if k == "new" then
                    return cls.new
                elseif k == "super" then
                    ErrorAttemptSuper(cls)
                elseif k == "__readonly" then
                    return true
                elseif k == "__ctype" then
                    --兼容C写的lua，在Class会取这个字段
                    return nil
                elseif k == "__name" then
                    --临时兼容，通过__name请求类名
                    return cls.__name
                else
                    if Is__Property(k) then
                        ErrorForbid__Property(k, 3)
                    else
                        return GetMember(cls, k)
                    end
                end
            end,
            __newindex = function(t, k, v)
                if k == "singleton" or k == "abstract" then
                    rawset(cls, k, v)
                elseif Is__Property(k) then
                    ErrorForbid__Property(k, 3)
                else
                    AddMember(cls, k, v)
                end
            end,
            __pairs = function(t)
                return function(t, k)
                    local v
                    repeat
                        k, v = next(t, k)
                        if k ~= nil and IsClsShellKeys(k) then
                            return k, v
                        end
                    until k == nil
                end, cls, nil
            end,
            __len = function()
                return table.len(cls)
            end,
            __metatable = OOP_MT_NAMES.module
        })
        cls.__shell = shell
        return shell
    end
end
--@endregion

--@region class create
local function CheckAbstract(cls)
    if rawget(cls, "abstract") then
        ErrorAbstract(cls)
    end
end

local function ExecCtor(inst, cls, ...)
    --面向inst的class是__shell(壳)
    rawset(inst, "class", cls.__shell)
    --这里的ctor不能改名，后续逻辑会用于判断
    local ctorMember = GetNearCtor(cls)
    local ctor = ctorMember.v
    ctor(inst, ...)
    return inst
end

local function CreateC(cls, ...)
    CheckAbstract(cls)
    local inst = cls.__create(...)
    -- copy fields from class to  native object
    for k, v in pairs(cls) do
        inst[k] = v
    end
    return ExecCtor(inst, cls, ...)
end

local function CreateLua(cls, ...)
    CheckAbstract(cls)
    --为inst实例，设置元表，以便在运行阶段，实现OOP
    local inst = setmetatable({__type = OOP_MT_NAMES.inst}, cls)
    return ExecCtor(inst, cls, ...)
end

local function CreateSingle(cls)
    function cls.get:singleton()
        return SingleInsts[cls.__name]
    end
end

local function SetNewFunc(cls, createFunc)
    --单例类的实例化，也是使用new，再次new不会创建新的实例，此后可以使用 class.singleton 获取了
    cls.new = function(...)
        if cls.singleton then
            local name = cls.__name
            if not SingleInsts[name] then
                SingleInsts[name] = createFunc(cls, ...)
                CreateSingle(cls)
            end
            return SingleInsts[name]
        else
            return createFunc(cls, ...)
        end
    end
end

local function SetClassProperties(cls, name, createFunc, type)
    cls.__name = name
    cls.__ctype = type
    cls.__type = OOP_MT_NAMES.class
    cls.__metatable = OOP_MT_NAMES.class
    cls.ctor = {c = cls, v = NullFunc}
    -- cls.dtor = DoSetMemberValue(cls, "ctor", {}, NullFunc)
    SetNewFunc(cls, createFunc)
    AllCls[name] = cls
end
--@endregion

--@region instance OOP
local function AllowPublic(domain, cls, k)
    if domain ~= DomainType.public then
        if domain == DomainType.protected then
            ErrorCallProtected(cls, k)
        else
            ErrorCallPrivate(cls, k)
        end
    end
end

local function DisablePrivate(domain, cls, k)
    if domain == DomainType.private then
        ErrorCallPrivate(cls, k)
    end
end

local function CheckDomain(k, cls, member)
    -- print("\t\t\t访问:  ", cls.__name, k)
    local _, inst = debug.getlocal(4, 1)
    local domain = member.d
    if not IsTable(inst) then
        AllowPublic(domain, cls, k)
    else
        local _, inst = debug.getlocal(3, 1)---1,1是自身语句，2,1是当前方法，3,1是当前文件，4,1是外部类
        -- print("")
        -- print("--------",GetInstClassName(inst), GetClassName(cls))
        if not IsTheClass(inst, cls) then
            -- print("--------",GetInstClassName(inst), GetClassName(cls))
            if IsInstSuperClass(inst, cls) then
                DisablePrivate(domain, cls, k)
            else
                AllowPublic(domain, cls, k)
            end
        end
    end
    return true
end

local FuncFormat = "return function(t, func, args) local %s = func; %s(unpack(args)); end"
local function GetFuncProxy(t, k, member)
    return function(...)
        local args = {...}
        if args[1] or args[1] == t then
            local tempFunc = loadstring(string.format(FuncFormat, k, k)); 
            tempFunc()(t, member.v, args)
        else
            ErrorDotAttemptFunc(k)
        end
    end
end
--实现运行阶段，实现OOP
local function RealizeInstanceOOP(cls)
    --调用阶段（使用self或外部实例调用）
    function cls.__index(t, k)
        if k == "ctor" then
            ErrorAttemptCtor(GetInstClass(t), k)
        elseif k == "dtor" then
            return cls.dtor
        elseif k == "super" then
            local funcTbl = debug.getinfo(2)
            return CreateSuperProxy(t, cls, funcTbl.name or "ctor", funcTbl.func)
        else
            local member = cls[k]
            if member == nil then
                ErrorNoExist(cls, k)
            else
                if CheckDomain(k, cls, member) then
                    if member.t == MemberType.set then
                        ErrorGet(cls, k)
                    elseif member.t == MemberType.get then
                        return member.v(t)
                    elseif member.s == StorageType.static then
                        return GetStaticMemberValue(cls, k)
                    else
                        local member = cls[k]
                        if IsFunction(member.v) then
                            return GetFuncProxy(t, k, member)
                        else
                            return GetFilterNull(rawget(t, k) or member.v)
                        end
                    end
                end
            end
        end
    end

    function cls.__newindex(t, k, v)
        if k == "ctor" or k == "dtor" then
            ErrorModifyInnerFunc(k)
        else
            local member = cls[k]
            if member == nil then
                ErrorNoExist(cls, k)
            else
                if CheckDomain(k, cls, member) then
                    if member.r == ReadType.readonly then
                        local funcTbl = debug.getinfo(2)
                        --funcTbl.name为nil，是OOP内部，通过继承查找到基类ctor，进行调用的
                        if funcTbl.name and funcTbl.name ~= "ctor" then
                            ErrorReadOnly(cls, k)
                        end
                    end
                    if member.t == MemberType.get then
                        ErrorSet(cls, k)
                    elseif member.t == MemberType.set then
                        member.v(t, v)
                    elseif member.s == StorageType.static then
                        --static设置类模板的成员的数值
                        SetMemberValue(cls, k, member, v)
                    else
                        rawset(t, k, SetFilterNil(v))
                    end
                end
            end
        end
    end
end
--@endregion

--@region complete OOP Entry
local function RealizeOOP(cls)
    RealizeInstanceOOP(cls)
    return CreateClassShell(cls)
end
--@endregion

function IsTheClass(inst, cls)
    return GetInstClass(inst).__name == cls.__name
end

function IsInstSuperClass(inst, class)
    if type(inst) ~= 'table' then
        return false
    end
    local clsName = IsString(class) and class or class.__name
    local cls = GetInstClass(inst)
    while cls do
        local curName = cls.__name
        if curName == clsName then
            return true
        end
        cls = GetSuperCls(cls)
        if cls == nil then
            return false
        end
    end
    return false
end
--@endregion

--@region OPP Entry
function Class(name, super)
    if AllCls[name] ~= nil then
        ErrorRepeatClass(name)
    end

    if super then
        local superType = type(super)
        if not IsFunction(super) and not IsTable(super) then
            ErrorClassSuperType(name, superType)
            --     superType = nil
            --     super = nil
        end
    end

    local cls = {}
    local isCMode = IsFunction(super) or (super and super.__ctype == 1)
    if isCMode then
        --对于C++ Object的兼容，需要回顾之前的oop实现
        -- inherited from native C++ Object
        local isTable = IsTable(super)
        if isTable then
            -- copy fields from super
            for k, v in pairs(super) do
                cls[k] = v
            end
        end
        cls.__create = isTable and super.__create or super
        cls.super = isTable and super or Null
        SetClassProperties(cls, name, CreateC, 1)
    else
        --Shell用AllCls找到真实cls
        local superCls = GetShellClass(super)
        if super and superCls == nil then
            ErrorNoSuperCls(name, super.__name)
        end
        SetClassProperties(cls, name, CreateLua, 2)
        --类继承关系，指向真实cls
        setmetatable(cls, {__index = superCls or Null})
        cls = RealizeOOP(cls)
    end
    return cls
end
--@endregion