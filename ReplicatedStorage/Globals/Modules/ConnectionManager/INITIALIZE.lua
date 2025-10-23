local ConnectionManager = {}
ConnectionManager.__index = ConnectionManager

-----------------------------------------------------------------------------------------------------------------------
export type ConnectionManager = {
	new: () -> (ConnectionManager),
	ReleaseAll: (self: ConnectionManager) -> (),
	Connections: {[string]: RBXScriptConnection},
	RemoveConnection: (self: ConnectionManager, Name: string) -> (),
	GetConnection: (self: ConnectionManager, Name: string) -> (RBXScriptConnection?),
	AddConnection: (self: ConnectionManager, Name: string, Connection: RBXScriptConnection) -> (),
}

-----------------------------------------------------------------------------------------------------------------------
function ConnectionManager.new()
	local self = setmetatable({}, ConnectionManager)
	
	self.Connections = {}
	
	return self
end

-----------------------------------------------------------------------------------------------------------------------
function ConnectionManager:AddConnection(Name: string, Connection: RBXScriptConnection)
	if self.Connections[Name] then return end
	self.Connections[Name] = Connection
end

-----------------------------------------------------------------------------------------------------------------------
function ConnectionManager:GetConnection(Name: string): RBXScriptConnection?
	if not self.Connections[Name] then return end
	return self.Connections[Name]
end

-----------------------------------------------------------------------------------------------------------------------
function ConnectionManager:RemoveConnection(Name: string)
	if not self.Connections[Name] then return end
	self.Connections[Name]:Disconnect()
	self.Connections[Name] = nil
end

-----------------------------------------------------------------------------------------------------------------------
function ConnectionManager:ReleaseAll()
	for Name: string, Connection: RBXScriptConnection in self.Connections do Connection:Disconnect() end
	table.clear(self)
end

-----------------------------------------------------------------------------------------------------------------------
return ConnectionManager
