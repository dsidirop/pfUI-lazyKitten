local _setfenv, _strformat, _importer, _namespacer = (function()
    local _g = assert(_G or getfenv(0))
    local _assert = assert
    local _setfenv = _assert(_g.setfenv)
    _setfenv(1, {})

    local _strformat = _assert(_g.string.format)

    local _importer = _assert(_g.pvl_namespacer_get)
    local _namespacer = _assert(_g.pvl_namespacer_add)

    return _setfenv, _strformat, _importer, _namespacer
end)()

_setfenv(1, {})

local Guard = _importer("System.Guard")
local Scopify = _importer("System.Scopify")
local EScopes = _importer("System.EScopes")
local TablesHelper = _importer("System.Helpers.Tables")
local ArraysHelper = _importer("System.Helpers.Arrays")

local StringsHelper = _namespacer("System.Helpers.Strings [Partial]")

function StringsHelper.Format(format, ...)
    Scopify(EScopes.Function, StringsHelper)

    Guard.Check.IsNonEmptyTable(arg)
    Guard.Check.IsNonDudString(format)

    local argCount = ArraysHelper.Count(arg)
    if argCount == 0 then
        return format
    end
    
    if argCount == 1 then
        return _strformat(format, StringsHelper.ToString(arg[1]))
    end

    if argCount == 2 then
        return _strformat(format, StringsHelper.ToString(arg[1]), StringsHelper.ToString(arg[2]))
    end

    if argCount == 3 then
        return _strformat(format, StringsHelper.ToString(arg[1]), StringsHelper.ToString(arg[2]), StringsHelper.ToString(arg[3]))
    end

    if argCount == 4 then
        return _strformat(format, StringsHelper.ToString(arg[1]), StringsHelper.ToString(arg[2]), StringsHelper.ToString(arg[3]), StringsHelper.ToString(arg[4]))
    end

    if argCount == 5 then
        return _strformat(format, StringsHelper.ToString(arg[1]), StringsHelper.ToString(arg[2]), StringsHelper.ToString(arg[3]), StringsHelper.ToString(arg[4]), StringsHelper.ToString(arg[5]))
    end

    if argCount == 6 then
        return _strformat(format, StringsHelper.ToString(arg[1]), StringsHelper.ToString(arg[2]), StringsHelper.ToString(arg[3]), StringsHelper.ToString(arg[4]), StringsHelper.ToString(arg[5]), StringsHelper.ToString(arg[6]))
    end

    if argCount == 7 then
        return _strformat(format, StringsHelper.ToString(arg[1]), StringsHelper.ToString(arg[2]), StringsHelper.ToString(arg[3]), StringsHelper.ToString(arg[4]), StringsHelper.ToString(arg[5]), StringsHelper.ToString(arg[6]), StringsHelper.ToString(arg[7]))
    end

    if argCount == 8 then
        return _strformat(format, StringsHelper.ToString(arg[1]), StringsHelper.ToString(arg[2]), StringsHelper.ToString(arg[3]), StringsHelper.ToString(arg[4]), StringsHelper.ToString(arg[5]), StringsHelper.ToString(arg[6]), StringsHelper.ToString(arg[7]), StringsHelper.ToString(arg[8]))
    end

    if argCount == 9 then
        return _strformat(format, StringsHelper.ToString(arg[1]), StringsHelper.ToString(arg[2]), StringsHelper.ToString(arg[3]), StringsHelper.ToString(arg[4]), StringsHelper.ToString(arg[5]), StringsHelper.ToString(arg[6]), StringsHelper.ToString(arg[7]), StringsHelper.ToString(arg[8]), StringsHelper.ToString(arg[9]))
    end

    if argCount == 10 then
        return _strformat(format, StringsHelper.ToString(arg[1]), StringsHelper.ToString(arg[2]), StringsHelper.ToString(arg[3]), StringsHelper.ToString(arg[4]), StringsHelper.ToString(arg[5]), StringsHelper.ToString(arg[6]), StringsHelper.ToString(arg[7]), StringsHelper.ToString(arg[8]), StringsHelper.ToString(arg[9]), StringsHelper.ToString(arg[10]))
    end

    local stringifiedArgs = {}
    for i = 1, argCount do
        stringifiedArgs[i] = StringsHelper.ToString(arg[i])
    end
    
    return _strformat(format, TablesHelper.Unpack(stringifiedArgs))
end
