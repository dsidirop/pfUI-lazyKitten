﻿-- we just want to preemptively declare the namespaces so that we will be able to use strings.* inside guard.* and vice-versa

local using = assert((_G or getfenv(0) or {}).pvl_namespacer_get) --@formatter:off

-- using "[declare]" "System.Scopify"      no need to predeclare these really
-- using "[declare]" "System.Classify"
-- using "[declare]" "System.Exceptions.Utilities"
-- using "[declare]" "System.Externals.WoW.DefaultChatFrame"

using "[declare]" "System.Try"
using "[declare]" "System.Math"
using "[declare]" "System.Time"
using "[declare]" "System.Table"
using "[declare]" "System.Guard"
using "[declare]" "System.Debug"
using "[declare]" "System.Event"
using "[declare]" "System.Console"
using "[declare]" "System.Iterators"
using "[declare]" "System.Reflection"

using "[declare]" "System.Helpers.Arrays"
using "[declare]" "System.Helpers.Tables"
using "[declare]" "System.Helpers.Strings"
using "[declare]" "System.Helpers.Booleans"

-- using "[declare]" "System.Exceptions.Throw" -- needs to be refactored first
-- using "[declare]" "System.Exceptions.Rethrow" -- needs to be refactored first
using "[declare]" "System.Exceptions.Exception"
using "[declare]" "System.Exceptions.ValueAlreadySetException"
using "[declare]" "System.Exceptions.ValueCannotBeNilException"
using "[declare]" "System.Exceptions.ValueIsOutOfRangeException"
using "[declare]" "System.Exceptions.ValueIsOfInappropriateTypeException"
