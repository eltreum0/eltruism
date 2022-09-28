local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- AddonSkins profile setup
function ElvUI_EltreumUI:GetASProfile()
	local width = GetPhysicalScreenSize()
	local valuecolors = E:ClassColor(E.myclass, true)
	if IsAddOnLoaded("AddOnSkins") then
		local AS = unpack(AddOnSkins)
		AS.data:SetProfile("Eltreum Dual")
		AS.db["EmbedBackdrop"] = false
		AS.db["EmbedBackdropTransparent"] = false
		AS.db["EmbedRightChat"] = true
		AS.db["EmbedSystem"] = false
		AS.db["EmbedSystemDual"] = true
		AS.db["EmbedLeftWidth"] = 206
		AS.db["EmbedSystemMessage"] = false
		AS.db["EmbedOoC"] = true
		AS.db["EmbedOoCDelay"] = 1
		AS.db["EmbedIsHidden"] = false
		AS.db["EmbedFrameLevel"] = 2
		AS.db["HighlightColor"] = {
			valuecolors.r, -- [1]
			valuecolors.g, -- [2]
			valuecolors.b, -- [3]
			1, -- [4]
		}
		AS.db["StatusBarColor"] = {
			1, -- [1]
			1, -- [2]
			1, -- [3]
			1, -- [4]
		}
		AS.db["SelectedColor"] = {
			1, -- [1]
			1, -- [2]
			1, -- [3]
			1, -- [4]
		}
		AS.db["DBMSkinHalf"] = true
		AS.db["DBMFontFlag"] = E.db.general.fontStyle
		AS.db["DBMFont"] = E.db.general.font
		AS.db["DBMRadarTrans"] = true
		AS.db["HideChatFrame"] = "ChatFrame4"
		AS.db["TransparentEmbed"] = true
		AS.db["EmbedSystemDual"] = true
		AS.db["Immersion"] = true
		AS.db["BugSack"] = true
		if E.Retail then
			AS.db["Blizzard_AchievementUI"] = false
		end
	end
end
