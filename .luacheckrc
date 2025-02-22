std = "lua51"
max_line_length = false
codes = true
exclude_files = {
	"**/Libs",
}
only = {
	"011", -- syntax
	"1", -- globals
}
files["**/Loader.lua"].ignore = {
	"113/C_ChatInfo",
	"113/SendChatMessage",
	"113/SetRaidTarget",
	"113/UnitDetailedThreatSituation",
	"113/UnitGUID",
	"113/UnitName",
}
files["**/Core/BossPrototype.lua"].ignore = {
	"113/TranscriptIgnore",
	"113/Transcriptor",
}
ignore = {
	"11/SLASH_.*", -- slash handlers
	"1/[A-Z][A-Z][A-Z0-9_]+", -- three letter+ constants
}
globals = {
	-- wow std api
	"abs",
	"acos",
	"asin",
	"atan",
	"atan2",
	"bit",
	"ceil",
	"cos",
	"date",
	"debuglocals",
	"debugprofilestart",
	"debugprofilestop",
	"debugstack",
	"deg",
	"difftime",
	"exp",
	"fastrandom",
	"floor",
	"forceinsecure",
	"foreach",
	"foreachi",
	"format",
	"frexp",
	"geterrorhandler",
	"getn",
	"gmatch",
	"gsub",
	"hooksecurefunc",
	"issecure",
	"issecurevariable",
	"ldexp",
	"log",
	"log10",
	"max",
	"min",
	"mod",
	"rad",
	"random",
	"scrub",
	"securecall",
	"seterrorhandler",
	"sin",
	"sort",
	"sqrt",
	"strbyte",
	"strchar",
	"strcmputf8i",
	"strconcat",
	"strfind",
	"string.join",
	"strjoin",
	"strlen",
	"strlenutf8",
	"strlower",
	"strmatch",
	"strrep",
	"strrev",
	"strsplit",
	"strsub",
	"strtrim",
	"strupper",
	"table.wipe",
	"tan",
	"time",
	"tinsert",
	"tremove",

	-- framexml
	"SlashCmdList",
	"getprinthandler",
	"hash_SlashCmdList",
	"setprinthandler",
	"tContains",
	"tDeleteItem",
	"tInvert",
	"tostringall",

	-- everything else
	"AlertFrame",
	"Ambiguate",
	"BasicMessageDialog",
	"BigWigs",
	"BigWigs3DB",
	"BigWigsAnchor",
	"BigWigsAPI",
	"BigWigsEmphasizeAnchor",
	"BigWigsIconDB",
	"BigWigsLoader",
	"BigWigsOptions",
	"BigWigsStatsDB",
	"BigWigsKrosusFirstBeamWasLeft", -- Legion/Nighthold/Krosus.lua
	"BNGetFriendIndex",
	"BNIsSelf",
	"BNSendWhisper",
	"BossBanner",
	"C_EncounterJournal",
	"C_FriendList",
	"C_GossipInfo",
	"ChatFrame_ImportListToHash",
	"ChatTypeInfo",
	"CheckInteractDistance",
	"CinematicFrame_CancelCinematic",
	"C_Map",
	"CombatLogGetCurrentEventInfo",
	"CombatLog_String_GetIcon",
	"CreateFrame",
	"C_BattleNet",
	"C_CVar",
	"C_NamePlate",
	"C_RaidLocks",
	"C_Scenario",
	"C_Spell",
	"C_TalkingHead",
	"C_Timer",
	"EJ_GetCreatureInfo",
	"EJ_GetEncounterInfo",
	"EJ_GetTierInfo",
	"ElvUI",
	"EnableAddOn",
	"FlashClientIcon",
	"GameFontHighlight",
	"GameFontNormal",
	"GameTooltip",
	"GameTooltip_Hide",
	"GetAddOnDependencies",
	"GetAddOnEnableState",
	"GetAddOnInfo",
	"GetAddOnMetadata",
	"GetAddOnOptionalDependencies",
	"GetBuildInfo",
	"GetCurrentRegion", -- XXX temp 9.0.5
	"GetDifficultyInfo",
	"GetFramesRegisteredForEvent",
	"GetInstanceInfo",
	"GetItemCount",
	"GetLocale",
	"GetNumAddOns",
	"GetNumGroupMembers",
	"GetPartyAssignment",
	"GetPlayerFacing",
	"GetProfessionInfo",
	"GetProfessions",
	"GetRaidRosterInfo", -- Classic/AQ40/Cthun.lua
	"GetRaidTargetIndex",
	"GetRealmName",
	"GetRealZoneText",
	"GetSpecialization",
	"GetSpecializationInfoByID",
	"GetSpecializationRole",
	"GetSpellCooldown",
	"GetSpellDescription",
	"GetSpellInfo",
	"GetSpellLink",
	"GetSpellTexture",
	"GetSubZoneText",
	"GetTime",
	"GetTrackedAchievements",
	"InCombatLockdown",
	"IsAddOnLoaded",
	"IsAddOnLoadOnDemand",
	"IsAltKeyDown",
	"IsControlKeyDown",
	"IsEncounterInProgress",
	"IsGuildMember",
	"IsInGroup",
	"IsInRaid",
	"IsItemInRange",
	"IsLoggedIn",
	"IsPartyLFG",
	"IsSpellKnown",
	"IsTestBuild",
	"LFGDungeonReadyPopup",
	"LibStub",
	"LoadAddOn",
	"LoggingCombat",
	"MovieFrame",
	"ObjectiveTrackerFrame",
	"PlayerHasToy",
	"PlaySound",
	"PlaySoundFile",
	"RaidBossEmoteFrame",
	"RaidNotice_AddMessage",
	"RaidWarningFrame",
	"RolePollPopup",
	"SecondsToTime",
	"StopSound",
	"TalkingHeadFrame",
	"Tukui",
	"UIErrorsFrame",
	"UIParent",
	"UIWidgetManager",
	"UnitAffectingCombat",
	"UnitAura",
	"UnitCanAttack",
	"UnitCastingInfo",
	"UnitClass",
	"UnitExists",
	"UnitFactionGroup",
	"UnitGetTotalAbsorbs",
	"UnitGroupRolesAssigned",
	"UnitHealth",
	"UnitHealthMax",
	"UnitInParty",
	"UnitInRaid",
	"UnitInVehicle",
	"UnitIsConnected",
	"UnitIsCorpse",
	"UnitIsDead",
	"UnitIsDeadOrGhost",
	"UnitIsEnemy", -- Multiple old modules
	"UnitIsFriend", -- MoP/SiegeOfOrgrimmar/TheFallenProtectors.lua
	"UnitIsGroupAssistant",
	"UnitIsGroupLeader",
	"UnitIsPlayer",
	"UnitIsUnit",
	"UnitLevel",
	"UnitPhaseReason",
	"UnitPlayerControlled",
	"UnitPosition",
	"UnitPower",
	"UnitPowerMax",
	"UnitPowerType", -- Multiple old modules
	"UnitRace",
	"UnitSetRole",
	"UnitSex",
	"UnitThreatSituation", -- Cataclysm/Bastion/Sinestra.lua
	-- Legion/TombOfSargeras/Kiljaeden.lua
	"GetTrackingInfo",
	"SetTracking",
	"GetNumTrackingTypes",
	"Minimap",
}
