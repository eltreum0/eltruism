local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

function ElvUI_EltreumUI:Skins()
	--Reskin Blizzard Talent frame for TBC
	if ElvUI_EltreumUI.TBC then
		if E.db.ElvUI_EltreumUI.tbctalents.enable then
			local PlayerTalentFrame = _G.PlayerTalentFrame
			local PlayerTalentFrameScrollFrame = _G.PlayerTalentFrameScrollFrame
			local PlayerTalentFrameScrollFrameScrollBar = _G.PlayerTalentFrameScrollFrameScrollBar
			local PlayerTalentFrameBackgroundTopLeft = _G.PlayerTalentFrameBackgroundTopLeft
			local PlayerTalentFrameBackgroundTopRight = _G.PlayerTalentFrameBackgroundTopRight
			local PlayerTalentFrameBackgroundBottomLeft = _G.PlayerTalentFrameBackgroundBottomLeft
			local PlayerTalentFrameBackgroundBottomRight = _G.PlayerTalentFrameBackgroundBottomRight
			--hide the scroll
			if PlayerTalentFrameScrollFrameScrollBar then
				PlayerTalentFrameScrollFrameScrollBar:Kill()
			end
			--increase the size of the whole frame
			if PlayerTalentFrame then
				PlayerTalentFrame:SetSize(376, 770)
			end
			if PlayerTalentFrameScrollFrame then
				--increase the size of the actual frame that has the talent buttons
				PlayerTalentFrameScrollFrame:SetSize( 280 , 570)
				--set the position
				PlayerTalentFrameScrollFrame:ClearAllPoints()
				PlayerTalentFrameScrollFrame:SetPoint("CENTER", PlayerTalentFrame, 0, 20)
			end
			--kill stuff
			if PlayerTalentFrameBackgroundTopRight then
				PlayerTalentFrameBackgroundTopRight:Kill()
			end
			if PlayerTalentFrameBackgroundBottomLeft then
				PlayerTalentFrameBackgroundBottomLeft:Kill()
			end
			if PlayerTalentFrameBackgroundBottomRight then
				PlayerTalentFrameBackgroundBottomRight:Kill()
			end
			--increase the size of the background
			if PlayerTalentFrameBackgroundTopLeft then
				PlayerTalentFrameBackgroundTopLeft:SetSize(310 , 590)
			end
		end
	end

	--Reskin Blizzard Talent frame for Classic
	--[[if ElvUI_EltreumUI.Classic then
		--local TalentFrame = _G.TalentFrame
		local TalentFrameScrollFrame = _G.TalentFrameScrollFrame
		local TalentFrameScrollFrameScrollBar = _G.TalentFrameScrollFrameScrollBar
		local TalentFrameBackgroundTopLeft = _G.TalentFrameBackgroundTopLeft
		local TalentFrameBackgroundTopRight = _G.TalentFrameBackgroundTopRight
		local TalentFrameBackgroundBottomLeft = _G.TalentFrameBackgroundBottomLeft
		local TalentFrameBackgroundBottomRight = _G.TalentFrameBackgroundBottomRight
		--hide the scroll
		--TalentFrameScrollFrameScrollBar:Kill()
		--increase the size of the whole frame
		TalentFrame:SetSize(376, 760)
		--increase the size of the actuall frame that has the talent buttons
		--TalentFrameScrollFrame:SetSize( 280 , 580)
		--set the position
		--TalentFrameScrollFrame:SetPoint("CENTER", PlayerTalentFrame, 0, 0)
		--kill stuff
		--TalentFrameBackgroundTopRight:Kill()
		--TalentFrameBackgroundBottomLeft:Kill()
		--TalentFrameBackgroundBottomRight:Kill()
		--increase the size of the background
		--TalentFrameBackgroundTopLeft:SetSize(310 , 580)
	end ]]--

	-- Color level up display and boss banner by Aftermathh
	if ElvUI_EltreumUI.Retail then
		if E.db.ElvUI_EltreumUI.skins.enable then
			local R, G, B = unpack(E.media.rgbvaluecolor)
			local LevelUpDisplay = _G.LevelUpDisplay
			local BossBanner = _G.BossBanner
			if LevelUpDisplay then
				_G.LevelUpDisplayGLine:Kill()
				_G.LevelUpDisplayGLine2:Kill()
				LevelUpDisplay.StatusLine = CreateFrame("StatusBar", nil, LevelUpDisplay)
				LevelUpDisplay.StatusLine:SetSize(418, 2)
				LevelUpDisplay.StatusLine:SetPoint("TOP", LevelUpDisplay, 0, -5)
				LevelUpDisplay.StatusLine:SetStatusBarTexture(E.Media.Textures.Highlight)
				LevelUpDisplay.StatusLine:SetStatusBarColor(R, G, B, 0.7)
				LevelUpDisplay.StatusLine2 = CreateFrame("StatusBar", nil, LevelUpDisplay)
				LevelUpDisplay.StatusLine2:SetSize(418, 2)
				LevelUpDisplay.StatusLine2:SetPoint("BOTTOM", LevelUpDisplay, 0, -3)
				LevelUpDisplay.StatusLine2:SetStatusBarTexture(E.Media.Textures.Highlight)
				LevelUpDisplay.StatusLine2:SetStatusBarColor(R, G, B, 0.7)
				_G.LevelUpDisplay.challengeModeBits:Kill()
	    		_G.LevelUpDisplay.scenarioBits:Kill()
	    		_G.LevelUpDisplay.scenarioFiligree:Kill()
	    		_G.LevelUpDisplay.SpellBucketFrame:Kill()
				--/script LevelUpDisplay:Show()
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
