local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local ElvUI_EltreumUI = _G.ElvUI_EltreumUI

local classIconsReleaf = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorReleaf.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinReleaf.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterReleaf.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueReleaf.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestReleaf.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightReleaf.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanReleaf.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageReleaf.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockReleaf.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkReleaf.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidReleaf.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterReleaf.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerReleaf.tga",
}
local classIconsBlizzard = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Evoker.tga",
}
local classIconsBorder = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorIconReleaf.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinIconReleaf.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterIconReleaf.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueIconReleaf.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestIconReleaf.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightIconReleaf.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanIconReleaf.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageIconReleaf.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockIconReleaf.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkIconReleaf.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidIconReleaf.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterIconReleaf.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerIconReleaf.tga",
}
local classIconsShadow = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorShadow.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinShadow.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterShadow.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueShadow.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestShadow.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightShadow.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanShadow.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageShadow.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockShadow.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkShadow.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidShadow.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterShadow.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerShadow.tga",
}
local classIconsOutline = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior1.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin1.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter1.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue1.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest1.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight1.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman1.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage1.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock1.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk1.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid1.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter1.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Evoker1.tga",
}
local OriginalIcons = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorOriginal.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinOriginal.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterOriginal.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueOriginal.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestOriginal.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightOriginal.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanOriginal.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageOriginal.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockOriginal.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkOriginal.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidOriginal.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterOriginal.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerOriginal.tga",
}
local classSymbols = {
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Warrior.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Paladin.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Hunter.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Rogue.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Priest.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\DeathKnight.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Shaman.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Mage.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Warlock.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Monk.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Druid.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\DemonHunter.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\ClassSymbols\\Evoker.tga",
}
local gradient ={
	["WARRIOR"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorGradient.tga",
	["PALADIN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinGradient.tga",
	["HUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterGradient.tga",
	["ROGUE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueGradient.tga",
	["PRIEST"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestGradient.tga",
	["DEATHKNIGHT"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightGradient.tga",
	["SHAMAN"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanGradient.tga",
	["MAGE"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageGradient.tga",
	["WARLOCK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockGradient.tga",
	["MONK"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkGradient.tga",
	["DRUID"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidGradient.tga",
	["DEMONHUNTER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterGradient.tga",
	["EVOKER"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\EvokerGradient.tga",
}

local notexcoord = {
	["RELEAF"] = true,
	["BLIZZARD"] = true,
	["BORDER"] = true,
	["ORIGINAL"] =true,
}

--return textures for other functions
function ElvUI_EltreumUI:GetClassIconsTextures(icon,unitclass)
	if icon == "RELEAF" then
		return classIconsReleaf[unitclass]
	elseif icon == "OUTLINE" then
		return classIconsOutline[unitclass]
	elseif icon == "BLIZZARD" then
		return classIconsBlizzard[unitclass]
	elseif icon == "BORDER" then
		return classIconsBorder[unitclass]
	elseif icon == "SHADOW" then
		return classIconsShadow[unitclass]
	elseif icon == "ORIGINAL" then
		return OriginalIcons[unitclass]
	elseif icon == "GRADIENT" then
		return gradient[unitclass]
	elseif icon == "SYMBOLS" then
		return classSymbols[unitclass]
	end
end

--create and update the portraits
local function CreatePorfraitFrameAndTexture(frame,name,invert,update,db,SettingUpdate)
	if not frame then return end
	if not frame.USE_PORTRAIT then return end
	if not frame.unit then return end

	if not frame.EltruismPortrait then
		if frame.Portrait then
			frame.Portrait:Hide()
			frame.Portrait:Kill()
			--frame.Portrait:ClearAllPoints()
		end
		frame.EltruismPortrait = CreateFrame("FRAME", name.."EltruismPortrait", frame)
		frame.EltruismPortrait:SetPoint("CENTER", frame, tostring(E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.align), E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.x, E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.y)
		frame.EltruismPortrait:SetSize(E.db.ElvUI_EltreumUI.unitframes.portrait[db].size,E.db.ElvUI_EltreumUI.unitframes.portrait[db].size)
		frame.EltruismPortrait:SetFrameLevel(200)
		frame.EltruismPortrait:SetFrameStrata("HIGH")
		frame.EltruismPortrait.border = frame.EltruismPortrait:CreateTexture(name.."EltruismPortraitTexture", "OVERLAY", nil, 5)
		frame.EltruismPortrait.border:SetParent(frame.EltruismPortrait)
		frame.EltruismPortrait.border:SetAllPoints(frame.EltruismPortrait)

		frame.EltruismPortrait.Mask = frame.EltruismPortrait:CreateMaskTexture()
		frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\mask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		frame.EltruismPortrait.Mask:SetAllPoints(frame.EltruismPortrait)

		frame.EltruismPortrait.portrait = frame.EltruismPortrait:CreateTexture(name.."EltruismPortraitPortrait", "OVERLAY", nil, 4)
		frame.EltruismPortrait.portrait:SetAllPoints(frame.EltruismPortrait)

		frame.EltruismPortrait.edge = frame.EltruismPortrait:CreateTexture(name.."EltruismPortraitEdge", "OVERLAY", nil, 6)
		frame.EltruismPortrait.edge:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Edge.tga")
		frame.EltruismPortrait.edge:SetAllPoints(frame.EltruismPortrait)

		frame.EltruismPortrait.rare = frame.EltruismPortrait:CreateTexture(name.."EltruismPortraitRare", "OVERLAY", nil, 7)
		frame.EltruismPortrait.rare:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Rare.tga")
		frame.EltruismPortrait.rare:SetAllPoints(frame.EltruismPortrait)
	end

	if not frame.EltruismPortrait then return end

	if invert then
		frame.EltruismPortrait.rare:SetTexCoord(1, 0, 0, 1)
	end
	if not E.db.ElvUI_EltreumUI.unitframes.portrait[db].rare or E.db.ElvUI_EltreumUI.unitframes.portrait[db].type ~= "CIRCLE" then
		frame.EltruismPortrait.rare:SetTexture()
	end
	if E.db.ElvUI_EltreumUI.unitframes.portrait[db].type ~= "BLIZZARD" or not E.db.ElvUI_EltreumUI.unitframes.portrait[db].edge then
		frame.EltruismPortrait.edge:SetTexture()
	end
	if E.db.ElvUI_EltreumUI.unitframes.portrait[db].type == "BLIZZARD" then
		if E.db.ElvUI_EltreumUI.unitframes.portrait.shadow then
			frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\PortraitShadow.tga")
		else
			frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Portrait.tga")
		end
		if invert then
			frame.EltruismPortrait.border:SetTexCoord(1, 0, 0, 1)
			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
				if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
					frame.EltruismPortrait.portrait:SetTexCoord(0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				else
					frame.EltruismPortrait.portrait:SetTexCoord(1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
			else
				frame.EltruismPortrait.portrait:SetTexCoord(1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
			end
			frame.EltruismPortrait.edge:SetTexCoord(1, 0, 0, 1)
			frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskinvert.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		else
			frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\mask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		end
	else
		if E.db.ElvUI_EltreumUI.unitframes.portrait.shadow then
			frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\CircleShadow.tga")
		else
			frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Circle.tga")
		end
		frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskcircle.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	end


	if frame.Portrait then
		frame.Portrait:Hide()
		frame.Portrait:Kill()
		--frame.Portrait:ClearAllPoints()
	end

	if (update or SettingUpdate) then
		--if not UnitExists(frame.unit) then return end
		if not E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom or (E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle and E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom) then
			frame.EltruismPortrait.portrait:SetMask("")
			frame.EltruismPortrait.border:Show()
			frame.EltruismPortrait.rare:SetAlpha(1)
			frame.EltruismPortrait.edge:SetAlpha(1)
			if not E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
				SetPortraitTexture(frame.EltruismPortrait.portrait,frame.unit,true)
			end
			frame.EltruismPortrait.portrait:AddMaskTexture(frame.EltruismPortrait.Mask)

			--color
			if not E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcolor then
				if UnitIsPlayer(frame.unit) then
					local _, unitclass = UnitClass(frame.unit)
					if E.db.ElvUI_EltreumUI.unitframes.portrait.gradient then
						if (E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor) and not E.db.ElvUI_EltreumUI.unitframes.portrait[db].defaultgradient then
							frame.EltruismPortrait.border:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColorsCustom(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							frame.EltruismPortrait.edge:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColorsCustom(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							frame.EltruismPortrait.rare:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColorsCustom(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
						else
							frame.EltruismPortrait.border:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							frame.EltruismPortrait.edge:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							frame.EltruismPortrait.rare:SetGradient("HORIZONTAL",ElvUI_EltreumUI:GradientColors(unitclass, E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
						end
					else
						local r,g,b = ElvUI_EltreumUI:GetClassColorsRGB(unitclass)
						frame.EltruismPortrait.border:SetVertexColor(r,g,b,1)
						frame.EltruismPortrait.edge:SetVertexColor(r,g,b,1)
						frame.EltruismPortrait.rare:SetVertexColor(r,g,b,1)
					end
				else
					local reaction = UnitReaction(frame.unit, "player")
					if not reaction then return end
					if E.db.ElvUI_EltreumUI.unitframes.portrait.gradient then
						if (E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor) and not E.db.ElvUI_EltreumUI.unitframes.portrait[db].defaultgradient then
							if reaction >= 5 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction == 4 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCNEUTRAL", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction == 3 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCUNFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction <= 2 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom("NPCHOSTILE", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							end
						else
							if reaction >= 5 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction == 4 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCNEUTRAL", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction == 3 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCUNFRIENDLY", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							elseif reaction <= 2 then
								frame.EltruismPortrait.border:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
								frame.EltruismPortrait.edge:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors("NPCHOSTILE", E.db.ElvUI_EltreumUI.unitframes.portrait[db].reversegradient, false))
							end
						end
					else
						if reaction >= 5 then
							local r,g,b = ElvUI_EltreumUI:GetClassColorsRGB("NPCFRIENDLY")
							frame.EltruismPortrait.border:SetVertexColor(r,g,b,1)
							frame.EltruismPortrait.edge:SetVertexColor(r,g,b,1)
						elseif reaction == 4 then
							local r,g,b = ElvUI_EltreumUI:GetClassColorsRGB("NPCNEUTRAL")
							frame.EltruismPortrait.border:SetVertexColor(r,g,b,1)
							frame.EltruismPortrait.edge:SetVertexColor(r,g,b,1)
						elseif reaction == 3 then
							local r,g,b = ElvUI_EltreumUI:GetClassColorsRGB("NPCUNFRIENDLY")
							frame.EltruismPortrait.border:SetVertexColor(r,g,b,1)
							frame.EltruismPortrait.edge:SetVertexColor(r,g,b,1)
						elseif reaction == 2 or reaction == 1 then
							local r,g,b = ElvUI_EltreumUI:GetClassColorsRGB("NPCHOSTILE")
							frame.EltruismPortrait.border:SetVertexColor(r,g,b,1)
							frame.EltruismPortrait.edge:SetVertexColor(r,g,b,1)
						end
					end
				end
			else
				frame.EltruismPortrait.border:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.r,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.g,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.b,1)
				frame.EltruismPortrait.edge:SetVertexColor(E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.r,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.g,E.db.ElvUI_EltreumUI.unitframes.portrait[db].color.b,1)
			end

			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].rare and E.db.ElvUI_EltreumUI.unitframes.portrait[db].type == "CIRCLE" then
				frame.EltruismPortrait.rare:SetAlpha(1)
				local c = UnitClassification(frame.unit)
				if (c == 'rare') or (c == 'rareelite') then
					frame.EltruismPortrait.rare:SetVertexColor(1,1,1,1)
				elseif(c == 'elite') or (c == 'worldboss') then
					frame.EltruismPortrait.rare:SetVertexColor(0.84,0.74,0.35,1)
				else
					if not UnitIsPlayer(frame.unit) then
						frame.EltruismPortrait.rare:SetVertexColor(0,0,0,0)
					end
				end
			else
				frame.EltruismPortrait.rare:SetAlpha(0)
			end
		end

		if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
			if UnitIsPlayer(frame.unit) then
				local _, unitclass = UnitClass(frame.unit)
				frame.EltruismPortrait.portrait:SetTexture(ElvUI_EltreumUI:GetClassIconsTextures(E.db.ElvUI_EltreumUI.unitframes.portrait[db].style,unitclass))
				frame.EltruismPortrait.border:Hide()
				frame.EltruismPortrait.rare:SetAlpha(0)
				frame.EltruismPortrait.edge:SetAlpha(0)
			else
				frame.EltruismPortrait.border:Hide()
				frame.EltruismPortrait.rare:SetAlpha(0)
				frame.EltruismPortrait.edge:SetAlpha(0)
			end

			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle then
				frame.EltruismPortrait.border:Show()
				frame.EltruismPortrait.portrait:AddMaskTexture(frame.EltruismPortrait.Mask)
			else
				frame.EltruismPortrait.portrait:SetMask("")
			end
		end

		if invert then
			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
				if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
					frame.EltruismPortrait.portrait:SetTexCoord(0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				else
					frame.EltruismPortrait.portrait:SetTexCoord(1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
			else
				frame.EltruismPortrait.portrait:SetTexCoord(1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
			end
		else
			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
				if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
					frame.EltruismPortrait.portrait:SetTexCoord(0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				else
					frame.EltruismPortrait.portrait:SetTexCoord(-0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
			else
				frame.EltruismPortrait.portrait:SetTexCoord(E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
			end
		end
	end

	if SettingUpdate then
		frame.EltruismPortrait:SetPoint("CENTER", frame, tostring(E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.align), E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.x, E.db.ElvUI_EltreumUI.unitframes.portrait[db].position.y)
		frame.EltruismPortrait:SetSize(E.db.ElvUI_EltreumUI.unitframes.portrait[db].size,E.db.ElvUI_EltreumUI.unitframes.portrait[db].size)

		if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
			frame.EltruismPortrait.border:Hide()
			frame.EltruismPortrait.rare:SetAlpha(0)
			frame.EltruismPortrait.edge:SetAlpha(0)
			frame.EltruismPortrait.portrait:SetMask("")
		else
			frame.EltruismPortrait.border:Show()
			frame.EltruismPortrait.edge:SetAlpha(1)
		end

		if E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle and E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
			frame.EltruismPortrait.border:Show()
			frame.EltruismPortrait.portrait:AddMaskTexture(frame.EltruismPortrait.Mask)
		elseif E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom and not E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle then
			frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\clearmask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			frame.EltruismPortrait.portrait:AddMaskTexture(frame.EltruismPortrait.Mask)
			frame.EltruismPortrait.portrait:SetMask("")
			frame.EltruismPortrait.border:Hide()
		end

		if not E.db.ElvUI_EltreumUI.unitframes.portrait[db].rare or E.db.ElvUI_EltreumUI.unitframes.portrait[db].type ~= "CIRCLE" or E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
			frame.EltruismPortrait.rare:SetTexture()
		else
			frame.EltruismPortrait.rare:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Rare.tga")
		end

		if E.db.ElvUI_EltreumUI.unitframes.portrait[db].type ~= "BLIZZARD" or not E.db.ElvUI_EltreumUI.unitframes.portrait[db].edge or E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
			frame.EltruismPortrait.edge:SetTexture()
		else
			frame.EltruismPortrait.edge:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Edge.tga")
		end

		if E.db.ElvUI_EltreumUI.unitframes.portrait[db].type == "BLIZZARD" then
			if E.db.ElvUI_EltreumUI.unitframes.portrait.shadow then
				frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\PortraitShadow.tga")
			else
				frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Portrait.tga")
			end
			if invert then
				frame.EltruismPortrait.border:SetTexCoord(1, 0, 0, 1)
				if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
					if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
						frame.EltruismPortrait.portrait:SetTexCoord(0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					else
						frame.EltruismPortrait.portrait:SetTexCoord(1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					end
				else
					frame.EltruismPortrait.portrait:SetTexCoord(1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
				frame.EltruismPortrait.edge:SetTexCoord(1, 0, 0, 1)
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskinvert.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			else
				if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
					if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
						frame.EltruismPortrait.portrait:SetTexCoord(0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					else
						frame.EltruismPortrait.portrait:SetTexCoord(-0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					end
				else
					frame.EltruismPortrait.portrait:SetTexCoord(E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\mask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			end
			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
				frame.EltruismPortrait.Mask:SetColorTexture(0,0,0,1)
			end
		else
			if E.db.ElvUI_EltreumUI.unitframes.portrait.shadow then
				frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\CircleShadow.tga")
			else
				frame.EltruismPortrait.border:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\Circle.tga")
			end
			if invert then
				if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
					if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
						frame.EltruismPortrait.portrait:SetTexCoord(0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					else
						frame.EltruismPortrait.portrait:SetTexCoord(1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					end
				else
					frame.EltruismPortrait.portrait:SetTexCoord(1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
			else
				if E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
					if notexcoord[E.db.ElvUI_EltreumUI.unitframes.portrait[db].style] then
						frame.EltruismPortrait.portrait:SetTexCoord(0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 0.85 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					else
						frame.EltruismPortrait.portrait:SetTexCoord(-0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, -0.15 + E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1.15 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
					end
				else
					frame.EltruismPortrait.portrait:SetTexCoord(E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale, 1 - E.db.ElvUI_EltreumUI.unitframes.portrait[db].scale)
				end
			end
			if E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle and E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskcircle.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			elseif E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom and not E.db.ElvUI_EltreumUI.unitframes.portrait[db].customcircle then
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\clearmask.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			elseif not E.db.ElvUI_EltreumUI.unitframes.portrait[db].custom then
				frame.EltruismPortrait.Mask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Portrait\\maskcircle.tga", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
			end
		end
	end
end

--main hook
function ElvUI_EltreumUI:BlizzPortraits(unit,hasStateChanged)
	if E.db.ElvUI_EltreumUI.unitframes.portrait.enable then
		if unit == "player" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Player"],"ElvUF_Player",false,hasStateChanged,"player")
		end
		if unit == "target" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Target"],"ElvUF_Target",true,hasStateChanged,"target")
		end
		if unit == "targettarget" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_TargetTarget"],"ElvUF_TargetTarget",true,hasStateChanged,"targettarget")
		end
		if not (E.Classic or E.ClassicHC) then
			if unit == "focus" then
				CreatePorfraitFrameAndTexture(_G["ElvUF_Focus"],"ElvUF_Focus",false,hasStateChanged,"focus")
			end
			if unit == "focustarget" then
				CreatePorfraitFrameAndTexture(_G["ElvUF_FocusTarget"],"ElvUF_FocusTarget",false,hasStateChanged,"focustarget")
			end
		end
		if IsInGroup() and not IsInRaid() then
			for i = 1, 5 do
				if _G["ElvUF_PartyGroup1UnitButton"..i]:IsVisible() then
					CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton"..i],"ElvUF_PartyGroup1UnitButton"..i,false,true,"party")
				end
			end
		end
	end
end
local UF = E:GetModule('UnitFrames')
hooksecurefunc(UF,"PortraitUpdate", ElvUI_EltreumUI.BlizzPortraits)

--hook for party frames and others
function ElvUI_EltreumUI:BlizzPortraitsGroup(frame)
	if E.db.ElvUI_EltreumUI.unitframes.portrait.enable then
		if not frame then return end
		if not frame.USE_PORTRAIT then return end
		if not frame:GetName() then return end
		if frame:GetName():match("PartyGroup") then
			E:Delay(0, function() CreatePorfraitFrameAndTexture(_G[tostring(frame:GetName())],tostring(frame:GetName()),false,true,"party") end)
		end
		if frame:GetName():match("Focus") then
			E:Delay(0, function() CreatePorfraitFrameAndTexture(_G[tostring(frame:GetName())],tostring(frame:GetName()),false,true,tostring(frame.unit)) end)
		end
		if frame:GetName():match("FocusTarget") then
			E:Delay(0, function() CreatePorfraitFrameAndTexture(_G[tostring(frame:GetName())],tostring(frame:GetName()),false,true,"focustarget") end)
		end
		if frame:GetName():match("TargetTarget") then
			E:Delay(0, function() CreatePorfraitFrameAndTexture(_G[tostring(frame:GetName())],tostring(frame:GetName()),true,true,"targettarget") end)
		end
	end
end
hooksecurefunc(UF,"Configure_Portrait", ElvUI_EltreumUI.BlizzPortraitsGroup)
hooksecurefunc(UF,"Update_PartyFrames", ElvUI_EltreumUI.BlizzPortraitsGroup)

--function to update portrait when settings change
function ElvUI_EltreumUI:BlizzPortraitSettingUpdate(unit)
	if E.db.ElvUI_EltreumUI.unitframes.portrait.enable then
		if unit == "player" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Player"],"ElvUF_Player",false,true,"player",true)
		end
		if unit == "target" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Target"],"ElvUF_Target",true,true,"target",true)
		end
		if unit == "party" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton1"],"ElvUF_PartyGroup1UnitButton1",false,true,"party",true)
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton2"],"ElvUF_PartyGroup1UnitButton2",false,true,"party",true)
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton3"],"ElvUF_PartyGroup1UnitButton3",false,true,"party",true)
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton4"],"ElvUF_PartyGroup1UnitButton4",false,true,"party",true)
			CreatePorfraitFrameAndTexture(_G["ElvUF_PartyGroup1UnitButton5"],"ElvUF_PartyGroup1UnitButton5",false,true,"party",true)
		end
		if unit == "targettarget" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_TargetTarget"],"ElvUF_TargetTarget",true,true,"targettarget",true)
		end
		if unit == "focus" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_Focus"],"ElvUF_Focus",false,true,"focus",true)
		end
		if unit == "focustarget" then
			CreatePorfraitFrameAndTexture(_G["ElvUF_FocusTarget"],"ElvUF_FocusTarget",false,true,"focustarget",true)
		end
	end
end
