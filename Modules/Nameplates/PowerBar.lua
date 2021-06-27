local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
--local NP = E:GetModule('NamePlates')
local _G = _G
local GetShapeshiftForm = _G.GetShapeshiftForm
local UnitPower = _G.UnitPower
local GetSpecialization = _G.GetSpecialization
local GetSpecializationInfo = _G.GetSpecializationInfo
local C_NamePlate = _G.C_NamePlate
local UnitExists = _G.UnitExists
local CreateFrame = _G.CreateFrame
local UnitPowerMax = _G.UnitPowerMax
local hooksecurefunc = _G.hooksecurefunc
local myclass = E.myclass
local id, _
local UnitBuff = _G.UnitBuff
local IsAddOnLoaded = _G.IsAddOnLoaded
local UnitCanAttack = _G.UnitCanAttack

--setup nameplate power frame
local EltreumPowerBar = CreateFrame("StatusBar")
EltreumPowerBar:SetValue(0)
EltreumPowerBar:SetFillStyle("STANDARD")
EltreumPowerBar.Text = EltreumPowerBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
EltreumPowerBar.Text:SetTextColor(1, 1, 1)
EltreumPowerBar.Text:SetFont(E.LSM:Fetch("font", E.db.general.font), 10, "OUTLINE")
EltreumPowerBar.Text:SetPoint("CENTER")
EltreumPowerBar.Text:SetJustifyH("CENTER")
EltreumPowerBar.Text:SetJustifyV("CENTER")
EltreumPowerBar.bg = EltreumPowerBar:CreateTexture(nil, "BACKGROUND")
EltreumPowerBar.bg:SetTexture(E.media.normTex)
EltreumPowerBar.bg:SetVertexColor(0, 0, 0)
EltreumPowerBar.bg:SetPoint("CENTER", EltreumPowerBar, "CENTER", 0, 0)
EltreumPowerBar:Hide() --hide at the start before events
EltreumPowerBar:RegisterEvent("UNIT_POWER_FREQUENT")
EltreumPowerBar:RegisterEvent("PLAYER_TARGET_CHANGED")
EltreumPowerBar:RegisterEvent("UNIT_DISPLAYPOWER")
EltreumPowerBar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
EltreumPowerBar:RegisterEvent("UNIT_MODEL_CHANGED")

--so that the power updates when spec changes
function ElvUI_EltreumUI:GetSpec()
	if ElvUI_EltreumUI.Retail then
		local currentSpec = GetSpecialization()
		if currentSpec then
			id, _ = GetSpecializationInfo(currentSpec)
		end
	end
end


