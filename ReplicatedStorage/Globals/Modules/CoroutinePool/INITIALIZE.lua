local CoroutinePool = {}
CoroutinePool.__index = CoroutinePool

---------------------------------------------------------------------------------------------------------------------
local Cache = require(script.CoroutineCache)

export type CoroutineCache = Cache.CoroutineCache

export type CoroutinePool = {
	Reset: (self: CoroutinePool) -> (),
	FreeAll: (self: CoroutinePool) -> (),
	Destroy: (self: CoroutinePool) -> (),
	new: (Count: number) -> (CoroutinePool),
	GetCount: (self: CoroutinePool) -> (number),
	Get: (self: CoroutinePool) -> (CoroutineCache),
	SetCount: (self: CoroutinePool, Count: number) -> (),
}

---------------------------------------------------------------------------------------------------------------------
function CoroutinePool.new(Count: number): CoroutinePool
	local self = setmetatable({}, CoroutinePool)
	
	self.Count = Count or 1
	self.Coroutines = {}
	for Index: number = 1, Count do self.Coroutines[Index] = Cache.new() end
	
	return self
end

---------------------------------------------------------------------------------------------------------------------
function CoroutinePool:Get(): CoroutineCache
	for Index: number, Cache: CoroutineCache in self.Coroutines do
		if Cache.Status ~= "Free" then continue end
		return Cache:Obtain()
	end
	
	local NewRoutine: CoroutineCache = Cache.new():Obtain()
	table.insert(self.Coroutines, NewRoutine)
	self.Count += 1
	return NewRoutine
end

---------------------------------------------------------------------------------------------------------------------
function CoroutinePool:GetCount(): number
	return self.Count
end

---------------------------------------------------------------------------------------------------------------------
function CoroutinePool:SetCount(Count: number)
	if Count < 0 or self.Count == Count then return end
	
	if self.Count > Count then
		for Index: number = self.Count, Count + 1, -1 do table.remove(self.Coroutines, Index):Close() end
	else
		for Index: number = self.Count + 1, Count do self.Coroutines[Index] = Cache.new()end
	end
	
	self.Count = Count
end

---------------------------------------------------------------------------------------------------------------------
function CoroutinePool:FreeAll()
	for Index: number, Cache: CoroutineCache in self.Coroutines do
		Cache:Free()
		coroutine.resume(Cache.Coroutine, nil, nil)
	end
end

---------------------------------------------------------------------------------------------------------------------
function CoroutinePool:Reset()
	for Index: number, Cache: CoroutineCache in self.Coroutines do Cache:Close() end
	table.clear(self.Coroutines)
	self.Count = 1
end

---------------------------------------------------------------------------------------------------------------------
function CoroutinePool:Destroy()
	self:Reset()
	table.clear(self)
end

---------------------------------------------------------------------------------------------------------------------
return CoroutinePool
