﻿local using = assert((_G or getfenv(0) or {}).pvl_namespacer_get)

local Validation = using "System.Validation"
local StringsHelper = using "System.Helpers.Strings"

local Throw = using "[declare]" "System.Exceptions.Throw [Partial]"

function Throw:__Call__(exception)
    if exception.ChainSetStacktrace ~= nil then
        exception:ChainSetStacktrace(Validation.Stacktrace(1))
    end

    Validation.Fail(exception) -- 00

    -- 00  notice that we intentionally use assert() instead of error() here primarily because pfui and other libraries override the vanilla
    --     error() function to make it not throw an exception-error opting to simply print a message to the chat frame  this ofcourse is bad
    --     practice but we have to live with this shortcoming   so we use assert() instead which is typically not overriden
end
