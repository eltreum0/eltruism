local E, L = unpack(ElvUI)
local _G = _G
local IsEncounterInProgress = _G.IsEncounterInProgress

--apply recommended ElvUI perforamnce optimizations
function ElvUI_EltreumUI:PerformanceOptimization()
	--ElvUI
	E.private["general"]["pixelPerfect"] = true
	E.db["unitframe"]["thinBorders"] = true
	E.db["nameplates"]["thinBorders"] = true
	E.db["unitframe"]["units"]["target"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raid1"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raid2"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raid3"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["raidpet"]["healPrediction"]["enable"] = false
	E.db["unitframe"]["units"]["tank"]["healPrediction"]["enable"] = false

	E.db["auras"]["buffs"]["seperateOwn"] = 0 -- do not sort auras
	E.db["auras"]["debuffs"]["seperateOwn"] = 0 -- do not sort auras
	E.db["auras"]["cooldown"]["override"] = false
	E.db["chat"]["fade"] = true -- fade text again
	E.db["unitframe"]["units"]["assist"]["enable"] = false --disable assist/tank frames
	E.db["unitframe"]["units"]["tank"]["enable"] = false --disable assist/tank frames
	E.db["unitframe"]["units"]["boss"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["player"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["target"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["targettarget"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["focus"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["pet"]["fader"]["smooth"] = 0 --used to be 0.25
	E.db["unitframe"]["units"]["arena"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["boss"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["party"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["raid1"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["raid2"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["raid3"]["fader"]["smooth"] = 0
	E.db["general"]["altPowerBar"]["smoothbars"] = false --was true
	E.db["nameplates"]["smoothbars"] = false --was true
	E.db["unitframe"]["smoothbars"] = false --was true
	E.db["tooltip"]["inspectDataEnable"] = false --was true
	E.db["tooltip"]["mythicDataEnable"] = false --was true
	E.db["tooltip"]["role"] = false --was true
	E.db["tooltip"]["targetInfo"] = false --was true
	E.db["tooltip"]["showMount"] = false --was true
	E.db["unitframe"]["units"]["boss"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["raid1"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["raid2"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["raid3"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["focus"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["pet"]["portrait"]["enable"] = false
	E.db["unitframe"]["units"]["targettarget"]["portrait"]["enable"] = false

	--Eltruism
	E.db.ElvUI_EltreumUI.otherstuff.partyraiddeath.enable = false
	E.db.ElvUI_EltreumUI.nameplates.friendlynameplatetoggle.disablefriendly = true
	E.db.ElvUI_EltreumUI.chat.enable = false
	E.db.ElvUI_EltreumUI.nameplates.nameplatepower.autoadjustposition = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassColorGlow = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.ClassBorderNameplate = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.nameplatetexture = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.classbarautohide = false
	E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect = false
	E.db.ElvUI_EltreumUI.nameplates.classification.enable = false
	E.db.ElvUI_EltreumUI.nameplates.nameplatepower.gradient = false
	E.db.ElvUI_EltreumUI.skins.shadow.nameplates = false
	E.db.ElvUI_EltreumUI.skins.shadow.nppower = false
	E.db.ElvUI_EltreumUI.skins.shadow.npcastbar = false
	E.db.ElvUI_EltreumUI.skins.shadow.npportraits = false
	E.db.ElvUI_EltreumUI.skins.shadow.npauras = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.enableHealthHeight = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel = false
	E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.npglow = false
	E.db.ElvUI_EltreumUI.nameplates.auras.enable = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientXP = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientReputation = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientHonor = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.gradientAltPower = false
	E.db.ElvUI_EltreumUI.unitframes.models.powerbar = false
	E.db.ElvUI_EltreumUI.unitframes.models.castbar = false
	E.db.ElvUI_EltreumUI.unitframes.models.unitframe = false
	E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enable = false
	E.db.ElvUI_EltreumUI.unitframes.sparkcustomcolor.enableaurabars = false
	E.db.ElvUI_EltreumUI.unitframes.portraitfix = false
	E.db.ElvUI_EltreumUI.skins.shadow.aura = false
	E.db.ElvUI_EltreumUI.skins.shadow.ufaura = false
	E.db.ElvUI_EltreumUI.skins.bigwigs = false
	E.db.ElvUI_EltreumUI.skins.shadow.bigwigs = false
	E.db.ElvUI_EltreumUI.skins.details = false
	E.db.ElvUI_EltreumUI.skins.bugsack = false
	E.db.ElvUI_EltreumUI.skins.warpdeplete = false
	E.db.ElvUI_EltreumUI.skins.omnicd = false
	E.db.ElvUI_EltreumUI.skins.cell = false
	E.db.ElvUI_EltreumUI.skins.dbm = false
	E.db.ElvUI_EltreumUI.glow.enable = false
	E.db.ElvUI_EltreumUI.cursors.cursor.enable = false
	E.db.ElvUI_EltreumUI.cursors.cursor.cooldown = false
	E.db.ElvUI_EltreumUI.waypoints.waypointetasetting.enable = false
	E.db.ElvUI_EltreumUI.loot.loottext.enable = false
	E.private.ElvUI_EltreumUI.nameplatepower.enable = false
	E.db.ElvUI_EltreumUI.quests.anchor = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.enable = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.npenable = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablepower = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.enableaurabars = false
	E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop = false
	E.db.ElvUI_EltreumUI.chat.chatgradient = false

	--disable combat logging
	_G.C_CVar.SetCVar("advancedCombatLogging", 0)
	_G.LoggingCombat(false)
end

--toggle 3d models
function ElvUI_EltreumUI:ModelsToggle(install)
	if install then
		E.db.ElvUI_EltreumUI.disabledmodels = true

		E.db.unitframe.units.boss.portrait.enable = false
		E.db.unitframe.units.player.portrait.enable = false
		E.db.unitframe.units.pet.portrait.enable = false
		E.db.unitframe.units.target.portrait.enable = false
		E.db.unitframe.units.targettarget.portrait.enable = false
		E.db.unitframe.units.focus.portrait.enable = false
		E.db.unitframe.units.party.portrait.enable = false
		E.db.unitframe.units.raid1.portrait.enable = false
		E.db.unitframe.units.raid2.portrait.enable = false
		E.db.unitframe.units.raid3.portrait.enable = false
		E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect = false
		E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel = false
		E.db.ElvUI_EltreumUI.unitframes.models.powerbar = false
		E.db.ElvUI_EltreumUI.unitframes.models.castbar = false
		E.db.ElvUI_EltreumUI.unitframes.models.unitframe = false
	else
		if E.db.ElvUI_EltreumUI.disabledmodels then
			E.db.ElvUI_EltreumUI.disabledmodels = false

			E.db.unitframe.units.boss.portrait.enable = true
			E.db.unitframe.units.player.portrait.enable = true
			E.db.unitframe.units.pet.portrait.enable = true
			E.db.unitframe.units.target.portrait.enable = true
			--E.db.unitframe.units.targettarget.portrait.enable = true
			--E.db.unitframe.units.focus.portrait.enable = true
			E.db.unitframe.units.party.portrait.enable = true
			--E.db.unitframe.units.raid1.portrait.enable = true
			--E.db.unitframe.units.raid2.portrait.enable = true
			--E.db.unitframe.units.raid3.portrait.enable = true
			E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect = true
			E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel = true
			E.db.ElvUI_EltreumUI.unitframes.models.powerbar = true
			--E.db.ElvUI_EltreumUI.unitframes.models.castbar = true
			--E.db.ElvUI_EltreumUI.unitframes.models.unitframe = true

			ElvUI_EltreumUI:Print("Enabled several models in ElvUI and Eltruism")
		else
			E.db.ElvUI_EltreumUI.disabledmodels = true

			E.db.unitframe.units.boss.portrait.enable = false
			E.db.unitframe.units.player.portrait.enable = false
			E.db.unitframe.units.pet.portrait.enable = false
			E.db.unitframe.units.target.portrait.enable = false
			E.db.unitframe.units.targettarget.portrait.enable = false
			E.db.unitframe.units.focus.portrait.enable = false
			E.db.unitframe.units.party.portrait.enable = false
			E.db.unitframe.units.raid1.portrait.enable = false
			E.db.unitframe.units.raid2.portrait.enable = false
			E.db.unitframe.units.raid3.portrait.enable = false
			E.db.ElvUI_EltreumUI.nameplates.nameplatepower.modeleffect = false
			E.db.ElvUI_EltreumUI.nameplates.nameplateOptions.targetmodel = false
			E.db.ElvUI_EltreumUI.unitframes.models.powerbar = false
			E.db.ElvUI_EltreumUI.unitframes.models.castbar = false
			E.db.ElvUI_EltreumUI.unitframes.models.unitframe = false

			ElvUI_EltreumUI:Print("Disabled several models to improve performance")
		end

		E:StaticPopup_Show('CONFIG_RL')
	end
end

function ElvUI_EltreumUI:EncounterCheck() --let other functions know if its a boss fight
	if E.db.ElvUI_EltreumUI.encountercheck then
		return IsEncounterInProgress()
	else
		return false
	end
end

--for fps testing
--[[
local framerate = CreateFrame("Frame", nil, UIParent)
framerate.TimeText = framerate:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
framerate.TimeText:SetJustifyV("TOP")
framerate.TimeText:SetSize(0, 26)
framerate.TimeText:SetPoint("CENTER", UIParent, "CENTER",0, 400)
framerate.TimeText:SetFont(E.LSM:Fetch("font", E.db.general.font), 36, E.db.general.fontStyle)
framerate.TimeText:SetTextColor(1,1,1)
UIParent.ClearAllPoints(FramerateText)
_G.FramerateText:SetPoint("RIGHT",UIParent,"CENTER",0, 2035)
_G.FramerateLabel:SetText("")
ToggleFramerate()

framerate:SetScript("OnUpdate", function()
	_G.FRAMERATE_FREQUENCY = 0.1
	if _G.FramerateText:GetText() ~= nil then
		if tonumber(_G.FramerateText:GetText()) < 60 then
			framerate.TimeText:SetTextColor(1,0,0)
			framerate.TimeText:SetText(_G.FramerateText:GetText())
		elseif tonumber(_G.FramerateText:GetText()) > 60 then
			framerate.TimeText:SetTextColor(1,1,1)
			framerate.TimeText:SetText(_G.FramerateText:GetText())
		end
	end
end)
]]
