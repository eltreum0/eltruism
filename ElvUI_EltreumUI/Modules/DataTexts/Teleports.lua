local E, L = unpack(ElvUI)
local _G = _G
local DT = E:GetModule("DataTexts")
local math = _G.math
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local GetItemCount = _G.C_Item and _G.C_Item.GetItemCount or _G.GetItemCount
local string = _G.string
local pairs = _G.pairs
local GetItemIcon = _G.C_Item and _G.C_Item.GetItemIconByID or _G.GetItemIcon
local PlayerHasToy = _G.PlayerHasToy
local C_ToyBox = _G.C_ToyBox
local GetItemCooldown = _G.C_Container.GetItemCooldown or _G.C_Item and _G.C_Item.GetItemCooldown --TODO, confirm it works
local CreateFrame = _G.CreateFrame
local GetBindLocation = _G.GetBindLocation
local GetTime = _G.GetTime
local GetSpellTexture = _G. GetSpellTexture
local GetSpellInfo = _G.GetSpellInfo
local IsSpellKnown = _G.IsSpellKnown
local GetSpellCooldown = _G.GetSpellCooldown
local tostring = _G.tostring
local mod = _G.mod
local IsUsableItem = _G.C_Item and _G.C_Item.IsUsableItem or _G.IsUsableItem
local hsIsReady = true
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------hearthstone/tp item datatext
--based yet again on elvui config
--most from https://www.wowhead.com/item=6948/hearthstone#comments
local TeleportsItems = {
	6948, --hearthstone
	22630, --atiesh-greatstaff-of-the-guardian
	22631, --atiesh-greatstaff-of-the-guardian
	22632, --atiesh-greatstaff-of-the-guardian
	22589, --atiesh-greatstaff-of-the-guardian
	54452, --ethereal-portal
	93672, --dark-portal
	184871, --dark-portal 2?
	142542, --tome of town portal (finally has a new animation)
	--188952, --dominated-hearthstone
	--162973, --greatfather-winters-hearthstone
	--193588, --timewalkers-hearthstone
	--208704, --deepdwellers-earthen-hearthstone
	206195, --path of the naaru
	110560, --garrison-hearthstone
	140192, --dalaran-hearthstone
	141605, --flight-masters-whistle
	128353,--admirals-compass
	18984, --dimensional-ripper-everlook
	18986, --ultrasafe-transporter-gadgetzan
	30542, --dimensional-ripper-area-52
	30544, --ultrasafe-transporter-toshleys-station
	48933, --wormhole-generator-northrend
	87215, --wormhole-generator-pandaria
	112059, --wormhole-centrifuge
	151652, --wormhole-generator-argus
	168807,--wormhole-generator-kultiras
	168808,--wormhole-generator-zandalar
	172924, --wormhole-generator-shadowlands
	198156, --wyrmhole-dragonflight
	32757, --blessed-medallion-of-karabor
	40585, --signet-of-the-kirin-tor
	40586, --band-of-the-kirin-tor
	48954, --etched-band-of-the-kirin-tor
	48955, --etched-loop-of-the-kirin-tor
	48956, --etched-ring-of-the-kirin-tor
	48957, --etched-signet-of-the-kirin-tor
	45688, --inscribed-band-of-the-kirin-tor
	45689, --inscribed-loop-of-the-kirin-tor
	45690, --inscribed-ring-of-the-kirin-tor
	45691, --inscribed-signet-of-the-kirin-tor
	44934, --loop-of-the-kirin-tor
	44935, --ring-of-the-kirin-tor
	51557, --runed-signet-of-the-kirin-tor
	51558, --runed-loop-of-the-kirin-tor
	51559, --runed-ring-of-the-kirin-tor
	51560, --runed-band-of-the-kirin-tor
	139599, --empowered-ring-of-the-kirin-tor
	63206, --wrap-of-unity
	63207, --wrap-of-unity
	63352, --shroud-of-cooperation
	63353, --shroud-of-cooperation
	65274, --cloak-of-coordination
	65360, --cloak-of-coordination
	46874, --argent-crusaders-tabard
	63378, --hellscreams-reach-tabard
	63379, --baradins-wardens-tabard
	28585, --ruby-slippers
	37863, --direbrews-remote
	43824,--the-schools-of-arcane-magic-mastery
	50287, --boots-of-the-bay
	52251, --jainas-locket
	64457, --the-last-relic-of-argus
	95050, --the-brassiest-knuckle
	95051, --the-brassiest-knuckle
	103678, --time-lost-artifact
	118663,--relic-of-karabor
	118907, --pit-fighters-punching-ring
	118908, --pit-fighters-punching-ring
	129276,--beginners-guide-to-dimensional-rifting
	128502,--hunters-seeking-crystal
	138448,--emblem-of-margoss
	142298, --astonishingly-scarlet-slippers
	142469, --violet-seal-of-the-grand-magus
	144391, --pugilists-powerful-punching-ring
	151016, --fractured-necrolyte-skull
	180817, --cypher-of-relocation
	29796, --socrethars-teleportation-stone
	61379, --gidwins-hearthstone
	68808, --heros-hearthstone
	68809, --veterans-hearthstone
	92510, --voljins-hearthstone
	35230, --darnarians-scroll-of-teleportation
	119183, --scroll-of-risky-recall
	139590, --scroll-of-teleport-ravenholdt
	141015, --scroll-of-town-portal-kaldelar
	141014, --scroll-of-town-portal-sashjtar
	141017, --scroll-of-town-portal-liantril
	141016, --scroll-of-town-portal-faronaar
	141013, --scroll-of-town-portal-shalanir
	142543, --scroll-of-town-portal
	95567, --kirin-tor-beacon
	95568, --sunreaver-beacon
	37118, --scroll-of-recall
	44314, --scroll-of-recall-ii
	44315, --scroll-of-recall-iii
	58487, --potion-of-deepholm
	17690, --frostwolf-insignia-rank-1
	17691, --stormpike-insignia-rank-1
	17900, --stormpike-insignia-rank-2
	17901, --stormpike-insignia-rank-3
	17902, --stormpike-insignia-rank-4
	17903, --stormpike-insignia-rank-5
	17904, --stormpike-insignia-rank-6
	17905, --frostwolf-insignia-rank-2
	17906, --frostwolf-insignia-rank-3
	17907, --frostwolf-insignia-rank-4
	17908, --frostwolf-insignia-rank-5
	17909, --frostwolf-insignia-rank-6
}
local TeleportsSpells = {
	556, --astral-recall
	50977, --death-gate
	126892, --zen-pilgrimage
	193753, --dreamwalk
	193759, --teleport-hall-of-the-guardian
	131204, --path-of-the-jade-serpent
	131205, --path-of-the-stout-brew
	131206, --path-of-the-shado-pan
	131222, --path-of-the-mogu-king
	131225, --path-of-the-setting-sun
	131228, --path-of-the-black-ox
	131229, --path-of-the-scarlet-mitre
	131231, --path-of-the-scarlet-blade
	131232, --path-of-the-necromancer
	159895, --path-of-the-bloodmaul
	159896, --path-of-the-iron-prow
	159897, --path-of-the-vigilant
	159898, --path-of-the-skies
	159899, --path-of-the-crescent-moon
	159900, --path-of-the-dark-rail
	159901, --path-of-the-verdant
	159902, --path-of-the-burning-mountain
	354462, --path-of-the-courageous
	354463, --path-of-the-plagued
	354464, --path-of-the-misty-forest
	354465, --path-of-the-sinful-soul
	354467, --path-of-the-undefeated
	354468, --path-of-the-scheming-loa
	354469, --path-of-the-stone-warden
	367416, --path-of-the-streetwise-merchant
	373262, --path-of-the-fallen-guardian
	373274, --path-of-the-scrappy-prince
	373190, --path-of-the-sire
	373191, --path-of-the-tormented-soul
	373192, --path-of-the-first-ones
	393222, --path-of-the-watchers-legacy
	393273, --path-of-the-draconic-diploma
	393256, --path-of-the-clutch-defender
	393262, --path-of-the-windswept-plains
	393283, --path-of-the-titanic-reservoir
	393276, --path-of-the-obsidian-hoard
	393279, --path-of-arcane-secrets
	393764, --path-of-proven-worth
	393766, --path-of-the-grand-magistrix
	393267, --path-of-the-rotting-woods
	410078, --path-of-the-earth-warder
	410074, --path-of-festering-rot
	410071, --path-of-the-freebooter
	410080, --path-of-winds-domain
	424197, --path-of-twisted-time
	432254, --path-of-the-primal-prison
	432257, --path-of-the-bitter-legacy
	432258, --path-of-the-scorching-dream
}
local texturePaths = {
	["6948"] = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga", --hearthstone
	["22630"] = "Interface\\Icons\\inv_staff_medivh.blp", --atiesh-greatstaff-of-the-guardian
	["22631"] = "Interface\\Icons\\inv_staff_medivh.blp", --atiesh-greatstaff-of-the-guardian
	["22632"] = "Interface\\Icons\\inv_staff_medivh.blp", --atiesh-greatstaff-of-the-guardian
	["22589"] = "Interface\\Icons\\inv_staff_medivh.blp", --atiesh-greatstaff-of-the-guardian
	["54452"] = "Interface\\Icons\\ability_mage_netherwindpresence.blp", --ethereal-portal
	["93672"] = "Interface\\Icons\\achievement_dungeon_outland_dungeonmaster.blp", --dark-portal
	["184871"] = "Interface\\Icons\\achievement_dungeon_outland_dungeonmaster.blp", --dark-portal 2
	["110560"] = "Interface\\Icons\\inv_garrison_hearthstone.blp", --dalaran-hearthstone
	["140192"] = "Interface\\Icons\\inv_misc_rune_15.blp", --dalaran-hearthstone
	["141605"] = "Interface\\Icons\\ability_hunter_beastcall.blp", --flight-masters-whistle
	["128353"] = "Interface\\Icons\\inv_misc_idol_05.blp", --admirals-compass
	["18984"] = "Interface\\Icons\\inv_misc_enggizmos_15.blp", --dimensional-ripper-everlook
	["18986"] = "Interface\\Icons\\inv_misc_enggizmos_12.blp", --ultrasafe-transporter-gadgetzan
	["30542"] = "Interface\\Icons\\inv_misc_enggizmos_07.blp", --dimensional-ripper-area-52
	["30544"] = "Interface\\Icons\\inv_misc_blizzcon09_graphicscard.blp", --ultrasafe-transporter-toshleys-station
	["48933"] = "Interface\\Icons\\spell_fire_bluefirenova.blp", --wormhole-generator-northrend
	["87215"] = "Interface\\Icons\\sha_spell_fire_felfirenova.blp", --wormhole-generator-pandaria
	["112059"] = "Interface\\Icons\\ability_siege_engineer_pattern_recognition.blp", --wormhole-centrifuge
	["151652"] = "Interface\\Icons\\spell_shadow_demoniccircleteleport.blp", --wormhole-generator-argus
	["168807"] = "Interface\\Icons\\inv_trinket_80_kultiras02b.blp", --wormhole-generator-kultiras
	["168808"] = "Interface\\Icons\\inv_trinket_80_kultiras02a.blp", --wormhole-generator-zandalar
	["172924"] = "Interface\\Icons\\inv_engineering_90_wormholegenerator.blp", --wormhole-generator-shadowlands
	["198156"] = "Interface\\Icons\\inv_10_engineering_device_gadget3_color3.blp", --wyrmhole-dragonflight
	["32757"] = "Interface\\Icons\\inv_jewelry_amulet_04.blp", --blessed-medallion-of-karabor
	["40585"] = "Interface\\Icons\\inv_jewelry_ring_73.blp", --signet-of-the-kirin-tor
	["40586"] = "Interface\\Icons\\inv_jewelry_ring_74.blp", --band-of-the-kirin-tor
	["48954"] = "Interface\\Icons\\inv_jewelry_ring_74.blp", --etched-band-of-the-kirin-tor
	["48955"] = "Interface\\Icons\\inv_jewelry_ring_73.blp", --etched-loop-of-the-kirin-tor
	["48956"] = "Interface\\Icons\\inv_jewelry_ring_74.blp", --etched-ring-of-the-kirin-tor
	["48957"] = "Interface\\Icons\\inv_jewelry_ring_73.blp", --etched-ring-of-the-kirin-tor
	["45688"] = "Interface\\Icons\\inv_jewelry_ring_74.blp", --inscribed-band-of-the-kirin-tor
	["45689"] = "Interface\\Icons\\inv_jewelry_ring_73.blp", --inscribed-loop-of-the-kirin-tor
	["45690"] = "Interface\\Icons\\inv_jewelry_ring_74.blp", --inscribed-ring-of-the-kirin-tor
	["45691"] = "Interface\\Icons\\inv_jewelry_ring_73.blp", --inscribed-signet-of-the-kirin-tor
	["44934"] = "Interface\\Icons\\inv_jewelry_ring_73.blp", --loop-of-the-kirin-tor
	["44935"] = "Interface\\Icons\\inv_jewelry_ring_74.blp", --ring-of-the-kirin-tor
	["51557"] = "Interface\\Icons\\inv_jewelry_ring_73.blp", --runed-signet-of-the-kirin-tor
	["51558"] = "Interface\\Icons\\inv_jewelry_ring_73.blp", --runed-loop-of-the-kirin-tor
	["51559"] = "Interface\\Icons\\inv_jewelry_ring_74.blp", --runed-ring-of-the-kirin-tor
	["51560"] = "Interface\\Icons\\inv_jewelry_ring_74.blp", --runed-band-of-the-kirin-tor
	["139599"] = "Interface\\Icons\\inv_jewelry_ring_73.blp", --empowered-ring-of-the-kirin-tor
	["63206"] = "Interface\\Icons\\inv_guild_cloak_alliance_b.blp", --wrap-of-unity
	["63207"] = "Interface\\Icons\\inv_guild_cloak_horde_b.blp", --wrap-of-unity
	["63352"] = "Interface\\Icons\\inv_guild_cloak_alliance_a.blp", --shroud-of-cooperation
	["63353"] = "Interface\\Icons\\inv_guild_cloak_horde_a.blp", --shroud-of-cooperation
	["65274"] = "Interface\\Icons\\inv_guild_cloak_horde_c.blp", --cloak-of-coordination
	["65360"] = "Interface\\Icons\\inv_guild_cloak_alliance_c.blp", --cloak-of-coordination
	["46874"] = "Interface\\Icons\\inv_shirt_guildtabard_01.blp", --argent-crusaders-tabard
	["63378"] = "Interface\\Icons\\inv_misc_tabard_hellscream.blp", --hellscreams-reach-tabard
	["63379"] = "Interface\\Icons\\inv_misc_tabard_baradinwardens.blp", --baradins-wardens-tabard
	["28585"] = "Interface\\Icons\\inv_boots_cloth_09.blp", --ruby-slippers
	["37863"] = "Interface\\Icons\\inv_gizmo_goblingtonkcontroller.blp", --direbrews-remote
	["43824"] = "Interface\\Icons\\inv_misc_book_11.blp", --the-schools-of-arcane-magic-mastery
	["50287"] = "Interface\\Icons\\inv_boots_cloth_21.blp", --boots-of-the-bay
	["52251"] = "Interface\\Icons\\inv_jewelry_necklace_21.blp", --jainas-locket
	["64457"] = "Interface\\Icons\\trade_archaeology_draeneirelic.blp", --the-last-relic-of-argus
	["95050"] = "Interface\\Icons\\inv_jewelry_ring_03.blp", --the-brassiest-knuckle
	["95051"] = "Interface\\Icons\\inv_jewelry_ring_03.blp", --the-brassiest-knuckle
	["103678"] = "Interface\\Icons\\inv_misc_trinketpanda_06.blp", --time-lost-artifact
	["118663"] = "Interface\\Icons\\inv_jewelry_necklace_28.blp", --relic-of-karabor
	["118907"] = "Interface\\Icons\\inv_60pvp_ring1c.blp", --pit-fighters-punching-ring
	["118908"] = "Interface\\Icons\\inv_60pvp_ring1c.blp", --pit-fighters-punching-ring
	["129276"] = "Interface\\Icons\\inv_relics_libramofgrace.blp", --beginners-guide-to-dimensional-rifting
	["128502"] = "Interface\\Icons\\trade_archaeology_apexiscrystal.blp", --hunters-seeking-crystal
	["138448"] = "Interface\\Icons\\spell_shadow_demoniccircleteleport.blp", --emblem-of-margoss
	["142298"] = "Interface\\Icons\\inv_cloth_raidpriest_q_01_boot.blp", --astonishingly-scarlet-slippers
	["142469"] = "Interface\\Icons\\inv_70_raid_ring2a.blp", --violet-seal-of-the-grand-magus
	["144391"] = "Interface\\Icons\\inv_60pvp_ring1d.blp", --pugilists-powerful-punching-ring
	["151016"] = "Interface\\Icons\\inv_misc_bone_orcskull_01.blp", --fractured-necrolyte-skull
	["180817"] = "Interface\\Icons\\trade_archaeology_titan_fragment.blp", --cypher-of-relocation
	["29796"] = "Interface\\Icons\\inv_misc_stonetablet_11.blp", --socrethars-teleportation-stone
	["61379"] = "Interface\\Icons\\achievement_guildperk_hastyhearth.blp", --gidwins-hearthstone
	["68808"] = "Interface\\Icons\\achievement_guildperk_hastyhearth.blp", --heros-hearthstone
	["68809"] = "Interface\\Icons\\achievement_guildperk_hastyhearth.blp", --veterans-hearthstone
	["92510"] = "Interface\\Icons\\achievement_guildperk_hastyhearth.blp", --voljins-hearthstone
	["35230"] = "Interface\\Icons\\inv_scroll_02.blp", --darnarians-scroll-of-teleportation
	["119183"] = "Interface\\Icons\\inv_scroll_07.blp", --scroll-of-risky-recall
	["139590"] = "Interface\\Icons\\inv_scroll_05.blp", --scroll-of-teleport-ravenholdt
	["141015"] = "Interface\\Icons\\inv_enchant_formulasuperior_01.blp", --scroll-of-town-portal-kaldelar
	["141014"] = "Interface\\Icons\\inv_enchant_formulaepic_01.blp", --scroll-of-town-portal-sashjtar
	["141017"] = "Interface\\Icons\\inv_scroll_12.blp", --scroll-of-town-portal-liantril
	["141016"] = "Interface\\Icons\\inv_scroll_13.blp", --scroll-of-town-portal-faronaar
	["141013"] = "Interface\\Icons\\inv_enchant_formulagood_01.blp", --scroll-of-town-portal-shalanir
	["142543"] = "Interface\\Icons\\diabloanniversary_scrolloftownportal.blp", --scroll-of-town-portal
	["95567"] = "Interface\\Icons\\achievement_reputation_kirintor_offensive.blp", --kirin-tor-beacon
	["95568"] = "Interface\\Icons\\achievement_faction_sunreaveronslaught.blp", --sunreaver-beacon
	["37118"] = "Interface\\Icons\\inv_scroll_15.blp", --scroll-of-recall
	["44314"] = "Interface\\Icons\\inv_scroll_12.blp", --scroll-of-recall-ii
	["44315"] = "Interface\\Icons\\inv_scroll_16.blp", --scroll-of-recall-iii
	["58487"] = "Interface\\Icons\\inv_potionc_1.blp", --potion-of-deepholm
	["17691"] = "Interface\\Icons\\inv_jewelry_stormpiketrinket_01.blp", --stormpike-insignia-rank-1
	["17900"] = "Interface\\Icons\\inv_jewelry_stormpiketrinket_01.blp", --stormpike-insignia-rank-2
	["17901"] = "Interface\\Icons\\inv_jewelry_stormpiketrinket_02.blp", --stormpike-insignia-rank-3
	["17902"] = "Interface\\Icons\\inv_jewelry_stormpiketrinket_03.blp", --stormpike-insignia-rank-4
	["17903"] = "Interface\\Icons\\inv_jewelry_stormpiketrinket_04.blp", --stormpike-insignia-rank-5
	["17904"] = "Interface\\Icons\\inv_jewelry_stormpiketrinket_05.blp", --stormpike-insignia-rank-6
	["17690"] = "Interface\\Icons\\inv_jewelry_frostwolftrinket_01.blp", --frostwolf-insignia-rank-1
	["17905"] = "Interface\\Icons\\inv_jewelry_frostwolftrinket_01.blp", --frostwolf-insignia-rank-2
	["17906"] = "Interface\\Icons\\inv_jewelry_frostwolftrinket_02.blp", --frostwolf-insignia-rank-3
	["17907"] = "Interface\\Icons\\inv_jewelry_frostwolftrinket_03.blp", --frostwolf-insignia-rank-4
	["17908"] = "Interface\\Icons\\inv_jewelry_frostwolftrinket_04.blp", --frostwolf-insignia-rank-5
	["17909"] = "Interface\\Icons\\inv_jewelry_frostwolftrinket_05.blp", --frostwolf-insignia-rank-6
	["142542"] = "Interface\\Icons\\diabloanniversary_tomeoftownportal.blp", --tome of town portal
	["556"] = "Interface\\Icons\\spell_nature_astralrecal.blp", --astral-recall
	["50977"] = "Interface\\Icons\\spell_arcane_teleportundercity.blp", --death-gate
	["126892"] = "Interface\\Icons\\spell_monk_zenpilgrimage.blp", --zen-pilgrimage
	["193753"] = "Interface\\Icons\\spell_arcane_teleportstormwind.blp", --dreamwalk
	["193759"] = "Interface\\Icons\\spell_arcane_teleporthalloftheguardian.blp", --teleport-hall-of-the-guardian
	["131204"] = "Interface\\Icons\\achievement_jadeserpent.blp", --path-of-the-jade-serpent
	["131205"] = "Interface\\Icons\\achievement_brewery.blp", --path-of-the-stout-brew
	["131206"] = "Interface\\Icons\\achievement_shadowpan_hideout.blp", --path-of-the-shado-pan
	["131222"] = "Interface\\Icons\\achievement_dungeon_mogupalace.blp", --path-of-the-mogu-king
	["131225"] = "Interface\\Icons\\achievement_greatwall.blp", --path-of-the-setting-sun
	["131228"] = "Interface\\Icons\\achievement_dungeon_siegeofniuzaotemple.blp", --path-of-the-black-ox
	["131229"] = "Interface\\Icons\\spell_holy_resurrection.blp", --path-of-the-scarlet-mitre
	["131231"] = "Interface\\Icons\\inv_helmet_52.blp", --path-of-the-scarlet-blade
	["131232"] = "Interface\\Icons\\spell_holy_senseundead.blp", --path-of-the-necromancer
	["159895"] = "Interface\\Icons\\achievement_dungeon_ogreslagmines.blp", --path-of-the-bloodmaul
	["159896"] = "Interface\\Icons\\achievement_dungeon_blackrockdocks.blp", --path-of-the-iron-prow
	["159897"] = "Interface\\Icons\\achievement_dungeon_auchindoun.blp", --path-of-the-vigilant
	["159898"] = "Interface\\Icons\\achievement_dungeon_arakkoaspires.blp", --path-of-the-skies
	["159899"] = "Interface\\Icons\\achievement_dungeon_shadowmoonhideout.blp", --path-of-the-crescent-moon
	["159900"] = "Interface\\Icons\\achievement_dungeon_blackrockdepot.blp", --path-of-the-dark-rail
	["159901"] = "Interface\\Icons\\achievement_dungeon_everbloom.blp", --path-of-the-verdant
	["159902"] = "Interface\\Icons\\achievement_dungeon_upperblackrockspire.blp", --path-of-the-burning-mountain
	["354462"] = "Interface\\Icons\\achievement_dungeon_theneroticwake.blp", --path-of-the-courageous
	["354463"] = "Interface\\Icons\\achievement_dungeon_plaguefall.blp", --path-of-the-plagued
	["354464"] = "Interface\\Icons\\achievement_dungeon_mistsoftirnascithe.blp", --path-of-the-misty-forest
	["354465"] = "Interface\\Icons\\achievement_dungeon_hallsofattonement.blp", --path-of-the-sinful-soul
	["354467"] = "Interface\\Icons\\achievement_dungeon_theatreofpain.blp", --path-of-the-undefeated
	["354468"] = "Interface\\Icons\\achievement_dungeon_theotherside.blp", --path-of-the-scheming-loa
	["354469"] = "Interface\\Icons\\achievement_dungeon_sanguinedepths.blp", --path-of-the-stone-warden
	["367416"] = "Interface\\Icons\\achievement_dungeon_brokerdungeon.blp", --path-of-the-streetwise-merchant
	["373262"] = "Interface\\Icons\\achievement_raid_karazhan.blp", --path-of-the-fallen-guardian
	["373274"] = "Interface\\Icons\\achievement_boss_mechagon.blp", --path-of-the-scrappy-prince
	["373190"] = "Interface\\Icons\\achievement_raid_revendrethraid_castlenathria.blp", --path-of-the-sire
	["373191"] = "Interface\\Icons\\achievement_raid_torghastraid.blp", --path-of-the-tormented-soul
	["373192"] = "Interface\\Icons\\inv_achievement_raid_progenitorraid.blp", --path-of-the-first-ones
	["393222"] = "Interface\\Icons\\achievement_dungeon_uldaman.blp", --path-of-the-watchers-legacy
	["393273"] = "Interface\\Icons\\achievement_dungeon_dragonacademy.blp", --path-of-the-draconic-diploma
	["393256"] = "Interface\\Icons\\achievement_dungeon_lifepools.blp", --path-of-the-clutch-defender
	["393262"] = "Interface\\Icons\\achievement_dungeon_centaurplains.blp", --path-of-the-windswept-plains
	["393283"] = "Interface\\Icons\\achievement_dungeon_hallsofinfusion.blp", --path-of-the-titanic-reservoir
	["393276"] = "Interface\\Icons\\achievement_dungeon_neltharus.blp", --path-of-the-obsidian-hoard
	["393279"] = "Interface\\Icons\\achievement_dungeon_arcanevaults.blp", --path-of-arcane-secrets
	["393764"] = "Interface\\Icons\\achievement_dungeon_hallsofvalor.blp", --path-of-proven-worth
	["393766"] = "Interface\\Icons\\achievement_dungeon_courtofstars.blp", --path-of-the-grand-magistrix
	["393267"] = "Interface\\Icons\\achievement_dungeon_brackenhidehollow.blp", --path-of-the-rotting-woods
	["410078"] = "Interface\\Icons\\achievement_dungeon_neltharionslair.blp", --path-of-the-earth-warder
	["410074"] = "Interface\\Icons\\achievement_dungeon_underrot.blp", --path-of-festering-rot
	["410071"] = "Interface\\Icons\\achievement_dungeon_freehold.blp", --path-of-the-freebooter
	["410080"] = "Interface\\Icons\\achievement_dungeon_skywall.blp", --path-of-winds-domain
	["206195"] = "Interface\\Icons\\inv_pet_naaru_purple.blp"
	--["188952"] = "Interface\\Icons\\Spell_AnimaMaw_Nova.blp", --dominated hearthsone
	--["162973"] = "Interface\\Icons\\inv_holiday_hearthstonewinterveil.blp", --greatfather-winters-hearthstone
}
local hearthstones = {
	["6948"] = true, --hearthstone
	["54452"] = true, --ethereal-portal
	["93672"] = true, --dark-portal
	["184871"] = true, --dark-portal 2?
	["28585"] = true, --ruby-slippers
	["142298"] = true, --astonishingly-scarlet-slippers
	["142542"] = true, --tome of town portal (finally has a new animation)
	["556"] = true, --astral-recall
	["206195"] = true, --path of the naaru
	--["188952"] = true, --dominated hearthsone
	--["162973"] = true, --greatfather-winters-hearthstone
}
function ElvUI_EltreumUI:GetTeleportSpells()
	if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
		return TeleportsSpells
	else
		return TeleportsItems
	end
