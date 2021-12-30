local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame

function ElvUI_EltreumUI:SkinLevelUp()
	-- Color level up display and boss banner originally by Aftermathh, 9.1 partially by Eltreum
	if ElvUI_EltreumUI.Retail then
		if E.db.ElvUI_EltreumUI.skins.enable then
			local R, G, B = unpack(E.media.rgbvaluecolor)
			local BossBanner = _G.BossBanner
			local EventToastManagerFrame = _G.EventToastManagerFrame

			if EventToastManagerFrame then
				_G.EventToastManagerFrame.GLine:SetVertexColor(R, G, B)
				_G.EventToastManagerFrame.GLine2:SetVertexColor(R, G, B)
				EventToastManagerFrame.StatusLine = CreateFrame("StatusBar", "EltruismEventToastLine", EventToastManagerFrame)
				EventToastManagerFrame.StatusLine:SetSize(418, 3)
				EventToastManagerFrame.StatusLine:SetPoint("TOP", EventToastManagerFrame, 0, -5)
				EventToastManagerFrame.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				EventToastManagerFrame.StatusLine:SetStatusBarColor(R, G, B, 1)
				EventToastManagerFrame.StatusLine2 = CreateFrame("StatusBar", "EltruismEventToastLine2", EventToastManagerFrame)
				EventToastManagerFrame.StatusLine2:SetSize(418, 3)
				EventToastManagerFrame.StatusLine2:SetPoint("BOTTOM", EventToastManagerFrame, 0, 0)
				EventToastManagerFrame.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				EventToastManagerFrame.StatusLine2:SetStatusBarColor(R, G, B, 1)
				--EventToastManagerFrame.currentDisplayingToast.BannerFrame:Kill() --lets try
				--/script EventToastManagerFrame:Show()
			end

			--test
			if E.db.ElvUI_EltreumUI.skins.bossemote then
				local RaidBossEmoteFrame = _G.RaidBossEmoteFrame
				RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
				RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
				RaidBossEmoteFrame:UnregisterEvent("CLEAR_BOSS_EMOTES")
			end

			if BossBanner then
				local StatusLineTop = CreateFrame("StatusBar", nil, _G.BossBanner)
				StatusLineTop:SetSize(418, 2)
				--(point, relativeTo, relativePoint, offset_x, offset_y)
				StatusLineTop:SetPoint("TOP", _G.BossBanner, 0, -80)
				StatusLineTop:SetStatusBarTexture(E.Media.Textures.Highlight)
				StatusLineTop:SetStatusBarColor(R, G, B, 0.7)
				local StatusLineBottom = CreateFrame("StatusBar", nil, _G.BossBanner)
				StatusLineBottom:SetSize(418, 2)
				StatusLineBottom:SetPoint("BOTTOM", _G.BossBanner, 0, -20)
				StatusLineBottom:SetStatusBarTexture(E.Media.Textures.Highlight)
				StatusLineBottom:SetStatusBarColor(R, G, B, 0.7)
				_G.BossBanner.BannerTop:Kill()
				_G.BossBanner.BannerTopGlow:Kill()
				_G.BossBanner.BannerBottom:Kill()
				_G.BossBanner.BannerBottomGlow:Kill()
				_G.BossBanner.BannerMiddle:Kill()
				--_G.BossBanner.BannerMiddle:SetTexture(E.Media.Textures.Highlight)
				--_G.BossBanner.BannerMiddle:SetColorTexture(0, 0, 0, 0.20)
				_G.BossBanner.BannerMiddleGlow:Kill()
				_G.BossBanner.LootCircle:Kill()
				_G.BossBanner.SkullCircle:Kill()
				_G.BossBanner.RightFillagree:Kill()
				_G.BossBanner.LeftFillagree:Kill()
				_G.BossBanner.BottomFillagree:Kill()
				_G.BossBanner.SkullSpikes:Kill()
				--/script BossBanner:Show()
			end
		end
	end
end
