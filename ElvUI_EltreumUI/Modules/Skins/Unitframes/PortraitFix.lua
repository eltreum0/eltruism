local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local UnitIsDead = _G.UnitIsDead
local hooksecurefunc = _G.hooksecurefunc
local UnitIsGhost = _G.UnitIsGhost
local UF = E:GetModule('UnitFrames')

local druidshamanfix = {
	[1272625] = true, --""druidbear2_artifact1.m2",
	[1272606] = true, --""druidbear2_artifact2.m2",
	[1272605] = true, --""druidbear2_artifact3.m2",
	[1272604] = true, --""druidbear2_artifact4.m2",
	[1272741] = true, --""druidbear2_artifact5.m2",
	--[1505169] = true, --""druidbear2_artifact6.m2", --mage tower
	[1273658] = true, --"druidcat2.m2",
	[1363012] = true, --"druidcattauren2.m2",
	[1363013] = true, --"druidcattroll2.m2",
	[1363016] = true, --"druidcatworgen2.m2",
	[1302532] = true, --"druidbear2.m2",
	[1336653] = true, --"druidbeartauren2.m2",
	[1336652] = true, --"druidbeartroll2.m2",
	[1336654] = true, --"druidbearworgen2.m2",
	[4268207] = true, --"cheetahnewthingthatisnotcataloged"
	[652455] = true, --"druidtravelalliance.m2",
	[660898] = true, --"druidtravelalliance_low01.m2",
	[1778010] = true, --"druidtravelhmtauren.m2",
	[652458] = true, --"druidtravelhorde.m2",
	[2068158] = true, --"druidtravelkultiran.m2",
	[1818256] = true, --"druidtravelzandalaritroll.m2",
	[1378642] = true, --"doe.m2",
	[1980608] = true, --kul tiran bear
	[2021536] = true, -- kul tiran cat
	[1274669] = true, -- artifact cat ashamane
	[1273834] = true, -- artifact cat wood type
	[1273835] = true, -- artifact cat jungle type
	[1273904] = true, --artifact cat incarnation
	[1306665] = true, --artifact cat bird
	[5099283] = true, --cat druid of the flame
	[1509765] = true, --druid passanger travel form bird
	[3071370] = true, --shaman ghost wolf glyph
	[4734292] = true,
	[5091437] = true,
	[5008711] = true,
	--[926251] = true, --"wolfdraenor.m2",
	--[1043712] = true, --"raptor2.m2",
	[392615] = true, --cata feral druid troll
	[126171] = true, --cata travel form
	[125835] = true, --cata druid aquatic form
	[123688] = true, --cata feral druid tauren
	[123682] = true, --cata feral druid night elf
	[393783] = true, --cata feral druid worgen
}

local dracthyrlikefix = {
	[4207724] = true, --"dracthyr",
	[1620605] = true, --"lightforged male,
}

