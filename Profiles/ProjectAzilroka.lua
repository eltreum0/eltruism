local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

-- ProjectAzilroka profile setup
function ElvUI_EltreumUI:GetPAProfile()
	local PA = _G.ProjectAzilroka
	PA.data:SetProfile('Eltreum')

	-- Module toggles
	PA.db["AuraReminder"]["Enable"] = false
	PA.db["BigButtons"]["Enable"] = false
	PA.db["Cooldown"]["Enable"] = false
	PA.db["DragonOverlay"]["Enable"] = false
	PA.db["EnhancedShadows"]["Enable"] = true
	PA.db["EnhancedShadows"]["ColorByClass"] = true
	PA.db["EnhancedShadows"]["Size"] = 10
	PA.db["MasterExperience"]["Enable"] = false
	PA.db["MouseoverAuras"]["Enable"] = false
	PA.db["MovableFrames"]["Enable"] = false
	PA.db["OzCooldowns"]["Enable"] = false
	PA.db["QuestSounds"]["Enable"] = true
	PA.db["QuestSounds"]["ObjectiveProgressID"] = 6196
	PA.db["QuestSounds"]["QuestCompleteID"] = 6199
	PA.db["QuestSounds"]["ObjectiveCompleteID"] = 7194
	PA.db["QuestSounds"]["ObjectiveProgress"] = "None"
	PA.db["ReputationReward"]["Enable"] = false
	PA.db["TorghastBuffs"]["Enable"] = false
	PA.db["TorghastBuffs"]["horizontalSpacing"] = 1
	PA.db["TorghastBuffs"]["verticalSpacing"] = 1
	PA.db["TorghastBuffs"]["size"] = 26
	PA.db["EnhancedFriendsList"] = false
	PA.db["TargetSounds"]["Enable"] = true

	PA.db["stAddonManager"]["Enable"] = true
	PA.db["stAddonManager"]["FontSize"] = 15
	PA.db["stAddonManager"]["NumAddOns"] = 20
	PA.db["stAddonManager"]["ButtonHeight"] = 20
	PA.db["stAddonManager"]["FontFlag"] = "THICKOUTLINE"
	PA.db["stAddonManager"]["ButtonWidth"] = 20
	PA.db["stAddonManager"]["ClassColor"] = true
	PA.db["stAddonManager"]["Font"] = "Kimberley"
	PA.db["stAddonManager"]["FrameWidth"] = 470
	PA.db["stAddonManager"]["CheckTexture"] = "Eltreum-Elvui-Norm"

	PA.db["SquareMinimapButtons"]["Enable"] = true
	PA.db["SquareMinimapButtons"]["Shadows"] = false
	PA.db["SquareMinimapButtons"]["MoveQueue"] = false
	PA.db["SquareMinimapButtons"]["ButtonSpacing"] = 1
	PA.db["SquareMinimapButtons"]["ReverseDirection"] = true
	PA.db["SquareMinimapButtons"]["IconSize"] = 24
	PA.db["SquareMinimapButtons"]["MoveMail"] = false
	PA.db["SquareMinimapButtons"]["ButtonsPerRow"] = 8
	PA.db["SquareMinimapButtons"]["Visibility"] = "[petbattle][combat]hide; show"
	PA.db["SquareMinimapButtons"]["MoveTracker"] = false
	-- Movers
end
