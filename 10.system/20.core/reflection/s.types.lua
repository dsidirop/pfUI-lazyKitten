﻿local _setfenv, _type, _error, _rawget, _namespacer, _setmetatable = (function()
    local _g = assert(_G or getfenv(0))
    local _assert = assert
    local _setfenv = _assert(_g.setfenv)

    _setfenv(1, {})

    local _type = _assert(_g.type)
    local _error = _assert(_g.error)
    local _rawget = _assert(_g.rawget)
    local _namespacer = _assert(_g.pvl_namespacer_add)
    local _setmetatable = _assert(_g.setmetatable)

    return _setfenv, _type, _error, _rawget, _namespacer, _setmetatable
end)()

_setfenv(1, {})

local STypes = _namespacer("System.Reflection.STypes") --@formatter:off

STypes.Nil      = "nil"
STypes.Table    = "table"
STypes.Number   = "number"
STypes.String   = "string"
STypes.Boolean  = "boolean"
STypes.Function = "function" --@formatter:on

_setmetatable(STypes, {
    __index = function(tableObject, key) -- we cant use getrawvalue here  we have to write the method ourselves
        local value = _rawget(tableObject, key)
        if value == nil then
            _error("STypes enum doesn't have a member named '" .. key .. "'", 2)
        end
        
        return value
    end
})

function STypes.IsValid(value)
    -- we need to use _type here   we obviously cant use reflection utilities in here
    if _type(value) ~= "string" then
        return false
    end

    return value == STypes.Nil
            or value == STypes.Table
            or value == STypes.Number
            or value == STypes.String
            or value == STypes.Boolean
            or value == STypes.Function
end