--Main function
function ElvUI_EltreumUI:NameplatePower(nameplate)
	if not IsAddOnLoaded("ElvUI_EltreumUI") then
		return
	elseif not E.private.ElvUI_EltreumUI then
		return
    elseif not E.private.ElvUI_EltreumUI.nameplatepower then
    	return
    elseif not nameplate then
		EltreumPowerBar:Hide()
	end

	if E.db.ElvUI_EltreumUI.nameplatepower == nil then
		E.db.ElvUI_EltreumUI.nameplatepower = {
			autoadjustposition = true,
			sizex = 132,
			sizey = 6,
			posy = 16,
			texture = "Eltreum-Elvui-Norm",
		}
	end
	if E.db.ElvUI_EltreumUI.nameplatepower.sizex == nil then
		E.db.ElvUI_EltreumUI.nameplatepower.sizex = 132
	end
	if E.db.ElvUI_EltreumUI.nameplatepower.sizey == nil then
		E.db.ElvUI_EltreumUI.nameplatepower.sizey = 6
	end
	if E.db.ElvUI_EltreumUI.nameplatepower.posy == nil then
		E.db.ElvUI_EltreumUI.nameplatepower.posy = 16
	end
	if E.db.ElvUI_EltreumUI.nameplatepower.texture == nil then
		E.db.ElvUI_EltreumUI.nameplatepower.texture = E.media.norm
	end
	local sizex
	if E.db.ElvUI_EltreumUI.nameplatepower.sizex then
		sizex = E.db.ElvUI_EltreumUI.nameplatepower.sizex
	else
		sizex = 132
	end
	local sizey
	if E.db.ElvUI_EltreumUI.nameplatepower.sizey then
		sizey = E.db.ElvUI_EltreumUI.nameplatepower.sizey
	else
		sizey = 6
	end
	local bgx
	if E.db.ElvUI_EltreumUI.nameplatepower.sizex then
		bgx = E.db.ElvUI_EltreumUI.nameplatepower.sizex + 1
	else
		bgx = 133
	end
	local bgy
	if E.db.ElvUI_EltreumUI.nameplatepower.sizey then
		bgy = E.db.ElvUI_EltreumUI.nameplatepower.sizey + 1
	else
		bgy = 7
	end
	local posy
	if E.db.ElvUI_EltreumUI.nameplatepower.posy then
		posy = E.db.ElvUI_EltreumUI.nameplatepower.posy
	else
		posy = 16
	end
	local powertexture
	if E.db.ElvUI_EltreumUI.nameplatepower.texture then
		powertexture =  E.LSM:Fetch("statusbar", E.db.ElvUI_EltreumUI.nameplatepower.texture)
	else
		powertexture = E.media.norm
	end


	local manab = E.db.unitframe.colors.power.MANA.b
	local manag = E.db.unitframe.colors.power.MANA.g
	local manar = E.db.unitframe.colors.power.MANA.r
	local rageb = E.db.unitframe.colors.power.RAGE.b
	local rageg = E.db.unitframe.colors.power.RAGE.g
	local rager = E.db.unitframe.colors.power.RAGE.r
	local energyb = E.db.unitframe.colors.power.ENERGY.b
	local energyg = E.db.unitframe.colors.power.ENERGY.g
	local energyr = E.db.unitframe.colors.power.ENERGY.r


	local focusb
	local focusg
	local focusr
	local furyb
	local furyg
	local furyr
	local insanityb
	local insanityg
	local insanityr
	local lunarb
	local lunarg
	local lunarr
	local maelb
	local maelr
	local maelg
	local runicr
	local runicr
	local runicg
	local runicb
	if ElvUI_EltreumUI.Retail then
		focusb = E.db.unitframe.colors.power.FOCUS.b
		focusg = E.db.unitframe.colors.power.FOCUS.g
		focusr = E.db.unitframe.colors.power.FOCUS.r
		furyb = E.db.unitframe.colors.power.FURY.b
		furyg = E.db.unitframe.colors.power.FURY.g
		furyr = E.db.unitframe.colors.power.FURY.r
		insanityb = E.db.unitframe.colors.power.INSANITY.b
		insanityg = E.db.unitframe.colors.power.INSANITY.g
		insanityr = E.db.unitframe.colors.power.INSANITY.r
		lunarb = E.db.unitframe.colors.power.LUNAR_POWER.b
		lunarg = E.db.unitframe.colors.power.LUNAR_POWER.g
		lunarr = E.db.unitframe.colors.power.LUNAR_POWER.r
		if E.db.unitframe.colors.power.MAELSTROM.b == nil then
			maelb = 1
		else
			maelb = E.db.unitframe.colors.power.MAELSTROM.b
		end

		if E.db.unitframe.colors.power.MAELSTROM.r == nil then
			maelr = 0
		else
			maelr = E.db.unitframe.colors.power.MAELSTROM.r
		end

		maelg = E.db.unitframe.colors.power.MAELSTROM.g

		if E.db.unitframe.colors.power.RUNIC_POWER.r == nil then
			runicr = 0
		else
			runicr = E.db.unitframe.colors.power.RUNIC_POWER.r
		end

		runicr = E.db.unitframe.colors.power.RUNIC_POWER.r

		if E.db.unitframe.colors.power.RUNIC_POWER.g == nil then
			runicg = 0
		else
			runicg = E.db.unitframe.colors.power.RUNIC_POWER.g
		end

		if E.db.unitframe.colors.power.RUNIC_POWER.b == nil then
			runicb = 1
		else
			runicb = E.db.unitframe.colors.power.RUNIC_POWER.b
		end
	end

    if E.private.ElvUI_EltreumUI.nameplatepower.enable then

		local canattack = UnitCanAttack("player", "target")
		if UnitExists("target") and canattack then

			local EltreumPowerAnchor = C_NamePlate.GetNamePlateForUnit("target")
			EltreumPowerBar:SetParent(EltreumPowerAnchor)

			local powerMax = UnitPowerMax("player")
			EltreumPowerBar:SetMinMaxValues(0, powerMax)

			local startpower = UnitPower("player")
			EltreumPowerBar:SetValue(startpower) --try to make it not be full always at the start
			EltreumPowerBar.Text:SetText(startpower)


			EltreumPowerBar:SetSize(sizex, sizey)
			EltreumPowerBar:SetStatusBarTexture(powertexture)
			EltreumPowerBar.bg:SetSize(bgx, bgy)

			if ElvUI_EltreumUI.Retail then
				if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
				else
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
				end
			elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
				if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
				else
					EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
				end
			end

			if myclass == 'PALADIN' or myclass == 'MAGE' or myclass == 'WARLOCK' then
				if E.private.ElvUI_EltreumUI.nameplatepower.mana then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
					if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					end
					if ElvUI_EltreumUI.Retail  then
						if myclass == 'PALADIN' or myclass == 'WARLOCK' then
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						elseif myclass == 'MAGE' then
							if id == 62 then
								if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
								end
							end
						end
					end
				end
			elseif myclass == 'DRUID' then
				local stance = GetShapeshiftForm()
				--print(stance)
				--[[
					-- FOR BALANCE
					--retail
					-- 0 is human
					-- 1 is bear
					-- 2 is cat
					-- 3 is bird
					-- 4 is moonkin
					-- 5 is tree (if known)
					-- 6 is mount form (if known)

					--for resto
					-- 0 is human
					-- 1 is bear
					-- 2 is cat
					-- 3 is bird
					-- 4 is moonkin  (if known)
					-- 4 is tree (if known and moonkin not known)
					--5  = tree of life (talent)
				]]--
				if ElvUI_EltreumUI.Retail then
					local tree = IsSpellKnown(114282)
					local moonkin = IsSpellKnown(197625)
					local stag = IsSpellKnown(210053)
					if stance == 0 then --humanoid
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					elseif stance == 1 then --bear
						if E.private.ElvUI_EltreumUI.nameplatepower.rage then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(rager, rageg, rageb) --its rage so color it like rage
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					elseif stance == 2 then --cat
						if E.private.ElvUI_EltreumUI.nameplatepower.energy then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(energyr, energyg, energyb) --its energy so color it like energy
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 22)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					elseif stance == 3 then --3 is travel
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					--this is where it gets tricky due to talents and specs 4 is either moonkin OR tree of life if resto and not talented into moonkin affinity
					elseif stance == 4 then
						if id == 103 then --moonkin
							if E.private.ElvUI_EltreumUI.nameplatepower.astral then
								EltreumPowerBar:Show()
								EltreumPowerBar:SetStatusBarColor(lunarr, lunarg, lunarb) --its astral/lunar power
								if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
								end
							end
						else --resto druid or other druid
							if E.private.ElvUI_EltreumUI.nameplatepower.mana then
								EltreumPowerBar:Show()
								EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
								if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
								else
									EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
								end
							end
						end
					elseif stance == 5 or stance == 6 then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					end
				end
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					if stance == 0 then --humanoid
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					elseif stance == 1 then --bear
						if E.private.ElvUI_EltreumUI.nameplatepower.rage then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(rager, rageg, rageb) --its rage so color it like rage
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end

						end
					elseif stance == 2 then --aquatic
						if E.private.ElvUI_EltreumUI.nameplatepower.energy then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					elseif stance == 3 then --3 cat in classic
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(energyr, energyg, energyb) --its energy so color it like energy
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 17)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					elseif stance == 4 or stance == 5 then --4 is travel in classic and 5 is moonkin/resto tree in classic
						if E.private.ElvUI_EltreumUI.nameplatepower.astral then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					end
				end
			elseif myclass == 'WARRIOR' then
				if E.private.ElvUI_EltreumUI.nameplatepower.rage then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(rager, rageg, rageb) --its rage so color it like rage
					if ElvUI_EltreumUI.Retail then
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					elseif ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					end
				end
			elseif myclass == 'ROGUE' then
				if E.private.ElvUI_EltreumUI.nameplatepower.energy then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(energyr, energyg, energyb) --its energy so color it like energy
					if ElvUI_EltreumUI.Retail then
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					end
				end
			elseif myclass == 'MONK' then
				if E.private.ElvUI_EltreumUI.nameplatepower.energy then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(energyr, energyg, energyb) --its energy so color it like energy
					if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
					end
				end
			elseif myclass == 'DEATHKNIGHT' then
				if E.private.ElvUI_EltreumUI.nameplatepower.runic then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(runicr, runicg, runicb) --its runic power
					if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 23)
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
					end
				end
			elseif myclass == 'HUNTER' then
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					end
				elseif ElvUI_EltreumUI.Retail then
					if E.private.ElvUI_EltreumUI.nameplatepower.focus then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(focusr, focusg, focusb) --its focus so color it like focus
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					end
				end
			elseif myclass == 'DEMONHUNTER' then
				if E.private.ElvUI_EltreumUI.nameplatepower.fury then
					EltreumPowerBar:Show()
					EltreumPowerBar:SetStatusBarColor(furyr, furyg, furyb) --its fury
					if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
					else
						EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
					end
				end
			elseif myclass == 'PRIEST' then
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					end
				elseif ElvUI_EltreumUI.Retail then
					if id == 258 then
						if E.private.ElvUI_EltreumUI.nameplatepower.insanity then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(insanityr, insanityg, insanityb) --its insanity
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					elseif id == 256 or id == 257 then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					else --its a low level priest
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					end
				end
			elseif myclass == 'SHAMAN' then
				if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
					if E.private.ElvUI_EltreumUI.nameplatepower.mana then
						EltreumPowerBar:Show()
						EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
						if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 10)
						else
							EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
						end
					end
				elseif ElvUI_EltreumUI.Retail then
					if id == 262 or id == 263 then
					   	if E.private.ElvUI_EltreumUI.nameplatepower.maelstrom then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(maelr, maelg, maelb) --its maelstrom
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					elseif id == 264 then
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					else --its a low level shaman
						if E.private.ElvUI_EltreumUI.nameplatepower.mana then
							EltreumPowerBar:Show()
							EltreumPowerBar:SetStatusBarColor(manar, manag, manab) --its mana so color like mana
							if E.db.ElvUI_EltreumUI.nameplatepower.autoadjustposition then
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, 16)
							else
								EltreumPowerBar:SetPoint("TOP", EltreumPowerAnchor, "TOP", 0, posy)
							end
						end
					end
				end
			end
		else
			EltreumPowerBar:Hide()
		end
	end
