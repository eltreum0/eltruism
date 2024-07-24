local E = unpack(ElvUI)
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local IsInInstance = _G.IsInInstance
local UIFrameFadeIn = _G.UIFrameFadeIn
local UIFrameFadeOut = _G.UIFrameFadeOut

function ElvUI_EltreumUI:SkinLevelUp()
	-- Color level up display and boss banner originally by Aftermathh, 9.1 partially by Eltreum
	if E.Retail or E.Cata then
		if E.db.ElvUI_EltreumUI.skins.levelbossinstance then

			--skin the toast popup for level
			local EventToastManagerFrame = _G.EventToastManagerFrame
			if EventToastManagerFrame then
				--EventToastManagerFrame.GLine:SetVertexColor(classcolor.r, classcolor.g, classcolor.b)
				--EventToastManagerFrame.GLine2:SetVertexColor(classcolor.r, classcolor.g, classcolor.b)
				EventToastManagerFrame.GLine:SetAlpha(0)
				EventToastManagerFrame.GLine2:SetAlpha(0)

				EventToastManagerFrame.StatusLine = CreateFrame("StatusBar", "EltruismEventToastLine", EventToastManagerFrame)
				EventToastManagerFrame.StatusLine:SetMinMaxValues(0,100)
				EventToastManagerFrame.StatusLine:SetValue(100)
				EventToastManagerFrame.StatusLine:SetSize(418, 3)
				EventToastManagerFrame.StatusLine:SetPoint("TOP", EventToastManagerFrame, 0, -5)
				EventToastManagerFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				EventToastManagerFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
				EventToastManagerFrame.StatusLine:SetParent(EventToastManagerFrame)
				EventToastManagerFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismEventToastLine2", EventToastManagerFrame)
				EventToastManagerFrame.StatusLine2:SetMinMaxValues(0,100)
				EventToastManagerFrame.StatusLine2:SetValue(100)
				EventToastManagerFrame.StatusLine2:SetSize(418, 3)
				EventToastManagerFrame.StatusLine2:SetPoint("BOTTOM", EventToastManagerFrame, 0, 0)
				EventToastManagerFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				EventToastManagerFrame.StatusLine2:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
				EventToastManagerFrame.StatusLine2:SetParent(EventToastManagerFrame)

				hooksecurefunc(_G.EventToastManagerFrame,"DisplayToast", function(toast)
					if toast.currentDisplayingToast then
						EventToastManagerFrame.StatusLine:Show()
						EventToastManagerFrame.StatusLine2:Show()
						if toast.currentDisplayingToast.Title then
							toast.currentDisplayingToast.Title:SetShadowColor(0, 0, 0, 0.8)
							toast.currentDisplayingToast.Title:SetShadowOffset(2, -2)
							--toast.currentDisplayingToast.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 30, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)) --font size doesnt adjust so it kinda breaks level up
						end
						if toast.currentDisplayingToast.SubTitle then
							toast.currentDisplayingToast.SubTitle:SetShadowColor(0, 0, 0, 0.8)
							toast.currentDisplayingToast.SubTitle:SetShadowOffset(2, -2)
							--toast.currentDisplayingToast.SubTitle:SetFont(E.LSM:Fetch("font", E.db.general.font), 17, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle)) --font size doesnt adjust so it kinda breaks level up
						end
					end
				end)
				hooksecurefunc(_G.EventToastManagerFrame,"StopToasting", function()
					EventToastManagerFrame.StatusLine:Hide()
					EventToastManagerFrame.StatusLine2:Hide()
				end)
				--/script EventToastManagerFrame:Show()
			end

			--skin the boss loot banner
			local BossBanner = _G.BossBanner
			if BossBanner then
				local StatusLineTop = CreateFrame("StatusBar", nil, BossBanner)
				StatusLineTop:SetMinMaxValues(0,100)
				StatusLineTop:SetValue(100)
				StatusLineTop:SetSize(418, 2)
				--(point, relativeTo, relativePoint, offset_x, offset_y)
				StatusLineTop:SetPoint("TOP", BossBanner, 0, -80)
				StatusLineTop:SetStatusBarTexture(E.Media.Textures.Highlight)
				StatusLineTop:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 0.7)
				local StatusLineBottom = CreateFrame("StatusBar", nil, BossBanner)
				StatusLineBottom:SetMinMaxValues(0,100)
				StatusLineBottom:SetValue(100)
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
				BossBanner.Title:SetFont(E.LSM:Fetch("font", E.db.general.font), 30, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				BossBanner.SubTitle:SetTextColor(1, 1, 1, 1)
				BossBanner.SubTitle:SetShadowColor(0, 0, 0, 0.8)
				BossBanner.SubTitle:SetShadowOffset(2, -1)
				BossBanner.SubTitle:SetFont(E.LSM:Fetch("font", E.db.general.font), 17, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				--/script BossBanner:Show()
			end

			--cata levelup
			if _G.LevelUpDisplay then
				_G.LevelUpDisplay.gLine:SetAlpha(0)
				_G.LevelUpDisplay.gLine2:SetAlpha(0)

				_G.LevelUpDisplay.StatusLine = CreateFrame("StatusBar", "EltruismEventToastLine", _G.LevelUpDisplay)
				_G.LevelUpDisplay.StatusLine:SetMinMaxValues(0,100)
				_G.LevelUpDisplay.StatusLine:SetValue(100)
				_G.LevelUpDisplay.StatusLine:SetSize(418, 3)
				_G.LevelUpDisplay.StatusLine:SetPoint("TOP", _G.LevelUpDisplay, 0, -5)
				_G.LevelUpDisplay.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.LevelUpDisplay.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
				_G.LevelUpDisplay.StatusLine:SetParent(_G.LevelUpDisplay)
				_G.LevelUpDisplay.StatusLine2 = CreateFrame("StatusBar", "EltruismEventToastLine2", _G.LevelUpDisplay)
				_G.LevelUpDisplay.StatusLine2:SetMinMaxValues(0,100)
				_G.LevelUpDisplay.StatusLine2:SetValue(100)
				_G.LevelUpDisplay.StatusLine2:SetSize(418, 3)
				_G.LevelUpDisplay.StatusLine2:SetPoint("BOTTOM", _G.LevelUpDisplay, 0, 0)
				_G.LevelUpDisplay.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				_G.LevelUpDisplay.StatusLine2:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
				_G.LevelUpDisplay.StatusLine2:SetParent(_G.LevelUpDisplay)
			end
		end
	end

	--remove blizzard boss emote during raids/dungeons
	if E.db.ElvUI_EltreumUI.skins.bossemote and _G.RaidBossEmoteFrame then
		_G.RaidBossEmoteFrame:SetScale(E.db.ElvUI_EltreumUI.skins.blizzframes.bossScale)
		local RaidBossEmoteFrame = _G.RaidBossEmoteFrame
		local _, instanceType = IsInInstance()
		if instanceType == "raid" or instanceType == "party" or instanceType == "scenario" then --fix for WQs that use the boss emote frame
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
			RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
			RaidBossEmoteFrame:UnregisterEvent("CLEAR_BOSS_EMOTES")
		end
	end

end

--add one for classic/tbc as well, but for some reason doesnt really work inside a function, maybe because of the timer?
if E.Classic then
	local LevelUpFrame = CreateFrame("Frame", "EltruismLevelUp", UIParent)
	LevelUpFrame:SetPoint("TOP", UIParent, 0, -100)
	LevelUpFrame:SetSize(418, 72)

	LevelUpFrame.Text = LevelUpFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	LevelUpFrame.Text:SetSize(418, 72)
	LevelUpFrame.Text:SetPoint("CENTER", "EltruismLevelUp", "CENTER", 0, 16)
	LevelUpFrame.Text:SetTextColor(1, 1, 1)
	LevelUpFrame.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 18, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
	LevelUpFrame.Text:SetText(LEVEL_UP_YOU_REACHED)

	LevelUpFrame.Text2 = LevelUpFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
	LevelUpFrame.Text2:SetSize(418, 72)
	LevelUpFrame.Text2:SetPoint("CENTER", "EltruismLevelUp", "CENTER", 0, -14)
	if E.myclass == "SHAMAN" and E.Classic then
		LevelUpFrame.Text2:SetTextColor(0, 0.44, 87)
	else
		LevelUpFrame.Text2:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
	end
	LevelUpFrame.Text2:SetFont(E.LSM:Fetch("font", E.db.general.font), 42, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

	LevelUpFrame.StatusLine = CreateFrame("StatusBar", "EltruismLevelUp", LevelUpFrame)
	LevelUpFrame.StatusLine:SetMinMaxValues(0,100)
	LevelUpFrame.StatusLine:SetValue(100)
	LevelUpFrame.StatusLine:SetSize(418, 3)
	LevelUpFrame.StatusLine:SetPoint("TOP", LevelUpFrame, 0, -5)
	LevelUpFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
	if E.myclass == "SHAMAN" and E.Classic then
		LevelUpFrame.StatusLine:SetStatusBarColor(0, 0.44, 87, 1)
	else
		LevelUpFrame.StatusLine:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
	end
	LevelUpFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismLevelUp", LevelUpFrame)
	LevelUpFrame.StatusLine2:SetMinMaxValues(0,100)
	LevelUpFrame.StatusLine2:SetValue(100)
	LevelUpFrame.StatusLine2:SetSize(418, 3)
	LevelUpFrame.StatusLine2:SetPoint("BOTTOM", LevelUpFrame, 0, 0)
	LevelUpFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
	if E.myclass == "SHAMAN" and E.Classic then
		LevelUpFrame.StatusLine2:SetStatusBarColor(0, 0.44, 87, 1)
	else
		LevelUpFrame.StatusLine2:SetStatusBarColor(classcolor.r, classcolor.g, classcolor.b, 1)
	end

	LevelUpFrame:Hide()

	local playerlevel = E.mylevel
	if E.Cata or E.Classic then
		LevelUpFrame:RegisterEvent("PLAYER_LEVEL_UP")
		--LevelUpFrame:RegisterEvent("PLAYER_STARTED_MOVING")
		--LevelUpFrame:SetScript("OnEvent", function(self, event, ...)
		LevelUpFrame:SetScript("OnEvent", function()
			if E.db.ElvUI_EltreumUI.skins.levelbossinstance then
				playerlevel = playerlevel + 1
				--print(playerlevel)
				LevelUpFrame.Text2:SetText(LEVEL.." "..playerlevel.."!")
				UIFrameFadeIn(LevelUpFrame, 1, 0, 1)
				E:Delay(5, function() UIFrameFadeOut(LevelUpFrame, 1, 1, 0) end)
			end
		end)
	end
end
