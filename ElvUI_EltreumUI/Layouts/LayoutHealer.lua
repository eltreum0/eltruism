local E, L = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded
local GetPhysicalScreenSize = _G.GetPhysicalScreenSize

function ElvUI_EltreumUI:SetupLayoutHealer(silent)
	if not E.db.movers then E.db.movers = {} end
	if E.Modern then
		E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
		E.db["unitframe"]["units"]["player"]["customTexts"]["EltreumPlayerAbsorb"] = {
		["enable"] = true
		}
		E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
		E.db["unitframe"]["units"]["party"]["customTexts"]["EltreumPartyAbsorb"] = {
		["enable"] = true
		}
		E.db["unitframe"]["units"]["raid1"]["customTexts"] = E.db["unitframe"]["units"]["raid1"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["EltreumRaid1Absorb"] = {
		["enable"] = true
		}
		E.db["unitframe"]["units"]["raid2"]["customTexts"] = E.db["unitframe"]["units"]["raid2"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid2"]["customTexts"]["EltreumRaid2Absorb"] = {
		["enable"] = true
		}
		E.db["unitframe"]["units"]["raid3"]["customTexts"] = E.db["unitframe"]["units"]["raid3"]["customTexts"] or {}
		E.db["unitframe"]["units"]["raid3"]["customTexts"]["EltreumRaid3Absorb"] = {
		["enable"] = true
		}
		E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
		E.db["unitframe"]["units"]["target"]["customTexts"]["EltreumTargetAbsorb"] = {
		["enable"] = true
		}
	end
	local width = GetPhysicalScreenSize()

	--only healers should really have these
	E.db.ElvUI_EltreumUI.glow.enableUFs = true

	--healprediction
	E.db["unitframe"]["units"]["raid1"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["raid2"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["raid3"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["raidpet"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["tank"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["focus"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["targettarget"]["healPrediction"]["enable"] = true

	--set Dynamic Status Icons
	if IsAddOnLoaded("ElvUI_DynamicStatusIcons") then
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["xOffset"] = -49
		E.db["unitframe"]["units"]["player"]["DynamicStatusIcons"]["yOffset"] = -88
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["xOffset"] = 49
		E.db["unitframe"]["units"]["target"]["DynamicStatusIcons"]["yOffset"] = -88
	end

	-- Healer Action bars
	-- Bar 1
	E.db["actionbar"]["bar1"]["buttonSize"] = 40
	E.db["actionbar"]["bar1"]["point"] = "TOPLEFT"

	-- Bar 2
	E.db["actionbar"]["bar2"]["buttonHeight"] = 25
	E.db["actionbar"]["bar2"]["buttonSize"] = 30
	E.db["actionbar"]["bar2"]["point"] = "TOPLEFT"

	-- Bar 3
	E.db["actionbar"]["bar3"]["buttonsPerRow"] = 6
	E.db["actionbar"]["bar3"]["buttonHeight"] = 25
	E.db["actionbar"]["bar3"]["buttonSize"] = 30
	E.db["actionbar"]["bar3"]["point"] = "TOPLEFT"

	-- Bar 4
	E.db["actionbar"]["bar4"]["buttonHeight"] = 25
	E.db["actionbar"]["bar4"]["buttonSize"] = 30
	E.db["actionbar"]["bar4"]["point"] = "TOPLEFT"

	-- Bar 5
	E.db["actionbar"]["bar5"]["buttonsPerRow"] = 6
	E.db["actionbar"]["bar5"]["buttonHeight"] = 25
	E.db["actionbar"]["bar5"]["buttonSize"] = 30
	E.db["actionbar"]["bar5"]["buttonSpacing"] = 3
	E.db["actionbar"]["bar5"]["enabled"] = true
	E.db["actionbar"]["bar5"]["point"] = "TOPLEFT"

	-- Bar 6
	E.db["actionbar"]["bar6"]["buttonSpacing"] = 0
	E.db["actionbar"]["bar6"]["buttonSize"] = 35
	if width ~= 3840 then
		E.db["actionbar"]["bar6"]["buttonSpacing"] = 1
		E.db["actionbar"]["bar6"]["buttonSize"] = 33
	end

	-- Bar 7
	E.db["actionbar"]["bar7"]["point"] = "TOPLEFT"

	-- Bar 8
	E.db["actionbar"]["bar8"]["point"] = "TOPLEFT"

	-- Bar 9
	E.db["actionbar"]["bar9"]["point"] = "TOPLEFT"

	-- Bar 10
	E.db["actionbar"]["bar10"]["point"] = "TOPLEFT"
	E.db["actionbar"]["bar10"]["visibility"] = "[vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"

	-- Pet Bar
	E.db["actionbar"]["barPet"]["buttonHeight"] = 18
	E.db["actionbar"]["barPet"]["buttonSize"] = 31
	E.db["actionbar"]["barPet"]["buttonsPerRow"] = 3
	E.db["actionbar"]["barPet"]["point"] = "TOPLEFT"

	-- Stance Bar
	E.db["actionbar"]["stanceBar"]["buttonSize"] = 25 --27 can go over if too many stances
	E.db["actionbar"]["stanceBar"]["mouseover"] = E.Retail

	-- Colors
	E.db["actionbar"]["noPowerColor"]["b"] = 0.43921568627451
	E.db["actionbar"]["noPowerColor"]["g"] = 0.21960784313725
	E.db["actionbar"]["noPowerColor"]["r"] = 0.21960784313725
	E.db["actionbar"]["notUsableColor"]["b"] = 0.16862745098039
	E.db["actionbar"]["notUsableColor"]["g"] = 0.16862745098039
	E.db["actionbar"]["notUsableColor"]["r"] = 0.16862745098039

	-- Healer Auras
	E.db["auras"]["debuffs"]["fadeThreshold"] = 5
	-- Growth Directions Healing
	E.db["unitframe"]["units"]["party"]["growthDirection"] = "RIGHT_UP"

	-- Movers Healing
	E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-65,-292"
	E.db["movers"]["AzeriteBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-421,0"
	if E.Forever then
		E.db["movers"]["BNETMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-233"
	else
		E.db["movers"]["BNETMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-259"
	end
	E.db["movers"]["BelowMinimapContainerMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,79,-155"
	E.db["movers"]["BigButtonsFarmBar"] = "TOPLEFT,ElvUIParent,TOPLEFT,433,-134"
	E.db["movers"]["BigButtonsSeedBarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,281,-186"
	E.db["movers"]["BossButton"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-458,126"
	E.db["movers"]["BossHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-334"
	E.db["movers"]["DurabilityFrameMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,481,366"
	E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,307"
	E.db["movers"]["ElvAB_10"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,344"
	E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,280"
	E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,308,253"
	E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,253"
	E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-308,253"
	E.db["movers"]["ElvAB_7"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,240"
	E.db["movers"]["ElvAB_8"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,275"
	E.db["movers"]["ElvAB_9"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,310"
	E.db["movers"]["ElvUF_AssistMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,420,499"
	E.db["movers"]["ElvUF_PartyMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,87"
	E.db["movers"]["ElvUF_PetCastbarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,311,352"
	E.db["movers"]["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,426,336"
	E.db["movers"]["PetAB"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,426,255"
	if width == 1920 then
		E.db["movers"]["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,426,338"
		E.db["movers"]["PetAB"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,426,253"
	elseif width == 2560 then
		E.db["movers"]["ElvUF_PetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,426,332"
		E.db["movers"]["PetAB"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,426,252"
	end
	E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,14,355"
	E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,340"
	E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-280,387"
	E.db["movers"]["ElvUF_Raid1Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,26"
	E.db["movers"]["ElvUF_Raid2Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,24"
	E.db["movers"]["ElvUF_Raid3Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,25"
	if not E.Retail then
		E.db["movers"]["ElvUF_Raid1Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,108"
		E.db["movers"]["ElvUF_Raid2Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,25"
		E.db["movers"]["ElvUF_Raid3Mover"] = "BOTTOM,ElvUIParent,BOTTOM,0,26"
	end
	E.db["movers"]["ElvUF_RaidpetMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,217" --new
	E.db["movers"]["ElvUF_TankMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-420,500"
	E.db["movers"]["ElvUF_TargetAuraMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-400,288"
	E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,311,359"
	E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,280,387"
	E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-410,387"
	if width == 1920 then
		E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-408,387"
	end
	E.db["movers"]["ElvUIBagMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,24"
	E.db["movers"]["ElvUIBankMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,0,24"
	E.db["movers"]["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,274,-132"
	E.db["movers"]["MasterExperienceMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-349"
	--E.db["movers"]["MicrobarMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,140,1"
	if IsAddOnLoaded("ElvUI_SLE") then
		E.db["movers"]["SLE_DataPanel_1_Mover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,202"
		E.db["movers"]["SLE_FarmSeedMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,278"
	end
	E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,-308,308"
	E.db["movers"]["SocialMenuMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-456"
	E.db["movers"]["SquareMinimapBar"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,0,-197"
	E.db["movers"]["TalkingHeadFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,274,-77"
	E.db["movers"]["TooltipMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,274,-134"
	E.db["movers"]["TorghastBuffsMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,206"
	E.db["movers"]["TotemBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,308,306" --shaman totem
	E.db["movers"]["TotemTrackerMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-399,260" --class totems thing like consecration
	E.db["movers"]["AdditionalPowerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,341" --move it below the castbar for monk/druid in mop
	--[[if E.Cata then
		--Shaman things
		E.db["actionbar"]["totemBar"]["buttonSize"] = 24
		E.db["actionbar"]["totemBar"]["flyoutSize"] = 24
		E.db["actionbar"]["totemBar"]["flyoutSpacing"] = 3
		E.db["actionbar"]["totemBar"]["font"] = "Kimberley"
		E.db["actionbar"]["totemBar"]["spacing"] = 5
		E.db["actionbar"]["totemBar"]["visibility"] = "[combat] show;[@target, noexists] hide; [vehicleui] hide; [bonusbar:5] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
	end]]
	E.db["movers"]["TorghastChoiceToggle"] = "BOTTOM,ElvUIParent,BOTTOM,0,445"
	E.db["movers"]["VOICECHAT"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,-1"
	if IsAddOnLoaded("ElvUI_WindTools") then
		E.db["movers"]["WTRaidMarkersBarAnchor"] = "TOPLEFT,ElvUIParent,TOPLEFT,398,1"
		E.db["movers"]["WTCustomEmoteFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-24"
		E.db["movers"]["WTExtraItemsBar1Mover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-239,231"
		E.db["movers"]["WTExtraItemsBar2Mover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-239,275"
		E.db["movers"]["WTExtraItemsBar3Mover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-239,310"
		E.db["movers"]["WTExtraItemsBar4Mover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-239,351"
		E.db["movers"]["WTExtraItemsBar5Mover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-239,391"
		E.db["movers"]["WTParagonReputationToastFrameMover"] = "TOP,ElvUIParent,TOP,0,-222"
	end
	E.db["movers"]["ZoneAbility"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-458,73"
	E.db["movers"]["MoverEltruismWA"] = "BOTTOM,ElvUIParent,BOTTOM,0,264"
	E.db["movers"]["MoverEltruismWA2"] = "BOTTOM,ElvUIParent,BOTTOM,0,387"
	E.db["movers"]["MoverEltruismWAConsumables"] = "BOTTOM,ElvUIParent,BOTTOM,-280,357"

	-- UnitFrames Healing
	-- Assist
	E.db["unitframe"]["units"]["assist"]["height"] = 30
	E.db["unitframe"]["units"]["assist"]["verticalSpacing"] = 1
	E.db["unitframe"]["units"]["assist"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["assist"]["targetsGroup"]["enable"] = false
	E.db["unitframe"]["units"]["assist"]["targetsGroup"]["height"] = 25
	E.db["unitframe"]["units"]["assist"]["targetsGroup"]["xOffset"] = -3
	E.db["unitframe"]["units"]["assist"]["buffIndicator"]["enable"] = true
	E.db["unitframe"]["units"]["assist"]["buffIndicator"]["size"] = 12
	E.db["unitframe"]["units"]["assist"]["buffs"]["enable"] = true
	E.db["unitframe"]["units"]["assist"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["assist"]["debuffs"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["assist"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["assist"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["assist"]["debuffs"]["yOffset"] = 2
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["duration"]["yOffset"] = 3
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["duration"]["position"] = "TOP"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontSize"] = 14
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["yOffset"] = 0
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["size"] = 20
	E.db["unitframe"]["units"]["assist"]["rdebuffs"]["stack"]["xOffset"] = -3

	-- Tank
	E.db["unitframe"]["units"]["tank"]["buffIndicator"]["size"] = 12
	E.db["unitframe"]["units"]["tank"]["buffs"]["enable"] = true
	E.db["unitframe"]["units"]["tank"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["tank"]["debuffs"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["tank"]["debuffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["tank"]["debuffs"]["yOffset"] = 2
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["anchorPoint"] = "LEFT"
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["xOffset"] = -3

	-- Focus
	E.db["unitframe"]["units"]["focus"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["focus"]["healPrediction"]["absorbStyle"] = "REVERSED"
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["colorBackdrop"]["b"] = 0
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["colorBackdrop"]["g"] = 0
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["colorBackdrop"]["r"] = 0
	E.db["unitframe"]["units"]["focus"]["castbar"]["customColor"]["enable"] = true
	E.db["unitframe"]["units"]["focus"]["infoPanel"]["transparent"] = true

	-- FocusTarget
	E.db["unitframe"]["units"]["focustarget"]["colorOverride"] = "FORCE_OFF"

	-- Party
	E.db["unitframe"]["units"]["party"]["buffIndicator"]["size"] = 16
	E.db["unitframe"]["units"]["party"]["buffs"]["clickThrough"] = true
	E.db["unitframe"]["units"]["party"]["buffs"]["countFontSize"] = 10
	E.db["unitframe"]["units"]["party"]["buffs"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["sizeOverride"] = 24
	E.db["unitframe"]["units"]["party"]["buffs"]["yOffset"] = 1
	E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "TOP"
	E.db["unitframe"]["units"]["party"]["debuffs"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["party"]["debuffs"]["desaturate"] = false
	E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 6
	E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 24
	E.db["unitframe"]["units"]["party"]["debuffs"]["yOffset"] = 1
	E.db["unitframe"]["units"]["party"]["healPrediction"]["absorbStyle"] = "REVERSED"
	E.db["unitframe"]["units"]["party"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["party"]["horizontalSpacing"] = 9
	E.db["unitframe"]["units"]["party"]["infoPanel"]["height"] = 16
	E.db["unitframe"]["units"]["party"]["orientation"] = "RIGHT"
	E.db["unitframe"]["units"]["party"]["power"]["height"] = 12
	E.db["unitframe"]["units"]["party"]["raidicon"]["attachTo"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["party"]["raidicon"]["size"] = 24
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["fontSize"] = 12
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["size"] = 22
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["xOffset"] = -35
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["yOffset"] = 40
	E.db["unitframe"]["units"]["party"]["readycheckIcon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["party"]["resurrectIcon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["party"]["roleIcon"]["size"] = 16
	E.db["unitframe"]["units"]["party"]["roleIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["sortDir"] = "DESC"
	E.db["unitframe"]["units"]["party"]["summonIcon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["party"]["verticalSpacing"] = 9
	E.db["unitframe"]["units"]["party"]["width"] = 150
	E.db["unitframe"]["units"]["party"]["petsGroup"]["anchorPoint"] = "BOTTOM"
	E.db["unitframe"]["units"]["party"]["petsGroup"]["buffIndicator"]["size"] = 16
	E.db["unitframe"]["units"]["party"]["petsGroup"]["height"] = 36
	E.db["unitframe"]["units"]["party"]["petsGroup"]["width"] = 150
	E.db["unitframe"]["units"]["party"]["petsGroup"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["petsGroup"]["yOffset"] = -3

	-- Pet
	E.db["unitframe"]["units"]["pet"]["power"]["enable"] = true
	E.db["unitframe"]["units"]["pet"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
	E.db["unitframe"]["units"]["pet"]["width"] = 98
	E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 98
	if width == 1920 then
		E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 102
		E.db["unitframe"]["units"]["pet"]["width"] = 102
	elseif width == 2560 then
		E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 100
		E.db["unitframe"]["units"]["pet"]["width"] = 100
	end

	-- Player
	E.db["unitframe"]["units"]["player"]["buffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["player"]["buffs"]["yOffset"] = -2
	E.db["unitframe"]["units"]["player"]["buffs"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorBackdrop"]["a"] = 0
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorBackdrop"]["b"] = 0.50196078431373
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorBackdrop"]["g"] = 0.50196078431373
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorBackdrop"]["r"] = 0.50196078431373
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorNoInterrupt"]["b"] = 0.29803921568627
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorNoInterrupt"]["g"] = 0.78039215686275
	E.db["unitframe"]["units"]["player"]["castbar"]["customColor"]["colorNoInterrupt"]["r"] = 0
	E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 28
	E.db["unitframe"]["units"]["player"]["castbar"]["iconSize"] = 27
	E.db["unitframe"]["units"]["player"]["castbar"]["insideInfoPanel"] = false
	E.db["unitframe"]["units"]["player"]["castbar"]["tickColor"]["a"] = 0
	E.db["unitframe"]["units"]["player"]["castbar"]["tickColor"]["b"] = 1
	E.db["unitframe"]["units"]["player"]["castbar"]["tickColor"]["g"] = 1
	E.db["unitframe"]["units"]["player"]["castbar"]["tickColor"]["r"] = 1
	E.db["unitframe"]["units"]["player"]["castbar"]["tickWidth"] = 20
	E.db["unitframe"]["units"]["player"]["castbar"]["ticks"] = false
	E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 267
	E.db["unitframe"]["units"]["player"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
	E.db["unitframe"]["units"]["player"]["debuffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["player"]["debuffs"]["yOffset"] = -32
	E.db["unitframe"]["units"]["player"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["player"]["debuffs"]["numrows"] = 2
	E.db["unitframe"]["units"]["player"]["debuffs"]["perrow"] = 6
	E.db["unitframe"]["units"]["player"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["name"]["xOffset"] = 3
	E.db["unitframe"]["units"]["player"]["power"]["height"] = 14
	E.db["unitframe"]["units"]["player"]["power"]["autoHide"] = false --was true
	E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = false
	E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 295
	E.db["unitframe"]["units"]["player"]["raidicon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["player"]["raidicon"]["yOffset"] = 0

	-- Raid 1
	E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["size"] = 12
	E.db["unitframe"]["units"]["raid1"]["buffs"]["countXOffset"] = 3
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["attachTo"] = "HEALTH"
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["countXOffset"] = 3
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["desaturate"] = false
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["perrow"] = 5
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["sizeOverride"] = 15
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["spacing"] = 0
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["xOffset"] = -75
	E.db["unitframe"]["units"]["raid1"]["debuffs"]["yOffset"] = 5
	E.db["unitframe"]["units"]["raid1"]["fader"]["minAlpha"] = 0.3
	E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 10
	E.db["unitframe"]["units"]["raid1"]["healPrediction"]["absorbStyle"] = "REVERSED"
	E.db["unitframe"]["units"]["raid1"]["height"] = 30
	E.db["unitframe"]["units"]["raid1"]["power"]["height"] = 8
	E.db["unitframe"]["units"]["raid1"]["power"]["yOffset"] = 4
	E.db["unitframe"]["units"]["raid1"]["raidRoleIcons"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid1"]["raidicon"]["attachTo"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid1"]["raidicon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["size"] = 20
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["stack"]["xOffset"] = 3
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["xOffset"] = -40
	E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["yOffset"] = 18
	E.db["unitframe"]["units"]["raid1"]["readycheckIcon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["raid1"]["resurrectIcon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["raid1"]["resurrectIcon"]["size"] = 20
	E.db["unitframe"]["units"]["raid1"]["summonIcon"]["size"] = 20
	E.db["unitframe"]["units"]["raid1"]["threatStyle"] = "HEALTHBORDER"
	if not E.Retail then
		E.db["unitframe"]["units"]["raid1"]["numGroups"] = 2
		E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "RIGHT_DOWN"
		E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3
	end
	E.db["unitframe"]["units"]["raid1"]["width"] = 160

	-- Raid 2
	E.db["unitframe"]["units"]["raid2"]["buffIndicator"]["size"] = 12
	E.db["unitframe"]["units"]["raid2"]["buffs"]["countXOffset"] = 3
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["attachTo"] = "HEALTH"
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["countXOffset"] = 3
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["desaturate"] = false
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["perrow"] = 5
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["sizeOverride"] = 15
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["spacing"] = 0
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["xOffset"] = -75
	E.db["unitframe"]["units"]["raid2"]["debuffs"]["yOffset"] = 5
	E.db["unitframe"]["units"]["raid2"]["groupSpacing"] = 2
	E.db["unitframe"]["units"]["raid2"]["healPrediction"]["absorbStyle"] = "REVERSED"
	E.db["unitframe"]["units"]["raid2"]["height"] = 26
	E.db["unitframe"]["units"]["raid2"]["horizontalSpacing"] = 6
	E.db["unitframe"]["units"]["raid2"]["infoPanel"]["height"] = 10
	E.db["unitframe"]["units"]["raid2"]["power"]["height"] = 8
	E.db["unitframe"]["units"]["raid2"]["power"]["yOffset"] = 4
	E.db["unitframe"]["units"]["raid2"]["raidRoleIcons"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid2"]["raidicon"]["attachTo"] = "TOPRIGHT"
	E.db["unitframe"]["units"]["raid2"]["raidicon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["size"] = 20
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["stack"]["xOffset"] = 3
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["xOffset"] = -40
	E.db["unitframe"]["units"]["raid2"]["readycheckIcon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["raid2"]["resurrectIcon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["raid2"]["resurrectIcon"]["size"] = 20
	E.db["unitframe"]["units"]["raid2"]["summonIcon"]["size"] = 20
	E.db["unitframe"]["units"]["raid2"]["threatStyle"] = "HEALTHBORDER"
	E.db["unitframe"]["units"]["raid2"]["verticalSpacing"] = 1
	if not E.Retail then
		E.db["unitframe"]["units"]["raid2"]["growthDirection"] = "RIGHT_DOWN"
		E.db["unitframe"]["units"]["raid2"]["verticalSpacing"] = 2
		E.db["unitframe"]["units"]["raid2"]["height"] = 30
		E.db["unitframe"]["units"]["raid2"]["horizontalSpacing"] = 0
		E.db["unitframe"]["units"]["raid2"]["infoPanel"]["height"] = 12
	end
	E.db["unitframe"]["units"]["raid2"]["width"] = 130

	-- Raid 3
	E.db["unitframe"]["units"]["raid3"]["buffIndicator"]["size"] = 12
	E.db["unitframe"]["units"]["raid3"]["buffs"]["sizeOverride"] = 17
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["attachTo"] = "HEALTH"
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["countFont"] = "Kimberley"
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["countFontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["countFontSize"] = 10
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["countXOffset"] = 3
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["growthX"] = "LEFT"
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["sizeOverride"] = 15
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["spacing"] = 0
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["xOffset"] = -45
	E.db["unitframe"]["units"]["raid3"]["debuffs"]["yOffset"] = 5
	E.db["unitframe"]["units"]["raid3"]["fader"]["minAlpha"] = 0.3
	E.db["unitframe"]["units"]["raid3"]["groupSpacing"] = 10
	E.db["unitframe"]["units"]["raid3"]["healPrediction"]["absorbStyle"] = "REVERSED"
	E.db["unitframe"]["units"]["raid3"]["health"]["attachTextTo"] = "InfoPanel"
	E.db["unitframe"]["units"]["raid3"]["health"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["raid3"]["health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid3"]["height"] = 30
	E.db["unitframe"]["units"]["raid3"]["horizontalSpacing"] = 0
	E.db["unitframe"]["units"]["raid3"]["name"]["position"] = "BOTTOMLEFT"
	E.db["unitframe"]["units"]["raid3"]["power"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["raid3"]["power"]["height"] = 8
	E.db["unitframe"]["units"]["raid3"]["power"]["width"] = "inset"
	E.db["unitframe"]["units"]["raid3"]["power"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid3"]["power"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid3"]["raidRoleIcons"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid3"]["raidicon"]["yOffset"] = -2
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["fontOutline"] = "THICKOUTLINE"
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["xOffset"] = -20
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["yOffset"] = 18
	E.db["unitframe"]["units"]["raid3"]["readycheckIcon"]["attachTo"] = "CENTER"
	E.db["unitframe"]["units"]["raid3"]["resurrectIcon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["raid3"]["resurrectIcon"]["size"] = 15
	E.db["unitframe"]["units"]["raid3"]["roleIcon"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid3"]["roleIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid3"]["summonIcon"]["attachToObject"] = "Health"
	E.db["unitframe"]["units"]["raid3"]["summonIcon"]["size"] = 15
	E.db["unitframe"]["units"]["raid3"]["numGroups"] = 8
	if not E.Retail then
		E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 2
		E.db["unitframe"]["units"]["raid3"]["groupSpacing"] = 6
	end
	E.db["unitframe"]["units"]["raid3"]["width"] = 100

	-- Raid Pets
	E.db["unitframe"]["units"]["raidpet"]["healPrediction"]["absorbStyle"] = "REVERSED"
	E.db["unitframe"]["units"]["raidpet"]["rdebuffs"]["size"] = 20
	E.db["unitframe"]["units"]["raidpet"]["rdebuffs"]["yOffset"] = 5

	-- Target
	E.db["unitframe"]["units"]["target"]["smartAuraPosition"] = "FLUID_BUFFS_ON_DEBUFFS"
	E.db["unitframe"]["units"]["target"]["buffs"]["anchorPoint"] = "TOP"
	E.db["unitframe"]["units"]["target"]["buffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["target"]["buffs"]["numrows"] = 2
	E.db["unitframe"]["units"]["target"]["buffs"]["perrow"] = 6
	E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["buffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["buffs"]["yOffset"] = -2
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["customColor"]["transparent"] = false
	E.db["unitframe"]["units"]["target"]["castbar"]["reverse"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["height"] = 28
	E.db["unitframe"]["units"]["target"]["castbar"]["iconAttached"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["iconSize"] = 14
	E.db["unitframe"]["units"]["target"]["castbar"]["insideInfoPanel"] = false
	E.db["unitframe"]["units"]["target"]["castbar"]["overlayOnFrame"] = "Power"
	E.db["unitframe"]["units"]["target"]["castbar"]["strataAndLevel"]["frameLevel"] = 128
	E.db["unitframe"]["units"]["target"]["castbar"]["strataAndLevel"]["frameStrata"] = "MEDIUM"
	E.db["unitframe"]["units"]["target"]["castbar"]["strataAndLevel"]["useCustomStrata"] = true
	E.db["unitframe"]["units"]["target"]["castbar"]["xOffsetText"] = 2
	E.db["unitframe"]["units"]["target"]["castbar"]["yOffsetText"] = 1
	E.db["unitframe"]["units"]["target"]["debuffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["target"]["debuffs"]["maxDuration"] = 0
	E.db["unitframe"]["units"]["target"]["debuffs"]["countXOffset"] = 2
	E.db["unitframe"]["units"]["target"]["debuffs"]["countYOffset"] = -3
	E.db["unitframe"]["units"]["target"]["debuffs"]["durationPosition"] = "TOP"
	E.db["unitframe"]["units"]["target"]["debuffs"]["anchorPoint"] = "BOTTOM"
	E.db["unitframe"]["units"]["target"]["debuffs"]["numrows"] = 2
	E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 6
	E.db["unitframe"]["units"]["target"]["debuffs"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["debuffs"]["yOffset"] = -32
	E.db["unitframe"]["units"]["target"]["fader"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["name"]["xOffset"] = 3
	E.db["unitframe"]["units"]["target"]["power"]["height"] = 14
	E.db["unitframe"]["units"]["target"]["power"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["raidicon"]["attachTo"] = "CENTER"

	-- TargetTarget
	E.db["unitframe"]["units"]["targettarget"]["power"]["height"] = 14
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["xOffset"] = 44
	E.db["unitframe"]["units"]["targettarget"]["raidicon"]["yOffset"] = 0

	E:UpdateAll()
	if not silent then
		ElvUI_EltreumUI:Print(L["Healer Layout has been set."])
	end
end
