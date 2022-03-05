
E2Lib.RegisterExtension("playercore", true, "Custom TAS fork of Sir Papate's PlyCore with @strict support and decent code")
local gm = gmod.GetGamemode()

local INVALID_PLAYER_ERROR = "Tried to use an invalid player"
local NO_PERMS_ERROR = "You do not have permission to run this function"
local INVALID_VEC_ERROR = "Tried to use an invalid vector"
local BUILDMODE_ERROR = "You cannot use this function while in build mode"

local function isValidPlayer(plr)
	return plr and IsEntity(plr) and IsValid(plr) and plr:IsPlayer()
end


local function hasAccess(plr, target, command)
	local valid = hook.Call("PlyCoreCommand", gm, plr, target, command)
	if valid ~= nil then
		return valid
	end

	if plr == target then return true end
	if not CPPI then return true end

	for _, friend in ipairs(target:CPPIGetFriends())  do
		if friend == plr then
			return true
		end
	end

	return false
end

local inf = math.huge
local function validateVector(v)
	return (
		v[1] == v[1] and v[1] ~= inf and v[1] ~= -inf and
		v[2] == v[2] and v[2] ~= inf and v[2] ~= -inf and
		v[3] == v[3] and v[3] ~= inf and v[3] ~= -inf
	)
end

e2function void entity:plyApplyForce(vector force)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyApplyForce") then return self:throw(NO_PERMS_ERROR) end
	if not validateVector(force) then return self:throw(INVALID_VEC_ERROR) end
	if not this:HasBuildMode() then return self:throw(BUILDMODE_ERROR) end

	this:SetVelocity(Vector(force[1], force[2], force[3]))
end

e2function void entity:plySetPos(vector pos)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetPos") then return self:throw(NO_PERMS_ERROR) end
	if not this:HasBuildMode() then return self:throw(BUILDMODE_ERROR) end

	local pos = Vector(
		math.Clamp(pos[1], -16384, 16384),
		math.Clamp(pos[2], -16384, 16384),
		math.Clamp(pos[3], -16384, 16384)
	)
	if not validateVector(pos) then return self:throw(INVALID_VEC_ERROR) end

	this:SetPos(pos)
end

e2function void entity:plySetAng(angle ang)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetAng") then return self:throw(NO_PERMS_ERROR) end

	local normalizedAng = Angle(ang[1], ang[2], ang[3])
	normalizedAng:Normalize()
	this:SetEyeAngles(normalizedAng)
end

e2function void entity:plyNoclip(number activate)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyNoclip") then return self:throw(NO_PERMS_ERROR) end
	if not this:HasBuildMode() then return self:throw(BUILDMODE_ERROR) end

	if activate ~= 0 then
		this:SetMoveType(MOVETYPE_NOCLIP)
	else
		this:SetMoveType(MOVETYPE_WALK)
	end
end

e2function void entity:plySetHealth(number health)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetHealth") then return self:throw(NO_PERMS_ERROR) end
	if not this:HasBuildMode() then return self:throw(BUILDMODE_ERROR) end

	this:SetHealth(math.Clamp(health, 0, 0x7FFFFFFF))
end
e2function number entity:plyGetHealth()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:Health()
end
e2function number entity:plyGetMaxHealth()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:GetMaxHealth()
end

local function setArmour(this, armour)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetArmor") then return self:throw(NO_PERMS_ERROR) end
	if not this:HasBuildMode() then return self:throw(BUILDMODE_ERROR) end

	this:SetArmor(math.Clamp(armour, 0, 0x7FFFFFFF))
end
local function getArmour(this)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:Armor()
end
local function getMaxArmour(this)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:GetMaxArmor()
end

e2function void entity:plySetArmor(number armor)
	setArmour(this, armor)
end
e2function void entity:plySetArmour(number armour)
	setArmour(this, armour)
end

e2function number entity:plyGetArmor()
	return getArmour(this)
end
e2function number entity:plyGetArmour()
	return getArmour(this)
end

e2function number entity:plyGetMaxArmor()
	return getMaxArmour(this)
end
e2function number entity:plyGetMaxArmour()
	return getMaxArmour(this)
end

e2function void entity:plySetMass(number mass)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetMass") then return self:throw(NO_PERMS_ERROR) end

	local phys = this:GetPhysicsObject()
	if not phys or not phys:IsValid() then return self:throw("Invalid physics object") end

	phys:SetMass(math.Clamp(mass, 1, 50000))
end

e2function number entity:plyGetMass()
	if not isValidPlayer(this) then return 0 end

	local phys = this:GetPhysicsObject()
	if not phys or not phys:IsValid() then return 0 end

	return phys:GetMass()
