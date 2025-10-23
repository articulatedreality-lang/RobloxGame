local AttributeObserver = {}
AttributeObserver.__index = AttributeObserver

---------------------------------------------------------------------------------------------------------------------
export type AttributeObserver = {
	Value: any,
	Object: Instance,
	AttributeName: string,
	Connection: RBXScriptConnection,
	Update: (self: AttributeObserver) -> (),
	Destroy: (self: AttributeObserver) -> (),
	GetValue: (self: AttributeObserver) -> (any),
	UpdateInstance: (self: AttributeObserver, NewObject: Instance) -> (),
	new: (Object: Instance, AttributeName: string) -> (AttributeObserver),
}

---------------------------------------------------------------------------------------------------------------------
function AttributeObserver.new(Object: Instance, AttributeName: string): AttributeObserver
	local self = setmetatable({}, AttributeObserver)
	
	self.Object = Object
	self.AttributeName = AttributeName
	self.Value = Object:GetAttribute(AttributeName)
	
	self.Connection = Object:GetAttributeChangedSignal(AttributeName):Connect(function()
		self.Value = Object:GetAttribute(AttributeName)
	end)
	
	return self
end

---------------------------------------------------------------------------------------------------------------------
function AttributeObserver:Update() -- For Debugging Purposes
	self.Value = self.Object:GetAttribute(self.AttributeName)
end

---------------------------------------------------------------------------------------------------------------------
function AttributeObserver:GetValue(): any
	return self.Value
end

---------------------------------------------------------------------------------------------------------------------
function AttributeObserver:UpdateInstance(NewObject: Instance) -- Helpful For Character Model's Attributes.
	self.Connection:Disconnect()
	self.Object = NewObject
	self.Connection = self.Object:GetAttributeChangedSignal(self.AttributeName):Connect(function()
		self.Value = self.Object:GetAttribute(self.AttributeName)
	end)
	self.Value = self.Object:GetAttribute(self.AttributeName)
end

---------------------------------------------------------------------------------------------------------------------
function AttributeObserver:Destroy()
	self.Connection:Disconnect()
	table.clear(self)
end

---------------------------------------------------------------------------------------------------------------------
return AttributeObserver
