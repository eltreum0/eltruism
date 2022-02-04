local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local AB = E:GetModule('ActionBars')
local LCG = E.Libs.CustomGlow
local classcolor = E:ClassColor(E.myclass, true)

-- Skill Glow
function ElvUI_EltreumUI:SkillGlow()
	--print("glow spam")
	local skillglowcolor
	if not E.db.ElvUI_EltreumUI.glow.colorclass then
		local glowcustomcolor = E.db.ElvUI_EltreumUI.glowcustomcolor
		local r, g, b = glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b
		skillglowcolor = {r, g, b, 1}
	end
	if E.db.ElvUI_EltreumUI.glow.colorclass then
		skillglowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
	end
	if E.db.ElvUI_EltreumUI.glow.enable then
		if E.db.ElvUI_EltreumUI.glow.pixel then
			function LCG.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					LCG.PixelGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
				end
			end
			function LCG.HideOverlayGlow(button)
				LCG.PixelGlow_Stop(button)
			end
		end
		if E.db.ElvUI_EltreumUI.glow.autocast then
			function LCG.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					LCG.AutoCastGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
				end
			end
			function LCG.HideOverlayGlow(button)
				LCG.AutoCastGlow_Stop(button)
			end
		end
		if E.db.ElvUI_EltreumUI.glow.blizzard then
			function LCG.ShowOverlayGlow(button)
				if button:GetAttribute("type") == "action" then
					LCG.ButtonGlow_Start(button, skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
				end
			end
			function LCG.HideOverlayGlow(button)
				LCG.ButtonGlow_Stop(button)
			end
		end
		--classic shaman totem bar glow when totems are not active in combat
		if (ElvUI_EltreumUI.TBC or ElvUI_EltreumUI.Classic) and E.myclass == 'SHAMAN' and E.db.ElvUI_EltreumUI.glow.enabletotem then
			local totemglowholder = CreateFrame("FRAME")
			local totemglowcombatdetect = CreateFrame("FRAME")
			totemglowcombatdetect:RegisterEvent('PLAYER_REGEN_DISABLED')
			totemglowcombatdetect:RegisterEvent('PLAYER_REGEN_ENABLED')

			local totemglow1 = CreateFrame("FRAME")
			totemglow1:SetAllPoints(_G['ElvUF_PlayerTotem1'])
			totemglow1:SetParent(_G['ElvUF_Player'])

			local totemglow2 = CreateFrame("FRAME")
			totemglow2:SetAllPoints(_G['ElvUF_PlayerTotem2'])
			totemglow2:SetParent(_G['ElvUF_Player'])

			local totemglow3 = CreateFrame("FRAME")
			totemglow3:SetAllPoints(_G['ElvUF_PlayerTotem3'])
			totemglow3:SetParent(_G['ElvUF_Player'])

			local totemglow4 = CreateFrame("FRAME")
			totemglow4:SetAllPoints(_G['ElvUF_PlayerTotem4'])
			totemglow4:SetParent(_G['ElvUF_Player'])


			local totem1glowcolor = {0.58, 0.23, 0.10, 1}
			local totem2glowcolor = {0.23,0.45,0.13, 1}
			local totem3glowcolor = {0.19,0.48,0.60, 1}
			local totem4glowcolor = {0.42,0.18,0.74, 1}
			if not E.db.ElvUI_EltreumUI.glow.totemtypecolor then
				totem1glowcolor = {E.db.ElvUI_EltreumUI.glowtotem1customcolor.r, E.db.ElvUI_EltreumUI.glowtotem1customcolor.g, E.db.ElvUI_EltreumUI.glowtotem1customcolor.b, 1}
				totem2glowcolor = {E.db.ElvUI_EltreumUI.glowtotem2customcolor.r, E.db.ElvUI_EltreumUI.glowtotem2customcolor.g, E.db.ElvUI_EltreumUI.glowtotem2customcolor.b, 1}
				totem3glowcolor = {E.db.ElvUI_EltreumUI.glowtotem3customcolor.r, E.db.ElvUI_EltreumUI.glowtotem3customcolor.g, E.db.ElvUI_EltreumUI.glowtotem3customcolor.b, 1}
				totem4glowcolor = {E.db.ElvUI_EltreumUI.glowtotem4customcolor.r, E.db.ElvUI_EltreumUI.glowtotem4customcolor.g, E.db.ElvUI_EltreumUI.glowtotem4customcolor.b, 1}
			end

			totemglowcombatdetect:SetScript("OnEvent", function(self, event)
				if event == 'PLAYER_REGEN_DISABLED' then
					local ONUPDATE_INTERVAL = 1
					local TimeSinceLastUpdate = 0
					totemglowholder:SetScript("OnUpdate", function(self, elapsed)
						TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
						if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
							TimeSinceLastUpdate = 0
							if E.db.ElvUI_EltreumUI.glow.pixel then
								if E.db.ElvUI_EltreumUI.glow.totem1 then
									if not _G['ElvUF_PlayerTotem1']:IsShown() then
										LCG.PixelGlow_Start(totemglow1, totem1glowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
									elseif _G['ElvUF_PlayerTotem1']:IsShown() then
										LCG.PixelGlow_Stop(totemglow1)
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem2 then
									if not _G['ElvUF_PlayerTotem2']:IsShown() then
										LCG.PixelGlow_Start(totemglow2, totem2glowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
									elseif _G['ElvUF_PlayerTotem2']:IsShown() then
										LCG.PixelGlow_Stop(totemglow2)
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem3 then
									if not _G['ElvUF_PlayerTotem3']:IsShown() then
										LCG.PixelGlow_Start(totemglow3, totem3glowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
									elseif _G['ElvUF_PlayerTotem3']:IsShown() then
										LCG.PixelGlow_Stop(totemglow3)
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem4 then
									if not _G['ElvUF_PlayerTotem4']:IsShown() then
										LCG.PixelGlow_Start(totemglow4, totem4glowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
									elseif _G['ElvUF_PlayerTotem4']:IsShown() then
										LCG.PixelGlow_Stop(totemglow4)
									end
								end
							elseif E.db.ElvUI_EltreumUI.glow.autocast then
								if E.db.ElvUI_EltreumUI.glow.totem1 then
									if not _G['ElvUF_PlayerTotem1']:IsShown() then
										LCG.AutoCastGlow_Start(totemglow1, totem1glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
									elseif _G['ElvUF_PlayerTotem1']:IsShown() then
										LCG.AutoCastGlow_Stop(totemglow1)
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem2 then
									if not _G['ElvUF_PlayerTotem2']:IsShown() then
										LCG.AutoCastGlow_Start(totemglow2, totem2glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
									elseif _G['ElvUF_PlayerTotem2']:IsShown() then
										LCG.AutoCastGlow_Stop(totemglow2)
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem3 then
									if not _G['ElvUF_PlayerTotem3']:IsShown() then
										LCG.AutoCastGlow_Start(totemglow3, totem3glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
									elseif _G['ElvUF_PlayerTotem3']:IsShown() then
										LCG.AutoCastGlow_Stop(totemglow3)
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem4 then
									if not _G['ElvUF_PlayerTotem4']:IsShown() then
										LCG.AutoCastGlow_Start(totemglow4, totem4glowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
									elseif _G['ElvUF_PlayerTotem4']:IsShown() then
										LCG.AutoCastGlow_Stop(totemglow4)
									end
								end
							elseif E.db.ElvUI_EltreumUI.glow.blizzard then
								if E.db.ElvUI_EltreumUI.glow.totem1 then
									if not _G['ElvUF_PlayerTotem1']:IsShown() then
										LCG.ButtonGlow_Start(totemglow1, totem1glowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
									elseif _G['ElvUF_PlayerTotem1']:IsShown() then
										LCG.ButtonGlow_Stop(totemglow1)
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem2 then
									if not _G['ElvUF_PlayerTotem2']:IsShown() then
										LCG.ButtonGlow_Start(totemglow2, totem2glowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
									elseif _G['ElvUF_PlayerTotem2']:IsShown() then
										LCG.ButtonGlow_Stop(totemglow2)
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem3 then
									if not _G['ElvUF_PlayerTotem3']:IsShown() then
										LCG.ButtonGlow_Start(totemglow3, totem3glowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
									elseif _G['ElvUF_PlayerTotem3']:IsShown() then
										LCG.ButtonGlow_Stop(totemglow3)
									end
								end
								if E.db.ElvUI_EltreumUI.glow.totem4 then
									if not _G['ElvUF_PlayerTotem4']:IsShown() then
										LCG.ButtonGlow_Start(totemglow4, totem4glowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
									elseif _G['ElvUF_PlayerTotem4']:IsShown() then
										LCG.ButtonGlow_Stop(totemglow4)
									end
								end
							end
						end
					end)
				elseif event == 'PLAYER_REGEN_ENABLED' then
					totemglowholder:SetScript("OnUpdate", nil)
					if E.db.ElvUI_EltreumUI.glow.pixel then
						LCG.PixelGlow_Stop(totemglow1)
						LCG.PixelGlow_Stop(totemglow2)
						LCG.PixelGlow_Stop(totemglow3)
						LCG.PixelGlow_Stop(totemglow4)
					elseif E.db.ElvUI_EltreumUI.glow.autocast then
						LCG.AutoCastGlow_Stop(totemglow1)
						LCG.AutoCastGlow_Stop(totemglow2)
						LCG.AutoCastGlow_Stop(totemglow3)
						LCG.AutoCastGlow_Stop(totemglow4)
					elseif E.db.ElvUI_EltreumUI.glow.blizzard then
						LCG.ButtonGlow_Stop(totemglow1)
						LCG.ButtonGlow_Stop(totemglow2)
						LCG.ButtonGlow_Stop(totemglow3)
						LCG.ButtonGlow_Stop(totemglow4)
					end
				end
			end)
		end

	end
end

--Skill Glow Pet
function ElvUI_EltreumUI:SkillGlowPet()
	if E.myclass == 'HUNTER' or E.myclass == 'WARLOCK' then
		local skillglowcolor
		if not E.db.ElvUI_EltreumUI.glow.colorclass then
			local glowcustomcolor = E.db.ElvUI_EltreumUI.glowcustomcolorpet
			local r, g, b = glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b
			skillglowcolor = {r, g, b, 1}
		end
		if E.db.ElvUI_EltreumUI.glow.colorclass then
			skillglowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
		end

		if E.db.ElvUI_EltreumUI.glow.enablepet then
			for i = 1, NUM_PET_ACTION_SLOTS, 1 do
				local _, _, _, _, _, autoCastEnabled, _ = GetPetActionInfo(i)
				local buttonName = 'PetActionButton'..i
				local button = _G[buttonName]

				if autoCastEnabled then
					AutoCastShine_AutoCastStop(button.AutoCastShine)
					if E.db.ElvUI_EltreumUI.glow.pixel then
						--PixelGlow_Start(frame[, color[, N[, frequency[, length[, th[, xOffset[, yOffset[, border[ ,key]]]]]]]])
						LCG.PixelGlow_Start(button, skillglowcolor, 10, 0.25, 5, 2, 0, 0, false, nil, high)
					end
					if E.db.ElvUI_EltreumUI.glow.autocast then
						--AutoCastGlow_Start(frame[, color[, N[, frequency[, scale[, xOffset[, yOffset[, key]]]]]]])
						LCG.AutoCastGlow_Start(button, skillglowcolor, 16, 0.25, 0.7, 0, 0)
					end
					if E.db.ElvUI_EltreumUI.glow.blizzard then
						--ButtonGlow_Start(frame[, color[, frequency]]])
						LCG.ButtonGlow_Start(button, skillglowcolor, 0.125)
					end
				else
					AutoCastShine_AutoCastStop(button.AutoCastShine)
					if E.db.ElvUI_EltreumUI.glow.pixel then
						LCG.PixelGlow_Stop(button)
					end
					if E.db.ElvUI_EltreumUI.glow.autocast then
						LCG.AutoCastGlow_Stop(button)
					end
					if E.db.ElvUI_EltreumUI.glow.blizzard then
						LCG.ButtonGlow_Stop(button)
					end
				end
			end
		end
	end
end
hooksecurefunc(AB, "UpdatePet", ElvUI_EltreumUI.SkillGlowPet)

--Preview the Glow as asked by Releaf
local EltruismGlowPreview = CreateFrame("Frame", "EltruismGlowPreview")
EltruismGlowPreview:SetSize(40, 40)
EltruismGlowPreview:ClearAllPoints()
EltruismGlowPreview:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 50)
EltruismGlowPreview:SetFrameStrata("DIALOG")
local EltruismGlowTexture = EltruismGlowPreview:CreateTexture()
EltruismGlowPreview:Hide()
function ElvUI_EltreumUI:PreviewGlow()
	EltruismGlowTexture:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\GlowPreview.tga")
	EltruismGlowTexture:SetAllPoints(EltruismGlowPreview)
	EltruismGlowPreview:SetMovable(true)
	EltruismGlowPreview:EnableMouse(true)
	EltruismGlowPreview:RegisterForDrag("LeftButton")
	EltruismGlowPreview:SetScript("OnDragStart", EltruismGlowPreview.StartMoving)
	EltruismGlowPreview:SetScript("OnDragStop",EltruismGlowPreview.StopMovingOrSizing)

	local skillglowcolor
	if not E.db.ElvUI_EltreumUI.glow.colorclass then
		local glowcustomcolor = E.db.ElvUI_EltreumUI.glowcustomcolor
		local r, g, b = glowcustomcolor.r, glowcustomcolor.g, glowcustomcolor.b
		skillglowcolor = {r, g, b, 1}
	end
	if E.db.ElvUI_EltreumUI.glow.colorclass then
		skillglowcolor = {classcolor.r, classcolor.g, classcolor.b, 1}
	end
	if EltruismGlowPreview:IsShown() then
		LCG.PixelGlow_Stop(EltruismGlowPreview)
		LCG.AutoCastGlow_Stop(EltruismGlowPreview)
		LCG.ButtonGlow_Stop(EltruismGlowPreview)
		EltruismGlowPreview:Hide()
	else
		EltruismGlowPreview:Show()
		if E.db.ElvUI_EltreumUI.glow.pixel then
			LCG.PixelGlow_Start(EltruismGlowPreview, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberpixel, E.db.ElvUI_EltreumUI.glow.frequencypixel, E.db.ElvUI_EltreumUI.glow.lengthpixel, E.db.ElvUI_EltreumUI.glow.thicknesspixel, E.db.ElvUI_EltreumUI.glow.pixelxOffset, E.db.ElvUI_EltreumUI.glow.pixelyOffset, E.db.ElvUI_EltreumUI.glow.borderpixel, nil, high)
		end
		if E.db.ElvUI_EltreumUI.glow.autocast then
			LCG.AutoCastGlow_Start(EltruismGlowPreview, skillglowcolor, E.db.ElvUI_EltreumUI.glow.numberauto, E.db.ElvUI_EltreumUI.glow.frequencyauto, E.db.ElvUI_EltreumUI.glow.autoscale, E.db.ElvUI_EltreumUI.glow.autoxOffset, E.db.ElvUI_EltreumUI.glow.autoyOffset)
		end
		if E.db.ElvUI_EltreumUI.glow.blizzard then
			LCG.ButtonGlow_Start(EltruismGlowPreview, skillglowcolor, E.db.ElvUI_EltreumUI.glow.frequencyblizz)
		end
	end
end
