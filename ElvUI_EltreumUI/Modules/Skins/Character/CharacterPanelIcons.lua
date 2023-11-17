local E = unpack(ElvUI)
local _G = _G
local classcolor = E:ClassColor(E.myclass, true)
local CreateFrame = _G.CreateFrame
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local CharacterLevelText = _G.CharacterLevelText
local CharacterFrameTitleText = _G.CharacterFrameTitleText
local CharacterNameText = _G.CharacterNameText
local CharacterFrame = _G.CharacterFrame
local PaperDollFrame = _G.PaperDollFrame
local ReputationFrame = _G.ReputationFrame
local TokenFrame = _G.TokenFrame
local string = _G.string
local classsymbolonframe
local CharacterModelScene = _G.CharacterModelScene
local numCharacters =  3 --number of letters in the name
local classIcons = {
	["WARRIOR"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Warrior",
	["PALADIN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Paladin",
	["HUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Hunter",
	["ROGUE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Rogue",
	["PRIEST"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Priest",
	["DEATHKNIGHT"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DeathKnight",
	["SHAMAN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Shaman",
	["MAGE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Mage",
	["WARLOCK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Warlock",
	["MONK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Monk",
	["DRUID"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Druid",
	["DEMONHUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DemonHunter",
	["EVOKER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/Evoker",
}

-- Alternate Class Icons by Releaf with borders
local classIconsReleafborder = {
	["WARRIOR"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/WarriorIconReleaf",
	["PALADIN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/PaladinIconReleaf",
	["HUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/HunterIconReleaf",
	["ROGUE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/RogueIconReleaf",
	["PRIEST"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/PriestIconReleaf",
	["DEATHKNIGHT"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DeathKnightIconReleaf",
	["SHAMAN"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/ShamanIconReleaf",
	["MAGE"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/MageIconReleaf",
	["WARLOCK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/WarlockIconReleaf",
	["MONK"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/MonkIconReleaf",
	["DRUID"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DruidIconReleaf",
	["DEMONHUNTER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/DemonHunterIconReleaf",
	["EVOKER"] = "Interface/Addons/ElvUI_EltreumUI/Media/Textures/Classes/32/EvokerIconReleaf",
}

if E.Retail then
	CharacterLevelText:SetWidth(300) --new
elseif E.Classic or E.Wrath then
	CharacterLevelText:SetWidth(280) --new
end

function ElvUI_EltreumUI:ClassIconsOnCharacterPanel()
	if IsAddOnLoaded("ElvUI_MerathilisUI") then
		if E.db["mui"]["armory"]["character"]["classIcon"] then
			return
		end
	end

	if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel and E.private.skins.blizzard.enable and E.private.skins.blizzard.character then
		if E.db.ElvUI_EltreumUI.skins.classiconsblizz then
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		elseif E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
			classsymbolonframe = ("|T"..(classIconsReleafborder[E.myclass]..".tga:0:0:0:0|t"))
		else
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		end

		if not E.Retail then
			if _G.CharacterFrameTitleText and _G.CharacterFrameTitleText:GetText() ~= nil and not (_G.CharacterFrameTitleText:GetText():match("|T")) then
				CharacterNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
				CharacterNameText:SetShadowColor(0, 0, 0, 0.8)
				CharacterNameText:SetShadowOffset(2, -1)
				if string.len(CharacterNameText:GetText()) >= numCharacters then
					if E.db.ElvUI_EltreumUI.skins.characterskingradients then
						CharacterNameText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(CharacterNameText:GetText(), E.myclass))
					else
						CharacterNameText:SetText(classsymbolonframe.." "..CharacterNameText:GetText())
						CharacterNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					end
				else
					CharacterNameText:SetText(classsymbolonframe.." "..CharacterNameText:GetText())
					CharacterNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				end
			end
		elseif E.Retail and not self.ischarpanelHooked then

			local function UpdateNameGradient()
				E:Delay(0, function()
					CharacterFrameTitleText:ClearAllPoints()
					CharacterFrameTitleText:SetPoint('TOP', CharacterModelScene, 0, 50)
					CharacterFrameTitleText:SetParent(CharacterFrame)
					CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
					CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
					CharacterFrameTitleText:SetShadowColor(0, 0, 0, 0.8)
					CharacterFrameTitleText:SetShadowOffset(2, -1)

					CharacterLevelText:ClearAllPoints()
					CharacterLevelText:SetPoint('TOP', CharacterFrameTitleText, 'BOTTOM', 0, 0)

					CharacterLevelText:SetDrawLayer("OVERLAY")
					if _G.CharacterFrameTitleText and _G.CharacterFrameTitleText:GetText() ~= nil and not (_G.CharacterFrameTitleText:GetText():match("|T")) then
						CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if string.len(CharacterFrameTitleText:GetText()) >= numCharacters then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(CharacterFrameTitleText:GetText(), E.myclass))
							else
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
								CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						else
							CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
							CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
				end)
			end

			hooksecurefunc('PaperDollFrame_SetLevel', function()
				UpdateNameGradient()
			end)

			hooksecurefunc('PaperDollTitlesPane_Update', function()
				UpdateNameGradient()
			end)

			hooksecurefunc("CharacterFrame_Collapse", function()
				if PaperDollFrame:IsShown() then
					if _G.CharacterFrameTitleText and _G.CharacterFrameTitleText:GetText() ~= nil and not (_G.CharacterFrameTitleText:GetText():match("|T")) then
						CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize - 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if string.len(CharacterFrameTitleText:GetText()) >= numCharacters then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(CharacterFrameTitleText:GetText(), E.myclass))
							else
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
								CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						else
							CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
							CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
				end
			end)

			hooksecurefunc("CharacterFrame_Expand", function()
				if PaperDollFrame:IsShown() then
					if _G.CharacterFrameTitleText and _G.CharacterFrameTitleText:GetText() ~= nil and not (_G.CharacterFrameTitleText:GetText():match("|T")) then
						CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if string.len(CharacterFrameTitleText:GetText()) >= numCharacters then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(CharacterFrameTitleText:GetText(), E.myclass))
							else
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
								CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						else
							CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
							CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
				end
			end)

			hooksecurefunc("ReputationFrame_Update", function()
				if ReputationFrame:IsShown() then
					if _G.CharacterFrameTitleText and _G.CharacterFrameTitleText:GetText() ~= nil and not (_G.CharacterFrameTitleText:GetText():match("|T")) then
						CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize - 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if string.len(CharacterFrameTitleText:GetText()) >= numCharacters then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(CharacterFrameTitleText:GetText(), E.myclass))
							else
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
								CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						else
							CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
							CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
				end
			end)

			hooksecurefunc("TokenFrame_Update", function()
				if TokenFrame:IsShown() then
					if _G.CharacterFrameTitleText and _G.CharacterFrameTitleText:GetText() ~= nil and not (_G.CharacterFrameTitleText:GetText():match("|T")) then
						CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize - 6, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						if string.len(CharacterFrameTitleText:GetText()) >= numCharacters then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(CharacterFrameTitleText:GetText(), E.myclass))
							else
								CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
								CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						else
							CharacterFrameTitleText:SetText(classsymbolonframe.." "..CharacterFrameTitleText:GetText())
							CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
				end
			end)

			self.ischarpanelHooked = true
		end
	end
end

local EltruismCharacterPanelEventFrame = CreateFrame("FRAME")
EltruismCharacterPanelEventFrame:RegisterUnitEvent("UNIT_NAME_UPDATE", "player")
EltruismCharacterPanelEventFrame:RegisterUnitEvent("PLAYER_ENTERING_WORLD")
EltruismCharacterPanelEventFrame:SetScript("OnEvent", function()
	if not IsAddOnLoaded("ElvUI_EltreumUI") then return end
	if not E.private then return end
	if not E.private.ElvUI_EltreumUI then return end
	if IsAddOnLoaded("ElvUI_MerathilisUI") then
		if E.db["mui"]["armory"]["character"]["classIcon"] then
			return
		end
	end

	if E.db.ElvUI_EltreumUI.skins.classiconsoncharacterpanel and E.private.skins.blizzard.enable and E.private.skins.blizzard.character then
		ElvUI_EltreumUI:ClassIconsOnCharacterPanel()

		if E.db.ElvUI_EltreumUI.skins.classiconsblizz then
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		elseif E.db.ElvUI_EltreumUI.skins.classiconsreleaf then
			classsymbolonframe = ("|T"..(classIconsReleafborder[E.myclass]..".tga:0:0:0:0|t"))
		else
			classsymbolonframe = ("|T"..(classIcons[E.myclass]..".tga:0:0:0:0|t"))
		end

		if E.Retail then
			if _G.CharacterFrameTitleText:GetText() ~= nil and not (_G.CharacterFrameTitleText:GetText():match("|T")) then
				if E.db.ElvUI_EltreumUI.skins.characterskingradients then
					_G.CharacterFrameTitleText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(_G.CharacterFrameTitleText:GetText(), E.myclass))
				else
					_G.CharacterFrameTitleText:SetText(classsymbolonframe.." ".._G.CharacterFrameTitleText:GetText())
					_G.CharacterFrameTitleText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
				end
				_G.CharacterFrameTitleText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
			end
		else
			hooksecurefunc('PaperDollFrame_SetLevel', function()
				--without delay for some reason it does not work since the text returns as just... Name for some reason
				E:Delay(0, function()
					if not (CharacterNameText:GetText():match("|T")) then
						CharacterNameText:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.armorynamefontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
						CharacterNameText:SetShadowColor(0, 0, 0, 0.8)
						CharacterNameText:SetShadowOffset(2, -1)
						if string.len(CharacterNameText:GetText()) >= numCharacters then
							if E.db.ElvUI_EltreumUI.skins.characterskingradients then
								CharacterNameText:SetText(classsymbolonframe.." "..ElvUI_EltreumUI:GradientName(CharacterNameText:GetText(), E.myclass))
							else
								CharacterNameText:SetText(classsymbolonframe.." "..CharacterNameText:GetText())
								CharacterNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
							end
						else
							CharacterNameText:SetText(classsymbolonframe.." "..CharacterNameText:GetText())
							CharacterNameText:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
						end
					end
				end)
			end)
		end
	end
end)
