local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local IsInInstance = _G.IsInInstance
local C_Timer = _G.C_Timer
local UIFrameFadeIn = _G.UIFrameFadeIn
local UIFrameFadeOut = _G.UIFrameFadeOut

function ElvUI_EltreumUI:SkinLevelUp()
	-- Color level up display and boss banner originally by Aftermathh, 9.1 partially by Eltreum
	if E.Retail then
		if E.db.ElvUI_EltreumUI.skins.levelbossinstance then

			--skin the toast popup for level
			local EventToastManagerFrame = _G.EventToastManagerFrame
			if EventToastManagerFrame then
				--EventToastManagerFrame.GLine:SetVertexColor(classcolor.r, classcolor.g, classcolor.b)
				--EventToastManagerFrame.GLine2:SetVertexColor(classcolor.r, classcolor.g, classcolor.b)
				EventToastManagerFrame.GLine:SetAlpha(0)
				EventToastManagerFrame.GLine2:SetAlpha(0)

				EventToastManagerFrame.StatusLine = CreateFrame("StatusBar", "EltruismEventToastLine", EventToastManagerFrame)
				EventToastManagerFrame.StatusLine:SetSize(418, 3)
				EventToastManagerFrame.StatusLine:SetPoint("TOP", EventToastManagerFrame, 0, -5)
				EventToastManagerFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				EventToastManagerFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
				EventToastManagerFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismEventToastLine2", EventToastManagerFrame)
				EventToastManagerFrame.StatusLine2:SetSize(418, 3)
				EventToastManagerFrame.StatusLine2:SetPoint("BOTTOM", EventToastManagerFrame, 0, 0)
				EventToastManagerFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				EventToastManagerFrame.StatusLine2:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
				--/script EventToastManagerFrame:Show()
			end

			--remove blizzard boss emote during raids/dungeons
			if E.db.ElvUI_EltreumUI.skins.bossemote then
				local RaidBossEmoteFrame = _G.RaidBossEmoteFrame
				local _, instanceType = IsInInstance()
				if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --fix for WQs that use the boss emote frame
					RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
					RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
					RaidBossEmoteFrame:UnregisterEvent("CLEAR_BOSS_EMOTES")
				end
			end

			--skin the boss loot banner
			local BossBanner = _G.BossBanner
			if BossBanner then
				local StatusLineTop = CreateFrame("StatusBar", nil, BossBanner)
				StatusLineTop:SetSize(418, 2)
				--(point, relativeTo, relativePoint, offset_x, offset_y)
				StatusLineTop:SetPoint("TOP", BossBanner, 0, -80)
				StatusLineTop:SetStatusBarTexture(E.Media.Textures.Highlight)
				StatusLineTop:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 0.7)
				local StatusLineBottom = CreateFrame("StatusBar", nil, BossBanner)
				StatusLineBottom:SetSize(418, 2)
				StatusLineBottom:SetPoint("BOTTOM", BossBanner, 0, -20)
				StatusLineBottom:SetStatusBarTexture(E.Media.Textures.Highlight)
				StatusLineBottom:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 0.7)
				BossBanner.BannerTop:Kill()
				BossBanner.BannerTopGlow:Kill()
				BossBanner.BannerBottom:Kill()
				BossBanner.BannerBottomGlow:Kill()
				BossBanner.BannerMiddle:Kill()
				BossBanner.BannerMiddleGlow:Kill()
				BossBanner.LootCircle:Kill()
				BossBanner.SkullCircle:Kill()
				BossBanner.RightFillagree:Kill()
				BossBanner.LeftFillagree:Kill()
				BossBanner.BottomFillagree:Kill()
				BossBanner.SkullSpikes:Kill()

				BossBanner.Title:SetTextColor(1, 1, 1, 1)
				BossBanner.Title:SetShadowColor(0, 0, 0, 0.8)
				BossBanner.Title:SetShadowOffset(2, -1)
				BossBanner.SubTitle:SetTextColor(1, 1, 1, 1)
				BossBanner.SubTitle:SetShadowColor(0, 0, 0, 0.8)
				BossBanner.SubTitle:SetShadowOffset(2, -1)
				--/script BossBanner:Show()
			end
		end
	end
end

--add one for classic/tbc as well, but for some reason doesnt really work inside a function, maybe because of the timer?
if E.Wrath or E.Classic then
	local LevelUpFrame = CreateFrame("Frame", "EltruismLevelUp", UIParent)
	LevelUpFrame:SetPoint("TOP", UIParent, 0, -100)
	LevelUpFrame:SetSize(418, 72)

	LevelUpFrame.Text = LevelUpFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	LevelUpFrame.Text:SetSize(418, 72)
	LevelUpFrame.Text:SetPoint("CENTER", "EltruismLevelUp", "CENTER", 0, 16)
	LevelUpFrame.Text:SetTextColor(1, 1, 1)
	LevelUpFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, E.db.general.fontStyle)
	LevelUpFrame.Text:SetText(LEVEL_UP_YOU_REACHED)

	LevelUpFrame.Text2 = LevelUpFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	LevelUpFrame.Text2:SetSize(418, 72)
	LevelUpFrame.Text2:SetPoint("CENTER", "EltruismLevelUp", "CENTER", 0, -14)
	LevelUpFrame.Text2:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
	LevelUpFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 42, E.db.general.fontStyle)

	LevelUpFrame.StatusLine = CreateFrame("StatusBar", "EltruismLevelUp", LevelUpFrame)
	LevelUpFrame.StatusLine:SetSize(418, 3)
	LevelUpFrame.StatusLine:SetPoint("TOP", LevelUpFrame, 0, -5)
	LevelUpFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
	LevelUpFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
	LevelUpFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismLevelUp", LevelUpFrame)
	LevelUpFrame.StatusLine2:SetSize(418, 3)
	LevelUpFrame.StatusLine2:SetPoint("BOTTOM", LevelUpFrame, 0, 0)
	LevelUpFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
	LevelUpFrame.StatusLine2:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)

	LevelUpFrame:Hide()

	local playerlevel = E.mylevel
	if E.Wrath or E.Classic then
		LevelUpFrame:RegisterEvent("PLAYER_LEVEL_UP")
		--LevelUpFrame:SetScript("OnEvent", function(self, event, ...)
		LevelUpFrame:SetScript("OnEvent", function()
			if E.db.ElvUI_EltreumUI.skins.levelbossinstance then
				playerlevel = playerlevel + 1
				--print(playerlevel)
				LevelUpFrame.Text2:SetText(LEVEL.." "..playerlevel.."!")
				UIFrameFadeIn(LevelUpFrame, 1, 0, 1)
				C_Timer.After(5, function() UIFrameFadeOut(LevelUpFrame, 1, 1, 0) end)
			end
		end)
	end
end