end

e2function void entity:plySetJumpPower(number jumpPower)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetJumpPower") then return self:throw(NO_PERMS_ERROR) end

	this:SetJumpPower(math.Clamp(jumpPower, 0, 0x7FFFFFFF))
end

e2function number entity:plyGetJumpPower()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:GetJumpPower()
end

e2function void entity:plySetGravity(number gravity)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetGravity") then return self:throw(NO_PERMS_ERROR) end

	if gravity == 0 then this:SetGravity(1.175494/(10^38)) end
	this:SetGravity(gravity / 600)
end
e2function void entity:plySetGravityMul(number multiplier)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetGravity") then return self:throw(NO_PERMS_ERROR) end

	if multiplier == 0 then this:SetGravity(1.175494/(10^38)) end
	this:SetGravity(multiplier)
end

e2function number entity:plyGetGravity()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:GetGravity() * 600
end
e2function number entity:plyGetGravityMul()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:GetGravity()
end

e2function void entity:plySetSpeed(number speed)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetSpeed") then return self:throw(NO_PERMS_ERROR) end
	if not this:HasBuildMode() then return self:throw(BUILDMODE_ERROR) end

	this:SetWalkSpeed(speed)
	this:SetRunSpeed(speed)
end
e2function void entity:plySetWalkSpeed(number speed)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetWalkSpeed") then return self:throw(NO_PERMS_ERROR) end
	if not this:HasBuildMode() then return self:throw(BUILDMODE_ERROR) end

	this:SetWalkSpeed(speed)
end
e2function void entity:plySetRunSpeed(number speed)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySetRunSpeed") then return self:throw(NO_PERMS_ERROR) end
	if not this:HasBuildMode() then return self:throw(BUILDMODE_ERROR) end

	this:SetRunSpeed(speed)
end

e2function number entity:plyGetSpeed()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:GetWalkSpeed()
end
e2function number entity:plyGetWalkSpeed()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:GetWalkSpeed()
end
e2function number entity:plyGetRunSpeed()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:GetRunSpeed()
end

e2function void entity:plyResetSettings()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyResetSettings") then return self:throw(NO_PERMS_ERROR) end

	if this:HasBuildMode() then
		this:Health(this:GetMaxHealth())
		this:Armor(0)

		this:SetWalkSpeed(200)
		this:SetRunSpeed(400)
	end

	local phys = this:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:SetMass(85)
	end

	this:SetJumpPower(200)
	this:SetGravity(1)
end

e2function void entity:plyEnterVehicle(entity vehicle)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyEnterVehicle") then return self:throw(NO_PERMS_ERROR) end
	if not vehicle or not vehicle:IsValid() or not vehicle:IsVehicle() then return self:throw("Vehicle is invalid or not a vehicle") end

	if this:InVehicle() then this:ExitVehicle() end
	this:EnterVehicle(vehicle)
end

e2function void entity:plyExitVehicle()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyExitVehicle") then return self:throw(NO_PERMS_ERROR) end
	if not this:InVehicle() then return end

	this:ExitVehicle()
end

e2function void entity:plySpawn()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plySpawn") then return self:throw(NO_PERMS_ERROR) end

	if not this.e2PcLastSpawn then this.e2PcLastSpawn = CurTime() - 1 end
	if CurTime() - this.e2PcLastSpawn < 1 then return self:throw("Tried to respawn the player too quickly") end
	this.e2PcLastSpawn = CurTime()

	this:Spawn()
end

registerCallback("destruct", function(self)
	for _, plr in ipairs(player.GetAll()) do
		if plr.plycore_freezeby == self then
			plr:Freeze(false)
		end

		if plr.plycore_noclipdisabledby == self then
			plr:SetNWBool("PlyCore_DisableNoclip", false)
		end
	end
end)

e2function void entity:plyFreeze(number freeze)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyFreeze") then return self:throw(NO_PERMS_ERROR) end

	if freeze == 0 then
		this.plycore_freezeby = nil
		this:Freeze(false)
	else
		this.plycore_freezeby = self
		this:Freeze(true)
	end
end

e2function number entity:plyIsFrozen()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:IsFlagSet(FL_FROZEN)
end

e2function void entity:plyDisableNoclip(number disable)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyDisableNoclip") then return self:throw(NO_PERMS_ERROR) end

	if disable == 0 then
		this.plycore_noclipdisabledby = nil
		this:SetNWBool("PlyCore_DisableNoclip", false)
	else
		this.plycore_noclipdisabledby = self
		this:SetNWBool("PlyCore_DisableNoclip", true)
	end
end