end
--the maw to avoid cypher showing up everywhere
local mawIDs = {
	["11400"] = true,
	["1543"] = true,
	["1550"] = true,
	["2456"] = true,
	["2364"] = true,
}
local teleportupdate = CreateFrame("FRAME")
local TimeSinceLastUpdate = 0
local ONUPDATE_INTERVAL = 1
local displayStringEltruismTeleports = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Warcraft3Hearthstone.tga:18:18:0:0:64:64:5:59:5:59|t "..GetBindLocation()
_G["EltruismHearthStoneSecureButton"] = _G["EltruismHearthStoneSecureButton"] or CreateFrame('Button', "EltruismHearthStoneSecureButton", nil, 'SecureActionButtonTemplate')
_G["EltruismHearthStoneSecureButton"].id = "6948"
_G["EltruismHearthStoneSecureButton"]:SetAttribute('type', 'item')
local name = GetItemInfo(6948)
_G["EltruismHearthStoneSecureButton"]:SetAttribute('item', name)
_G["EltruismHearthStoneSecureButton"]:RegisterForClicks("AnyUp", "AnyDown")

local function EltruismTeleportsOnEvent(self)

	--fix id
	if not hsIsReady and E.myclass == "SHAMAN" then
		local _, _, _, _, _, _, spellID = GetSpellInfo(556)
		_G["EltruismHearthStoneSecureButton"].id = tostring(spellID)
	else
		if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
			local _, _, _, _, _, _, spellID = GetSpellInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
			_G["EltruismHearthStoneSecureButton"].id = tostring(spellID)
		elseif E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "ITEM" then
			local _, itemLink = GetItemInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
			if itemLink then
				local itemid = itemLink:match("item:(%d+)")
				_G["EltruismHearthStoneSecureButton"].id = tostring(itemid)
			end
		else
			_G["EltruismHearthStoneSecureButton"].id = "6948"
		end
	end
	local start, duration = GetItemCooldown(6948)
	if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
		start,duration = GetSpellCooldown(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport))
	elseif E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "ITEM" then
		local _, itemLink = GetItemInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
		if itemLink then
			local itemid = itemLink:match("item:(%d+)")
			start, duration = GetItemCooldown(itemid)
		end
	end
	if not start then return end
	local cooldown = start + duration - GetTime()
	if E.myclass == "SHAMAN" and cooldown >= 2 then
		local startAR,durationAR = GetSpellCooldown(556)
		local cooldownAR = startAR + durationAR - GetTime()
		if cooldownAR >= 2 then
			if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
				displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffED7474"..GetBindLocation().."|r"
			else
				displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffED7474"..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
			end
		elseif cooldownAR <= 0 then
			if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
				displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..GetBindLocation()
			else
				displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
			end
		end
	else
		if cooldown >= 2 then
			if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
				displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffED7474"..GetBindLocation().."|r"
			else
				displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffED7474"..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
			end
			hsIsReady = false
		elseif cooldown <= 0 then
			if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
				displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..GetBindLocation()
			else
				displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
			end
			hsIsReady = true
		end
	end
	self.text:SetText(displayStringEltruismTeleports)
