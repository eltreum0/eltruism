local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

-- AddonSkins profile setup
function ElvUI_EltreumUI:GetASProfile()
	local valuecolors = E:ClassColor(E.myclass, true)
	if IsAddOnLoaded("AddOnSkins") then
		local AS = unpack(AddOnSkins)
		--AS.data:SetProfile("Eltreum Dual")
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
		AS.db["DBMSkinHalf"] = false
		AS.db["DBM-Core"] = false
		AS.db["DBMFontFlag"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		AS.db["DBMFont"] = E.db.general.font
		AS.db["Font"] = E.db.general.font
		AS.db["FontFlag"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)
		AS.db["DBMRadarTrans"] = false
		AS.db["HideChatFrame"] = "ChatFrame4"
		AS.db["TransparentEmbed"] = true
		AS.db["BagSync"] = false
		AS.db["RareScanner"] = false
		AS.db["Auctionator"] = false --currently causing errors
		AS.db["Hekili"] = false
		AS.db["Simulationcraft"] = false
		AS.db["BugSack"] = false
		AS.db["Clique"] = false
		AS.db["BigWigs"] = false
		AS.db["Immersion"] = false
		if E.Retail then
			AS.db["Blizzard_AchievementUI"] = false
		end
	end
end