hook.Add("PlayerNoClip", "PlyCore", function(plr, state)
	if not state then return end

	if plr:GetNWBool("PlyCore_DisableNoclip", false) then
		return false
	end
end)

e2function void entity:plyIgnite(number time)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyIgnite") then return self:throw(NO_PERMS_ERROR) end

	this:Ignite(math.Clamp(time, 1, 3600))
end

e2function void entity:plyIgnite()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyIgnite") then return self:throw(NO_PERMS_ERROR) end

	this:Ignite(60)
end

e2function void entity:plyExtinguish()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyExtinguish") then return self:throw(NO_PERMS_ERROR) end

	this:Extinguish()
end

local function sendMessage(instance, caller, targets, text, centre)
	for _, plr in ipairs(targets) do
		if not isValidPlayer(plr) then
			return instance:throw(INVALID_PLAYER_ERROR)
		end
		if not hasAccess(caller, plr, centre and "sendMessageCenter" or "sendMessage") then
			return instance:throw(NO_PERMS_ERROR)
		end
	end

	for _, plr in ipairs(targets) do
		if centre then
			plr:PrintMessage(HUD_PRINTCENTER, text)
		else
			plr:PrintMessage(HUD_PRINTCONSOLE, self.player:Name() .. " sent this next chat message via E2")
			plr:ChatPrint(text)
		end
	end
end

e2function void sendMessage(string text)
	sendMessage(self, self.player, player.GetAll(), text)
end
e2function void sendMessageCenter(string text)
	sendMessage(self, self.player, player.GetAll(), text, true)
end
e2function void sendMessageCentre(string text)
	sendMessage(self, self.player, player.GetAll(), text, true)
end

e2function void entity:sendMessage(string text)
	sendMessage(self, self.player, {this}, text)
end
e2function void entity:sendMessageCenter(string text)
	sendMessage(self, self.player, {this}, text, true)
end
e2function void entity:sendMessageCentre(string text)
	sendMessage(self, self.player, {this}, text, true)
end

e2function void array:sendMessage(string text)
	sendMessage(self, self.player, this, text)
end
e2function void array:sendMessageCenter(string text)
	sendMessage(self, self.player, this, text, true)
end
e2function void array:sendMessageCentre(string text)
	sendMessage(self, self.player, this, text, true)
end

local printColour_typeids = {
	v = function(v) return Color(v[1], v[2], v[3]) end,
	xv4 = function(v) return Color(v[1], v[2], v[3], v[4]) end
}

local function guessTypes(arr)
	local typeids = {}
	for i, v in ipairs(arr) do
		if istable(v) then
			local isColour, hasAlpha = true, false
			for k, _ in pairs(v) do
				if k == 4 then
					hasAlpha = true
				elseif k ~= 1 or k ~= 2 or k ~= 3 then
					isColour = false
				end
			end

			if isColour then
				typeids[i] = hasAlpha and "xv4" or "v"
			else
				typeids[i] = "s"
			end
		else
			typeids[i] = "s"
		end
	end
	return typeids
end

local function printColour(instance, caller, targets, typeids, args)
	for _, plr in ipairs(targets) do
		if not isValidPlayer(plr) then
			return instance:throw(INVALID_PLAYER_ERROR)
		end
		if not hasAccess(caller, plr, "sendMessageColor") then
			return instance:throw(NO_PERMS_ERROR)
		end
	end

	for i, tp in ipairs(typeids) do
		if printColour_typeids[tp] then
			args[i] = printColour_typeids[tp](args[i])
		end
	end

	for _, plr in ipairs(targets) do
		plr:ChatPrint(unpack(args))
	end
end

e2function void sendMessageColor(array arr)
	printColour(self, self.player, player.GetAll(), guessTypes(arr),  arr)
end
e2function void sendMessageColor(...)
	printColour(self, self.player, player.GetAll(), typeids, {...})
end
e2function void sendMessageColour(array arr)
	printColour(self, self.player, player.GetAll(), guessTypes(arr),  arr)
end
e2function void sendMessageColour(...)
	printColour(self, self.player, player.GetAll(), typeids, {...})
end

e2function void entity:sendMessageColor(array arr)
	printColour(self, self.player, {this}, guessTypes(arr), arr)
end
e2function void entity:sendMessageColor(...)
	printColour(self, self.player, {this}, typeids, {...})
end
e2function void entity:sendMessageColour(array arr)
	printColour(self, self.player, {this}, guessTypes(arr), arr)
end
e2function void entity:sendMessageColour(...)
	printColour(self, self.player, {this}, typeids, {...})
end

e2function void array:sendMessageColor(array arr)
	printColour(self, self.player, this, guessTypes(arr), arr)