local catabearform = {
	[123678] = true, --cata bear form night elf
	[123680] = true, --cata bear form tauren
	[403282] = true, --cata bear form troll
	[393782] = true, --cata bear form worgen
}

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
	--[1272625] = true, --""druidbear2_artifact1.m2",
	--[1272606] = true, --""druidbear2_artifact2.m2",
	--[1272605] = true, --""druidbear2_artifact3.m2",
	--[1272604] = true, --""druidbear2_artifact4.m2",
	--[1272741] = true, --""druidbear2_artifact5.m2",
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
	--[1687797] = true, --"titanargus.m2",
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
	[124521] = true, --"humanmalepiratecrewman.m2",
	[124522] = true, --"humanmalepiratecrewman_ghost.m2",
	[234501] = true, --"ladyalexstrasa.m2",
	[575104] = true, --"ladyalexstrasa2.m2",
	[1624825] = true, --"alleria.m2",
	[1668960] = true, --"alleriavoid.m2",
	[437089] = true, --"ysera.m2",
	[575208] = true, --"ysera2.m2",
	[526474] = true, --"nozdormu.m2",
	[575159] = true, --"nozdormu2.m2",
	[123690] = true, --"druidowlbear.m2",
	[629427] = true, --"druidowlbearepic.m2",
	[123695] = true, --"druidowlbeartauren.m2",
	[629453] = true, --"druidowlbeartaurenepic.m2",
	[1139162] = true, --"druidowlbear2.m2",
	[1139289] = true, --"druidowlbearepic2.m2",
	[1139164] = true, --"druidowlbeartauren2.m2",
	[1139167] = true, --"druidowlbeartaurenepic2.m2",
	[2393672] = true, --"druidowlbearhmtauren2.m2",
	[2574520] = true, --"druidowlbearhmtaurenepic2.m2",
	[2734575] = true, --"druidowlbearkultiranepic2.m2",
	[2734573] = true, --"druidowlbearzandalariepic2.m2",
	[1133752] = true, --"warden.m2",
	[2406143] = true, --"warden_wraith.m2",
	[1769126] = true, --"nathanos.m2",
	[1729790] = true, --"bainebloodhoof.m2",
	[1368775] = true, --"nightbornefemalecitizen.m2",
	[1389276] = true, --"nightbornefemalecitizen2.m2",
	[1661111] = true, --"nightbornefemalecreature.m2",
	[1390672] = true, --"nightbornefemalefel.m2",
	[1368718] = true, --"nightbornemalecitizen.m2",
	[1389275] = true, --"nightbornemalecitizen2.m2",
	[1661112] = true, --"nightbornemalecreature.m2",
	[1393158] = true, --"nightbornemalefel.m2",
	[1273520] = true, --"nightbornespellbreaker.m2",
	[2123299] = true, --"nightelfarcher_f.m2",
	[2153839] = true, --"nightelfarcher_m.m2",
	[2123317] = true, --"nightelfsentinel_f.m2",
	[1271671] = true, --"nightfallenfemale.m2",
	[1274732] = true, --"nightfallenmale.m2",
	[1277447] = true, --"nightborneastronomer.m2",
	[1306568] = true, --"nightbornebotanist.m2",
	[1692762] = true, --"princesstalanji.m2",
	[3990370] = true, --"progenitorbotguardbroken.m2",
	[234694] = true, --"kingvarianwrynn.m2",
	[1466423] = true, --"kingvarianwrynn2.m2",
	[1697869] = true, --"katherineproudmoore.m2",
	[1321518] = true, --"hulkedguldan.m2",
	[1344610] = true, --"hulkedguldan_super.m2",
	[1264839] = true, --"bloodtotemtauren_caster.m2",
	[1261881] = true, --"bloodtotemtauren_melee.m2",
	[125948] = true, --"skeletonnaked.m2",
	[1120702] = true, --"harpy2.m2",
	[1568931] = true, --"harpy2fel.m2",
	[2617507] = true, --"deepjinyucaster.m2",
	[2617509] = true, --"deepjinyumelee.m2",
	[2445592] = true, --"lorthemar.m2",
	--[368597] = true, --"gilgoblin.m2", --for whatever reason this one is ok, female isnt
	[2832038] = true, --"gilgoblin_female.m2",
	[1716306] = true, --"skeletaltrollwarrior.m2",
	[1110239] = true, --"felorcmalehd.m2",
	[1129716] = true, --"felorcjubei_baked.m2",
	[123915] = true, --"felorcwarriorsword.m2",
	[123918] = true, --"felorcwarlord.m2",
	[123901] = true, --"felorcdire.m2",
	[123900] = true, --"felorcwarriorboss.m2",
	[123893] = true, --"felorcwarrioraxe.m2",
	[123887] = true, --"felorc_sword.m2",
	[123882] = true, --"felorc_axe.m2",
	[123880] = true, --"felorc.m2",
	[414827] = true, --"chogall.m2",
	[1035318] = true, --"chogall2.m2",
	[394557] = true, --"chogalldisciple.m2",
	[467025] = true, --"chogall_corrupt.m2",
	[124667] = true, --"kargath.m2",
	[971774] = true, --"kargathbladefist.m2",
	[3483612] = true, --"yserashadowlands.m2",
	[387859] = true, --"garrosh.m2",
	[876912] = true, --"garrosh2",
	[126337] = true, --"velen.m2",
	[971357] = true, --"velen2.m2",
	[1695214] = true, --"velen2young.m2",
	[1572084] = true, --"wingederedar.m2",
	[1671255] = true, --"wingederedarboss.m2",
	[1661447] = true, --"fellord_bountyhunter.m2",
	[1279257] = true, --"fellord_creature.m2",
	[1624880] = true, --"darkwatcherfemale.m2",
	[1249799] = true, --"malfurion.m2",
	[432000] = true, --"malfurionstormrage.m2",
	--[3449671] = true, --"gargoyle2_femaleboss.m2", --this
	--[3155463] = true, --"gargoyle2_female.m2", --and this would require special offsets
	[1132139] = true, --"dhfemaledps.m2",
	[1270179] = true, --"dhfemaledps2.m2",
	[4190632] = true, --"antros not cataloged model"
	[3620242] = true, --"mawguardspikes.m2",
	[3636995] = true, --"anduinshadowlands.m2",
	[3158650] = true, --"ghost from shadowlands not categorized"
	[4395382] = true, --"dracthyr male blood elf"
	[4207724] = true, --"dracthyr not dragon"
	[4220448] = true, -- "dracthyr female human"
	[4217881] = true, --Scalesworn Guardian
	[126483] = true, --nightelf wisp
	[799941] = true, --animated warrior isle of thunder
	[123730] = true, --pink elekk
	[4238520] = true, --Kalecgos humanoid
	[669393] = true, -- Vol'jin Humanoid
	[4206797] = true, --Dominated Saboteur
	[4216963] = true, --Lihuvim
	[4203840] = true, --Prototype of Renewal
	[4222579] = true, --Unmade Steward Mechanical
	[4207517] = true, --Prototype of Absolution
	[4218359] = true, --Chromie
	[3055446] = true, --Wrathion
	[514985] = true, --Majordomo Staghelm
	[122883] = true, --Akama
	[852829] = true, --Echo of Y'Shaarj
	[1269151] = true, --Cordana Felsong
	[4218362] = true, --Alexstrasza the Life-Binder
	[4218967] = true, --Nozdormu
	[797415] = true,
	[2205511] = true, --kul tiran moonkin
	[4518803] = true, --Subterrax
	[875156] = true, --Emperor Shaohao
	[1601374] = true, --Chitinbuk Grazer
	[5059961] = true, --Neltharion
	[4519034] = true, --Neldris
	[4918670] = true, --Rionthus
	[1311487] = true, --Elisande
	[4928312] = true, --Sarkareth
	[4928310] = true, --Sarkareth
	[123788] = true,
	[1569455] = true, --Chieftain Hatuun
	[4184229] = true, --Orizmu
	[126289] = true, --Emperor Vek'lor/Vek'nilash
	[5098429] = true, --Morchie
	[5209702] = true, --Grommash Hellscream
	[5143717] = true, --new druid bear form
	[5154480] = true, --new druid moonkin form
	[3952432] = true, --Prowling Inferno Elemental
	[1786281] = true, --Reagent Skeleton Skinnaur
	[1949828] = true, --Sian'Shim
	[4259454] = true, --Ysera
	[797708] = true, --Stacks
	[794489] = true, --General Jakra'zet
	[1928040] = true, --Zul the Prophet
	[2031732] = true, --Rexxar
	[2123282] = true, --Valorcall Defender
	[2123284] = true, --Valorcall Defender
	[2123291] = true, --Stromgarde Rifleman
	[2123288] = true, --Stromgarde Rifleman
	[534761] = true, --Wrathion (old model)
	[353670] = true, --Anduin Wrynn (old model)
	[124366] = true, --high elf (old model)
	[124368] = true, --Dark Strand Adept
	[3446018] = true, --Winter Queen
	[3016204] = true, --Blingtron 7000
	[5492980] = true, --Moira Thaurissan
	[5767091] = true, --Dagran Thaurissan II
	[5548261] = true, --Baelgrim
	[5548259] = true, --Adelgonn
	[5395590] = true, --Alleria Windrunner
	[5484812] = true, --Speaker Brinthe
	[892526] = true, --other Garrosh Hellscream
	[5349642] = true, --Undertide Preystalker
	[123772] = true, --Recalled Lord Jaraxxus
	[5680838] = true, --Faerin
	[3490792] = true, --Deepsludger
	[5278868] = true, --Risen Mage
	[5633401] = true, --Orweyna
	[5422147] = true, --Ney'leia
	[5422149] = true, --On'hiea
	[5794850] = true, --demineralized Magni Bronzebeard
}

