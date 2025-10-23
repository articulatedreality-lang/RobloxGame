local CustomEnumClass = require(script.Parent.CustomEnumClass)

----------------------------------------------------------------------------------------------------------------------
local CustomEnum = setmetatable({}, CustomEnumClass.CustomEnums)

----------------------------------------------------------------------------------------------------------------------
CustomEnum.WrapSignalType = setmetatable({}, CustomEnumClass.CustomEnum)

CustomEnum.WrapSignalType.Void 			      = setmetatable({Name = "Void"			      , Value = 0, EnumType = CustomEnum.WrapSignalType, Class = "WrapSignalType"}, CustomEnumClass.CustomEnumItem)
CustomEnum.WrapSignalType.Default		      = setmetatable({Name = "Default"	  	  , Value = 1, EnumType = CustomEnum.WrapSignalType, Class = "WrapSignalType"}, CustomEnumClass.CustomEnumItem)
CustomEnum.WrapSignalType.Property  	    = setmetatable({Name = "Property"	  	  , Value = 2, EnumType = CustomEnum.WrapSignalType, Class = "WrapSignalType"}, CustomEnumClass.CustomEnumItem)
CustomEnum.WrapSignalType.Attribute 	    = setmetatable({Name = "Attribute"	    , Value = 3, EnumType = CustomEnum.WrapSignalType, Class = "WrapSignalType"}, CustomEnumClass.CustomEnumItem)
CustomEnum.WrapSignalType.MarkerReached	  = setmetatable({Name = "MarkerReached"  , Value = 4, EnumType = CustomEnum.WrapSignalType, Class = "WrapSignalType"}, CustomEnumClass.CustomEnumItem)
CustomEnum.WrapSignalType.InstanceAdded   = setmetatable({Name = "InstanceAdded"  , Value = 5, EnumType = CustomEnum.WrapSignalType, Class = "WrapSignalType"}, CustomEnumClass.CustomEnumItem)
CustomEnum.WrapSignalType.InstanceRemoved = setmetatable({Name = "InstanceRemoved", Value = 6, EnumType = CustomEnum.WrapSignalType, Class = "WrapSignalType"}, CustomEnumClass.CustomEnumItem)

----------------------------------------------------------------------------------------------------------------------
CustomEnum.SignalMode = setmetatable({}, CustomEnumClass.CustomEnum)

CustomEnum.SignalMode.Default 			       = setmetatable({Name = "Default" 			      , Value = 1, EnumType = CustomEnum.SignalMode, Class = "SignalMode"}, CustomEnumClass.CustomEnumItem)
CustomEnum.SignalMode.FromRBXScriptSignal  = setmetatable({Name = "FromRBXScriptSignal" , Value = 2, EnumType = CustomEnum.SignalMode, Class = "SignalMode"}, CustomEnumClass.CustomEnumItem)
CustomEnum.SignalMode.FromInstanceAccessor = setmetatable({Name = "FromInstanceAccessor", Value = 3, EnumType = CustomEnum.SignalMode, Class = "SignalMode"}, CustomEnumClass.CustomEnumItem)

----------------------------------------------------------------------------------------------------------------------
CustomEnum.ErrorType = setmetatable({}, CustomEnumClass.CustomEnum)

CustomEnum.ErrorType.NoPlayer 	 = setmetatable({Name = "No Player"	  , Value = 1, EnumType = CustomEnum.ErrorType, Class = "ErrorType"}, CustomEnumClass.CustomEnumItem)
CustomEnum.ErrorType.NoCharacter = setmetatable({Name = "No Character", Value = 2, EnumType = CustomEnum.ErrorType, Class = "ErrorType"}, CustomEnumClass.CustomEnumItem)
CustomEnum.ErrorType.ExistingKey = setmetatable({Name = "Existing Key", Value = 3, EnumType = CustomEnum.ErrorType, Class = "ErrorType"}, CustomEnumClass.CustomEnumItem)
CustomEnum.ErrorType.MissingKey	 = setmetatable({Name = "Missing Key" , Value = 4, EnumType = CustomEnum.ErrorType, Class = "ErrorType"}, CustomEnumClass.CustomEnumItem)

----------------------------------------------------------------------------------------------------------------------
return CustomEnum
