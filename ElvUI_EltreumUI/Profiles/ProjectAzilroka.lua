local E, L, V, P, G = unpack(ElvUI)
local _G = _G

-- ProjectAzilroka profile setup
function ElvUI_EltreumUI:GetPAProfile()
	local PA = _G.ProjectAzilroka
	PA.data:SetProfile("Default")

	-- Module toggles
	PA.db["AuraReminder"] = {}
	PA.db["AuraReminder"]["Enable"] = false
	PA.db["QuestSounds"]["Enable"] = false
	PA.db["FasterLoot"]["Enable"] = false
	if E.Retail then
		--PA.db["SunsongRanchFarmer"]["Enable"] = false
		PA.db["QuestSounds"]["Enable"] = true
		PA.db["QuestSounds"]["ObjectiveCompleteID"] = "None"
		PA.db["QuestSounds"]["ObjectiveProgressID"] = "None"
		PA.db["QuestSounds"]["ObjectiveComplete"] = "None"
		PA.db["QuestSounds"]["QuestCompleteID"] = "None"
		PA.db["QuestSounds"]["ObjectiveProgress"] = "None"
		--PA.db["ReputationReward"]["Enable"] = false
		PA.db["TorghastBuffs"]["horizontalSpacing"] = 1
		PA.db["TorghastBuffs"]["verticalSpacing"] = 1
		PA.db["TorghastBuffs"]["size"] = 26
		PA.db["EnhancedFriendsList"] = false
		PA.db["TorghastBuffs"]["Enable"] = false
	end
	PA.db["Cooldown"]["Enable"] = false
	if PA.db["DragonOverlay"] and PA.db["DragonOverlay"]["Enable"] then
		PA.db["DragonOverlay"]["Enable"] = false
	end
	PA.db["EnhancedShadows"]["Enable"] = false
	PA.db["EnhancedShadows"]["ColorByClass"] = true --lol it was false while enable was true causing the purple color
	PA.db["EnhancedShadows"]["Size"] = 3
	PA.db["EnhancedFriendsList"] = {}
	PA.db["EnhancedFriendsList"]["StatusIconPack"] = "Square"
	PA.db["EnhancedFriendsList"]["Texture"] = "ElvUI Norm1"
	PA.db["MasterExperience"]["Enable"] = false
	PA.db["MouseoverAuras"]["Enable"] = false
	PA.db["MovableFrames"]["Enable"] = true
	PA.db["OzCooldowns"]["Enable"] = false
	PA.db["TargetSounds"]["Enable"] = false
	PA.db["stAddonManager"]["Enable"] = true
	PA.db["stAddonManager"]["FontSize"] = 15
	PA.db["stAddonManager"]["NumAddOns"] = 20
	PA.db["stAddonManager"]["ButtonHeight"] = 20
	PA.db["stAddonManager"]["FontFlag"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
	PA.db["stAddonManager"]["ButtonWidth"] = 20
	PA.db["stAddonManager"]["ClassColor"] = true
	PA.db["stAddonManager"]["Font"] = E.db.general.font
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
	PA.db["SquareMinimapButtons"]["Visibility"] = "show" --"[petbattle][combat]hide; show"
	PA.db["SquareMinimapButtons"]["MoveTracker"] = false
	PA.db["SquareMinimapButtons"]["BarMouseOver"] = true

	E.private.ElvUI_EltreumUI.isInstalled.projectazilroka = true
end