end

local function EltruismTeleportsOnEnter()
	DT.tooltip:ClearLines()
	for _,v in pairs(TeleportsItems) do
		local texture = GetItemIcon(v)
		local nameitems = GetItemInfo(v)
		local hasItem = GetItemCount(v)

		if v == 180817 then --hide cypher if outside the maw
			local mapID = not E.Retail and tostring(_G.WorldMapFrame:GetMapID()) or tostring(C_Map.GetBestMapForUnit("player"))
			--print(mapID)
			if not mawIDs[mapID] then
				hasItem = 0
			end
		end
		--print(nameitems,PlayerHasToy(v),C_ToyBox.IsToyUsable(v))
		if texture and nameitems and ((hasItem > 0 and IsUsableItem(v)) or (not E.Classic and PlayerHasToy(v) and C_ToyBox.IsToyUsable(v))) then

			local start, duration = GetItemCooldown(v)
			local cooldown = start + duration - GetTime()
			if cooldown >= 2 then
				local hours = math.floor(cooldown /3600)
				local minutes = math.floor(cooldown / 60)
				local seconds = string.format("%02.f", math.floor(cooldown - minutes * 60))
				if hours >= 1 then
					minutes = math.floor(mod(cooldown,3600)/60)
					DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..nameitems.."|r", ("|cffdb3030"..hours.."h "..minutes.."m "..seconds.."s|r"))
				else
					DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..nameitems.."|r", ("|cffdb3030"..minutes.."m "..seconds.."s|r"))
				end
			elseif cooldown <= 0 then
				DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..nameitems.."|r", "|cff00FF00"..L["Ready"].."|r")
			end
		end
	end
	for _,v in pairs(TeleportsSpells) do
		local texture = GetSpellTexture(v)
		local namespells = GetSpellInfo(v)
		local hasSpell = IsSpellKnown(v)
		if texture and namespells and hasSpell then
			local start, duration = GetSpellCooldown(v)
			local cooldown = start + duration - GetTime()
			if cooldown >= 2 then
				local hours = math.floor(cooldown /3600)
				local minutes = math.floor(cooldown / 60)
				local seconds = string.format("%02.f", math.floor(cooldown - minutes * 60))
				if hours >= 1 then
					minutes = math.floor(mod(cooldown,3600)/60)
					DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..namespells.."|r", ("|cffdb3030"..hours.."h "..minutes.."m "..seconds.."s|r"))
				else
					DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..namespells.."|r", ("|cffdb3030"..minutes.."m "..seconds.."s|r"))
				end
			elseif cooldown <= 0 then
				DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..namespells.."|r", "|cff00FF00"..L["Ready"].."|r")
			end
		end
	end
	local start, duration = GetItemCooldown(6948)
	if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
		start,duration = GetSpellCooldown(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport))
	elseif E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "ITEM" then
		local _, itemLink = GetItemInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
		if itemLink then
			local itemid = itemLink:match("item:(%d+)")
			start, duration = GetItemCooldown(itemid)
		end
	end
	local cooldown = start + duration - GetTime()
	if cooldown >= 2 then
		if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
			displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffdb3030"..GetBindLocation().."|r"
		else
			displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffdb3030"..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
		end
		hsIsReady = false
	elseif cooldown <= 0 then
		if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
			displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..GetBindLocation()
		else
			displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
		end
		hsIsReady = true
	end
	DT.tooltip:AddDoubleLine(L["Double Click:"], E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
	DT.tooltip:Show()

	teleportupdate:SetScript("OnUpdate", function(_, elapsed)
		--print("onupdate spam"..math.random(1,99))
		TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
		if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
			TimeSinceLastUpdate = 0
			DT.tooltip:ClearLines()
			for _,v in pairs(TeleportsItems) do
				local texture = GetItemIcon(v)
				local nameitems = GetItemInfo(v)
				local hasItem = GetItemCount(v)
				if v == 180817 then --hide cypher if outside the maw
					local mapID = not E.Retail and tostring(_G.WorldMapFrame:GetMapID()) or tostring(C_Map.GetBestMapForUnit("player"))
					if not mawIDs[mapID] then
						hasItem = 0
					end
				end
				if texture and nameitems and (hasItem > 0 or (not E.Classic and PlayerHasToy(v) and C_ToyBox.IsToyUsable(v)) ) then
					local startcd, durationcd = GetItemCooldown(v)
					local cooldown2 = startcd + durationcd - GetTime()
					if cooldown2 >= 2 then
						local hours = math.floor(cooldown2 /3600)
						local minutes = math.floor(cooldown2 / 60)
						local seconds = string.format("%02.f", math.floor(cooldown2 - minutes * 60))
						if hours >= 1 then
							minutes = math.floor(mod(cooldown2,3600)/60)
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..nameitems.."|r", ("|cffdb3030"..hours.."h "..minutes.."m "..seconds.."s|r"))
						else
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..nameitems.."|r", ("|cffdb3030"..minutes.."m "..seconds.."s|r"))
						end
					elseif cooldown2 <= 0 then
						DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..nameitems.."|r", "|cff00FF00"..L["Ready"].."|r")
					end
				end
			end
			for _,v in pairs(TeleportsSpells) do
				local texture = GetSpellTexture(v)
				local namespells = GetSpellInfo(v)
				local hasSpell = IsSpellKnown(v)
				if texture and namespells and hasSpell then
					local startcd2, durationcd2 = GetSpellCooldown(v)
					local cooldown3 = startcd2 + durationcd2 - GetTime()
					if cooldown3 >= 2 then
						local hours = math.floor(cooldown3 /3600)
						local minutes = math.floor(cooldown3 / 60)
						local seconds = string.format("%02.f", math.floor(cooldown3 - minutes * 60))
						if hours >= 1 then
							minutes = math.floor(mod(cooldown3,3600)/60)
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..namespells.."|r", ("|cffdb3030"..hours.."h "..minutes.."m "..seconds.."s|r"))
						else
							DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffdb3030"..namespells.."|r", ("|cffdb3030"..minutes.."m "..seconds.."s|r"))
						end
					elseif cooldown3 <= 0 then
						DT.tooltip:AddDoubleLine("|T"..texture..":14:14:0:0:64:64:5:59:5:59|t |cffFFFFFF"..namespells.."|r", "|cff00FF00"..L["Ready"].."|r")
					end
				end
			end
			local startcd3, durationcd3 = GetItemCooldown(6948)
			if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
				startcd3, durationcd3 = GetSpellCooldown(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport))
			elseif E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "ITEM" then
				local _, itemLink = GetItemInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
				if itemLink then
					local itemid = itemLink:match("item:(%d+)")
					startcd3, durationcd3 = GetItemCooldown(itemid)
				end
			end
			if startcd3 and durationcd3 then
				local cooldown4 = startcd3 + durationcd3 - GetTime()
				if cooldown4 >= 2 then
					if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
						displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffdb3030"..GetBindLocation().."|r"
					else
						displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffdb3030"..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
					end
					hsIsReady = false
				else
					if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
						displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..GetBindLocation().."|r"
					else
						displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
					end
					hsIsReady = true
				end
			end
			DT.tooltip:AddDoubleLine(L["Double Click:"], E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
			DT.tooltip:Show()
		end
	end)
