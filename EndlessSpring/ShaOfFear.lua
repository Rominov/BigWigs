
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sha of Fear", 886, 709)
if not mod then return end
mod:RegisterEnableMob(60999, 61003) -- Sha of Fear, Dread Spawn

--------------------------------------------------------------------------------
-- Locals
--

local swingCounter, thrashCounter, thrashNext = 0, 0, nil
local atSha = true
local nextFear = 0
local submergeCounter = 0
local cackleCounter = 1
local phase = 1
local dreadSpawns = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.fading_soon = "%s fading soon"

	L.swing = "Swing"
	L.swing_desc = "Counts the swings preceeding Thrash."

	L.throw = "Throw!"
	L.ball_dropped = "Ball dropped!"
	L.ball_you = "You have the ball!"
	L.ball = "Ball"

	L.cooldown_reset = "Your cooldowns have been reset!"

	L.ability_cd = "Ability cooldown"
	L.ability_cd_desc = "Try and guess in which order abilities will be used after an Emerge."
	L.ability_cd_icon = 120458

	L.huddle_or_spout = "Huddle or Spout"
	L.huddle_or_strike = "Huddle or Strike"
	L.strike_or_spout = "Strike or Spout"
	L.huddle_or_spout_or_strike = "Huddle or Spout or Strike"
end
L = mod:GetLocale()
--L.swing = L.swing.." "..INLINE_TANK_ICON -- the string is used in messages so ;[
L.swing_desc = CL.tank..L.swing_desc

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"ej:6699", 119414, 129147, {119519, "FLASHSHAKE", "SAY"},
		{ 119888, "FLASHSHAKE" }, 118977,
		129378, "ej:6700", 120669, {120629, "SAY"}, {120519, "FLASHSHAKE"}, 120672, "ability_cd", 120455, {120268, "FLASHSHAKE", "PROXIMITY"}, {"ej:6109", "FLASHSHAKE"}, "ej:6107",
		"swing", "berserk", "proximity", "bosskill",
	}, {
		["ej:6699"] = "ej:6086",
		[119888] = "ej:6089",
		[129378] = ("%s (%s)"):format(self:SpellName(120289), CL["heroic"]),
		swing = "general",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BreathOfFear", 119414)
	self:Log("SPELL_CAST_START", "OminousCackle", 119692, 119693, 119593)
	self:Log("SPELL_AURA_APPLIED", "OminousCackleApplied", 129147)
	self:Log("SPELL_AURA_REMOVED", "OminousCackleRemoved", 129147)
	self:Log("SPELL_AURA_APPLIED", "Thrash", 131996)
	self:Log("SPELL_AURA_APPLIED", "DreadThrash", 132007)
	self:Log("SPELL_AURA_APPLIED", "Fearless", 118977)
	self:Log("SPELL_AURA_REMOVED", "FearlessRemoved", 118977)
	self:Log("SPELL_CAST_START", "DeathBlossom", 119888)
	self:Log("SPELL_CAST_SUCCESS", "EerieSkull", 119519)
	-- Heroic
	self:Log("SPELL_CAST_START", "Waterspout", 120519)
	self:Log("SPELL_AURA_APPLIED", "WaterspoutApplied", 120519)
	self:Log("SPELL_AURA_APPLIED", "HuddleInTerror", 120629)
	self:Log("SPELL_CAST_SUCCESS", "NakedAndAfraid", 120669)
	self:Log("SPELL_AURA_APPLIED", "ChampionOfTheLight", 120268)
	self:Log("SPELL_AURA_REMOVED", "ChampionOfTheLightRemoved", 120268)
	self:Log("SPELL_CAST_START", "Submerge", 120455)
	self:Log("SPELL_CAST_START", "Emerge", 120458)
	self:Log("SPELL_CAST_START", "ImplacableStrike", 120672)
	self:Log("SPELL_CAST_START", "EternalDarkness", 120394)
	self:Log("SPELL_CAST_SUCCESS", "DreadSpawnSingleCast", 120388)
	self:Log("SPELL_AURA_APPLIED", "FadingLight", 129378)

	self:Log("SWING_DAMAGE", "Swing", "*")
	self:Log("SWING_MISSED", "Swing", "*")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "Transitions", "boss1")

	self:Death("Deaths", 60999, 61003)
end


function mod:OnEngage(diff)
	cackleCounter = 1
	self:Bar(119414, 119414, 33, 119414) -- Breath of Fear
	self:Bar(129147, ("%s (%d)"):format(self:SpellName(129147), cackleCounter), (diff == 4 or diff == 6) and 25 or 41, 129147) -- Ominous Cackle
	--self:Berserk(900) -- we start in UNIT_SPELLCAST_SUCCEEDED
	swingCounter, thrashCounter, thrashNext = 0, 0, nil
	self:OpenProximity(5) -- might be less
	atSha = true
	nextFear = 0
	submergeCounter = 0
	wipe(dreadSpawns)
	phase = 1
