hook.Add("PlayerNoClip", "PlyCore", function(ply, state)
	if not state then return end

	if ply:GetNWBool("PlyCore_DisableNoclip", false) then
		return false
	end
end)

local tbl = E2Helper.Descriptions
local function desc(name, description)
    tbl[name] = description
end

desc("plyApplyForce", "Applies force to a player in a particular direction")
desc("plySetPos", "Sets the position of the player within the bounds of the map")
desc("plySetAng", "Sets the angle of the player's camera")

desc("plyNoclip", "Sets the current noclip state of the player")

desc("plySetHealth", "Sets the health of the player within the positive range of int32")
desc("plyGetHealth", "Gets the player's health")
desc("plyGetMaxHealth", "Gets the player's max health")

desc("plySetArmor", "Sets the armour of the player within the positive range of int32")
desc("plyGetArmor", "Gets the player's armour")
desc("plyGetMaxArmor", "Gets the player's max armour")
desc("plySetArmour", "Sets the armour of the player within the positive range of int32")
desc("plyGetArmour", "Gets the player's armour")
desc("plyGetMaxArmour", "Gets the player's max armour")

desc("plySetMass", "Sets the player's mass (default: 85)")
desc("plyGetMass", "Gets the player's mass")

desc("plySetJumpPower", "Sets the player's jump power (default: 200)")
desc("plyGetJumpPower", "Gets the player's jump power")

desc("plySetGravity", "Sets the raw gravity value for the player (default: 600)")
desc("plySetGravityMul", "Sets the multiplier for the player's gravity (gravity = 600 * mul, default: 1)")
desc("plyGetGravity", "Gets the raw gravity value for the player")
desc("plyGetGravityMul", "Gets the multiplier for the player's gravity")

desc("plySetSpeed", "Sets the overall speed of the player (walk = speed, run = speed * 2, default: 200)")
desc("plySetWalkSpeed", "Sets the player's walk speed (default: 200)")
desc("plySetRunSpeed", "Sets the player's run speed (default: 400)")
desc("plyGetSpeed", "Gets the overall speed of the player (this is equal to plyGetWalkSpeed)")
desc("plyGetWalkSpeed", "Gets the player's walk speed")
desc("plyGetRunSpeed", "Gets the player's run speed")

desc("plyResetSettings", "Resets the player's settings to default values")

desc("plyEnterVehicle", "Makes the player enter a vehicle")
desc("plyExitVehicle", "Makes the player exit the vehicle they're in")

desc("plySpawn", "Causes the player to respawn")

desc("plyFreeze", "Toggles the freeze state of the player")
desc("plyIsFrozen", "Returns whether the player is frozen or not")

desc("plyDisableNoclip", "Toggles the ability for the player to enter noclip")

desc("plyIgnite()", "Sets the player on fire for a minute")
desc("plyIgnite(n)", "Sets the player on fire for the specified number of seconds")
desc("plyExtinguish", "Puts out any fires on the player")

desc("sendMessage", "Sends a message to every player's chatbox")
desc("sendMessageCenter", "Sends a message to the centre of every player's screen")
desc("sendMessageCentre", "Sends a message to the centre of every player's screen")

desc("e:sendMessage", "Sends a message to the player's chatbox")
desc("e:sendMessageCenter", "Sends a message to the centre of the player's screen")
desc("e:sendMessageCentre", "Sends a message to the centre of the player's screen")

desc("a:sendMessage", "Sends a message to every player in the array's chatbox")
desc("a:sendMessageCenter", "Sends a message to the centre of every player in the array's screen")
desc("a:sendMessageCentre", "Sends a message to the centre of every player in the array's screen")

desc("sendMessageColor", "Sends a coloured message to every player's chatbox")
desc("sendMessageColour", "Sends a coloured message to every player's chatbox")

desc("e:sendMessageColor", "Sends a coloured message to the player's chatbox")
desc("e:sendMessageColour", "Sends a coloured message to the player's chatbox")

desc("a:sendMessageColor", "Sends a coloured message to every player in the array's chatbox")
desc("a:sendMessageColour", "Sends a coloured message to every player in the array's chatbox")

desc("runOnSpawn", "Causes the chip to run every player death")
desc("spawnClk", "Returns 1 if this execution was caused by a player spawn")
desc("lastSpawnedPlayer", "Returns the last player that spawned")

desc("runOnDeath", "Causes the chip to run every player spawn")
desc("deathClk", "Returns 1 if this execution was caused by a player death")
desc("lastDeath", "Returns the last player that died")
desc("lastDeathInflictor", "Returns the entity that caused the last player death")
desc("lastDeathAttacker", "Returns the player that killed the last player that died")

desc("runOnConnect", "Causes the chip to run every initial player spawn")
desc("connectClk", "Returns 1 if this execution was caused by a player joining")
desc("lastConnectedPlayer", "Returns the last player that joined")

desc("runOnDisonnect", "Causes the chip to run every initial player spawn")
desc("disconnectClk", "Returns 1 if this execution was caused by a player joining")
desc("lastDisconnectedPlayer", "Returns the last player that joined")
