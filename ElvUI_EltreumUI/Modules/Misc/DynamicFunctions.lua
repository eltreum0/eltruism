local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsInInstance = _G.IsInInstance
local IsAddOnLoaded = _G.IsAddOnLoaded
local hooksecurefunc = _G.hooksecurefunc
local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown
local UnitLevel = _G.UnitLevel
local HasNewMail = _G.HasNewMail
local PlaySoundFile = _G.PlaySoundFile
local C_Timer = _G.C_Timer
local _, instanceType
local level, targetmodel--, playermodel

--character models that should be rotated
local modelsRotate = {
	[118355] = true, --dwarf male
	[118135] = true, --dwarf female
	[1838560] = true, --dwarfmale_hd_sdr.m2
	[1838562] = true, --dwarffemale_hd_sdr.m2
	[878772] = true, --dwarfmale_hd.m2
	[950080] = true, --dwarffemale_hd.m2
	[116921] = true, --"bloodelffemale.m2",
	[1100258] = true, --"bloodelffemale_hd.m2",
	[1839709] = true, --"bloodelffemale_hd_sdr.m2",
	[117170] = true, --"bloodelfmale.m2",
	[1100087] = true, --"bloodelfmale_hd.m2",
	[1853408] = true, --"bloodelfmale_hd_sdr.m2",
	[1890763] = true, --"darkirondwarffemale.m2",
	[1892825] = true, --"darkirondwarffemale_sdr.m2",
	[1890765] = true, --"darkirondwarfmale.m2",
	[1892543] = true, --"darkirondwarfmale_sdr.m2",
	[117437] = true, --"draeneifemale.m2",
	[1022598] = true, --"draeneifemale_hd.m2",
	[1822372] = true, --"draeneifemale_hd_sdr.m2",
	[117721] = true, --"draeneimale.m2",
	[1005887] = true, --"draeneimale_hd.m2",
	[1839253] = true, --"draeneimale_hd_sdr.m2",
	[119063] = true, --"gnomefemale.m2",
	[940356] = true, --"gnomefemale_hd.m2",
	[1838564] = true, --"gnomefemale_hd_sdr.m2",
	[119159] = true, --"gnomemale.m2",
	[900914] = true, --"gnomemale_hd.m2",
	[1838566] = true, --"gnomemale_hd_sdr.m2",
	[119369] = true, --"goblinfemale.m2",
	[1838568] = true, --"goblinfemale_sdr.m2",
	[119376] = true, --"goblinmale.m2",
	[1838570] = true, --"goblinmale_sdr.m2",
	[1630402] = true, --"highmountaintaurenfemale.m2",
	[1859379] = true, --"highmountaintaurenfemale_sdr.m2",
	[1630218] = true, --"highmountaintaurenmale.m2",
	[1858265] = true, --"highmountaintaurenmale_sdr.m2",
	[119563] = true, --"humanfemale.m2",
	[1000764] = true, --"humanfemale_hd.m2",
	[1838572] = true, --"humanfemale_hd_sdr.m2",
	[1842700] = true, --"humanfemale_sdr.m2",
	[119940] = true, --"humanmale.m2",
	[1011653] = true, --"humanmale_hd.m2",
	[1838385] = true, --"humanmale_hd_sdr.m2",
	[1886724] = true, --"kultiranfemale.m2",
	[1721003] = true, --"kultiranmale.m2",
	[1593999] = true, --"lightforgeddraeneifemale.m2",
	[1825438] = true, --"lightforgeddraeneifemale_sdr.m2",
	[1620605] = true, --"lightforgeddraeneimale.m2",
	[1839042] = true, --"lightforgeddraeneimale_sdr.m2",
	[2564806] = true, --"mechagnomefemale.m2",
	[2622502] = true, --"mechagnomemale.m2",
	[1810676] = true, --"nightbornefemale.m2",
	[1858099] = true, --"nightbornefemale_sdr.m2",
	[1814471] = true, --"nightbornemale.m2",
	[1857801] = true, --"nightbornemale_sdr.m2",
	[120590] = true, --"nightelffemale.m2",
	[921844] = true, --"nightelffemale_hd.m2",
	[1838574] = true, --"nightelffemale_hd_sdr.m2",
	[120791] = true, --"nightelfmale.m2",
	[974343] = true, --"nightelfmale_hd.m2",
	[1838576] = true, --"nightelfmale_hd_sdr.m2",
	[121087] = true, --"orcfemale.m2",
	[949470] = true, --"orcfemale_hd.m2",
	[1838580] = true, --"orcfemale_hd_sdr.m2",
	[121287] = true, --"orcmale.m2",
	[917116] = true, --"orcmale_hd.m2",
	[1838578] = true, --"orcmale_hd_sdr.m2",
	[1968587] = true, --"orcmaleupright.m2",
	[1968838] = true, --"orcmaleupright_sdr.m2",
	[1087591] = true, --"orcfemale_hd_shadowmoon.m2",
	[1088030] = true, --"orcmale_hd_shadowmoon.m2",
	[589715] = true, --"pandarenfemale.m2",
	[1853610] = true, --"pandarenfemale_sdr.m2",
	[535052] = true, --"pandarenmale.m2",
	[1853956] = true, --"pandarenmale_sdr.m2",
	[121608] = true, --"scourgefemale.m2",
	[997378] = true, --"scourgefemale_hd.m2",
	[1838582] = true, --"scourgefemale_hd_sdr.m2",
	[121768] = true, --"scourgemale.m2",
	[959310] = true, --"scourgemale_hd.m2",
	[1838584] = true, --"scourgemale_hd_sdr.m2",
	[233878] = true, --"taunkamale.m2",
	[121961] = true, --"taurenfemale.m2",
	[986648] = true, --"taurenfemale_hd.m2",
	[1839008] = true, --"taurenfemale_hd_sdr.m2",
	[122055] = true, --"taurenmale.m2",
	[968705] = true, --"taurenmale_hd.m2",
	[1838586] = true, --"taurenmale_hd_sdr.m2",
	[122414] = true, --"trollfemale.m2",
	[1018060] = true, --"trollfemale_hd.m2",
	[1838588] = true, --"trollfemale_hd_sdr.m2",
	[122560] = true, --"trollmale.m2",
	[1022938] = true, --"trollmale_hd.m2",
	[1838590] = true, --"trollmale_hd_sdr.m2",
	[1733758] = true, --"voidelffemale.m2",
	[1859345] = true, --"voidelffemale_sdr.m2",
	[1734034] = true, --"voidelfmale.m2",
	[1858367] = true, --"voidelfmale_sdr.m2",
	[1890759] = true, --"vulperafemale.m2",
	[1890761] = true, --"vulperamale.m2",
	[307453] = true, --"worgenfemale.m2",
	[1838201] = true, --"worgenfemale_sdr.m2",
	[307454] = true, --"worgenmale.m2",
	[1838592] = true, --"worgenmale_sdr.m2",
	[1662187] = true, --"zandalaritrollfemale.m2",
	[1894572] = true, --"zandalaritrollfemale_sdr.m2",
	[1630447] = true, --"zandalaritrollmale.m2",
	[1900779] = true, --"zandalaritrollmale_sdr.m2",

	--others
	[117400] = true, --"brokenfemale.m2",
	[117412] = true, --"brokenmale.m2",
	[118652] = true, --"felorcfemale.m2",
	[118653] = true, --"felorcmale.m2",
	[118654] = true, --"felorcmaleaxe.m2",
	[118667] = true, --"felorcmalesword.m2",
	[118798] = true, --"foresttrollmale.m2",
	[232863] = true, --"icetrollmale.m2",
	[121941] = true, --"skeletonfemale.m2",
	[121942] = true, --"skeletonmale.m2",
	[1793470] = true, --"thinhumanmale.m2",
	[122738] = true, --"tuskarrmale.m2",
	[234884] = true, --"undeadicetroll.m2",,
	[1272625] = true, --""druidbear2_artifact1.m2",
	[1272606] = true, --""druidbear2_artifact2.m2",
	[1272605] = true, --""druidbear2_artifact3.m2",
	[1272604] = true, --""druidbear2_artifact4.m2",
	[1272741] = true, --""druidbear2_artifact5.m2",
	[1505169] = true, --""druidbear2_artifact6.m2",
	[3013816] = true, --"automatonbrute.m2",
	[3196574] = true, --"denathrius.m2",
	[3487358] = true, --"maldraxxusskeleton.m2",
	[3542807] = true, --"maldraxxusgladiatorfemale.m2",
	[3284341] = true, --"maldraxxusgladiator.m2",
	[125092] = true, --"necromancer.m2",
	[3087468] = true, --"necromancer2.m2",
	[3570847] = true, --"maldraxxusdraka.m2",
	[3256097] = true, --"bolvar.m2",
	[122965] = true, --"arthas.m2",
	[122971] = true, --"arthasundead.m2",
	[337875] = true, --"jaina.m2",
	[646095] = true, --"jaina2.m2",
	[1717164] = true, --"jaina3.m2",
	[447138] = true, --"shaman_thrall.m2",
	[1881902] = true, --"thrall.m2",
	[962097] = true, --"thralldoomplate.m2",
	[1035532] = true, --"thralldoomplate_noballs.m2",
	[3952870] = true, --"thrallshadowlands.m2",
	[536149] = true, --"tyrande.m2",
	[2266826] = true, --"tyrande2",
	[4198151] = true, --"tyrande3.m2",
	[234701] = true, --"ladysylvanaswindrunner.m2",
	[1245874] = true, --"sylvanas.m2",
	[3948222] = true, --"sylvanasbanshee.m2",
	[3221727] = true, --"sylvanasshadowlands.m2",
	[3996207] = true, --"mawnecromancerboss.m2",
	[1246857] = true, --"genngreymane.m2",
	[1466597] = true, --"genngreymaneworgen.m2",
	[1817113] = true, --"genngreymaneworgen2.m2",
	[3527746] = true, --"attendantoribos.m2",
	[3257514] = true, --"faunfemale.m2",
	[3063200] = true, --"faunmale.m2",
	[2173913] = true, --"boralusguard_f.m2",
	[2173917] = true, --"boralusguard_ktf.m2",
	[2173915] = true, --"boralusguard_ktm.m2",
	[2173911] = true, --"boralusguard_m.m2",
	[234599] = true, --"earthendwarf.m2",
	[407377] = true, --"earthendwarf_low.m2",
	[1024776] = true, --"khadgar2.m2",
	[124659] = true, --"kalecgos.m2",
	[579571] = true, --"jinyu.m2",
	[1611191] = true, --"turalyon.m2",
	[125263] = true, --"ogre.m2",
	[125264] = true, --"ogremage.m2",
	[125293] = true, --"ogrewarlord.m2",
	[125300] = true, --"ogre02.m2",
	[930099] = true, --"ogredraenor.m2",
	[1039724] = true, --"ogredraenorbutcher.m2",
	[976839] = true, --"ogrefelbreaker.m2",
	[1027992] = true, --"ogrehighmaulking.m2",
	[125313] = true, --"ogreking.m2",
	[125317] = true, --"ogremage02.m2",
	[125336] = true, --"ogremagelord.m2",
	[3545238] = true, --"ogrenecromancer.m2",
	[1956660] = true, --"ogrepirate.m2",
	[1687797] = true, --"titanargus.m2",
	[790332] = true, --"beholdereye.m2",
	[962079] = true, --"elekkdraenor.m2",
	[942697] = true, --"talbukdraenor.m2",
	[126235] = true, --"tripod.m2",
	[986699] = true, --"arakkoa2.m2",
	[1020934] = true, --"shatteredhandcaster.m2",
	[1020938] = true, --"shatteredhandmelee.m2",
	[125869] = true, --"shivan.m2",
	[642804] = true, --"shivan_pet.m2",
	[1570675] = true, --"shivan2.m2",
	[1617431] = true, --"shivanpriestessfel.m2",
	[1617445] = true, --"shivanpriestessfire.m2",
	[1617446] = true, --"shivanpriestessfrost.m2",
	[1617447] = true, --"shivanpriestessshadow.m2",
	[1042731] = true, --"infestedorc.m2",
	[898014] = true, --"ordos.m2",
	[577035] = true, --"yaunka.m2",
	[588373] = true, --"spikysprite.m2",
	[576676] = true, --"mogu.m2",
	[613021] = true, --"moguking.m2",
	[666357] = true, --"mogulieutenant.m2",
	[625293] = true, --"pandarenmalekid_basic.m2",
	[653173] = true, --"pandarenmalekid.m2",
	[328267] = true, --"pandarenmonk.m2",
	[652330] = true, --"pandarenfemalekid.m2",
	[647984] = true, --"lili.m2",
	[648647] = true, --"chenstormstout.m2",
	[123247] = true, --"clockworkgnome.m2",
	[123248] = true, --"clockworkgnome_a.m2",
	[123249] = true, --"clockworkgnome_b.m2",
	[123250] = true, --"clockworkgnome_c.m2",
	[123251] = true, --"clockworkgnome_d.m2",
	[234666] = true, --"irondwarf.m2",
	[250585] = true, --"irondwarf_low01.m2",
	[250586] = true, --"irondwarf_low02.m2",
}