end

local function EltruismTeleportsOnLeave()
	teleportupdate:SetScript("OnUpdate", nil)
	if not InCombatLockdown() then
		E:Delay(1, function()_G["EltruismHearthStoneSecureButton"]:Hide() end) --delay because showing leaves the datatext so this would trigger early
	end
end

local function EltruismTeleportsOnClick(self)
	if InCombatLockdown() then return end
	if not hsIsReady and E.myclass == "SHAMAN" then
		_G["EltruismHearthStoneSecureButton"]:SetAttribute('type', 'spell')
		local nameastrall, _, _, _, _, _, spellID = GetSpellInfo(556)
		_G["EltruismHearthStoneSecureButton"].id = tostring(spellID)
		_G["EltruismHearthStoneSecureButton"]:SetAttribute('spell', nameastrall)
	else
		if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
			_G["EltruismHearthStoneSecureButton"]:SetAttribute('type', 'spell')
			local namespell, _, _, _, _, _, spellID = GetSpellInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
			_G["EltruismHearthStoneSecureButton"].id = tostring(spellID)
			_G["EltruismHearthStoneSecureButton"]:SetAttribute('spell', namespell)
		elseif E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "ITEM" then
			if E.db.ElvUI_EltreumUI.otherstuff.datatextteleport == nil then
				E.db.ElvUI_EltreumUI.otherstuff.datatextteleport = 6948
			end
			_G["EltruismHearthStoneSecureButton"]:SetAttribute('type', 'item')
			local nameitem, itemLink = GetItemInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
			if itemLink then
				local itemid = itemLink:match("item:(%d+)")
				_G["EltruismHearthStoneSecureButton"].id = tostring(itemid)
				_G["EltruismHearthStoneSecureButton"]:SetAttribute('item', nameitem)
			end
		else
			_G["EltruismHearthStoneSecureButton"]:SetAttribute('type', 'item')
			local namehs = GetItemInfo(6948)
			_G["EltruismHearthStoneSecureButton"].id = "6948"
			_G["EltruismHearthStoneSecureButton"]:SetAttribute('item', namehs)
		end
	end
	_G["EltruismHearthStoneSecureButton"]:RegisterForClicks("AnyUp", "AnyDown")
	_G["EltruismHearthStoneSecureButton"]:Show()
	_G["EltruismHearthStoneSecureButton"]:SetAllPoints(self)

	--fix icon on click
	local start, duration = GetItemCooldown(6948)
	if E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "SPELL" then
		start,duration = GetSpellCooldown(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport))
	elseif E.db.ElvUI_EltreumUI.otherstuff.datatextteleporttype == "ITEM" then
		local _, itemLink = GetItemInfo(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport)
		if itemLink then
			local itemid = itemLink:match("item:(%d+)")
			start, duration = GetItemCooldown(itemid)
		end
	end
	if not hsIsReady and E.myclass == "SHAMAN" then
		start,duration = GetSpellCooldown(556)
	end
	if not start then return end
	local cooldown = start + duration - GetTime()
	if cooldown >= 2 then
		if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
			displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffED7474"..GetBindLocation().."|r"
		else
			displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t |cffED7474"..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
		end
	elseif cooldown <= 0 then
		if hearthstones[_G["EltruismHearthStoneSecureButton"].id] then
			displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..GetBindLocation()
		else
			displayStringEltruismTeleports = "|T"..tostring(texturePaths[_G["EltruismHearthStoneSecureButton"].id])..":18:18:0:0:64:64:5:59:5:59|t "..ElvUI_EltreumUI:ShortenString(tostring(E.db.ElvUI_EltreumUI.otherstuff.datatextteleport), 23).."|r"
		end
	end
	self.text:SetText(displayStringEltruismTeleports)
end
DT:RegisterDatatext('EltruismTeleports', nil, { 'SPELL_UPDATE_COOLDOWN', 'BAG_UPDATE_COOLDOWN', "HEARTHSTONE_BOUND", "LOADING_SCREEN_DISABLED"}, EltruismTeleportsOnEvent, nil, EltruismTeleportsOnClick, EltruismTeleportsOnEnter, EltruismTeleportsOnLeave, L["Eltruism Hearthstones/Teleports"], nil, nil)
