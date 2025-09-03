local E = unpack(ElvUI)
local _G = _G
local IsEncounterInProgress = _G.IsEncounterInProgress
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar

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

function ElvUI_EltreumUI:PerformanceCVars(command,login)
	if login then --these get reset on logout/login
		if E.Retail then
			SetCVar('raidGraphicsSpellDensity', 1)
			SetCVar('graphicsSpellDensity', 1) --use the new
		end
	elseif command then

		--general graphics
		SetCVar('cameraSmoothStyle', 0) --raw camera
		SetCVar('vrsValar', 0) --vrs doesnt improve anything and decreases graphics on the corners of the screen, useful for fps but not wow
		SetCVar('textureFilteringMode', 5) --AF x16 is not expensive and looks better
		SetCVar('RenderScale', 1) --anything other than 1 has problems atm
		SetCVar('useTargetFPS', 0) --disable target fps
		SetCVar('maxLightDist', 2048) --USEDEFAULT
		SetCVar('entityLodOffset',10) --USEDEFAULT (lowest) value
		SetCVar('clusteredShading', 0) --disable forward lightining
		SetCVar('RAIDclusteredShading', 0) --disable forward lightining
		SetCVar('componentTextureLevel', 0) --reset character mip level to default (although thats full detail, NEEDSTESTING)
		SetCVar('RAIDcomponentTextureLevel', 0) --USEDEFAULT reset character mip level to default (although thats full detail, NEEDSTESTING)
		SetCVar('projectedTextures', 1) --make sure to use projected textures
		SetCVar('RAIDprojectedTextures', 1) --make sure to use projected textures
		SetCVar('sunShafts',1) --enable sun shafts
		SetCVar('RAIDsunShafts',1) --but disable in raid

		--LOD things
		SetCVar('entityLodDist',10) --USEDEFAULT (lowest) value
		SetCVar('RAIDentityLodDist',10) --USEDEFAULT (lowest) value
		SetCVar('lodObjectCullDist',30) --USEDEFAULT
		SetCVar('RAIDlodObjectCullDist',30) --USEDEFAULT
		SetCVar('lodObjectMinSize',20) --USEDEFAULT
		SetCVar('RAIDlodObjectMinSize',20) --USEDEFAULT
		SetCVar('TerrainLodDiv', 256) --default is 768, decrease to 1/3
		SetCVar('RAIDTerrainLodDiv', 256) --default is 768, decrease to 1/3
		SetCVar('doodadLodScale',150) --default is 100, but that has some issues when camera is too far, use a bit higher value
		SetCVar('RAIDdoodadLodScale',150) --USEDEFAULT
		SetCVar('lodObjectFadeScale',100) --USEDEFAULT
		SetCVar('RAIDlodObjectFadeScale',100) --USEDEFAULT
		SetCVar('groundEffectFade',70) --USEDEFAULT
		SetCVar('RAIDgroundEffectFade',70) --USEDEFAULT
		SetCVar('groundEffectDensity',70) --USEDEFAULT
		SetCVar('RAIDgroundEffectDensity',70) --USEDEFAULT
		SetCVar('entityShadowFadeScale',10) --decrease to the raid default
		SetCVar('RAIDentityShadowFadeScale',10) --USEDEFAULT
		SetCVar('lodObjectCullSize', 20) --hides everything smaller than this
		SetCVar('RAIDlodObjectCullSize', 20) --hides everything smaller than this
		SetCVar('wmoLodDist', 300) --USEDEFAULT
		SetCVar('RAIDwmoLodDist', 300) --USEDEFAULT
		SetCVar('terrainLodDist', 400) --USEDEFAULT
		SetCVar('RAIDterrainLodDist', 400) --USEDEFAULT
		SetCVar('terrainMipLevel', 0) --USEDEFAULT reset terrain mip level to default
		SetCVar('RAIDterrainMipLevel', 0) --USEDEFAULT reset terrain mip level to default
		SetCVar('worldBaseMip', 0) --reset world detail
		SetCVar('RAIDworldBaseMip', 0) --reset world detail

		--shadows
		SetCVar('graphicsSSAO', 0) --AO has two settings for some reason, disable both
		SetCVar('raidGraphicsSSAO', 0)
		SetCVar('shadowBlendCascades', 1) --enable blending between shadows, minor detail really
		SetCVar('RAIDshadowBlendCascades', 1) --enable blending between shadows, minor detail really
		SetCVar('shadowMode', 2) --shadow level
		SetCVar('RAIDshadowMode', 2) --shadow level
		SetCVar('shadowNumCascades', 2) --default is 1, but too few shadows then, more show up as you approach
		--performance impact not as huge as first assumed, visually there is a big difference though, 4 gives more shadows and is max setting
		SetCVar('RAIDshadowNumCascades', 2) --default is 1, but too few shadows then, more show up as you approach
		SetCVar('shadowRt', 0) --disable ray tracing
		SetCVar('RAIDshadowRt', 0) --disable ray tracing
		SetCVar('shadowSoft', 1) --soft shadows
		SetCVar('RAIDshadowSoft', 1) --soft shadows
		SetCVar('shadowTextureSize', 1024) --USEDEFAULT shadow resolution
		SetCVar('RAIDshadowTextureSize', 1024) --USEDEFAULT shadow resolution
		SetCVar('SSAO', 0) --AO doesn't look good in wow and has a decent impact performance
		SetCVar('RAIDSSAO', 0)

		--draw distance
		SetCVar('horizonClip', 1600) --USEDEFAULT, this controls where the models will get clipped within the draw distance
		SetCVar('RAIDhorizonClip', 1600) --USEDEFAULT
		SetCVar('horizonStart', 1600) --default is 800, this controls the actual draw distance
		SetCVar('RAIDhorizonStart', 800) --USEDEFAULT
		SetCVar('groundEffectDist', 70) --USEDEFAULT
		SetCVar('RAIDgroundEffectDist', 70) --USEDEFAULT
		SetCVar('farclip', 4000) --default is 1000, increase to 4000
		SetCVar('RAIDfarclip', 1000) --USEDEFAULT

		--depth things
		SetCVar('DepthBasedOpacity', 0) --disable soft edge detect, can cause issues like memory leaks from my experience
		SetCVar('RAIDDepthBasedOpacity', 0) --disable soft edge detect, can cause issues like memory leaks from my experience
		SetCVar('graphicsComputeEffects', 0) --disable computational effects (volumetric fog)
		SetCVar('raidGraphicsComputeEffects', 0) --disable computational effects (volumetric fog)
		SetCVar('graphicsDepthEffects', 1) --disable depth particles or set to 1 to low
		SetCVar('raidGraphicsDepthEffects', 0) --disable depth particles or set to 1 to low
		SetCVar('graphicsParticleDensity', 3) --particle density in game options level
		SetCVar('RAIDGraphicsParticleDensity', 3) --particle density in game options level
		SetCVar('volumeFog', 0)--disable volumetric fog
		SetCVar('RAIDVolumeFog', 0)--disable volumetric fog
		SetCVar('volumeFogLevel', 0)--volumetric fog
		SetCVar('RAIDVolumeFogLevel', 0)--volumetric fog
		SetCVar('particleDensity', 80) --default is 100, decrease to 80
		SetCVar('RAIDparticleDensity', 80) --default is 100, decrease to 80
		SetCVar('particleMTDensity', 80) --default is 100, decrease to 80
		SetCVar('RAIDparticleMTDensity', 80) --default is 100, decrease to 80
		SetCVar('particulatesEnabled', 0) --disable particulates
		SetCVar('RAIDParticulatesEnabled', 0) --disable particulates
		SetCVar('spellClutter', 2) --spell detail, seems replaced by graphicsSpellDensity
		SetCVar('RAIDspellClutter', 2) --spell detail, seems replaced by graphicsSpellDensity
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
