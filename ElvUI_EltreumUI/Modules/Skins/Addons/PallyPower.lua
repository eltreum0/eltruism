local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local unpack = _G.unpack
local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown

--based on old addonskins skin
function ElvUI_EltreumUI:EltruismPallyPower()
	if E.db.ElvUI_EltreumUI.skins.pallypower and E.Classic then
		if InCombatLockdown() then return end
		local PallyPower = _G.PallyPower
		local PALLYPOWER_MAXCLASSES = _G.PALLYPOWER_MAXCLASSES
		local PALLYPOWER_MAXPERCLASS = _G.PALLYPOWER_MAXPERCLASS
		local PallyPowerBlessingsFrame = _G.PallyPowerBlessingsFrame
		local PallyPowerBlessingsFrameCloseButton = _G.PallyPowerBlessingsFrameCloseButton
		local PallyPowerAnchor = _G.PallyPowerAnchor
		local PallyPowerAura = _G.PallyPowerAura
		local PallyPowerAuraIcon = _G.PallyPowerAuraIcon
		local PallyPowerAuto = _G.PallyPowerAuto
		local PallyPowerAutoIcon = _G.PallyPowerAutoIcon
		local PallyPowerBlessingsFrameAutoAssign = _G.PallyPowerBlessingsFrameAutoAssign
		local PallyPowerBlessingsFrameClear = _G.PallyPowerBlessingsFrameClear
		local PallyPowerBlessingsFrameFreeAssign = _G.PallyPowerBlessingsFrameFreeAssign
		local PallyPowerBlessingsFrameOptions = _G.PallyPowerBlessingsFrameOptions
		local PallyPowerBlessingsFramePreset = _G.PallyPowerBlessingsFramePreset
		local PallyPowerBlessingsFrameRefresh = _G.PallyPowerBlessingsFrameRefresh
		local PallyPowerBlessingsFrameReport = _G.PallyPowerBlessingsFrameReport
		local PallyPowerRF = _G.PallyPowerRF
		local PallyPowerRFIcon = _G.PallyPowerRFIcon
		local PallyPowerRFIconSeal = _G.PallyPowerRFIconSeal
		local PallyPowerFrame = _G.PallyPowerFrame
		local PallyPowerC1 = _G.PallyPowerC1
		local PallyPowerC2 = _G.PallyPowerC2
		local PallyPowerC3 = _G.PallyPowerC3
		local PallyPowerC4 = _G.PallyPowerC4
		local PallyPowerC5 = _G.PallyPowerC5
		local PallyPowerC6 = _G.PallyPowerC6
		local PallyPowerC7 = _G.PallyPowerC7
		local PallyPowerC8 = _G.PallyPowerC8
		local PallyPowerC9 = _G.PallyPowerC9
		local PallyPowerC10 = _G.PallyPowerC10

		--from old addonskins
		PallyPowerBlessingsFrame:StripTextures()
		--PallyPowerBlessingsFrame:SetTemplate('Transparent', nil, true)
		PallyPowerBlessingsFrame:SetTemplate("Transparent", E.media.normTex, true)
		S:HandleCloseButton(PallyPowerBlessingsFrameCloseButton)
		S:HandleButton(PallyPowerBlessingsFrameAutoAssign)
		S:HandleButton(PallyPowerBlessingsFrameClear)
		S:HandleButton(PallyPowerBlessingsFrameRefresh)
		S:HandleButton(PallyPowerBlessingsFrameOptions)
		S:HandleButton(PallyPowerBlessingsFrameReport)
		S:HandleButton(PallyPowerBlessingsFramePreset)
		S:HandleCheckBox(PallyPowerBlessingsFrameFreeAssign)

		--[[_G.L_DropDownList1:StripTextures()
		_G.L_DropDownList1:SetTemplate('Default')
		_G.L_DropDownList2:StripTextures()
		_G.L_DropDownList2:SetTemplate('Default')]]

		--PallyPowerAura:SetTemplate("Transparent", nil, true)
		PallyPowerAura:SetTemplate("Transparent", E.media.normTex, true)
		PallyPowerAuraIcon:SetTexCoord(unpack(E.TexCoords))
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not PallyPowerAura.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
			PallyPowerAura:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if PallyPowerAura.shadow then
				PallyPowerAura.shadow:ClearAllPoints()
				PallyPowerAura.shadow:SetPoint("BOTTOMLEFT", PallyPowerAuraIcon,"BOTTOMLEFT", -3, -3)
				PallyPowerAura.shadow:SetPoint("TOPLEFT", PallyPowerAuraIcon,"TOPLEFT", -3, 3)
				PallyPowerAura.shadow:SetPoint("BOTTOMRIGHT", PallyPowerAuraIcon,"BOTTOMRIGHT", 3, -3)
				PallyPowerAura.shadow:SetPoint("TOPRIGHT", PallyPowerAuraIcon,"TOPRIGHT", 3, 3)
				PallyPowerAura.shadow:SetParent(PallyPowerAura)
			end
			E:Delay(0, function()
				if PallyPowerAuraIcon:GetTexture() ~= nil then
					PallyPowerAura.shadow:Show()
				else
					PallyPowerAura.shadow:Hide()
				end
			end)
			ElvUI_EltreumUI:ShadowColor(PallyPowerAura.shadow)
		end

		--PallyPowerAuto:SetTemplate("Transparent", nil, true)
		PallyPowerAuto:SetTemplate("Transparent", E.media.normTex, true)
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not PallyPowerAuto.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
			PallyPowerAuto:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if PallyPowerAuto.shadow then
				PallyPowerAuto.shadow:ClearAllPoints()
				PallyPowerAuto.shadow:SetPoint("BOTTOMLEFT", PallyPowerAutoIcon,"BOTTOMLEFT", -3, -3)
				PallyPowerAuto.shadow:SetPoint("TOPLEFT", PallyPowerAutoIcon,"TOPLEFT", -3, 3)
				PallyPowerAuto.shadow:SetPoint("BOTTOMRIGHT", PallyPowerAutoIcon,"BOTTOMRIGHT", 3, -3)
				PallyPowerAuto.shadow:SetPoint("TOPRIGHT", PallyPowerAutoIcon,"TOPRIGHT", 3, 3)
				PallyPowerAuto.shadow:SetParent(PallyPowerAuto)
				ElvUI_EltreumUI:ShadowColor(PallyPowerAuto.shadow)
			end
		end

		PallyPowerRF:SetTemplate("Transparent", E.media.normTex, true)
		PallyPowerAuto:SetTemplate("Transparent", E.media.normTex, true)
		PallyPowerRFIcon:SetTexCoord(unpack(E.TexCoords))
		PallyPowerRFIconSeal:SetTexCoord(unpack(E.TexCoords))

		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not PallyPowerRF.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
			PallyPowerRF:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if PallyPowerRF.shadow then
				PallyPowerRF.shadow:ClearAllPoints()
				PallyPowerRF.shadow:SetPoint("BOTTOMLEFT", PallyPowerRFIconSeal,"BOTTOMLEFT", -3, -3)
				PallyPowerRF.shadow:SetPoint("TOPLEFT", PallyPowerRFIconSeal,"TOPLEFT", -3, 3)
				PallyPowerRF.shadow:SetPoint("BOTTOMRIGHT", PallyPowerRFIconSeal,"BOTTOMRIGHT", 3, -3)
				PallyPowerRF.shadow:SetPoint("TOPRIGHT", PallyPowerRFIconSeal,"TOPRIGHT", 3, 3)
				PallyPowerRF.shadow:SetParent(PallyPowerRF)
				ElvUI_EltreumUI:ShadowColor(PallyPowerRF.shadow)
			end
		end
		--because we need 2 shadows
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not PallyPowerAnchor.shadow and PallyPowerRFIcon:GetTexture() ~= nil and not E.db.ElvUI_EltreumUI.borders.universalborders then
			PallyPowerAnchor:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if PallyPowerAnchor.shadow then
				PallyPowerAnchor.shadow:ClearAllPoints()
				PallyPowerAnchor.shadow:SetPoint("BOTTOMLEFT", PallyPowerRFIcon,"BOTTOMLEFT", -3, -3)
				PallyPowerAnchor.shadow:SetPoint("TOPLEFT", PallyPowerRFIcon,"TOPLEFT", -3, 3)
				PallyPowerAnchor.shadow:SetPoint("BOTTOMRIGHT", PallyPowerRFIcon,"BOTTOMRIGHT", 3, -3)
				PallyPowerAnchor.shadow:SetPoint("TOPRIGHT", PallyPowerRFIcon,"TOPRIGHT", 3, 3)
				PallyPowerAnchor.shadow:SetParent(PallyPowerRF)
				ElvUI_EltreumUI:ShadowColor(PallyPowerAnchor.shadow)
			end
		end

		--hide the double lines
		if E.Mists or E.TBC or E.Wrath then
			PallyPowerRF.TopEdge:Kill()
		end
		PallyPowerRF.BottomEdge:Kill()

		--update for new pallypower
		for i = 1, PALLYPOWER_MAXCLASSES do
			local button = PallyPower.classButtons[i]
			--button:SetTemplate("Transparent", nil, true)
			button:SetTemplate("Transparent", E.media.normTex, true)

			--_G[button:GetName().."ClassIcon"]:SetTexCoord(unpack(E.TexCoords))
			_G[button:GetName().."BuffIcon"]:SetTexCoord(unpack(E.TexCoords))
			if E.db.ElvUI_EltreumUI.skins.shadow.enable and not button.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
				button:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				button.shadow:ClearAllPoints()
				button.shadow:SetPoint("BOTTOMLEFT", _G[button:GetName().."BuffIcon"],"BOTTOMLEFT", -3, -3)
				button.shadow:SetPoint("TOPLEFT", _G[button:GetName().."BuffIcon"],"TOPLEFT", -3, 3)
				button.shadow:SetPoint("BOTTOMRIGHT", _G[button:GetName().."BuffIcon"],"BOTTOMRIGHT", 3, -3)
				button.shadow:SetPoint("TOPRIGHT", _G[button:GetName().."BuffIcon"],"TOPRIGHT", 3, 3)
				button.shadow:SetParent(button)
				ElvUI_EltreumUI:ShadowColor(button.shadow)
			end

			for j = 1, PALLYPOWER_MAXPERCLASS do
				--PallyPower.playerButtons[i][j]:SetTemplate("Transparent", nil, true)
				PallyPower.playerButtons[i][j]:SetTemplate("Transparent", E.media.normTex, true)
			end
		end

		for i = 1, PALLYPOWER_MAXCLASSES do
			for j = 1, 8 do
				if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"] then
					_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"]:SetTexCoord(unpack(E.TexCoords))
					if not E.db.ElvUI_EltreumUI.borders.universalborders then
						if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow then
							_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:ClearAllPoints()
							_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:SetPoint("BOTTOMLEFT", _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"],"BOTTOMLEFT", -3, -3)
							_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:SetPoint("BOTTOMRIGHT", _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"],"BOTTOMRIGHT", 3, -3)
							_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:SetPoint("TOPLEFT", _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"],"TOPLEFT", -3, 3)
							_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:SetPoint("TOPRIGHT", _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"],"TOPRIGHT", 3, 3)
							if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"]:GetTexture() ~= nil then
								_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Show()
							else
								_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Hide()
							end
							ElvUI_EltreumUI:ShadowColor(_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow)
						end
						_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i]:HookScript("OnClick", function()
							E:Delay(0, function()
								if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow then
									if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"]:GetTexture() ~= nil then
										_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Show()
									else
										_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Hide()
									end
								end
							end)
						end)
					end
				end
				if _G["PallyPowerBlessingsFramePlayer"..j.."Icon"..i] then
					_G["PallyPowerBlessingsFramePlayer"..j.."Icon"..i]:SetTexCoord(unpack(E.TexCoords))
				end
				if _G["PallyPowerBlessingsFramePlayer"..j.."AIcon"..i] then
					_G["PallyPowerBlessingsFramePlayer"..j.."AIcon"..i]:SetTexCoord(unpack(E.TexCoords))
				end
				if _G["PallyPowerBlessingsFramePlayer"..j.."CIcon"..i] then
					_G["PallyPowerBlessingsFramePlayer"..j.."CIcon"..i]:SetTexCoord(unpack(E.TexCoords))
				end
			end
		end

		for i = 1, PALLYPOWER_MAXCLASSES do
			if _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"] then
				_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"]:SetTexCoord(unpack(E.TexCoords))
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:ClearAllPoints()
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetPoint("BOTTOMLEFT", _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"],"BOTTOMLEFT", -3, -3)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetPoint("TOPLEFT", _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"],"TOPLEFT", -3, 3)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetPoint("BOTTOMRIGHT", _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"],"BOTTOMRIGHT", 3, -3)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetPoint("TOPRIGHT", _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeaderIcon"],"TOPRIGHT", 3, 3)
					_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow:SetParent(_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"])
					ElvUI_EltreumUI:ShadowColor(_G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow)
				end
			end

			for j = 1, 8 do
				if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"] then
					_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"]:SetTexCoord(unpack(E.TexCoords))
					if not E.db.ElvUI_EltreumUI.borders.universalborders then
						if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow then
							if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"]:GetTexture() ~= nil then
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:ClearAllPoints()
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetPoint("BOTTOMLEFT", _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"],"BOTTOMLEFT", -3, -3)
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetPoint("TOPLEFT", _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"],"TOPLEFT", -3, 3)
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetPoint("BOTTOMRIGHT", _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"],"BOTTOMRIGHT", 3, -3)
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetPoint("TOPRIGHT", _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"],"TOPRIGHT", 3, 3)
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:SetParent(_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i])
								ElvUI_EltreumUI:ShadowColor(_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow)
							end
						end
						_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i]:HookScript("OnClick", function()
							E:Delay(0, function()
								if E.db.ElvUI_EltreumUI.skins.shadow.enable then
									if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"]:GetTexture() ~= nil then
										_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:Show()
										if PallyPowerAura.shadow then
											PallyPowerAura.shadow:Show()
										end
									else
										_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:Hide()
										if PallyPowerAura.shadow then
											PallyPowerAura.shadow:Hide()
										end
									end
								end
							end)
						end)
					end
				end
			end
		end

		--add shadow
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not PallyPowerBlessingsFrame.shadow and not E.db.ElvUI_EltreumUI.borders.universalborders then
			PallyPowerBlessingsFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(PallyPowerBlessingsFrame.shadow)
		end

		--better point
		PallyPowerAnchor:ClearAllPoints()
		E:Delay(0, function()
			if PallyPowerAura and PallyPowerAura:IsShown() then
				PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-10,10)
			else
				PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
			end
		end)
		PallyPowerAnchor:SetFrameLevel(10)

		--shadow update function
		local function UpdateShadows()
			if InCombatLockdown() then return end
			if not PallyPowerFrame.shadow then
				PallyPowerFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				PallyPowerFrame.shadow:SetParent(PallyPowerRF)
			end
			if PallyPowerFrame.shadow then
				if PallyPowerC1 and PallyPowerC1:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC1, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC2 and PallyPowerC2:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC2, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC3 and PallyPowerC3:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC3, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC4 and PallyPowerC4:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC4, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC5 and PallyPowerC5:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC5, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC6 and PallyPowerC6:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC6, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC7 and PallyPowerC7:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC7, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC8 and PallyPowerC8:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC8, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC9 and PallyPowerC9:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC9, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC10 and PallyPowerC10:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					else
						PallyPowerAnchor:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-10,10)
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerC1, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerC10, "BOTTOMRIGHT",3,-3)
				end
				if PallyPowerC1 and not PallyPowerC1:IsShown() then
					PallyPowerFrame.shadow:ClearAllPoints()
					if PallyPowerAura and PallyPowerAura:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAura, "TOPLEFT",-3,3)
					elseif PallyPowerRF and PallyPowerRF:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerRF, "TOPLEFT",-3,3)
					elseif PallyPowerAuto and PallyPowerAuto:IsShown() then
						PallyPowerFrame.shadow:SetPoint("TOPLEFT", PallyPowerAuto, "TOPLEFT",-3,3)
					end
					PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", PallyPowerAuto, "BOTTOMRIGHT",3,-3)
				end
				ElvUI_EltreumUI:ShadowColor(PallyPowerFrame.shadow)
			end
		end

		--main shadow
		if not E.db.ElvUI_EltreumUI.borders.universalborders then
			local shadowupdate = CreateFrame("FRAME")
			shadowupdate:RegisterEvent("GROUP_ROSTER_UPDATE")
			shadowupdate:RegisterEvent("GROUP_JOINED")
			shadowupdate:RegisterEvent("PLAYER_ENTERING_WORLD")
			shadowupdate:RegisterEvent("ZONE_CHANGED")
			shadowupdate:RegisterEvent("ZONE_CHANGED_INDOORS")
			shadowupdate:RegisterEvent("ZONE_CHANGED_NEW_AREA")
			shadowupdate:SetScript("OnEvent",function()
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					UpdateShadows()
				end
			end)
		end

		if PallyPowerC10 and not E.db.ElvUI_EltreumUI.borders.universalborders then
			PallyPowerC10:HookScript("OnShow", function()
				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					UpdateShadows()
				end
			end)
		end

		local function toggle()
			for i = 1, PALLYPOWER_MAXCLASSES do
				for j = 1, 8 do
					if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow then
						E:Delay(0, function()
							if _G["PallyPowerBlessingsFramePlayer"..j.."Class"..i.."Icon"]:GetTexture() ~= nil then
								_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Show()
							else
								_G["PallyPowerBlessingsFramePlayer"..j.."Class"..i].shadow:Hide()
							end
						end)
					end
					if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i] and _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow then
						E:Delay(0, function()
							if _G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i.."Icon"]:GetTexture() ~= nil then
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:Show()
							else
								_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:Hide()
							end
						end)
					end
				end
			end
		end

		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
			PallyPowerBlessingsFrame:HookScript("OnShow", function()
				toggle()
			end)

			PallyPowerBlessingsFrameClear:HookScript("OnClick", function()
				toggle()
			end)

			PallyPowerBlessingsFrameAutoAssign:HookScript("OnClick", function()
				toggle()
			end)
		end

		--crop icon
		if _G["PallyPowerAutoIcon"] then
			_G["PallyPowerAutoIcon"]:SetTexCoord(unpack(E.TexCoords))
		end

		--change toggle texture
		PallyPowerAnchor:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask")
		PallyPowerAnchor:GetNormalTexture():SetVertexColor(0,1,0)
		PallyPowerAnchor:GetCheckedTexture():SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask")
		PallyPowerAnchor:GetCheckedTexture():SetVertexColor(1,0,0)

		--use new icons
		PallyPower.ClassIcons = PallyPower.isWrath and {
			[1] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"WARRIOR",false,"128",true),
			[2] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"ROGUE",false,"128",true),
			[3] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"PRIEST",false,"128",true),
			[4] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"DRUID",false,"128",true),
			[5] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"PALADIN",false,"128",true),
			[6] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"HUNTER",false,"128",true),
			[7] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"MAGE",false,"128",true),
			[8] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"WARLOCK",false,"128",true),
			[9] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"SHAMAN",false,"128",true),
			[10] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"DEATHKNIGHT",false,"128",true),
		} or PallyPower.isBCC and {
			[1] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"WARRIOR",false,"128",true),
			[2] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"ROGUE",false,"128",true),
			[3] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"PRIEST",false,"128",true),
			[4] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"DRUID",false,"128",true),
			[5] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"PALADIN",false,"128",true),
			[6] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"HUNTER",false,"128",true),
			[7] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"MAGE",false,"128",true),
			[8] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"WARLOCK",false,"128",true),
			[9] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"SHAMAN",false,"128",true),
		} or {
			[1] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"WARRIOR",false,"128",true),
			[2] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"ROGUE",false,"128",true),
			[3] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"PRIEST",false,"128",true),
			[4] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"DRUID",false,"128",true),
			[5] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"PALADIN",false,"128",true),
			[6] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"HUNTER",false,"128",true),
			[7] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"MAGE",false,"128",true),
			[8] = ElvUI_EltreumUI:GetClassIcons(E.db.ElvUI_EltreumUI.skins.classiconsstyle,"WARLOCK",false,"128",true),
			[9] = "Interface\\Icons\\Ability_Mount_JungleTiger"
		}
	end
end
S:AddCallbackForAddon('PallyPower', 'EltruismPallyPower', ElvUI_EltreumUI.EltruismPallyPower)
