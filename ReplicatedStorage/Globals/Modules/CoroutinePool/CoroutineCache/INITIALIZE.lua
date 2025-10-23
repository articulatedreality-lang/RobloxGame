local CoroutineCache = {}
CoroutineCache.__index = CoroutineCache

---------------------------------------------------------------------------------------------------------------------
local RunService: RunService = game:GetService("RunService")

---------------------------------------------------------------------------------------------------------------------
export type CoroutineCache = {
	Break: boolean,
	Status: string,
	Coroutine: thread,
	new: () -> (CoroutineCache),
	Free: (self: CoroutineCache) -> (),
	Close: (self: CoroutineCache) -> (),
	Obtain: (self: CoroutineCache) -> (CoroutineCache),
}

---------------------------------------------------------------------------------------------------------------------
local function Runner(Cache)
	while true do
		if Cache.Break then break end
		local Callback = coroutine.yield()
		if Callback then Callback() end
		Cache.CurrentCallback = nil
		Cache:Free()
	end
end

---------------------------------------------------------------------------------------------------------------------
function CoroutineCache.new(): CoroutineCache
	local self = setmetatable({}, CoroutineCache)
	
	self.Break = false
	self.Status = "Free"
	self.CurrentCallback = nil
	self.Coroutine = coroutine.create(Runner)
	coroutine.resume(self.Coroutine, self)
	
	return self
end

---------------------------------------------------------------------------------------------------------------------
function CoroutineCache:Obtain(): CoroutineCache
	if self.Status ~= "Free" then return end
	self.Status = "Busy"
	return self
end

---------------------------------------------------------------------------------------------------------------------
function CoroutineCache:Free()
	if self.Status ~= "Busy" then return end
	self.Status = "Free"
end

---------------------------------------------------------------------------------------------------------------------
function CoroutineCache:Execute(Callback: () -> ())
	if self.Status ~= "Busy" then return false end
	self.Status = "Busy"
	self.CurrentCallback = Callback
	coroutine.resume(self.Coroutine, Callback)
	return true
end

---------------------------------------------------------------------------------------------------------------------
function CoroutineCache:Close()
	if self.Status == "Busy" then task.defer(self.Close, self) return end
	self.Break = true
	coroutine.resume(self.Coroutine)
	coroutine.close(self.Coroutine)
	table.clear(self)
end

---------------------------------------------------------------------------------------------------------------------
return CoroutineCache