local targetlike = {
	["boss1"] = true,
	["boss2"] = true,
	["boss3"] = true,
	["boss4"] = true,
	["boss5"] = true,
	["boss6"] = true,
	["boss7"] = true,
	["boss8"] = true,
	["arena1"] = true,
	["arena2"] = true,
	["arena3"] = true,
	["arena4"] = true,
	["arena5"] = true,
	["targettarget"] = true,
}

local playerlike = {
	["focus"] = true,
	["focustarget"] = true,
	["party1"] = true,
	["party2"] = true,
	["party3"] = true,
	["party4"] = true,
	["party5"] = true,
	["pet"] = true,
}

function ElvUI_EltreumUI:ShouldRotatePortrait(modelID)
	if modelsRotate[modelID] then
		return true
	else
		return false
	end
end

--fix portrait rotation since they dont align correctly due to how blizzard makes models
local modelcheck = CreateFrame("PlayerModel", "EltruismPortraitFixModel")
function ElvUI_EltreumUI:PortraitFix(unit)
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if self.playerModel then
		if E.db.ElvUI_EltreumUI.unitframes.portraitfix then
			local model = self:GetModelFileID()
			if not model then
				modelcheck:SetUnit(unit) --use a different model to get the file id since the file id is nil when the frame has 0 alpha from fader
				model = modelcheck:GetModelFileID()
				modelcheck:ClearModel()
			end
			local newrotation = 0
			local xOffset = 0

			--pause if dead or ghost
			if E.db.ElvUI_EltreumUI.unitframes.portraitdead then
				if UnitIsDead(unit) or UnitIsGhost(unit) then
					self:SetPaused(true)
					self:SetDesaturation(1)
				else
					self:SetPaused(false)
					self:SetDesaturation(0)
				end
			end

			if unit == 'player' or playerlike[unit] then
				if not model then return end
				if modelsRotate[model]then
					newrotation = 0
				elseif model == 926251 then
					newrotation = 99
				elseif model == 5091437 then
					newrotation = 28 --druid qonzu bird
				elseif catabearform[model] then
					newrotation = 0
				else
					newrotation = 67--3
				end
				if E.db.ElvUI_EltreumUI.unitframes.portraitfixoffset then
					if model == 1273833 then
						xOffset = -0.59 --cat
						if self:GetParent().unitframeType == "party" then
							xOffset = -1
						end
					elseif model == 1505169 or model == 5143717 then
						xOffset = 0.62 --bear
					elseif model == 4207724 then
						xOffset = 0.5 --dracthyr
					elseif druidshamanfix[model] or model == 926251 then
						xOffset = -0.39 --other bears
						if self:GetParent().unitframeType == "party" then
							xOffset = -1
						end
					elseif model == 1043712 then
						xOffset = -1 --shaman raptor
						if self:GetParent().unitframeType == "party" then
							xOffset = -2.3
						end
					elseif catabearform[model] then
						xOffset = 0.62 --cata bears
					elseif self:GetParent().unitframeType == "pet" then
						xOffset = -1 --offset the pets because they would be outside
					end
				end
			elseif unit == 'target' or targetlike[unit] then
				if not model then return end
				if modelsRotate[model] then
					newrotation = 291
				elseif catabearform[model] then
					newrotation = 270 --cata bears
				end
				if E.db.ElvUI_EltreumUI.unitframes.portraitfixoffset then
					if model == 5091437 then
						xOffset = 0 --druid things
					elseif model == 1273833 or druidshamanfix[model] or model == 926251 or model == 1043712 then
						xOffset = -0.59 --druid things
					elseif model == 1505169 or model == 5143717 then
						xOffset = 0.25 --bear
					elseif dracthyrlikefix[model] then
						xOffset = 0.6 --dracthyr and lightforged
					elseif catabearform[model] then
						xOffset = 0.17 --cata bears
					end
				end
			end

			if newrotation ~= 0 then
				local db = self.db
				if not db then return end
				self:SetRotation(rad(newrotation))
				self:SetViewTranslation(xOffset * 100, db.yOffset * 100)
			else
				--prob couldnt get model bc it was nil from PEW, so reset stuff
				self:SetRotation(0)
				if xOffset ~= 0 then
					local db = self.db
					if not db then return end
					self:SetViewTranslation(xOffset * 100, db.yOffset * 100)
				else
					self:SetViewTranslation(0, 0)
				end
			end
		end
	end
