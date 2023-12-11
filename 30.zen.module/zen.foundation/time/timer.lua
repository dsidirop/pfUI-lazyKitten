﻿local _g, _assert, _setfenv, _type, _getn, _error, _print, _unpack, _pairs, _importer, _namespacer, _setmetatable = (function()
    local _g = assert(_G or getfenv(0))
    local _assert = assert
    local _setfenv = _assert(_g.setfenv)

    _setfenv(1, {})

    local _type = _assert(_g.type)
    local _getn = _assert(_g.table.getn)
    local _error = _assert(_g.error)
    local _print = _assert(_g.print)
    local _pairs = _assert(_g.pairs)
    local _unpack = _assert(_g.unpack)
    local _importer = _assert(_g.pvl_namespacer_get)
    local _namespacer = _assert(_g.pvl_namespacer_add)
    local _setmetatable = _assert(_g.setmetatable)

    return _g, _assert, _setfenv, _type, _getn, _error, _print, _unpack, _pairs, _importer, _namespacer, _setmetatable
end)()

_setfenv(1, {})

local Event = _importer("Pavilion.System.Event")
local WoWCreateFrame = _importer("Pavilion.Warcraft.Addons.Zen.Externals.WoW.CreateFrame")

local Class = _namespacer("Pavilion.Warcraft.Addons.Zen.Foundation.Time.Timer")

function Class:New(interval)
    _setfenv(1, self)
    
    _assert(_type(interval) == "number" and interval > 0, "interval must be a positive number")

    local element = WoWCreateFrame("Frame") -- 00
    element:Hide() -- 10

    local instance = {
        _g = _g, -- 20

        _interval = interval,
        _wantedActive = false,

        _element = element,
        _eventElapsed = Event:New(),
        _elapsedTimeSinceLastFiring = 0,
    }

    _setmetatable(instance, self)
    self.__index = self

    return instance
    
    -- 00  dont even bother using strenums here
    -- 10  we need to hide the frame because its important to ensure that the timer is not running when we create it
    -- 20  this is vital in order for us to have access to _g.arg1 inside the onupdate handler
end

function Class:GetInterval()
    _setfenv(1, self)

    return _interval
end

function Class:ChainSetInterval(newInterval)
    _setfenv(1, self)

    _assert(_type(newInterval) == "number" and newInterval > 0, "interval must be a positive number")

    _interval = newInterval

    return self
end

function Class:IsRunning()
    _setfenv(1, self)

    return _element:IsVisible()
end

function Class:Start()
    _setfenv(1, self)

    _wantedActive = true
    self:OnSettingsChanged_()

    return self
end

function Class:Stop()
    _setfenv(1, self)

    _wantedActive = false
    self:OnSettingsChanged_()
    
    return self
end

function Class:EventElapsed_Subscribe(handler, owner)
    _setfenv(1, self)

    _eventElapsed:Subscribe(handler, owner) --   order
    self:OnSettingsChanged_() --                 order

    return self
end

function Class:EventElapsed_Unsubscribe(handler)
    _setfenv(1, self)

    _eventElapsed:Unsubscribe(handler)  --   order
    self:OnSettingsChanged_() --             order

    return self
end

-- private space

function Class:OnSettingsChanged_()
    _setfenv(1, self)

    if _wantedActive and _eventElapsed:HasSubscribers() then
        self:StartImpl_()
        return self
    end

    do
        -- wantedActive==false  or  wantedActive==true but noone is listening   so we need to halt the timer
        self:StopImpl_()
    end

    return self
end

function Class:StartImpl_()
    _setfenv(1, self)

    self:EnsureInitializedOnlyOnce_()

    _element:Show()

    return self
end

function Class:StopImpl_()
    _setfenv(1, self)

    _element:Hide()    
    _elapsedTimeSinceLastFiring = 0

    return self
end

function Class:EnsureInitializedOnlyOnce_()
    _setfenv(1, self)

    if _element:GetScript("OnUpdate") then
        return
    end

    _element:SetScript("OnUpdate", function()
        _elapsedTimeSinceLastFiring = _elapsedTimeSinceLastFiring + _g.arg1 -- 00
        if _elapsedTimeSinceLastFiring < _interval then
            return
        end
        
        -- _elapsedTimeSinceLastFiring >= _interval   its important to trim down the excess
        -- time as much as it is necessary to ensure it goes beneath the interval threshold
        repeat
            _elapsedTimeSinceLastFiring = _elapsedTimeSinceLastFiring - _interval
        until _elapsedTimeSinceLastFiring < _interval

        _eventElapsed:Raise(self, {})
        if not _eventElapsed:HasSubscribers() then
            self:OnSettingsChanged_()
        end
    end)
    
    -- 00  arg1 is the elapsed time since the previous callback invocation   there is no other way to get this value
    --     other than grabbing it from the global environment like we do here   very strange but true
end