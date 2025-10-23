export type CustomEnumItem = {
	IsA: (self: CustomEnumItem, Name: string) -> (boolean)
}

export type CustomEnum = {
	FromName: (self: CustomEnum, Name: string) -> (CustomEnumItem),
	FromValue: (self: CustomEnum, Value: number) -> (CustomEnumItem),
	GetEnumItems: (self: CustomEnum) -> ({[number]: CustomEnumItem}),
}

export type CustomEnums = {
	GetEnums: (self: CustomEnums) -> ({[number]: CustomEnum})
}

----------------------------------------------------------------------------------------------------------------------
local CustomEnumItem = {}
CustomEnumItem.__index = CustomEnumItem

function CustomEnumItem:IsA(Name: string): boolean
	return (self.Class == Name)
end

----------------------------------------------------------------------------------------------------------------------
local CustomEnum = {}
CustomEnum.__index = CustomEnum

function CustomEnum:GetEnumItems(): {[number]: CustomEnumItem}
	local EnumItems: {[number]: CustomEnumItem} = {}
	for Index: string, EnumItem: CustomEnumItem? in self do
		if typeof(EnumItem) ~= "table" then continue end
		EnumItems[EnumItem.Value + 1] = EnumItem.Name
	end
	return EnumItems
end

function CustomEnum:FromName(Name: string): CustomEnumItem
	for Index: string, EnumItem: CustomEnumItem? in self do
		if typeof(EnumItem) ~= "table" then continue end
		if EnumItem.Name ~= Name then continue end
		return EnumItem
	end
end

function CustomEnum:FromValue(Value: number): CustomEnumItem
	for Index: string, EnumItem: CustomEnumItem? in self do
		if typeof(EnumItem) ~= "table" then continue end
		if EnumItem.Value ~= Value then continue end
		return EnumItem
	end
end

----------------------------------------------------------------------------------------------------------------------
local CustomEnums = {}
CustomEnums.__index = CustomEnums

function CustomEnums:GetEnums(): {[number]: CustomEnum}
	local CustomEnumTable: {[number]: CustomEnum} = {}
	local Count: number = 1
	
	for Index: string, CustomEnumObject: CustomEnum in self do
		if typeof(CustomEnumObject) ~= "table" then continue end
		CustomEnumTable[Count] = CustomEnumObject
		Count += 1
	end
	
	return CustomEnumTable
end

----------------------------------------------------------------------------------------------------------------------
return {CustomEnumItem = CustomEnumItem, CustomEnum = CustomEnum, CustomEnums = CustomEnums}