end
hooksecurefunc(UF, "PortraitUpdate", ElvUI_EltreumUI.PortraitFix)

--handling player death
local playerdeath = CreateFrame("FRAME")
playerdeath:RegisterEvent("PLAYER_DEAD")
playerdeath:RegisterEvent("PLAYER_UNGHOST")
playerdeath:RegisterEvent("PLAYER_ALIVE")
playerdeath:RegisterUnitEvent("UNIT_FLAGS","player")
playerdeath:SetScript("OnEvent", function()
	if E.db.ElvUI_EltreumUI.unitframes.portraitfix and E.private.unitframe.enable then
		if E.db.unitframe.units.player.enable and E.db.unitframe.units.player.portrait.enable and E.db.unitframe.units.player.portrait.style == "3D" then
			if _G["ElvUF_Player"] and _G["ElvUF_Player"].Portrait3D then
				E:Delay(0,function()
					if UnitIsDead("player") or UnitIsGhost("player") then
						_G["ElvUF_Player"].Portrait3D:SetPaused(true)
						_G["ElvUF_Player"].Portrait3D:SetDesaturation(1)
					else
						_G["ElvUF_Player"].Portrait3D:SetPaused(false)
						_G["ElvUF_Player"].Portrait3D:SetDesaturation(0)
					end
				end)
			end
		end
	end
end)

