local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local unpack = _G.unpack
local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown

--based on old addonskins skin
function ElvUI_EltreumUI:EltruismPallyPower()
	if E.db.ElvUI_EltreumUI.skins.pallypower then
		if InCombatLockdown() then return end

		--from old addonskins
		local PallyPowerBlessingsFrame = _G.PallyPowerBlessingsFrame
		PallyPowerBlessingsFrame:StripTextures()
		--PallyPowerBlessingsFrame:SetTemplate('Transparent', nil, true)
		PallyPowerBlessingsFrame:SetTemplate("Transparent", E.media.normTex, true)
		S:HandleCloseButton(_G.PallyPowerBlessingsFrameCloseButton)
		S:HandleButton(_G.PallyPowerBlessingsFrameAutoAssign)
		S:HandleButton(_G.PallyPowerBlessingsFrameClear)
		S:HandleButton(_G.PallyPowerBlessingsFrameRefresh)
		S:HandleButton(_G.PallyPowerBlessingsFrameOptions)
		S:HandleButton(_G.PallyPowerBlessingsFrameReport)
		S:HandleButton(_G.PallyPowerBlessingsFramePreset)
		S:HandleCheckBox(_G.PallyPowerBlessingsFrameFreeAssign)

		--[[_G.L_DropDownList1:StripTextures()
		_G.L_DropDownList1:SetTemplate('Default')
		_G.L_DropDownList2:StripTextures()
		_G.L_DropDownList2:SetTemplate('Default')]]

		--_G.PallyPowerAura:SetTemplate("Transparent", nil, true)
		_G.PallyPowerAura:SetTemplate("Transparent", E.media.normTex, true)
		_G.PallyPowerAuraIcon:SetTexCoord(unpack(E.TexCoords))
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G.PallyPowerAura.shadow then
			_G.PallyPowerAura:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if _G.PallyPowerAura.shadow then
				_G.PallyPowerAura.shadow:ClearAllPoints()
				_G.PallyPowerAura.shadow:SetPoint("BOTTOMLEFT", _G.PallyPowerAuraIcon,"BOTTOMLEFT", -3, -3)
				_G.PallyPowerAura.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuraIcon,"TOPLEFT", -3, 3)
				_G.PallyPowerAura.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerAuraIcon,"BOTTOMRIGHT", 3, -3)
				_G.PallyPowerAura.shadow:SetPoint("TOPRIGHT", _G.PallyPowerAuraIcon,"TOPRIGHT", 3, 3)
				_G.PallyPowerAura.shadow:SetParent(_G.PallyPowerAura)
			end
			E:Delay(0, function()
				if _G.PallyPowerAuraIcon:GetTexture() ~= nil then
					_G.PallyPowerAura.shadow:Show()
				else
					_G.PallyPowerAura.shadow:Hide()
				end
			end)
			ElvUI_EltreumUI:ShadowColor(_G.PallyPowerAura.shadow)
		end

		--_G.PallyPowerAuto:SetTemplate("Transparent", nil, true)
		_G.PallyPowerAuto:SetTemplate("Transparent", E.media.normTex, true)
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G.PallyPowerAuto.shadow then
			_G.PallyPowerAuto:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if _G.PallyPowerAuto.shadow then
				_G.PallyPowerAuto.shadow:ClearAllPoints()
				_G.PallyPowerAuto.shadow:SetPoint("BOTTOMLEFT", _G.PallyPowerAutoIcon,"BOTTOMLEFT", -3, -3)
				_G.PallyPowerAuto.shadow:SetPoint("TOPLEFT", _G.PallyPowerAutoIcon,"TOPLEFT", -3, 3)
				_G.PallyPowerAuto.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerAutoIcon,"BOTTOMRIGHT", 3, -3)
				_G.PallyPowerAuto.shadow:SetPoint("TOPRIGHT", _G.PallyPowerAutoIcon,"TOPRIGHT", 3, 3)
				_G.PallyPowerAuto.shadow:SetParent(_G.PallyPowerAuto)
				ElvUI_EltreumUI:ShadowColor(_G.PallyPowerAuto.shadow)
			end
		end

		_G.PallyPowerRF:SetTemplate("Transparent", E.media.normTex, true)
		_G.PallyPowerAuto:SetTemplate("Transparent", E.media.normTex, true)
		_G.PallyPowerRFIcon:SetTexCoord(unpack(E.TexCoords))
		_G.PallyPowerRFIconSeal:SetTexCoord(unpack(E.TexCoords))

		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G.PallyPowerRF.shadow then
			_G.PallyPowerRF:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if _G.PallyPowerRF.shadow then
				_G.PallyPowerRF.shadow:ClearAllPoints()
				_G.PallyPowerRF.shadow:SetPoint("BOTTOMLEFT", _G.PallyPowerRFIconSeal,"BOTTOMLEFT", -3, -3)
				_G.PallyPowerRF.shadow:SetPoint("TOPLEFT", _G.PallyPowerRFIconSeal,"TOPLEFT", -3, 3)
				_G.PallyPowerRF.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerRFIconSeal,"BOTTOMRIGHT", 3, -3)
				_G.PallyPowerRF.shadow:SetPoint("TOPRIGHT", _G.PallyPowerRFIconSeal,"TOPRIGHT", 3, 3)
				_G.PallyPowerRF.shadow:SetParent(_G.PallyPowerRF)
				ElvUI_EltreumUI:ShadowColor(_G.PallyPowerRF.shadow)
			end
		end
		--because we need 2 shadows
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G.PallyPowerAnchor.shadow and _G.PallyPowerRFIcon:GetTexture() ~= nil then
			_G.PallyPowerAnchor:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			if _G.PallyPowerAnchor.shadow then
				_G.PallyPowerAnchor.shadow:ClearAllPoints()
				_G.PallyPowerAnchor.shadow:SetPoint("BOTTOMLEFT", _G.PallyPowerRFIcon,"BOTTOMLEFT", -3, -3)
				_G.PallyPowerAnchor.shadow:SetPoint("TOPLEFT", _G.PallyPowerRFIcon,"TOPLEFT", -3, 3)
				_G.PallyPowerAnchor.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerRFIcon,"BOTTOMRIGHT", 3, -3)
				_G.PallyPowerAnchor.shadow:SetPoint("TOPRIGHT", _G.PallyPowerRFIcon,"TOPRIGHT", 3, 3)
				_G.PallyPowerAnchor.shadow:SetParent(_G.PallyPowerRF)
				ElvUI_EltreumUI:ShadowColor(_G.PallyPowerAnchor.shadow)
			end
		end

		--hide the double lines
		if E.Wrath then
			_G.PallyPowerRF.TopEdge:Kill()
		end
		_G.PallyPowerRF.BottomEdge:Kill()

		--update for new pallypower
		for i = 1, PALLYPOWER_MAXCLASSES do
			local button = PallyPower.classButtons[i]
			--button:SetTemplate("Transparent", nil, true)
			button:SetTemplate("Transparent", E.media.normTex, true)

			--_G[button:GetName().."ClassIcon"]:SetTexCoord(unpack(E.TexCoords))
			_G[button:GetName().."BuffIcon"]:SetTexCoord(unpack(E.TexCoords))
			if E.db.ElvUI_EltreumUI.skins.shadow.enable and not button.shadow then
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
				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not _G["PallyPowerBlessingsFrameAuraGroup"..i.."AuraHeader"].shadow then
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
									if _G.PallyPowerAura.shadow then
										_G.PallyPowerAura.shadow:Show()
									end
								else
									_G["PallyPowerBlessingsFramePlayer"..j.."Aura"..i].shadow:Hide()
									if _G.PallyPowerAura.shadow then
										_G.PallyPowerAura.shadow:Hide()
									end
								end
							end
						end)
					end)
				end
			end
		end

		--add shadow
		if E.db.ElvUI_EltreumUI.skins.shadow.enable and not PallyPowerBlessingsFrame.shadow then
			PallyPowerBlessingsFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
			ElvUI_EltreumUI:ShadowColor(PallyPowerBlessingsFrame.shadow)
		end

		--better point
		_G.PallyPowerAnchor:ClearAllPoints()
		E:Delay(0, function()
			if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
				_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-10,10)
			else
				_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
			end
		end)
		_G.PallyPowerAnchor:SetFrameLevel(10)

		--shadow update function
		local function UpdateShadows()
			if InCombatLockdown() then return end
			if not _G.PallyPowerFrame.shadow then
				_G.PallyPowerFrame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
				_G.PallyPowerFrame.shadow:SetParent(_G.PallyPowerRF)
			end
			if _G.PallyPowerFrame.shadow then
				if _G.PallyPowerC1 and _G.PallyPowerC1:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC1, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC2 and _G.PallyPowerC2:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC2, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC3 and _G.PallyPowerC3:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC3, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC4 and _G.PallyPowerC4:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC4, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC5 and _G.PallyPowerC5:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC5, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC6 and _G.PallyPowerC6:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC6, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC7 and _G.PallyPowerC7:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC7, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC8 and _G.PallyPowerC8:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC8, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC9 and _G.PallyPowerC9:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC9, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC10 and _G.PallyPowerC10:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					else
						_G.PallyPowerAnchor:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-10,10)
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerC1, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerC10, "BOTTOMRIGHT",3,-3)
				end
				if _G.PallyPowerC1 and not _G.PallyPowerC1:IsShown() then
					_G.PallyPowerFrame.shadow:ClearAllPoints()
					if _G.PallyPowerAura and _G.PallyPowerAura:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAura, "TOPLEFT",-3,3)
					elseif _G.PallyPowerRF and _G.PallyPowerRF:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerRF, "TOPLEFT",-3,3)
					elseif _G.PallyPowerAuto and _G.PallyPowerAuto:IsShown() then
						_G.PallyPowerFrame.shadow:SetPoint("TOPLEFT", _G.PallyPowerAuto, "TOPLEFT",-3,3)
					end
					_G.PallyPowerFrame.shadow:SetPoint("BOTTOMRIGHT", _G.PallyPowerAuto, "BOTTOMRIGHT",3,-3)
				end
				ElvUI_EltreumUI:ShadowColor(_G.PallyPowerFrame.shadow)
			end
		end

		--main shadow
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

		if _G.PallyPowerC10 then
			_G.PallyPowerC10:HookScript("OnShow", function()
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

		if E.db.ElvUI_EltreumUI.skins.shadow.enable then
			_G.PallyPowerBlessingsFrame:HookScript("OnShow", function()
				toggle()
			end)

			_G.PallyPowerBlessingsFrameClear:HookScript("OnClick", function()
				toggle()
			end)

			_G.PallyPowerBlessingsFrameAutoAssign:HookScript("OnClick", function()
				toggle()
			end)
		end

		--crop icon
		if _G["PallyPowerAutoIcon"] then
			_G["PallyPowerAutoIcon"]:SetTexCoord(unpack(E.TexCoords))
		end



		--change toggle texture
		_G.PallyPowerAnchor:GetNormalTexture():SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask")
		_G.PallyPowerAnchor:GetNormalTexture():SetVertexColor(0,1,0)
		_G.PallyPowerAnchor:GetCheckedTexture():SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask")
		_G.PallyPowerAnchor:GetCheckedTexture():SetVertexColor(1,0,0)

		--use new icons
		if E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
			PallyPower.ClassIcons = PallyPower.isWrath and {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warrior1.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Rogue1.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Priest1.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Druid1.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Paladin1.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Hunter1.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Mage1.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warlock1.tga",
				[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Shaman1.tga",
				[10] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnight1.tga",
			} or PallyPower.isBCC and {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warrior1.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Rogue1.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Priest1.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Druid1.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Paladin1.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Hunter1.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Mage1.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warlock1.tga",
				[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Shaman1.tga",
			} or {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warrior1.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Rogue1.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Priest1.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Druid1.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Paladin1.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Hunter1.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Mage1.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\Warlock1.tga",
				[9] = "Interface\\Icons\\Ability_Mount_JungleTiger"
			}
		else
			PallyPower.ClassIcons = PallyPower.isWrath and {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorShadow.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueShadow.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestShadow.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidShadow.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinShadow.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterShadow.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageShadow.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockShadow.tga",
				[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanShadow.tga",
				[10] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DeathKnightShadow.tga",
			} or PallyPower.isBCC and {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorShadow.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueShadow.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestShadow.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidShadow.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinShadow.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterShadow.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageShadow.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockShadow.tga",
				[9] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\ShamanShadow.tga",
			} or {
				[1] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarriorShadow.tga",
				[2] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\RogueShadow.tga",
				[3] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PriestShadow.tga",
				[4] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\DruidShadow.tga",
				[5] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\PaladinShadow.tga",
				[6] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\HunterShadow.tga",
				[7] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\MageShadow.tga",
				[8] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\128\\WarlockShadow.tga",
				[9] = "Interface\\Icons\\Ability_Mount_JungleTiger"
			}
		end
	end
end
S:AddCallbackForAddon('PallyPower', 'EltruismPallyPower', ElvUI_EltreumUI.EltruismPallyPower)