end
e2function void array:sendMessageColor(...)
	printColour(self, self.player, this, typeids, {...})
end
e2function void array:sendMessageColour(array arr)
	printColour(self, self.player, this, guessTypes(arr), arr)
end
e2function void array:sendMessageColour(...)
	printColour(self, self.player, this, typeids, {...})
end

local registered_e2s_spawn = {}
local lastspawnedplayer = Player(-1)
local respawnrun = 0

registerCallback("destruct", function(self)
	registered_e2s_spawn[self.entity] = nil
end)

hook.Add("PlayerSpawn", "Expresion2_PlayerSpawn", function(plr)
	respawnrun = 1
	lastspawnedplayer = plr
	for entity, _ in pairs(registered_e2s_spawn) do
		if entity:IsValid() then entity:Execute() end
	end
	respawnrun = 0
end)

e2function void runOnSpawn(activate)
	if activate ~= 0 then
		registered_e2s_spawn[self.entity] = true
	else
		registered_e2s_spawn[self.entity] = nil
	end
end

e2function number spawnClk()
	return respawnrun
end

e2function entity lastSpawnedPlayer()
	return lastspawnedplayer
end

local registered_e2s_death = {}
local playerdeathinfo = {Player(-1), Entity(-1), Player(-1)}
local deathrun = 0

registerCallback("destruct",function(self)
	registered_e2s_death[self.entity] = nil
end)

hook.Add("PlayerDeath", "Expresion2_PlayerDeath", function(victim, inflictor, attacker)
	deathrun = 1
	playerdeathinfo = {victim, inflictor, attacker}
	for entity, _ in pairs(registered_e2s_death) do
		if entity:IsValid() then entity:Execute() end
	end
	deathrun = 0
end)

e2function void runOnDeath(activate)
	if activate ~= 0 then
		registered_e2s_death[self.entity] = true
	else
		registered_e2s_death[self.entity] = nil
	end
end

e2function number deathClk()
	return deathrun
end

e2function entity lastDeath()
	return playerdeathinfo[1]
end

e2function entity lastDeathInflictor()
	return playerdeathinfo[2]
end

e2function entity lastDeathAttacker()
	return playerdeathinfo[3]
end

local registered_e2s_connect = {}
local lastconnectedplayer = NULL
local connectrun = 0

registerCallback("destruct",function(self)
	registered_e2s_connect[self.entity] = nil
end)

hook.Add("PlayerInitialSpawn", "Expresion2_PlayerInitialSpawn", function(plr)
	connectrun = 1
	lastconnectedplayer = plr
	for entity, _ in pairs(registered_e2s_connect) do
		if entity:IsValid() then entity:Execute() end
	end
	connectrun = 0
end)

e2function void runOnConnect(activate)
	if activate ~= 0 then
		registered_e2s_connect[self.entity] = true
	else
		registered_e2s_connect[self.entity] = nil
	end
end

e2function number connectClk()
	return connectrun
end

e2function entity lastConnectedPlayer()
	return lastconnectedplayer
end

local registered_e2s_disconnect = {}
local lastdisconnectedplayer = Player(-1)
local disconnectrun = 0

registerCallback("destruct",function(self)
	registered_e2s_disconnect[self.entity] = nil
end)

hook.Add("PlayerDisconnected", "Expresion2_PlayerDisconnected", function(plr)
	disconnectrun = 1
	lastdisconnectedplayer = plr
	for entity, _ in pairs(registered_e2s_disconnect) do
		if entity:IsValid() then entity:Execute() end
	end
	disconnectrun = 0
end)

e2function void runOnDisconnect(activate)
	if activate ~= 0 then
		registered_e2s_disconnect[self.entity] = true
	else
		registered_e2s_disconnect[self.entity] = nil
	end
end

e2function number disconnectClk()
	return disconnectrun
end

e2function entity lastDisconnectedPlayer()
	return lastdisconnectedplayer
end

e2function void entity:plyBuild(number active)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyBuild") then return self:throw(NO_PERMS_ERROR) end

	if active ~= 0 then
		this:BuildEnable()
	else
		this:BuildDisable()
	end
end
e2function number entity:plyHasBuild()
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	return this:HasBuildMode() and 1 or 0
end

hook.Add("GetFallDamage", "plyDisableFallDamage", function(ply, speed)
	if ply.fallDamageDisabled ~= 0 then return 0 else return 10 end
end)

e2function void entity:plyDisableFallDamage(number active)
	if not isValidPlayer(this) then return self:throw(INVALID_PLAYER_ERROR) end
	if not hasAccess(self.player, this, "plyDisableFallDamage") then return self:throw(NO_PERMS_ERROR) end

	this.fallDamageDisabled = active
end