end

function mod:VerifyEnable(unit)
	return UnitCanAttack("player", unit)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	-- intelligent ability warning for last phase
	local huddleUsed, strikeUsed, spoutUsed = nil, nil, nil
	local huddleList, scheduled = mod:NewTargetList(), nil
	local function warnNext()
		if huddleUsed and spoutUsed and not strikeUsed then
			mod:Bar(120672, 120672, 10, 120672) -- strike
		elseif strikeUsed and spoutUsed and not huddleUsed then
			mod:Bar(120629, 120629, 10, 120629) -- huddle
		elseif huddleUsed and strikeUsed and not spoutUsed then
			mod:Bar(120519, 120519, 10, 120519) -- spout
		elseif huddleUsed and not strikeUsed and not spoutUsed then
			mod:Bar("ability_cd", L["strike_or_spout"], 10, 120458)
		elseif strikeUsed and not huddleUsed and not spoutUsed then
			mod:Bar("ability_cd", L["huddle_or_spout"], 10, 120458)
		elseif spoutUsed and not huddleUsed and not strikeUsed then
			mod:Bar("ability_cd", L["huddle_or_strike"], 10, 120458)
		end
	end
	local function warnHuddle(spellName)
		mod:TargetMessage(120629, spellName, huddleList, "Important", 120629, "Alert")
		scheduled = nil
	end
	function mod:HuddleInTerror(args)
		huddleUsed = true
		warnNext()
		huddleList[#huddleList + 1] = args.destName
		if UnitIsUnit(args.destName, "player") then
			self:SaySelf(args.spellId, args.spellName)
		end
		if not scheduled then
			scheduled = self:ScheduleTimer(warnHuddle, 0.3, args.spellName)
		end
	end
	function mod:Waterspout(args)
		spoutUsed = true
		warnNext()
		self:Message(args.spellId, args.spellName, "Urgent", args.spellId)
	end
	function mod:ImplacableStrike(args)
		strikeUsed = true
		warnNext()
		self:Message(args.spellId, args.spellName, "Attention", args.spellId, "Alarm")
	end
	function mod:Emerge(args)
		huddleUsed, strikeUsed, spoutUsed = nil, nil, nil
		self:Bar("ability_cd", L["huddle_or_spout_or_strike"], 10, args.spellId)
	end
end

function mod:Submerge(args)
	submergeCounter = submergeCounter + 1
	self:Message(args.spellId, ("%s (%d)"):format(args.spellName, submergeCounter), "Attention", args.spellId)
	self:Bar(args.spellId, ("%s (%d)"):format(args.spellName, submergeCounter+1), 52, args.spellId)
	--self:Bar(args.spellId, 120458, 6, args.spellId) -- Emerge
end

function mod:FadingLight(args)
	if UnitIsUnit("player", args.destName) then
		self:LocalMessage(129378, L["cooldown_reset"], "Positive", args.spellId, "Long")
	end
end

do
	local scheduled = nil
	local function announceDreadSpawnCount(source)
		local dreadSpawnCounter = 0
		for guid in next, dreadSpawns do
			dreadSpawnCounter = dreadSpawnCounter + 1
		end
		mod:Message("ej:6107", ("%s (%d)"):format(source, dreadSpawnCounter), "Positive", 128419) -- positive, tho we are not really happy about it (gathering speed the adds ability icon)
		scheduled = nil
	end
	function mod:DreadSpawnSingleCast(args)
		if not dreadSpawns[args.sourceGUID] then
			dreadSpawns[args.sourceGUID] = true
			if not scheduled then
				scheduled = self:ScheduleTimer(announceDreadSpawnCount, 0.2, args.sourceName)
			end
		end
	end
	function mod:Deaths(args)
		if args.mobId == 60999 then -- boss
			self:Win()
		elseif args.mobId == 61003 then -- dread spawn
			dreadSpawns[args.destGUID] = nil
			if not scheduled then
				scheduled = self:ScheduleTimer(announceDreadSpawnCount, 0.2, args.destName)
			end
		end
	end
end

do
	local prev = 0
	local champion = mod:SpellName(120268) -- Champion of the Light
	function mod:EternalDarkness(args)
		if UnitBuff("player", champion) then
			local t = GetTime()
			if t-prev > 1 then
				self:Message("ej:6109", L["throw"], "Personal", args.spellId, "Long")
				self:FlashShake("ej:6109")
				prev = t
			end
		end
	end
end

function mod:ChampionOfTheLight(args)
	self:TargetMessage(args.spellId, L["ball"], args.destName, "Positive", args.spellId, "Long")
	--self:CloseProximity(args.spellId) -- uncomment when mapdata becomes available for last phase
	if UnitIsUnit("player", args.destName) then
		--self:LocalMessage(args.spellId, L["ball_you"], "Personal", args.spellId, "Long") -- should maybe have a name like "Ball on you PASS IT!"
		self:FlashShake(args.spellId)
	end
end

do
	local function checkForDead(player)
		if UnitIsDead(player) then
			mod:Message(120669, L["ball_dropped"], "Important", 120669)
		end
	end
	function mod:ChampionOfTheLightRemoved(args)
		self:ScheduleTimer(checkForDead, 0.1, args.destName)
		--self:OpenProximity(40, args.spellId, args.destName, true) -- does not really work due to some map data issues in last phase -- uncomment when mapdata becomes available
	end
end

function mod:NakedAndAfraid(args)
	if self:Tank() then
		self:TargetMessage(args.spellId, args.spellName, args.destName, "Urgent", args.spellId)
		self:PlaySound(args.spellId, "Info") -- use TargetMessage for name coloring and play the sound for all tanks
		self:Bar(args.spellId, args.spellName, 31, args.spellId)
	end
end

function mod:Transitions(unit, spellName, _, _, spellId)
	if spellId == 114936 then -- Heroic Transition
		phase = 2
		self:CloseProximity()
		self:StopBar(119414) -- Breath of Fear
		self:CancelDelayedMessage(CL["soon"]:format(self:SpellName(119414))) -- Breath of Fear
		self:StopBar(("%s (%d)"):format(self:SpellName(129147), cackleCounter)) -- Ominous Cackle
		self:StopBar(131996) -- Thrash
		swingCounter = 0
	elseif spellId == 62535 then -- Berserk for that 1 sec accuracy
		self:Berserk(900, phase == 2)
		if phase == 2 then
			-- Phase 2 - Berserk in 15 min!
			self:Message("berserk", CL["phase"]:format(2).." - "..CL["custom_min"]:format(spellName, 15), "Attention")
			-- start Submerge timer using the current power and the new regen rate
			local left = 1 - (UnitPower("boss1") / UnitPowerMax("boss1")) * 52
			self:Bar(120455, ("%s (%d)"):format(self:SpellName(120455), 1), left, 120455)
		end
	end
end


function mod:WaterspoutApplied(args)
	if UnitIsUnit("player", args.destName) then
		self:LocalMessage(args.spellId, CL["underyou"]:format(args.spellName), "Personal", args.spellId, "Info")
		self:FlashShake(args.spellId)
	end
end

do -- COPY PASTE ACTION FROM COBALT MINE! see if this works
	local timer, fired = nil, 0
	local eerieSkull = mod:SpellName(119519)
	local function skullWarn(unitId)
		fired = fired + 1
		local unitIdTarget = unitId.."target"
		local player = UnitName(unitIdTarget)
		if player and (not UnitDetailedThreatSituation(unitIdTarget, unitId) or fired > 13) then
			-- If we've done 14 (0.7s) checks and still not passing the threat check, it's probably being cast on the tank
			if UnitIsUnit("player", player) then
				mod:LocalMessage(119519, CL["you"]:format(eerieSkull), "Urgent", 119519, "Alarm")
				mod:SaySelf(119519, eerieSkull)
				mod:FlashShake(119519)
			end
			mod:CancelTimer(timer)
			timer = nil
			return
		end
		-- 19 == 0.95sec
		-- Safety check if the unit doesn't exist
		if fired > 18 then
			mod:CancelTimer(timer)
			timer = nil
		end
	end
	function mod:EerieSkull()
		fired = 0
		if not timer and not self:LFR() then
			timer = self:ScheduleRepeatingTimer(skullWarn, 0.05, "boss1")
		end
	end
end

function mod:Thrash(args)
	if not self:Tank() and not self:Healer() then return end
	thrashNext = 2
	if phase == 2 then
		thrashCounter = thrashCounter + 1
		self:Message("ej:6699", ("%s (%d)"):format(args.spellName, thrashCounter), "Urgent", args.spellId)
		if thrashCounter == 3 then
			local dreadThrash = self:SpellName(132007)
			--self:DelayedMessage("ej:6700", 4, CL["soon"]:format(dreadThrash), "Attention", 132007)
			self:Bar("ej:6700", dreadThrash, 10, 132007)
		else
			self:Bar("ej:6699", ("%s (%d)"):format(args.spellName, thrashCounter + 1), 10, args.spellId)
		end
	elseif atSha then
		self:Message("ej:6699", args.spellName, "Important", args.spellId)
		self:Bar("ej:6699", args.spellName, 10, args.spellId)
	end
end

function mod:DreadThrash(args)
	if not self:Tank() and not self:Healer() then return end
	thrashCounter = 0
	thrashNext = 5
	self:Message("ej:6700", args.spellName, "Important", args.spellId, "Alarm")
	self:Bar("ej:6699", ("%s (%d)"):format(self:SpellName(131996), thrashCounter + 1), 10, 131996) -- Thrash
end

do
	local thrashSwings = ""
	function mod:Swing(args)
		if not self:Tank() or self:GetCID(args.sourceGUID) ~= 60999 then return end

		swingCounter = swingCounter + 1
		local hitType = tonumber(args.spellId) and _G["DAMAGE"] or _G["MISS"] --or _G["ACTION_SPELL_MISSED_"..damage] --
		if thrashNext then -- thrash triggering swing
			thrashSwings = ("%s (%d){%s}"):format(L["swing"], swingCounter, hitType)
			swingCounter = -thrashNext
			thrashNext = nil
		elseif UnitIsUnit("player", args.destName) then --just the current tank
			if swingCounter > 0 then -- normal swing
				self:Message("swing", ("%s (%d){%s}"):format(L["swing"], swingCounter, hitType), "Positive", 5547) -- hammer icon (meeeeh)
			elseif swingCounter < 0 then -- extra swing
				thrashSwings = ("%s{%s}"):format(thrashSwings, hitType)
			else -- (swingCounter==0) last extra swing
				self:Message("swing", ("%s{%s}"):format(thrashSwings, hitType), "Positive", 12972) -- thrashy icon
			end
		end
	end
end

function mod:DeathBlossom(args)
	if not atSha then
		self:FlashShake(args.spellId)
		self:Bar(args.spellId, CL["cast"]:format(args.spellName), 2.25, args.spellId) -- so it can be emphasized for countdown
		self:Message(args.spellId, args.spellName, "Important", args.spellId, "Alert")
	end
end

function mod:Fearless(args)
	if UnitIsUnit("player", args.destName) then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "target") -- just have it here for now
		self:OpenProximity(5) -- might be less
		atSha = true
		self:CancelDelayedMessage(CL["soon"]:format(self:SpellName(119888))) -- Death Blossom
		self:Bar(args.spellId, args.spellName, 30, args.spellId)
		self:DelayedMessage(args.spellId, 22, L["fading_soon"]:format(args.spellName), "Attention", args.spellId)

		-- resume Breath of Fear bar/message
		local left = nextFear - GetTime()
		self:Bar(119414, 119414, left, 119414)
		if left > 10 then
			self:DelayedMessage(119414, left-8, CL["soon"]:format(self:SpellName(119414)), "Attention", 119414)
		end
	end
