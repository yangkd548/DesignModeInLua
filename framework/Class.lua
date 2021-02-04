--[[
    Module:Class
    Author:DylanYang
    Time:2020-10-14 16:08:08
]]
require("framework.Readonly")
require("framework.Bit")
require("framework.BaseExtend")
require("framework.TableExtend")

--@region import function (考虑提取)

function Import(moduleName, curName)
    local nameParts
    local fullName = moduleName
    local offset = 1
    while true do
        if string.byte(moduleName, offset) ~= 46 then -- .
            fullName = string.sub(moduleName, offset)
            if nameParts and #nameParts > 0 then
                fullName = table.concat(nameParts, ".") .. "." .. fullName
            end
            break
        end
        offset = offset + 1
        if not nameParts then
            if not curName then
                local n, v = debug.getlocal(3, 1)
                curName = v
            end
            nameParts = string.split(curName, ".")
        end
        table.remove(nameParts, #nameParts)
    end
    return require(fullName)
end

--@endregion

--@region error functions

local function GetMemberFullName(cls, k)
    return cls.__name .. "." .. k
end

--类操作 相关
local function ErrorClassSuperType(name, type, level)
    error(string.format("The super class of current class (%s) you define is a '%s'", name, type), level or 3)
end
local function ErrorNoSuperCls(name, superName, level)
    error(string.format("The super class (%s) of the class (%s) you define is not exist!", superName or "nil", name), level or 3)
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
    error(string.format("This member (%s) does not allow to setting properties.", GetMemberFullName(cls, OOP_CTOR_NAME)), level or 5)
end

--成员访问 相关
local function ErrorNoExist(cls, k, level)
    error(string.format("attempt to call member '%s' (no-exist).", GetMemberFullName(cls, k)), level or 3)
end
local function ErrorCallPrivate(cls, k, level)
    error(string.format("attempt to call member '%s' (private).", GetMemberFullName(cls, k)), level or 5)
end
local function ErrorCallProtected(cls, k, level)
    error(string.format("attempt to call member '%s' (protected).", GetMemberFullName(cls, k)), level or 5)
end
local function ErrorGet(cls, k, level)
    error(string.format("attempt to get accessor '%s' (set).", GetMemberFullName(cls, k)), level or 3)
end
local function ErrorSet(cls, k, level)
    error(string.format("attempt to set accessor '%s' (get).", GetMemberFullName(cls, k)), level or 3)
end
local function ErrorReadOnly(cls, k, level)
    error(string.format("attempt to call accessor '%s' (readonly), in non ctor.", GetMemberFullName(cls, k)), level or 3)
end
local function ErrorNotStatic(cls, k, level)
    error(string.format("attempt to call member '%s' (not-static).", GetMemberFullName(cls, k)), level or 3)
end
local function ErrorModifyInnerFunc(funcName, level)--尝试通过self修改ctor和dtor
    error(string.format("The '%s' member of class, which cannot be modify directly.", funcName), level or 3)
end

--成员覆盖 相关
local function ErrorCoverCurClassMember(cls, k, level)
    error(string.format("The member (%s) of the current class is repeatedly defined", GetMemberFullName(cls, k)), level or 5)
end
local function ErrorCoverSuperPrivateMember(k, superCls, curCls, level)
    error(string.format("This private member (%s) already exists in the '%s' (cur:'%s'), cannot be repeatedly defined.", k, GetClassName(superCls), GetClassName(curCls)), level or 5)
end
local function ErrorCoverSuperDiffDoamin(k, superCls, curCls, level)
    error(string.format("This domains of members (%s) in the '%s' and '%s'(cur) are different.", k, GetClassName(superCls), GetClassName(curCls)), level or 5)
end

--访问基类的成员（读取self.super的ctor和成员） 相关
local function ErrorAttemptCtor(cls, k, level)
    error(string.format("Class ctor method cannot be called outside (%s).", GetMemberFullName(cls, k)), level or 3)
end
local function ErrorAttemptSuper(cls, level)
    error(string.format("Access Super directly using 'self.super', not shell (%s).", GetClassName(cls)), level or 3)
end
local function ErrorAssignSuperMember(cur, super, k, level)
    error(string.format("Access to the member (%s) of super class through 'self.super' is not allowed to write.", GetMemberFullName(super, k)), level or 3)
end
local function ErrorSuperNoExist(cls, k, level)
    error(string.format("attempt to call member '%s' (no-exist) of super class .", GetMemberFullName(cls, k)), level or 3)
end
local function ErrorAttemptSuperVar(cls, k, level)
    error(string.format("forbid to call variable '%s' by 'self.super'.", GetMemberFullName(cls, k)), level or 3)
end

--@endregion

--@region member properties

--下面4个属性表，在正式lua5.3运行环境下，可以加Readonly处理（lua5.1不支持__pairs，会报错）
local StorageType =  {default = nil, static = 2}  --------------------作为访问域前面的存储空间的控制
local DomainType =  {private = nil, public = 1, protected = 2}    ----访问域，在static和非static都有
local ReadType =  {default = nil, readonly = 1}  ---------------------仅对MemberType中default起作用
local MemberType =  {default = nil, set = 1, get = 2} ----------------成员类型，default包含function、variable

local MemberProperties = {domain = "d", readonly = "r", static = "s", type = "t", value = "v", name = "n", class = "c"}
local MemberPropertieTypes = {d = DomainType, r = ReadType, s = StorageType, t = MemberType}

local function GetKeyByValue(tbl, value)
    for k,v in pairs(tbl) do
        if v == value then
            return k
        end
    end
end

local ModifyKeyProperty = {
    public = MemberProperties.domain, protected = MemberProperties.domain, private = MemberProperties.domain,
    static = MemberProperties.static,
    readonly = MemberProperties.readonly,
    set = MemberProperties.type, get = MemberProperties.type,
    name = MemberProperties.name
}

--@endregion

--@region OOP base element

--下面是代理table的类型（super用于代理self.super:SuperFunc的代码）
local OOP_MT_TYPES = {inst = "OOP_inst", shell = "OOP_shell", class = "OOP_class", super = "OOP_super", member = "OOP_member"}
local OOP_CLS_NAME = "class"
local OOP_SHELL_NAME = "shell"
local OOP_CTOR_NAME = "ctor"
--@TODO 为所有的表，设置__type的目的是什么，考虑优化掉！！！
local Null = {__name = "Null"}
local NullFunc = function()
end
local function SetFilterNil(v)
    return v ~= nil and v or Null
end
local function GetFilterNull(v)
    return v ~= Null and v or nil
end

--禁止使用，所有“双下划线”开头的变量名（包含且不限于，下面的示例）
-- __index = true, __newindex = true, __pairs = true, __len = true, __metatable = true, __proxy = true,
-- __readonly = true, singleton = true, abstract = true, __ctype = true, __create = true, __inst = true
--__name表示类本身的名字，跟类模板和类实例的name，加以区分
local InnerProperty = {singleton = true, abstract = true}
local InnerFunction = {}
local ClsShellKeys = Readonly {super = true, new = true, dtor = true}--super用于self.super:XXXX访问父类的方法，避免歧义，用module缩写_M定义成员时禁用
local function IsClsShellKeys(k)
    return ClsShellKeys[k]
end

local function Is__Property(k)
    return IsString(k) and string.find(k, "__") == 1
end

--@endregion

--@region get cls or shell

local AllCls = {}
local function GetClassOfShell(shell)
    return shell and AllCls[shell]
end

local function GetClassOfInst(inst)
    local shell = rawget(inst, OOP_CLS_NAME)
    return GetClassOfShell(shell) or inst
end

local function GetClassName(cls)
    return cls and cls.__name or ""
end

--由cls获取shell
local function GetSuperCls(cls)
    local mt = getmetatable(cls)
    --继承关系在Class方法中，设置了原表和原方法__index
    return mt and mt.__index or nil
end

-- --由cls获取shell
local function GetShellOfClass(cls)
    return rawget(cls, OOP_SHELL_NAME)
end

-- --由Inst获取shell
local function GetShellOfInst(inst)
    return inst.class
end

function IsSameEnvCls(cls, tarCls)
    --先通过inst获取cls
    return cls == tarCls
end

function IsExtendRelation(cls, tarCls)
    while cls do
        cls = GetSuperCls(cls)
        if cls == tarCls then
            return true
        end
    end
    return false
end

--@endregion

--@region add member function

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

local ModifyKeyFunc = {
    public = AddDomainProperty, protected = AddDomainProperty, private = AddDomainProperty,
    static = AddStaticProperty,
    readonly = AddReadonlyProperty,
    set = AddTypeProperty, get = AddTypeProperty
}

local function IsKeyword(k)
    return ModifyKeyFunc[k] ~= nil or InnerProperty[k] or InnerFunction[k] or ClsShellKeys[k] or false
end

local function DoSetMemberValue(cls, k, member, v)
    member.v = SetFilterNil(v)
    member.c = cls
    member.n = k
    rawset(cls, k, member)
end

local function SetMemberValue(cls, k, member, v)
    --get/set成员，必须是function，否则报错
    if member and (member.t == MemberType.get or member.t == MemberType.set) and not IsFunction(v) then
        ErrorMustFunction(string.format("%s.%s.%s", cls.__name, GetKeyByValue(MemberType, member.t), k), 5)
    end
    DoSetMemberValue(cls, k, member, v)
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

local function CreateMember(member, cls)
    local result = CopyMember(member)
    result.c = cls
    return result
end

local function AddMember(cls, k, v, member)
    if IsKeyword(k) then
        ErrorDefineKeyword(k)
    end
    if k == OOP_CTOR_NAME then
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
        SetMemberValue(cls, k, CreateMember(member), v)
    end
end

--@endregion

--@region get member function

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

local function GetMember(cls, k, member)
    local addPropertyFunc = ModifyKeyFunc[k]
    if addPropertyFunc then
        local mv = member and member[ModifyKeyProperty[k]]
        if mv ~= nil then
            ErrorRepeatQualifier(k, member, mv)
        else
            member = CopyMember(member)
            addPropertyFunc(member, k)
            return setmetatable({__type = OOP_MT_TYPES.member}, {
                __index = function(t, k)
                    return GetMember(cls, k, member)
                end,
                __newindex = function(t, k, v)
                    AddMember(cls, k, v, member)
                end,
                __metatable = OOP_MT_TYPES.member
            })
        end
    else
        return GetStaticMemberValue(cls, k)
    end
end

local function GetMemberValue(cls, k)
    local member = rawget(cls, k)
    if member then
        --@TODO member统一为table结构，这里的判断就可以省掉了
        return IsFunction(member) and GetFilterNull(member) or GetFilterNull(member.v)
    end
end

--@endregion

--@region get/set class function

--获取super成员 相关

local function GetNearFunc(k, cls, super)
    local cur = cls
    while true do
        local member = rawget(cur, k)
        if member ~= nil then
            --只能找public和protected的方法
            if member.d == DomainType.private then
                return nil
            else
                return member
            end
        end
        cur = GetSuperCls(cur)
        if cur == super then
            return nil
        end
    end
end

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
        if GetMemberValue(cls, k) == func then
            return cls
        end
        cls = GetSuperCls(cls)
        if cls == Null then
            break
        end
    end
    ErrorNoExist(cur, k)
end

--@endregion

--@region exec function

local function ChangeEnvCls(inst, cls, newCls)
    --先关闭当前cls的mt，修改完后，再恢复
    rawset(cls, "__metatable", nil)
    setmetatable(inst, newCls)
    rawset(cls, "__metatable", OOP_MT_TYPES.class)
end

--使用原方法名，方便调试
--使用loadstring为的是，元方法index获取的k为对应的k
local FuncFormat = "return function(inst, func, ...) local %s = func return %s(inst, ...) end"
local function ExecFormatFunction(inst, member, ...)
    print(string.format("\n\t\t<<<<<<<<<<<<<<<进入方法%s>>>>>>>>>>>>>", GetMemberFullName(member.c, member.n)))
    local temp = loadstring(string.format(FuncFormat, member.n, member.n))
    local result = temp()(inst, member.v, ...)
    print(string.format("\t\t--------------Leave方法%s---------------\n\n", GetMemberFullName(member.c, member.n)))
    return result
end

local function ExecMemberFunc(member, inst, cls, ...)
    local result
    if member.c ~= cls then
        ChangeEnvCls(inst, cls, member.c)
        result = ExecFormatFunction(inst, member, ...)
        ChangeEnvCls(inst, member.c, cls)
    else
        result = ExecFormatFunction(inst, member, ...)
    end
    return result
end

--方法访问 相关
--@TODO 此方法的调用，考虑汇总到统一位置调用
local function ErrorDotAttemptFunc(k, level)--限制只能用“:”(冒号)访问function
    error(string.format("Please use ':' access method (%s).", k), level or 3)
end

--获取“:”(冒号)访问的代理方法
local function GetColonProxy(t, k, func)
    return function(...)
        print("进行“:”(冒号)访问的判定：", k)
        local args = {...}
        if args[1] and args[1] == t then
            return func(...)
        else
            ErrorDotAttemptFunc(k)
        end
    end
end

--self:Function==>转换为self:SuperFunction（父类方法访问域：public和private）
local function GetSelfSuperFuncProxy(t, k, member, cls)
    return GetColonProxy(t, k,
        function(...)
            return ExecMemberFunc(member, t, cls, ...)
        end
    )
end

--self.super:Function==>转换为self:SuperFuntion
local function GetSuperFuncProxy(t, inst, cls, member)
    return function(...)
        local args = {...}
        return GetColonProxy(t, member.n,
            function()
                table.remove(args, 1)
                return ExecMemberFunc(member, inst, cls, unpack(args))
            end
        )
    end
end

local function GetSuperCtorProxy(fromK, k, t, inst, cls, cur, member)
    --@desc 对于子类访问父类的ctor方法，限制必须在自己的ctor中
    if fromK == k then
        return GetSuperFuncProxy(t, inst, cls, member)
    else
        ErrorAttemptCtor(cur, k)
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
    if k == OOP_CTOR_NAME then
        return GetNearCtor(GetSuperCls(cls)).c
    else
        return GetNorFuncSuper(cls, k)
    end
end

--统一的self.super调用
local function CreateSuperProxy(inst, cls, fromK, func)
    local cur = GetCurFuncCls(cls, fromK, func)
    local super = GetFuncSuper(cur, fromK)
    return setmetatable({__type = OOP_MT_TYPES.super}, {
        __index = function(t, k)
            --如果通过self.super.XXX访问的是非方法，则报错提示
            --@TODO 考虑是否提取到“设置代理”的外部
            local member = super[k]
            if member.t == nil and not IsFunction(member.v) then
                ErrorAttemptSuperVar(super, k)
            end
            --如果当前是方法，则自动赋值第一个参数是????????
            if k == OOP_CTOR_NAME then
                return GetSuperCtorProxy(fromK, k, t, inst, cls, cur, member)
            else
                print("进入self.super代理首层:", GetMemberFullName(cls, k))
                --@TODO 考虑这里是否需要做“访问域”判定
                return GetSuperFuncProxy(t, inst, cls, member)
            end
        end,
        __newindex = function(t, k)
            ErrorAssignSuperMember(cur, super, k)
        end,
        __metatable = OOP_MT_TYPES.super
    })
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
    local shell = GetShellOfClass(cls)
    rawset(inst, OOP_CLS_NAME, shell)
    --这里的ctor不能改名，后续逻辑会用于判断
    local ctor = GetNearCtor(cls)
    ExecMemberFunc(ctor, inst, cls, ...)
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
    local inst = setmetatable({__type = OOP_MT_TYPES.inst}, cls)
    return ExecCtor(inst, cls, ...)
end

local SingleInsts = {}
local function CreateSingle(cls)
    function cls.get:singleton()
        return SingleInsts[cls]
    end
end

local function SetNewFunc(cls, createFunc)
    --单例类的实例化，也是使用new，再次new不会创建新的实例，此后可以使用 class.singleton 获取了
    cls.new = function(...)
        if cls.singleton then
            if not SingleInsts[cls] then
                SingleInsts[cls] = createFunc(cls, ...)
                CreateSingle(cls)
            end
            return SingleInsts[cls]
        else
            return createFunc(cls, ...)
        end
    end
end

--@endregion

--@region instance accessor

--判定为外部访问，只能是public访问域，否则按访问域进行报错提示
local function AllowPublic(domain, cls, k)
    if domain ~= DomainType.public then
        if domain == DomainType.protected then
            ErrorCallProtected(cls, k)
        else
            ErrorCallPrivate(cls, k)
        end
    end
end

--判定为子类访问，唯独不能访问private的访问域
local function DisablePrivate(domain, cls, k)
    if domain == DomainType.private then
        ErrorCallPrivate(cls, k)
    end
end

--经过了一层index/newindex代理，获取调动环境的层级为3
local function CheckDomain(k, cls, member)
    local funcCls = member.c
    print("检查访问域:", GetMemberFullName(cls, k))
    if IsSameEnvCls(cls, funcCls) then
        print("是当前类的方法，无访问域限制：", k)
    else
        local domain = member.d
        if IsExtendRelation(cls, funcCls) then
            DisablePrivate(domain, funcCls, k)
            print("不是private方法，可以访问：", k)
        else
            AllowPublic(domain, funcCls, k)
            print("外部访问，public方法可以访问：", k)
        end
    end
    return true
end

--暂时使用“浅拷贝”，现在看，是满足需求的
local function CopyValue(val)
    if type(val) == "table" then
        local copy = {}
        for i, v in pairs(val) do
            copy[i] = v
        end
        return copy
    else
        return val
    end
end

local function DoAccessMember(t, k, member, cls)
    if member.t == MemberType.set then
        ErrorGet(cls, k)
    elseif member.t == MemberType.get then
        return member.v(t)
    elseif member.s == StorageType.static then
        return GetStaticMemberValue(cls, k)
    else
        local v = rawget(t, k)
        if IsFunction(member.v) then
            if v == nil then
                --前面已经使用了CheckDomain检查了访问域，这里就不用检查了
                print("设置执行“父类的默认方法”:", GetMemberFullName(cls, k))
                return GetSelfSuperFuncProxy(t, k, member, cls)
            else
                --访问自身的方法，不用走代理，只判断是否使用了“:”冒号
                return GetColonProxy(t, k, member.v)
            end
        else
            if v == nil then
                if member.s == StorageType.default and member.t == MemberType.default then
                    --只有非static、default的变量，需要拷贝
                    --super的方法，拷贝到子类，就失去了访问super的private成员的权限了，所有不能拷贝方法
                    rawset(t, k, CopyValue(member.v))
                end
            end
            return v or rawget(t, k) or member.v
        end
    end
end

local function AccessMember(t, k, member, cls)
    if member == nil then
        ErrorNoExist(cls, k)
    else
        --增加：特定非member类型（暂时只支持string和number类型），直接返回
        if type(member) == "string" or type(member) == "number" then
            return member
        elseif CheckDomain(k, cls, member) then
            return DoAccessMember(t, k, member, cls)
        end
    end
end

--实例对象，访问成员的处理
--@desc cls是内部的class，用于实例inst，“访问成员”（function、set、get、variable）
local function CreateInstAccessor(cls)
    --调用阶段（使用self或外部实例调用）
    function cls.__index(t, k)
        if k == OOP_CTOR_NAME then
            ErrorAttemptCtor(GetClassOfInst(t), k)
        elseif k == "dtor" then
            return cls.dtor
        elseif k == "super" then
            local funcTbl = debug.getinfo(2)
            return CreateSuperProxy(t, cls, funcTbl.name or OOP_CTOR_NAME, funcTbl.func)
        else
            local member = cls[k]
            local oriCls = GetClassOfInst(t)
            if oriCls ~= cls then
                local newMember = GetNearFunc(k, oriCls, cls)
                --使用原始类及其上层的方法，不用检测访问域，但是方法内部，还是得切换cls才能正常执行
                if newMember then
                    local result
                    ChangeEnvCls(t, cls, newMember.c)
                    result = DoAccessMember(t, k, newMember, cls)
                    ChangeEnvCls(t, newMember.c, cls)
                    return result
                end
            end
            return AccessMember(t, k, member, cls)
        end
    end

    function cls.__newindex(t, k, v)
        if k == OOP_CTOR_NAME or k == "dtor" then
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
                        if funcTbl.name and funcTbl.name ~= OOP_CTOR_NAME then
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

--@region class creator

--实现定义阶段，实现OOP
--@desc shell是对外的class，用于shell向cls，“添加成员”（function、set、get、variable）
local function CreateClassShell(cls)
    local shell = GetShellOfClass(cls)
    if shell == nil then
        shell = setmetatable({__type = OOP_MT_TYPES.shell}, {
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
            __metatable = OOP_MT_TYPES.shell
        })
        --@TODO 设置shell，为何需要rawset方式？？？
        rawset(cls, OOP_SHELL_NAME, shell)
        AllCls[shell] = cls
    end
    return shell
end

--@endregion

--@region OPP Entry

local function SetClassProperties(cls, name, createFunc, type)
    cls.__name = name
    cls.__ctype = type
    cls.__type = OOP_MT_TYPES.class
    cls.__metatable = OOP_MT_TYPES.class
    cls.ctor = {c = cls, v = NullFunc, n = OOP_CTOR_NAME}
    SetNewFunc(cls, createFunc)
end

function Class(name, super)
    if super then
        local superType = type(super)
        if not IsFunction(super) and not IsTable(super) then
            ErrorClassSuperType(name, superType)
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
        local superCls = GetClassOfShell(super)
        if super and superCls == nil then
            ErrorNoSuperCls(name, super.__name)
        end
        SetClassProperties(cls, name, CreateLua, 2)
        --类继承关系，指向真实cls
        setmetatable(cls, {__index = superCls or Null})
        CreateInstAccessor(cls)
        cls = CreateClassShell(cls)
    end
    return cls
end

--@endregion