--hoping this is a temporary fix and blizzard actually fixes models not inherithing the parent's alpha

--fix alpha on login
local pewcheck = CreateFrame("FRAME")
pewcheck:RegisterEvent("PLAYER_ENTERING_WORLD")
pewcheck:SetScript("OnEvent",function()
	if _G["ElvUF_Player"] and E.db.unitframe.units.player.fader.enable and E.db.unitframe.units.player.fader.minAlpha == 0 then
		E:Delay(0, function()
			if not _G["ElvUF_Player"].EltruismAlphaCheck and E.db.unitframe.units.player.fader.smooth == 0 then --another hook to fix when not using elvui fader smoothing
				hooksecurefunc(_G["ElvUF_Player"], "SetAlpha", function(_,alpha)
					if alpha == 0 then
						if _G["EltruismPlayerEffect"] then
							_G["EltruismPlayerEffect"]:SetAlpha(0)
						end
						if _G["EltruismPlayerPowerBarEffect"] then
							_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0)
						end
					else
						if _G["EltruismPlayerEffect"] then
							if E.db.ElvUI_EltreumUI.unitframes.lightmode then
								_G["EltruismPlayerEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
							else
								_G["EltruismPlayerEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
							end
						end
						if _G["EltruismPlayerPowerBarEffect"] then
							if E.Retail then
								_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0.4)
							else
								_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0.8)
							end
						end
					end
				end)
				hooksecurefunc(_G["ElvUF_Pet"], "SetAlpha", function(_,alpha)
					if alpha == 0 then
						if _G["EltruismPetPowerBarEffect"] then
							_G["EltruismPetPowerBarEffect"]:SetAlpha(0)
						end
						if _G["EltruismPetEffect"] then
							_G["EltruismPetEffect"]:SetAlpha(0)
						end
					else
						if _G["EltruismPetPowerBarEffect"] then
							if E.Retail then
								_G["EltruismPetPowerBarEffect"]:SetAlpha(0.8)
							else
								_G["EltruismPetPowerBarEffect"]:SetAlpha(0.6)
							end
						end
						if _G["EltruismPetEffect"] then
							if E.db.ElvUI_EltreumUI.unitframes.lightmode then
								_G["EltruismPetEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
							else
								_G["EltruismPetEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
							end
						end
					end
				end)
				_G["ElvUF_Player"].EltruismAlphaCheck = true
			end
			if _G["EltruismPlayerEffect"] then
				_G["EltruismPlayerEffect"]:SetAlpha(0)
			end
			if _G["EltruismPlayerPowerBarEffect"] then
				_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0)
			end
			if _G["EltruismPetPowerBarEffect"] then
				_G["EltruismPetPowerBarEffect"]:SetAlpha(0)
			end
			if _G["EltruismPetEffect"] then
				_G["EltruismPetEffect"]:SetAlpha(0)
			end
		end)
	end
end)