--these are humanoids that should be 0
--[[local modelsNoRotate = {
	[122815] = true, --"vrykulmale.m2",
	[234622] = true, --"frostvrykulmale.m2",
	[234679] = true, --"ironvrykulmale.m2",
	[234834] = true, --"seavrykulmale.m2",
	[234835] = true, --"seavrykulmale_a.m2",
	[234842] = true, --"seavrykulmaleoarsman.m2",
	[234919] = true, --"vrykulfemalecaster.m2",
	[234902] = true, --"femalevrykulboss.m2",
	[234907] = true, --"frostvrykulfemalecaster.m2",
	[234908] = true, -- "frostvrykulfemaledruid.m2",
	[234914] = true, --"frostvrykulfemalehunter.m2",
	[234918] = true, --"frostvrykulfemalewarrior.m2",
	[126397] = true, --"vrykulfemale.m2",
	[234926] = true, --"vrykulfemaledruid.m2",
	[234933] = true, --"vrykulfemalehunter.m2",
	[234946] = true, --"vrykulfemalewarrior.m2",
}]]

--set portrait rotation based on target being npc or not
function ElvUI_EltreumUI:DynamicUFPortraitRotation()
	if E.db.ElvUI_EltreumUI.unitframes.portraitfix and E.private.unitframe.enable then

		if E.db.unitframe.units.target.portrait.enable and E.db.unitframe.units.target.portrait.style == "3D" then
			if UnitExists("target") and _G["ElvUF_Target"] then
				E:Delay(0, function()

					--get the model id
					if _G["ElvUF_Target"].Portrait3D then
						targetmodel = _G["ElvUF_Target"].Portrait3D:GetModelFileID()

						--fix camera rotation
						if modelsRotate[targetmodel]then
							E.db["unitframe"]["units"]["target"]["portrait"]["rotation"] = 291
						--elseif modelsNoRotate[targetmodel] then
							--E.db["unitframe"]["units"]["target"]["portrait"]["rotation"] = 0
						--elseif UnitCreatureType("target") == "Humanoid" then --TODO CHECK MORE MODELS
							--E.db["unitframe"]["units"]["target"]["portrait"]["rotation"] = 291
						else
							E.db["unitframe"]["units"]["target"]["portrait"]["rotation"] = 0
						end
					end

					--pause if dead
					if UnitIsDead("target") then
						E.db["unitframe"]["units"]["target"]["portrait"]["paused"] = true
						E.db["unitframe"]["units"]["target"]["portrait"]["desaturation"] = 1
					else
						E.db["unitframe"]["units"]["target"]["portrait"]["paused"] = false
						E.db["unitframe"]["units"]["target"]["portrait"]["desaturation"] = 0
					end

					--force update portrait
					if _G["ElvUF_Target"].Portrait3D then
						_G["ElvUF_Target"].Portrait3D:ForceUpdate()
					end
				end)
			end
		end
		--maybe player fix?
		--[[if E.db.unitframe.units.player.portrait.enable and E.db.unitframe.units.player.portrait.style == "3D" then
			if _G["ElvUF_Player"] then
				E:Delay(0, function()

					--get the model id
					if _G["ElvUF_Player"].Portrait3D then
						playermodel = _G["ElvUF_Player"].Portrait3D:GetModelFileID()
					else
						playermodel = "NotYetObtained"
					end

					--fix camera rotation
					if playermodel and playermodel ~= "NotYetObtained" then
						if modelsRotate[playermodel] and not modelsNoRotate[playermodel] then
							E.db["unitframe"]["units"]["player"]["portrait"]["rotation"] = 0
						elseif UnitCreatureType("player") == "Humanoid" then
							E.db["unitframe"]["units"]["player"]["portrait"]["rotation"] = 0
						else
							E.db["unitframe"]["units"]["player"]["portrait"]["rotation"] = 291
						end
					else
						if UnitCreatureType("player") == "Humanoid" then
							E.db["unitframe"]["units"]["player"]["portrait"]["rotation"] = 0
						else
							E.db["unitframe"]["units"]["player"]["portrait"]["rotation"] = 291
						end
					end

					--pause if dead
					if UnitIsDead("player") then
						E.db["unitframe"]["units"]["player"]["portrait"]["paused"] = true
						E.db["unitframe"]["units"]["player"]["portrait"]["desaturation"] = 1
					else
						E.db["unitframe"]["units"]["player"]["portrait"]["paused"] = false
						E.db["unitframe"]["units"]["player"]["portrait"]["desaturation"] = 0
					end

					--force update portrait
					if _G["ElvUF_Player"].Portrait3D then
						_G["ElvUF_Player"].Portrait3D:ForceUpdate()
					end
				end)
			end
		end]]

	end
