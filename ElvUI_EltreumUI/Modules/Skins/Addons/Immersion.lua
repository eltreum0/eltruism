local ElvUI_EltreumUI, E, L, V, P, G = unpack((select(2, ...)))
local S = E:GetModule('Skins')
local _G = _G
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

--skin immersion
function ElvUI_EltreumUI:EltruismImmersion()
	if E.db.ElvUI_EltreumUI.skins.immersion then
		local frames = {
			_G["ImmersionFrame"].TalkBox.BackgroundFrame,
			_G["ImmersionFrame"].TalkBox.Elements,
			_G["ImmersionFrame"].TalkBox.PortraitFrame,
		}
		for _, v in pairs(frames) do
			S:HandleFrame(v)
		end
		if E.db.ElvUI_EltreumUI.skins.shadow.enable then
			for _, frame in pairs(frames) do
				if not E.Classic then
					if frame and not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
					end
				else
					if frame and frame.backdrop and not frame.backdrop.shadow then
						frame.backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.backdrop.shadow) end
					end
				end
			end
		end

		S:HandleCloseButton(_G["ImmersionFrame"].TalkBox.MainFrame.CloseButton)

		--hide highlights/animations
		_G["ImmersionFrame"].TalkBox.MainFrame.Model.ModelShadow:Hide()
		_G["ImmersionFrame"].TalkBox.MainFrame.Model.PortraitBG:Hide()
		_G["ImmersionFrame"].TalkBox.Hilite:Hide()
		_G["ImmersionFrame"].TalkBox.PortraitFrame:Hide()
		_G["ImmersionFrame"].TalkBox.MainFrame.TextSheen:StripTextures()
		_G["ImmersionFrame"].TalkBox.MainFrame.Sheen:StripTextures()
		_G["ImmersionFrame"].TalkBox.MainFrame.Overlay:StripTextures()

		--update buttons on events/show
		local function updatebuttons()

			--move so it doesnt overlap
			if not InCombatLockdown() then
				_G["ImmersionFrame"].TalkBox.Elements:ClearAllPoints()
				_G["ImmersionFrame"].TalkBox.Elements:SetPoint("TOP", _G["ImmersionFrame"].TalkBox, "BOTTOM", 0, -10)
			end

			for _, v in pairs{_G["ImmersionFrame"].TitleButtons:GetChildren()} do
				if v and not v.IsSkinned then
					S:HandleButton(v)
					v:CreateBackdrop('Transparent')
					v.Hilite:Hide()
					v.Overlay:Hide()
					v:StyleButton()
					if E.db.ElvUI_EltreumUI.skins.shadow.enable then
						if v and not v.shadow then
							v:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(v.shadow) end
						end
					end
					v.IsSkinned = true
				end
			end

			for i = 1, 10 do
				if _G["ImmersionQuestInfoItem" .. i] and not _G["ImmersionQuestInfoItem" .. i].IsSkinned then
					_G["ImmersionQuestInfoItem" .. i].NameFrame:StripTextures()
					_G["ImmersionQuestInfoItem" .. i]:CreateBackdrop('Transparent')
					_G["ImmersionQuestInfoItem" .. i].backdrop:ClearAllPoints()
					_G["ImmersionQuestInfoItem" .. i].backdrop:SetAllPoints(_G["ImmersionQuestInfoItem" .. i .."Name"])
					_G["ImmersionQuestInfoItem" .. i].backdrop:SetAlpha(0.5) --transparent is setting alpha to 1 for some reason
					_G["ImmersionQuestInfoItem" .. i].IsSkinned = true
				end
				if _G["ImmersionProgressItem" .. i] and not _G["ImmersionProgressItem" .. i].IsSkinned then
					_G["ImmersionProgressItem" .. i].NameFrame:StripTextures()
					_G["ImmersionProgressItem" .. i]:CreateBackdrop('Transparent')
					_G["ImmersionProgressItem" .. i].backdrop:ClearAllPoints()
					_G["ImmersionProgressItem" .. i].backdrop:SetAllPoints(_G["ImmersionProgressItem" .. i .."Name"])
					_G["ImmersionProgressItem" .. i].backdrop:SetAlpha(0.5)
					_G["ImmersionProgressItem" .. i].IsSkinned = true
				end
			end
		end

		--buttons are created depending on quest, hook frame to update them
		_G["ImmersionFrame"]:HookScript("OnShow", updatebuttons)
		_G["ImmersionFrame"]:HookScript("OnEvent", updatebuttons)
	end
end
S:AddCallbackForAddon('Immersion', "EltruismImmersion", ElvUI_EltreumUI.EltruismImmersion)