--flags changed fix
local flagcheck = CreateFrame("FRAME")
flagcheck:RegisterUnitEvent("PLAYER_FLAGS_CHANGED", "player") --model seems to update when flags are changed
flagcheck:SetScript("OnEvent",function()
	if ElvUI_EltreumUI:EncounterCheck() then return end
	if _G["ElvUF_Player"] and E.db.unitframe.units.player.fader.enable and E.db.unitframe.units.player.fader.minAlpha == 0 then
		E:Delay(0, function()
			if _G["ElvUF_Player"]:GetAlpha() == 0 then
				if _G["EltruismPlayerEffect"] then
					_G["EltruismPlayerEffect"]:SetAlpha(0)
				end
				if _G["EltruismPlayerPowerBarEffect"] then
					_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0)
				end
			end
		end)
	end
	if _G["ElvUF_Pet"] and E.db.unitframe.units.pet.fader.enable and E.db.unitframe.units.pet.fader.minAlpha == 0 then
		E:Delay(0, function()
			if _G["ElvUF_Pet"]:GetAlpha() == 0 then
				if _G["EltruismPetEffect"] then
					_G["EltruismPetEffect"]:SetAlpha(0)
				end
				if _G["EltruismPetPowerBarEffect"] then
					_G["EltruismPetPowerBarEffect"]:SetAlpha(0)
				end
			end
		end)
	end
end)

--hook if frame has smoothing
if E.db.unitframe.units.player.fader.smooth > 0 then
	hooksecurefunc(E, "UIFrameFadeIn", function(_, frame,_, _, endAlpha)
		if ElvUI_EltreumUI:EncounterCheck() then return end
		if frame and endAlpha then
			if endAlpha == 0 then
				if frame:GetName() ~= nil then
					if frame:GetName():match("Player") then
						if _G["EltruismPlayerEffect"] then
							_G["EltruismPlayerEffect"]:SetAlpha(0)
						end
						if _G["EltruismPlayerPowerBarEffect"] then
							_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0)
						end
					elseif frame:GetName():match("Pet") then
						if _G["EltruismPetEffect"] then
							_G["EltruismPetEffect"]:SetAlpha(0)
						end
						if _G["EltruismPetPowerBarEffect"] then
							_G["EltruismPetPowerBarEffect"]:SetAlpha(0)
						end
					end
				end
			elseif endAlpha == 1 then
				if frame:GetName() ~= nil and frame:GetName():match("Player") then
					if frame:GetName():match("Player") then
						if _G["EltruismPlayerEffect"] then
							if E.db.ElvUI_EltreumUI.unitframes.lightmode then
								_G["EltruismPlayerEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
							else
								_G["EltruismPlayerEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
							end
						end
						if _G["EltruismPlayerPowerBarEffect"] then
							if E.Retail then
								_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0.4)
							else
								_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0.8)
							end
						end
					elseif frame:GetName():match("Pet") then
						if _G["EltruismPetEffect"] then
							if E.db.ElvUI_EltreumUI.unitframes.lightmode then
								_G["EltruismPetEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
							else
								_G["EltruismPetEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalphadark)
							end
						end
						if _G["EltruismPetPowerBarEffect"] then
							if E.Retail then
								_G["EltruismPetPowerBarEffect"]:SetAlpha(0.8)
							else
								_G["EltruismPetPowerBarEffect"]:SetAlpha(0.6)
							end
						end
					end
				end
			end
		end
	end)
	hooksecurefunc(E, "UIFrameFadeOut", function(_, frame,_, _, endAlpha)
		if ElvUI_EltreumUI:EncounterCheck() then return end
		if frame and endAlpha then
			if endAlpha == 0 then
				if frame:GetName() ~= nil then
					if frame:GetName():match("Player") then
						if _G["EltruismPlayerEffect"] then
							_G["EltruismPlayerEffect"]:SetAlpha(0)
						end
						if _G["EltruismPlayerPowerBarEffect"] then
							_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0)
						end
					elseif frame:GetName():match("Pet") then
						if _G["EltruismPetEffect"] then
							_G["EltruismPetEffect"]:SetAlpha(0)
						end
						if _G["EltruismPetPowerBarEffect"] then
							_G["EltruismPetPowerBarEffect"]:SetAlpha(0)
						end
					end
				end
			elseif endAlpha == 1 then
				if frame:GetName() ~= nil then
					if frame:GetName():match("Player") then
						if _G["EltruismPlayerEffect"] then
							_G["EltruismPlayerEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha or 0.5)
						end
						if _G["EltruismPlayerPowerBarEffect"] then
							_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0.4)
						end
					elseif frame:GetName():match("Pet") then
						if _G["EltruismPetEffect"] then
							_G["EltruismPetEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha or 0.5)
						end
						if _G["EltruismPetPowerBarEffect"] then
							_G["EltruismPetPowerBarEffect"]:SetAlpha(0.8)
						end
					end
				end
			end
		end
	end)
end