end

function mod:FearlessRemoved(args)
	self:StopBar(args.spellName) -- this is needed so combat ressed people don't get confused because debuff gets removed if you get CR
end

function mod:BreathOfFear(args)
	nextFear = GetTime() + 33.3
	if atSha then -- Don't care about Sha while at a shrine and you have Fearless when you come back
		self:Bar(args.spellId, args.spellName, 33.3, args.spellId)
		self:DelayedMessage(args.spellId, 25, CL["soon"]:format(args.spellName), "Attention", args.spellId)
	end
end

function mod:OminousCackle(args)
	cackleCounter = cackleCounter + 1
	local diff = self:Difficulty()
	self:Bar(args.spellId, ("%s (%d)"):format(args.spellName, cackleCounter), (diff == 4 or diff == 6) and 45 or 90, args.spellId)
end

function mod:OminousCackleRemoved(args) -- set it here, because at this point we are surely out of range of the other platforms
	if UnitIsUnit("player", args.destName) then
		self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", "BlossomPreWarn", "target")
	end
end

do
	local cackleTargets, scheduled = mod:NewTargetList(), nil
	local function warnCackle(spellId)
		mod:TargetMessage(spellId, spellId, cackleTargets, "Urgent", spellId)
		scheduled = nil
	end
	function mod:OminousCackleApplied(args)
		cackleTargets[#cackleTargets + 1] = args.destName
		if UnitIsUnit("player", args.destName) then
			atSha = nil
			self:CloseProximity()
			self:StopBar(131996) -- Thrash
			self:StopBar(119414) -- Breath of Fear
			self:CancelDelayedMessage(CL["soon"]:format(self:SpellName(119414))) -- Breath of Fear
		end
		if not scheduled then
			scheduled = self:ScheduleTimer(warnCackle, 0.1, args.spellId)
		end
	end
end

function mod:BlossomPreWarn(unitId)
	local mobId = self:GetCID(UnitGUID(unitId))
	if mobId == 61046 or mobId == 61038 or mobId == 61042 then
		local hp = UnitHealth(unitId) / UnitHealthMax(unitId) * 100
		if hp < 30 then
			self:Message(119888, CL["soon"]:format(self:SpellName(119888)), "Attention", 119888) -- Death Blossom
			self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unitId)
		end
	end
end