end
--idk when it started, but it works without hooking into elvui np
--hooksecurefunc(NP, 'Style', ElvUI_EltreumUI.NameplatePower)
--hooksecurefunc(NP, 'UpdatePlate', ElvUI_EltreumUI.NameplatePower)
--hooksecurefunc(NP, 'NamePlateCallBack', ElvUI_EltreumUI.NameplatePower)

--update the values of nameplate power bar
function ElvUI_EltreumUI:NameplatePowerTextUpdate(unit)
	EltreumPowerBar:SetScript("OnEvent", function(event, unit)
		if event == "UNIT_POWER_FREQUENT" or event == "UNIT_MODEL_CHANGED" then
			if unit and unit ~= 'player' then
				return
			elseif unit and unit == 'player' then
				local power = UnitPower("player")
				--ElvUI_EltreumUI:Print('power frequent')
				EltreumPowerBar:SetValue(power)
				EltreumPowerBar.Text:SetText(power)
			end
		end
	end)
end


function ElvUI_EltreumUI:UpdateNPwithoutBar(addon)
	if addon == 'ElvUI' then
		if E.private.ElvUI_EltreumUI.nameplatepower.adjust then
			if ElvUI_EltreumUI.Retail then
				local currentSpec = GetSpecialization()
				if currentSpec then
					id, _ = GetSpecializationInfo(currentSpec)
				end
			end
			if E.private.ElvUI_EltreumUI.nameplatepower.enable then
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
				if ElvUI_EltreumUI.Retail then
					if myclass == 'MONK' or myclass == 'ROGUE' or myclass == 'DEATHKNIGHT' or myclass == 'PALADIN' or myclass == 'WARLOCK' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
					elseif myclass == 'DRUID' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
					end
				elseif ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic then
					if myclass == 'ROGUE'  or myclass == 'DRUID' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 47
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 26
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 26
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.energy then
					if myclass == 'MONK' or myclass == 'ROGUE' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.runic then
					if myclass == 'DEATHKNIGHT' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.mana then
					if ElvUI_EltreumUI.Classic or ElvUI_EltreumUI.TBC then
						if myclass == 'MAGE' or myclass == 'HUNTER' or myclass == 'PRIEST' or myclass == 'SHAMAN' or myclass == 'PALADIN' or myclass == 'WARLOCK' then
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
						end
					end
					if ElvUI_EltreumUI.Retail then
						if id == 64 or id == 63 or id == 270 or id == 256 or id == 257 or id == 264 then
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
						elseif id == 65 or id == 66 or id == 70 or id == 265 or id == 266 or id == 267 then --paladin specs bc of holy power and warlocks bc of soul shards
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 38
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 38
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 17
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 17
						end
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.focus then
					if myclass == 'HUNTER' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.fury then
					if myclass == 'DEMONHUNTER' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.rage then
					if myclass == 'WARRIOR' then
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
						E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
						E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.insanity then
					if ElvUI_EltreumUI.Retail then
						if id == 258 then
						   	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
						end
					end
				end
				if not E.private.ElvUI_EltreumUI.nameplatepower.maelstrom then
					if ElvUI_EltreumUI.Retail then
						if id == 262 or id == 263 then
						   	E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
							E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
							E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
						end
					end
				end
			else
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["yOffset"] = 31
				E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["yOffset"] = 31
				E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["yOffset"] = 10
				E.db["nameplates"]["units"]["ENEMY_PLAYER"]["debuffs"]["yOffset"] = 10
			end
		end
	end
end