end

--check for druid things, ofc
local shapeshiftcheck = CreateFrame("FRAME")
shapeshiftcheck:RegisterUnitEvent("UNIT_MODEL_CHANGED", "target")
--shapeshiftcheck:RegisterUnitEvent("UNIT_MODEL_CHANGED", "player")
shapeshiftcheck:SetScript("OnEvent", function()
	ElvUI_EltreumUI:DynamicUFPortraitRotation()
end)

--fixed cooldown text to be class color
function ElvUI_EltreumUI:CooldownColors()
	if E.db.ElvUI_EltreumUI.skins.classcolorcooldowns then
		local valuecolors = E:ClassColor(E.myclass, true)
		E.db["cooldown"]["daysIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["daysIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["daysIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["hhmmColorIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["hhmmColorIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["hhmmColorIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["hoursIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["hoursIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["hoursIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["minutesIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["minutesIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["minutesIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["mmssColorIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["mmssColorIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["mmssColorIndicator"]["r"] = valuecolors.r
		E.db["cooldown"]["secondsIndicator"]["b"] = valuecolors.b
		E.db["cooldown"]["secondsIndicator"]["g"] = valuecolors.g
		E.db["cooldown"]["secondsIndicator"]["r"] = valuecolors.r
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["b"] = valuecolors.b
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["g"] = valuecolors.g
		E.db["actionbar"]["cooldown"]["targetAuraIndicator"]["r"] = valuecolors.r

		E:UpdateCooldownSettings('all')
	end
end

--hide raid/party frames in bgs bc of battlegroundenemies or similar
function ElvUI_EltreumUI:BattlegroundGroupUnitframes()
	if E.db.ElvUI_EltreumUI.unitframes.bgunitframes and E.private.unitframe.enable then
		_, instanceType = IsInInstance()
		if instanceType == "pvp" then
			E.db["unitframe"]["units"]["party"]["visibility"] = "hide"
			E.db["unitframe"]["units"]["raid1"]["visibility"] = "hide"
			E.db["unitframe"]["units"]["raid2"]["visibility"] = "hide"
			E.db["unitframe"]["units"]["raid3"]["visibility"] = "hide"
		elseif E.Retail and IsAddOnLoaded('GladiusEx') and instanceType == "arena" then
			E.db["unitframe"]["units"]["party"]["visibility"] = "hide"
		else
			E.db["unitframe"]["units"]["party"]["visibility"] = "[@raid6,exists][nogroup] hide;show"
			E.db["unitframe"]["units"]["raid1"]["visibility"] = "[@raid6,noexists][@raid21,exists] hide;show"
			E.db["unitframe"]["units"]["raid2"]["visibility"] = "[@raid21,noexists][@raid31,exists] hide;show"
			E.db["unitframe"]["units"]["raid3"]["visibility"] = "[@raid31,noexists] hide;show"
		end

		--E:StaggeredUpdateAll(nil, true)
		E:UpdateUnitFrames()
	end
end

--hide elvui arena frames in arena bc of addons like gladius, but show in bgs bc of flag carriers
function ElvUI_EltreumUI:ArenaUnitframes()
	if E.db.ElvUI_EltreumUI.unitframes.arenaunitframes and E.private.unitframe.enable then
		_, instanceType = IsInInstance()
		if instanceType == "arena" then
			_G["ElvUF_Arena1"]:Hide()
			_G["ElvUF_Arena2"]:Hide()
			_G["ElvUF_Arena3"]:Hide()
			_G["ElvUF_Arena4"]:Hide()
			--ConsoleExec("ElvUF_Arena4:Hide()")
			_G["ElvUF_Arena5"]:Hide()
		end
	end
end

--show/hide buffs if in arena or not
function ElvUI_EltreumUI:DynamicBuffs()
	if E.db.ElvUI_EltreumUI.unitframes.arenabuffs and E.private.unitframe.enable and not InCombatLockdown() then
		_, instanceType = IsInInstance()
		if instanceType == "arena" or instanceType == "pvp" then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["enable"] = true
			E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = true
			ElvUI_EltreumUI:Print(L["Buffs have been updated for Arenas"])
		elseif instanceType == "none" then
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["buffs"]["enable"] = false
			E.db["unitframe"]["units"]["target"]["buffs"]["enable"] = false
			ElvUI_EltreumUI:Print(L["Buffs have been updated for Open World"])
		end
	end
end

--Dynamically datatext swap based on player class
function ElvUI_EltreumUI:DynamicClassicDatatext()
	if E.db.ElvUI_EltreumUI.otherstuff.dynamicdatatext then
		if not E.db.movers then E.db.movers = {} end
		if E.myclass == 'HUNTER' or E.myclass == 'WARLOCK' then
			E.db["datatexts"]["panels"]["LeftChatDataPanel"][1] = "Eltruism Ammo"
			if E.db["datatexts"]["panels"]["EltruismDataText"] then
				E.db["datatexts"]["panels"]["EltruismDataText"][1] = "Eltruism Ammo"
			end
		end
	end
end

--Dynamic Level Nameplate Style Filter
function ElvUI_EltreumUI:DynamicLevelStyleFilter()
	if E.db.ElvUI_EltreumUI.nameplates.nameplatelevel and E.db.nameplates.filters.EltreumLevel and not InCombatLockdown() then
		if not E.private.ElvUI_EltreumUI.install_version then
			return
		else
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "TOPRIGHT"
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = -6
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -13
			E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = ""
			E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = ""
			E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "TOPRIGHT"
			E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = -6
			E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -13

			level = UnitLevel("player")
			if E.Classic or E.Retail then
				if level < 60 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = true
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = ""
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "TOPRIGHT"
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = -6
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -13
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = ""
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "TOPRIGHT"
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = -6
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -13
					end
				elseif level == 60 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = "[eltruism:targetcast:indicator]"
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "CENTER"
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = 0
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -28
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = "[eltruism:targetcast:indicator]"
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "CENTER"
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = 0
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -28
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = ""
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = ""
					end
				end
			elseif E.TBC then
				if level < 70 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = true
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = ""
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "TOPRIGHT"
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = -6
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -13
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = ""
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "TOPRIGHT"
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = -6
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -13
					end
				elseif level == 70 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = "[eltruism:targetcast:indicator]"
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "CENTER"
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = 0
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -28
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = "[eltruism:targetcast:indicator]"
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "CENTER"
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = 0
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -28
					end
				end
			elseif E.Wrath then
				if level < 80 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = true
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = ""
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "TOPRIGHT"
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = -6
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -13
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = ""
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "TOPRIGHT"
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = -6
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -13
					end
				elseif level == 80 then
					if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
						E.db["nameplates"]["filters"]["EltreumLevel"]["triggers"]["enable"] = false
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["format"] = "[eltruism:targetcast:indicator]"
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["position"] = "CENTER"
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["xOffset"] = 0
						--E.db["nameplates"]["units"]["ENEMY_PLAYER"]["level"]["yOffset"] = -28
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["format"] = "[eltruism:targetcast:indicator]"
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["position"] = "CENTER"
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["xOffset"] = 0
						--E.db["nameplates"]["units"]["ENEMY_NPC"]["level"]["yOffset"] = -28
					end
				end
			end
			E:UpdateNamePlates()
		end
	end
end

--Dynamic Spellsteal Nameplate Style Filter
function ElvUI_EltreumUI:DynamicSpellStealStyleFilter()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	else
		if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" and E.db.nameplates.filters.EltreumSpellsteal and not InCombatLockdown() then
			if E.Wrath or E.TBC or E.Retail then
				if E.myclass == 'MAGE' then
					level = UnitLevel("player")
					if E.Retail then
						if level >= 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
						elseif level < 39 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
						end
					elseif E.Wrath or E.TBC then
						if level >= 70 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = true
						elseif level < 70 then
							E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
						end
					end
				else
					E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
				end
			elseif E.Classic then
				if E.private.ElvUI_EltreumUI.install_version >= "2.2.5" then
					E.db["nameplates"]["filters"]["EltreumSpellsteal"]["triggers"]["enable"] = false
				end
			end
			E:UpdateNamePlates()
		end
	end
end

--swap bar1 and bar4 action paging / visibility
function ElvUI_EltreumUI:ActionPagingSwap()
	if E.private.actionbar.enable then
		if E.db.actionbar.bar1.visibility == "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show" then
			E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; show;"
			E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar1"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10; [vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;" --azilroka changed to [bonusbar:2] 10 from [bonusbar:2] 8
			E.db["actionbar"]["bar1"]["paging"]["HUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["MAGE"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["MONK"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = "[bonusbar:1] 7;[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:2] 8;[bonusbar:5] 11;" --other other besides this was causing problems with shadow dance
			E.db["actionbar"]["bar1"]["paging"]["SHAMAN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["WARLOCK"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[form:1] 7;[bonusbar:5] 11;"
			E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			if not E.Retail then
				E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11; [stance:1] 7; [stance:2] 8; [stance:3] 9;"
				E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11; [bonusbar:1] 7;"
			end
			E.db["actionbar"]["bar4"]["paging"]["DEATHKNIGHT"] = ""
			E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] = ""
			E.db["actionbar"]["bar4"]["paging"]["DRUID"] = ""
			E.db["actionbar"]["bar4"]["paging"]["HUNTER"] = ""
			E.db["actionbar"]["bar4"]["paging"]["MAGE"] = ""
			E.db["actionbar"]["bar4"]["paging"]["MONK"] = ""
			E.db["actionbar"]["bar4"]["paging"]["PALADIN"] = ""
			E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = ""
			E.db["actionbar"]["bar4"]["paging"]["ROGUE"] = ""
			E.db["actionbar"]["bar4"]["paging"]["SHAMAN"] = ""
			E.db["actionbar"]["bar4"]["paging"]["WARLOCK"] = ""
			E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = ""
		elseif E.db.actionbar.bar4.visibility == "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show" then
			E.db["actionbar"]["bar1"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [possessbar] hide; [petbattle] hide; show"
			E.db["actionbar"]["bar4"]["visibility"] = "[vehicleui] show; [overridebar] show; [possessbar] show; show;"

			E.db["actionbar"]["bar4"]["paging"]["DEATHKNIGHT"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["DEMONHUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["DRUID"] = "[bonusbar:1,nostealth] 7; [bonusbar:1,stealth] 8; [bonusbar:2] 10; [bonusbar:3] 9; [bonusbar:4] 10; [vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["HUNTER"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["MAGE"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["MONK"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["PALADIN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["ROGUE"] = "[bonusbar:1,nostealth] 4; [bonusbar:1,stealth] 7; [vehicleui] 12; [overridebar] 14; [possessbar] 12; [bonusbar:1] 7;[bonusbar:2] 8;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["SHAMAN"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["WARLOCK"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[form:1] 7;[bonusbar:5] 11;"
			E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;"
			if not E.Retail then
				E.db["actionbar"]["bar4"]["paging"]["WARRIOR"] = "[vehicleui] 12; [overridebar] 14;[possessbar] 12;[bonusbar:5] 11;[stance:1] 7;  [stance:2] 8; [stance:3] 9;"
				E.db["actionbar"]["bar4"]["paging"]["PRIEST"] = "[vehicleui] 12; [overridebar] 14; [possessbar] 12;[bonusbar:5] 11; [bonusbar:1] 7;"
			end
			E.db["actionbar"]["bar1"]["paging"]["DEATHKNIGHT"] = ""
			E.db["actionbar"]["bar1"]["paging"]["DEMONHUNTER"] = ""
			E.db["actionbar"]["bar1"]["paging"]["DRUID"] = ""
			E.db["actionbar"]["bar1"]["paging"]["HUNTER"] = ""
			E.db["actionbar"]["bar1"]["paging"]["MAGE"] = ""
			E.db["actionbar"]["bar1"]["paging"]["MONK"] = ""
			E.db["actionbar"]["bar1"]["paging"]["PALADIN"] = ""
			E.db["actionbar"]["bar1"]["paging"]["PRIEST"] = ""
			E.db["actionbar"]["bar1"]["paging"]["ROGUE"] = ""
			E.db["actionbar"]["bar1"]["paging"]["SHAMAN"] = ""
			E.db["actionbar"]["bar1"]["paging"]["WARLOCK"] = ""
			E.db["actionbar"]["bar1"]["paging"]["WARRIOR"] = ""
		end
	end
end

--fix master loot?
if E.Wrath or E.TBC then
	hooksecurefunc(_G.MasterLooterFrame, 'Hide', function(self)
		self:ClearAllPoints()
	end)
end

-- Inspired by Luckyone's performance option. Thanks Luckyone!
function ElvUI_EltreumUI:EmptyDetailsTable()
	if IsAddOnLoaded('Details') then
		_detalhes.encounter_spell_pool = {}
		_detalhes.npcid_pool = {}
		_detalhes.spell_pool = {}
		_detalhes.spell_school_cache = {}
		_detalhes.boss_mods_timers = {}

		ElvUI_EltreumUI:Print("Details tables were cleared")
	else
		ElvUI_EltreumUI:Print("Details is not loaded or enabled")
	end
end

--Dynamic Experience Bar Mouseover
function ElvUI_EltreumUI:DynamicExperienceDatabar()
	if not E.private.ElvUI_EltreumUI.install_version then
		return
	else
		level = UnitLevel("player")
		if E.db.ElvUI_EltreumUI.otherstuff.dynamicxpbar then
			if E.Retail or E.Classic then
				if level < 60 then
					E.db.databars.experience.mouseover = false
					E.db.databars.experience.enable = true
				elseif level == 60 then
					E.db.databars.experience.mouseover = true
					E.db.databars.experience.enable = false
				end
			elseif E.TBC then
				if level < 70 then
					E.db.databars.experience.mouseover = false
					E.db.databars.experience.enable = true
				elseif level == 70 then
					E.db.databars.experience.mouseover = true
					E.db.databars.experience.enable = false
				end
			elseif E.Wrath then
				if level < 80 then
					E.db.databars.experience.mouseover = false
					E.db.databars.experience.enable = true
				elseif level == 80 then
					E.db.databars.experience.mouseover = true
					E.db.databars.experience.enable = false
				end
			end
			E:UpdateDataBars()
		end
	end
end

--chat without backdrop
function ElvUI_EltreumUI:TransparentChat()
	E.db["chat"]["fadeUndockedTabs"] = true
	E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
	E.db["chat"]["panelTabTransparency"] = true
	E.db["chat"]["fadeTabsNoBackdrop"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = false
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = false
	if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
		E.db["datatexts"]["panels"]["EltruismDataText"]["backdrop"] = false
		E.db["datatexts"]["panels"]["EltruismDataText"]["panelTransparency"] = false
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["backdrop"] = false
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["panelTransparency"] = false
	end

	E:UpdateChat()
	E:UpdateLayout()
	E:UpdateDataBars()
	E:UpdateDataTexts()
	--E:StaggeredUpdateAll()

	if _G["EltruismRightChatShadowFrame"] then
		_G["EltruismRightChatShadowFrame"]:Hide()
	end
	if _G["EltruismLeftChatShadowFrame"] then
		_G["EltruismLeftChatShadowFrame"]:Hide()
	end

	--show the chat buttons because they are attached to the chat datatext not panel
	_G.LeftChatToggleButton:SetAlpha(1)
	_G.LeftChatToggleButton:Show()
	_G.RightChatToggleButton:SetAlpha(1)
	_G.RightChatToggleButton:Show()

	ElvUI_EltreumUI:Print("Chat set to Transparent mode")
end

--chat with backdrop
function ElvUI_EltreumUI:DarkChat()
	E.db["chat"]["fadeUndockedTabs"] = false
	E.db["chat"]["panelBackdrop"] = "SHOWBOTH"
	E.db["chat"]["panelTabTransparency"] = false
	E.db["chat"]["fadeTabsNoBackdrop"] = false
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["backdrop"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["panelTransparency"] = true
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["backdrop"] = true
	if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
		E.db["datatexts"]["panels"]["EltruismDataText"]["backdrop"] = true
		E.db["datatexts"]["panels"]["EltruismDataText"]["panelTransparency"] = true
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["backdrop"] = true
		E.global["datatexts"]["customPanels"]["EltruismDataText"]["panelTransparency"] = true
	end

	E:UpdateChat()
	E:UpdateLayout()
	E:UpdateDataBars()
	E:UpdateDataTexts()
	--E:StaggeredUpdateAll()

	if _G["EltruismRightChatShadowFrame"] then
		_G["EltruismRightChatShadowFrame"]:Show()
	end
	if _G["EltruismLeftChatShadowFrame"] then
		_G["EltruismLeftChatShadowFrame"]:Show()
	end

	--show the chat buttons because they are attached to the chat datatext not panel
	_G.LeftChatToggleButton:SetAlpha(1)
	_G.LeftChatToggleButton:Show()
	_G.RightChatToggleButton:SetAlpha(1)
	_G.RightChatToggleButton:Show()

	ElvUI_EltreumUI:Print("Chat set to Dark mode")
end

--automatically adjust things if borders is enabled
function ElvUI_EltreumUI:BorderAdjust()
	if E.db.ElvUI_EltreumUI.borders.borderautoadjust then
		--if not using one of my profiles then disable auto adjust to prevent overwriting settings and return
		if E.private.ElvUI_EltreumUI.install_version and not (ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") or ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer")) then
			E.db.ElvUI_EltreumUI.borders.borderautoadjust = false
		else
			local width = GetPhysicalScreenSize()
			if E.db.ElvUI_EltreumUI.borders.borders then
				if not E.db.movers then E.db.movers = {} end

				--transparency doesnt work well with borders due to the .backdrop/twopixels thing on UF
				E.db.ElvUI_EltreumUI.unitframes.ufcustomtexture.backdropalpha = 1

				--general border settings for both profiles
				E.db.ElvUI_EltreumUI.borders.texture = "Eltreum-Border-1"
				--E.db.ElvUI_EltreumUI.borders.classcolor = true
				E.db.ElvUI_EltreumUI.borders.auraborder = true
				E.db.ElvUI_EltreumUI.borders.aurasizex = 54
				E.db.ElvUI_EltreumUI.borders.aurasizey = 54
				E.db.ElvUI_EltreumUI.borders.chatborder = true
				E.db.ElvUI_EltreumUI.borders.leftchatborderx = 432
				if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
					E.db.ElvUI_EltreumUI.borders.leftchatbordery = 201
					E.db.ElvUI_EltreumUI.borders.rightchatbordery = 201
				else
					E.db.ElvUI_EltreumUI.borders.leftchatbordery = 224
					E.db.ElvUI_EltreumUI.borders.rightchatbordery = 224
				end
				E.db.ElvUI_EltreumUI.borders.rightchatborderx = 432
				E.db.ElvUI_EltreumUI.borders.partyborders = true
				E.db.ElvUI_EltreumUI.borders.raidborders = true
				E.db.ElvUI_EltreumUI.borders.playertargetsize = 20
				E.db.ElvUI_EltreumUI.borders.baredgesize = 13
				E.db.ElvUI_EltreumUI.borders.playertargetcastsize = 20
				E.db.ElvUI_EltreumUI.borders.petsize = 20
				E.db.ElvUI_EltreumUI.borders.totembar = true
				E.db.ElvUI_EltreumUI.borders.groupsize = 14
				E.db.ElvUI_EltreumUI.borders.focussize = 20
				E.db.ElvUI_EltreumUI.borders.bosssize = 20
				E.db.ElvUI_EltreumUI.borders.minimapsize = 15
				E.db.ElvUI_EltreumUI.borders.chatsize = 13
				E.db.ElvUI_EltreumUI.borders.aurasize = 13
				E.db.ElvUI_EltreumUI.borders.powerbarborder = false
				E.db.ElvUI_EltreumUI.borders.powerbarsize = 4
				E.db.ElvUI_EltreumUI.borders.xpowerbar = 138.8
				E.db.ElvUI_EltreumUI.borders.ypowerbar = 12
				E.db.ElvUI_EltreumUI.borders.minimapborder = true
				E.db.ElvUI_EltreumUI.borders.petborder = true
				E.db.ElvUI_EltreumUI.borders.petsizex = 188
				E.db.ElvUI_EltreumUI.borders.playerborder = true
				E.db.ElvUI_EltreumUI.borders.xplayer = 302
				E.db.ElvUI_EltreumUI.borders.yplayer = 75
				E.db.ElvUI_EltreumUI.borders.playercastborder = true
				E.db.ElvUI_EltreumUI.borders.yplayercast = 58
				E.db.ElvUI_EltreumUI.borders.targetborder = true
				E.db.ElvUI_EltreumUI.borders.xtarget = 302.8
				E.db.ElvUI_EltreumUI.borders.ytarget = 75
				E.db.ElvUI_EltreumUI.borders.targetcastborder = true
				E.db.ElvUI_EltreumUI.borders.xcasttarget = 272
				E.db.ElvUI_EltreumUI.borders.ycasttarget = 58
				E.db.ElvUI_EltreumUI.borders.targettargetborder = true
				E.db.ElvUI_EltreumUI.borders.ytargettarget = 75
				E.db.ElvUI_EltreumUI.borders.focusborder = true
				E.db.ElvUI_EltreumUI.borders.xfocus = 224
				E.db.ElvUI_EltreumUI.borders.yfocus = 72
				E.db.ElvUI_EltreumUI.borders.bossborder = true
				E.db.ElvUI_EltreumUI.borders.minimapsizex = 225
				E.db.ElvUI_EltreumUI.borders.focuscastborder = true
				E.db.ElvUI_EltreumUI.borders.xcastfocus = 365
				E.db.ElvUI_EltreumUI.borders.ycastfocus = 62

				if E.db.datatexts.panels.MinimapPanel.backdrop == false or E.db.datatexts.panels.MinimapPanel.enable == false then
					E.db.ElvUI_EltreumUI.borders.minimapsizey = 225
				else
					E.db.ElvUI_EltreumUI.borders.minimapsizey = 247
				end
				E.db.ElvUI_EltreumUI.borders.stancexborder = 49
				E.db.ElvUI_EltreumUI.borders.stanceyborder = 42
				E.db.ElvUI_EltreumUI.borders.petactionedgesize = 13
				E.db["actionbar"]["stanceBar"]["buttonSpacing"] = 5
				if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
					E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,22"
					E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,22"
				else
					E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,-1"
					E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,1,-1"
				end
				E.db["movers"]["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-4"

				if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") then

					if not E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
						E.db["actionbar"]["bar1"]["buttonSpacing"] = 4
						E.db["actionbar"]["bar2"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar3"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar4"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar5"]["buttonSpacing"] = 5
						E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,221"
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,187"
						E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,154"
						E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,121"
						E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 65
						E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 50
						E.db["ElvUI_EltreumUI"]["borders"]["bar3xborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar3yborder"] = 50
						E.db["ElvUI_EltreumUI"]["borders"]["bar4xborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar4yborder"] = 50
						E.db["ElvUI_EltreumUI"]["borders"]["bar5xborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar5yborder"] = 50
					else
						E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 62
						E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 62
						E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 56
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,260"
					end

					if E.db.ElvUI_EltreumUI.otherstuff.alternativegroups == false then
						E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4"
						E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4"
						E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4"
						E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 7
						E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 3
						E.db["unitframe"]["units"]["raid2"]["verticalSpacing"] = 6
						E.db["unitframe"]["units"]["raid2"]["groupsPerRowCol"] = 3
						E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 6
						E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 3
					end
					E.db["ElvUI_EltreumUI"]["borders"]["xplayercast"] = 272
					E.db["ElvUI_EltreumUI"]["borders"]["xtargettarget"] = 132.8

					E.db.ElvUI_EltreumUI.borders.partysizex = 222
					E.db.ElvUI_EltreumUI.borders.partysizey = 98

					E.db.ElvUI_EltreumUI.borders.raidsizex = 140
					E.db.ElvUI_EltreumUI.borders.raidsizey = 61
					E.db.ElvUI_EltreumUI.borders.raid2sizex = 141
					E.db.ElvUI_EltreumUI.borders.raid2sizey = 62
					E.db.ElvUI_EltreumUI.borders.raid40sizex = 143
					E.db.ElvUI_EltreumUI.borders.raid40sizey = 61

					E.db.ElvUI_EltreumUI.borders.xboss = 250
					E.db.ElvUI_EltreumUI.borders.yboss = 87
					E.db.ElvUI_EltreumUI.borders.xcasttarget = 272
					E.db.ElvUI_EltreumUI.borders.ycasttarget = 58
					E.db.ElvUI_EltreumUI.borders.petsizex = 192
					E.db.ElvUI_EltreumUI.borders.totemxborder = 44
					E.db.ElvUI_EltreumUI.borders.totemyborder = 44
					E.db.ElvUI_EltreumUI.borders.petactionxborder = 49
					E.db.ElvUI_EltreumUI.borders.petactionyborder = 44

					if E.Wrath then
						E.db["actionbar"]["totemBar"]["spacing"] = 5
						E.db["movers"]["TotemBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,94"
					end
					if not E.Retail then
						E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,97"
					end
				elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
					if not E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
						E.db["actionbar"]["bar1"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar2"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar3"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar4"]["buttonSpacing"] = 5
						E.db["actionbar"]["bar5"]["buttonSpacing"] = 5
						E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,307"
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,278"
						E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,311,249"
						E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,249"
						E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-311,249"
						E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,-303,309"
						if width == 1920 then
							E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,307"
							E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,278"
							E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,320,248"
							E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,249"
							E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-320,248"
							E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,-303,309"
						end
					else
						E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 62
						E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 56
						E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 62
						E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 56
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,260"
					end
					E.db["ElvUI_EltreumUI"]["borders"]["xplayercast"] = 294
					E.db["ElvUI_EltreumUI"]["borders"]["xtargettarget"] = 162
					E.db["ElvUI_EltreumUI"]["borders"]["bar1xborder"] = 61
					E.db["ElvUI_EltreumUI"]["borders"]["bar1yborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar2xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar2yborder"] = 46
					E.db["ElvUI_EltreumUI"]["borders"]["bar3xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar3yborder"] = 46
					E.db["ElvUI_EltreumUI"]["borders"]["bar4xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar4yborder"] = 46
					E.db["ElvUI_EltreumUI"]["borders"]["bar5xborder"] = 51
					E.db["ElvUI_EltreumUI"]["borders"]["bar5yborder"] = 46
					E.db.ElvUI_EltreumUI.borders.partysizex = 173
					E.db.ElvUI_EltreumUI.borders.partysizey = 98
					E.db.ElvUI_EltreumUI.borders.raidsizex = 182
					E.db.ElvUI_EltreumUI.borders.raidsizey = 63
					E.db.ElvUI_EltreumUI.borders.raid2sizex = 152
					E.db.ElvUI_EltreumUI.borders.raid2sizey = 62
					E.db.ElvUI_EltreumUI.borders.raid40sizex = 122
					E.db.ElvUI_EltreumUI.borders.raid40sizey = 63
					E.db.ElvUI_EltreumUI.borders.xboss = 248
					E.db.ElvUI_EltreumUI.borders.yboss = 78
					E.db.ElvUI_EltreumUI.borders.xcasttarget = 296
					E.db.ElvUI_EltreumUI.borders.ycasttarget = 58
					E.db.ElvUI_EltreumUI.borders.petsizex = 130
					E.db.ElvUI_EltreumUI.borders.totemxborder = 44
					E.db.ElvUI_EltreumUI.borders.totemyborder = 44
					E.db.ElvUI_EltreumUI.borders.petactionxborder = 50
					E.db.ElvUI_EltreumUI.borders.petactionyborder = 37
					E.db.ElvUI_EltreumUI.borders.stancexborder = 45

					if E.Wrath then
						E.db["actionbar"]["totemBar"]["spacing"] = 5
					end
				end
			elseif not E.db.ElvUI_EltreumUI.borders.borders then

				if E.db["datatexts"]["panels"]["EltruismDataText"] and E.db["datatexts"]["panels"]["EltruismDataText"]["enable"] then
					E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,22"
					E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,0,22"
				else
					E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,-1,0"
					E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,1,0"
				end
				E.db["movers"]["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-6,-3"
				E.db["actionbar"]["stanceBar"]["buttonSpacing"] = 3

				if ElvDB.profileKeys[E.mynameRealm]:match("Eltreum DPS") then
					if not E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
						E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar2"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar3"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar4"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar5"]["buttonSpacing"] = 3
						E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,223"
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,191"
						E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,159"
						E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,127"
						E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,106"
						if width == 1920 then
							E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,158"
							E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,125"
							E.db["actionbar"]["bar2"]["buttonSpacing"] = 2
							E.db["actionbar"]["bar3"]["buttonSpacing"] = 2
							E.db["actionbar"]["bar4"]["buttonSpacing"] = 2
							E.db["actionbar"]["bar5"]["buttonSpacing"] = 2
							E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,0,103"
						end
					end
					if E.db.ElvUI_EltreumUI.otherstuff.alternativegroups == false then
						E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-1"
						E.db["movers"]["ElvUF_Raid2Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-1"
						E.db["movers"]["ElvUF_Raid3Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,1,-1"
						E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 4
						E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 3
						E.db["unitframe"]["units"]["raid2"]["groupsPerRowCol"] = 4
						E.db["unitframe"]["units"]["raid2"]["verticalSpacing"] = 3
						E.db["unitframe"]["units"]["raid3"]["groupsPerRowCol"] = 4
						E.db["unitframe"]["units"]["raid3"]["verticalSpacing"] = 3
					end
					if E.Wrath then
						E.db["actionbar"]["totemBar"]["spacing"] = 3
						E.db["movers"]["TotemBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,100"
					end
				elseif ElvDB.profileKeys[E.mynameRealm]:match("Eltreum Healer") then
					if not E.db.ElvUI_EltreumUI.otherstuff.ABlikeWA then
						E.db["actionbar"]["bar1"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar2"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar3"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar4"]["buttonSpacing"] = 3
						E.db["actionbar"]["bar5"]["buttonSpacing"] = 3
						E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,307"
						E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,280"
						E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,308,253"
						E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,0,253"
						E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-308,253"
						E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,-308,308"
					end
					if E.Wrath then
						E.db["actionbar"]["totemBar"]["spacing"] = 3
					end
				end
			end
			E:UpdateActionBars()
			--wrath shaman compatibility
			if not (E.Wrath or E.TBC) then
				E:UpdateMoverPositions()
			elseif (E.Wrath or E.TBC) then
				if E.myclass ~= 'SHAMAN' then
					E:UpdateMoverPositions()
				elseif E.myclass == 'SHAMAN' then
					E:Delay(1, function()
						E:UpdateMoverPositions()
					end)
				end
			end
		end
	end
end

--based on elvui mail datatext
local mailsoundframe = CreateFrame("FRAME")
--mailsoundframe:RegisterEvent("MAIL_INBOX_UPDATE")
mailsoundframe:RegisterEvent("UPDATE_PENDING_MAIL")
local mailthrottle = 0
mailsoundframe:SetScript("OnEvent", function()
	if HasNewMail() == true and E.db.ElvUI_EltreumUI.otherstuff.mailsoundenable and not InCombatLockdown() and mailthrottle == 0 then

		if E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "tts" and E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice ~= nil then
			--C_VoiceChat.SpeakText(voiceID, text, destination, rate, volume)
			C_VoiceChat.SpeakText(E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoice, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttstext, Enum.VoiceTtsDestination.LocalPlayback, 0, E.db.ElvUI_EltreumUI.otherstuff.mailsoundttsvoicevolume)
		elseif E.db.ElvUI_EltreumUI.otherstuff.mailsoundtype == "sharedmedia" then
			PlaySoundFile(E.LSM:Fetch("sound", E.db.ElvUI_EltreumUI.otherstuff.mailsound) , "Master")
		end
		mailthrottle = 1
		C_Timer.After(2, function()
			mailthrottle = 0
		end)
	end
end)
