local E = unpack(ElvUI)
local _G = _G
local unpack = _G.unpack
local select = _G.select
local LibStub = _G.LibStub
local CreateFrame = _G.CreateFrame
local setmetatable = _G.setmetatable
local table = _G.table
local IsModifiedClick = _G.IsModifiedClick
local C_Timer = _G.C_Timer
local pairs = _G.pairs
local GetInventoryItemLink = _G.GetInventoryItemLink
local GetInventorySlotInfo = _G.GetInventorySlotInfo
local UnitLevel = _G.UnitLevel
local string = _G.string
local strsplit = _G.strsplit
local tonumber = _G.tonumber
local GetItemInfo = _G.C_Item and _G.C_Item.GetItemInfo or _G.GetItemInfo
local GetItemQualityColor = _G.C_Item and _G.C_Item.GetItemQualityColor or _G.GetItemQualityColor
local ipairs = _G.ipairs
local WorldFrame = _G.WorldFrame
local GetItemGem = _G.C_Item and _G.C_Item.GetItemGem or _G.GetItemGem
local GameTooltip = _G.GameTooltip
local GetSpellLink = _G.GetSpellLink
local GetSpellInfo = _G.GetSpellInfo
local GetSpellTexture = _G.GetSpellTexture
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local type = _G.type
local max = _G.max
local strlenutf8 = _G.strlenutf8
local bit = _G.bit

--Fork of Kibs Item Level by Kibsgaard
function ElvUI_EltreumUI:ClassicSockets()
	if not E.db.ElvUI_EltreumUI.skins.sockets then
		return
	end
	if not E.private.skins.blizzard.enable then return end
	if not E.private.skins.blizzard.character then return end

	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ENCHANT TABLES
	local KIBC_EnchantToSpellID = {
		--missing ones added by eltreum
		[1594] = 33996, -- +26 Attack Power
		[368] = 34004, -- cloak 12 agility
		[684] = 33995, --gloves 15 strength
		[2931] = 46519, -- ring stats +4
		[65] = 7454,
		[2928] = 27924, -- ring + 12 dmg spell
		[2929] = 27920, -- ring + 2 dmg phys
		[2930] = 27926, -- ring +20 healing
		[1593] = 359639, -- bracer assault
		[1144] = 33990, -- 15 spirit
		[1257] = 46506, -- 15 arcane res
		[1441] = 46507, -- 15 shadow res
		[2620] = E.Wrath and 359949 or 25082, -- 15 nature res
		[2519] = 359950, -- 15 fire res
		[2664] = 46508, -- 7 res all
		[2343] = 46531, -- major healing weapon
		[1888] = E.Wrath and 359685 or 20014, -- shield resilience? resistance? 46525
		[926] = E.Wrath and 359895 or 13933, -- shield frost res
		[983] = 44500, -- cloak superior agility
		[2566] = 2317, -- +13 spellpower
		[1354] = 44556, -- cloak superior fire res
		[1400] = 44494, -- cloak superior nature res
		[1446] = 44590, -- cloak superior shadow res
		[3230] = 44483, -- cloak superior frost res
		[1262] = 44596, -- cloak superior arcane res
		[3369] = 53341, -- rune of cinderglacier
		[3594] = 54446, -- rune of swordbreaking
		[3365] = 53323, -- rune of swordshattering
		[3883] = 70164, -- rune of the nerubian carapace
		[1950] = 46594, -- Enchant Chest - Defense
		[3603] = 54998, -- Hand-Mounted Pyro Rocket
		[3604] = 54999, -- Hyperspeed Accelerators
		[3860] = 63770, -- Reticulated Armor Webbing
		[3327] = 50903, --jormungar-leg-reinforcements
		[3328] = 50904, --nerubian-leg-reinforcements
		[3331] = 50911, --dragonscale-leg-armor
		[3290] = 52639, --spring-loaded-cloak-expander
		[3729] = 55655, --eternal-belt-buckle
		[3859] = 63765, --springy-arachnoweave
		[3722] = 55642, --lightweave-embroidery
		[3728] = 55769, --darkglow-embroidery
		[3730] = 55777, --swordguard-embroidery
		[3840] = 44636, --enchant-ring-greater-spellpower
		[3839] = 44645, --eenchant-ring-assault
		[3791] = 59636, --enchant-ring-stamina
		[3756] = 57683, --fur-lining-attack-power
		[3757] = 57690, --fur-lining-stamina
		[3758] = 57691, --fur-lining-spell-power
		[3759] = 57692, --fur-lining-fire-resist
		[3760] = 57694, --fur-lining-frost-resist
		[3761] = 57696, --fur-lining-shadow-resist
		[3762] = 57699, --fur-lining-nature-resist
		[3763] = 57701, --fur-lining-arcane-resist
		[3878] = 67839, --mind-amplification-dish
		[2585] = 24161, --deaths-embrace
		[2586] = 24162, --falcons-call
		[903] = 13794, --enchant-cloak-resistance
		[2619] = 25081, --enchant-cloak-greater-fire-resistance
		[2463] = 13657, --enchant-cloak-fire-resistance
		[804] = 13522, --enchant-cloak-lesser-shadow-resistance
		[256] = 7861, --enchant-cloak-lesser-fire-resistance
		--[1897] = 20031, --enchant-weapon-superior-striking
		[7223] = 435903, --enchant-chest-retricutioner
		[7210] = 435481, --enchant-weapon-dismantle

		---- old list
		[15] = 2831, -- Reinforced (+$k1 Armor)
		[16] = 2832, -- Reinforced (+$k1 Armor)
		[17] = 2833, -- Reinforced (+$k1 Armor)
		[18] = 10344, -- Reinforced (+$k1 Armor)
		[24] = 7443, -- +$k1 Mana
		[30] = 3974, -- Scope (+$k1 Damage)
		[32] = 3975, -- Scope (+$k1 Damage)
		[33] = 3976, -- Scope (+$k1 Damage)
		[34] = 7218, -- Counterweight (+$k1 Haste)
		[36] = 6296, -- Enchant: Fiery Blaze
		[37] = 7220, -- Steel Weapon Chain
		[41] = 7420, -- +$k1 Health
		[43] = 7216, -- Iron Spike (8-12)
		[44] = 7426, -- Absorption ($7423s1)
		[63] = 13538, -- Absorption ($7447s1)
		[66] = 7863, -- +$k1 Stamina
		[241] = 13503, -- +$k1 Weapon Damage
		[242] = 7748, -- +$k1 Health
		[243] = 7766, -- +$k1 Spirit
		[246] = 7776, -- +$k1 Mana
		[247] = 7867, -- +$k1 Agility
		[248] = 7782, -- +$k1 Strength
		[249] = 7786, -- +$7784s1 Beastslaying
		[250] = 7788, -- +$k1 Weapon Damage
		[254] = 7857, -- +$k1 Health
		[255] = 13380, -- +$k1 Spirit
		[369] = 34001, -- +$k1 Intellect
		[463] = 9781, -- Mithril Spike (16-20)
		[464] = 9783, -- +$7215s1% Mount Speed
		[663] = 12459, -- Scope (+$k1 Damage)
		[664] = 12460, -- Scope (+$k1 Damage)
		[723] = 7793, -- +$k1 Intellect
		[724] = 13644, -- +$k1 Stamina
		[744] = 13421, -- +$k1 Armor
		[783] = 7771, -- +$k1 Armor
		[803] = 13898, -- Fiery Weapon
		[805] = 13943, -- +$k1 Weapon Damage
		[823] = 13536, -- +$k1 Strength
		[843] = 13607, -- +$k1 Mana
		[844] = 13612, -- +$13611s1 Mining
		[845] = 13617, -- +$13614s1 Herbalism
		[846] = 24302, -- +$71691s1 Fishing
		[847] = 13626, -- +$13624s1 All Stats
		[848] = 13635, -- +$k1 Armor
		[849] = 13637, -- +$k1 Agility
		[850] = 13640, -- +$k1 Health
		[851] = 20024, -- +$k1 Spirit
		[852] = 13836, -- +$k1 Stamina
		[853] = 13653, -- +$13650s1 Beastslaying
		[854] = 13655, -- +$13651s1 Elemental Slayer
		[856] = 13661, -- +$k1 Strength
		[857] = 13663, -- +$k1 Mana
		[863] = 13689, -- +$k1 Parry
		[865] = 13698, -- +$13697s1 Skinning
		[866] = 13700, -- +$13625s1 All Stats
		[884] = 13746, -- +$k1 Armor
		[904] = 13935, -- +$k1 Agility
		[905] = 13822, -- +$k1 Intellect
		[906] = 13841, -- +$13838s1 Mining
		[907] = 13846, -- +$k1 Spirit
		[908] = 13858, -- +$k1 Health
		[909] = 13868, -- +$13839s1 Herbalism
		[910] = 25083, -- +$k1 Agility and +$k2 Dodge
		[911] = 13890, -- Minor Speed Increase
		[912] = 13915, -- Demonslaying
		[913] = 13917, -- +$k1 Mana
		[923] = 13931, -- +$k1 Dodge
		[924] = 7428, -- +$k1 Dodge
		[925] = 13646, -- +$k1 Dodge
		[927] = 13939, -- +$k1 Strength
		[928] = 13941, -- +$13824s1 All Stats
		[929] = 20020, -- +$k1 Stamina
		[930] = 13947, -- +$13927s1% Mount Speed
		[931] = 13948, -- +$k1 Haste
		[943] = 13529, -- +$k1 Weapon Damage
		[963] = 13937, -- +$k1 Weapon Damage
		[1071] = 34009, -- +$k1 Stamina
		[1075] = 44528, -- +$k1 Stamina
		[1099] = 60663, -- +$k1 Agility
		[1103] = 44633, -- +$k1 Agility
		[1119] = 44555, -- +$k1 Intellect
		[1128] = 60653, -- +$k1 Intellect
		[1147] = 44508, -- +$k1 Spirit
		[1483] = 15340, -- +$k1 Mana
		[1503] = 15389, -- +$k1 Health
		[1504] = 15391, -- +$k1 Armor
		[1505] = 15394, -- +$k1 Fire Resistance
		[1506] = 15397, -- +$k1 Strength
		[1507] = 15400, -- +$k1 Stamina
		[1508] = 15402, -- +$k1 Agility
		[1509] = 15404, -- +$k1 Intellect
		[1510] = 15406, -- +$k1 Spirit
		[1523] = 15427, -- +$k1 Mana and +$k2 Fire Resistance
		[1524] = 15429, -- +$k1 Health and +$k2 Fire Resistance
		[1525] = 15439, -- +$k1 Armor and +$k2 Fire Resistance
		[1526] = 15441, -- +$k1 Strength and +$k2 Fire Resistance
		[1527] = 15444, -- +$k1 Stamina and +$k2 Fire Resistance
		[1528] = 15446, -- +$k1 Agility and +$k2 Fire Resistance
		[1529] = 15449, -- +$k1 Intellect and +$k2 Fire Resistance
		[1530] = 15458, -- +$k1 Spirit and +$k2 Fire Resistance
		[1532] = 15463, -- +$k1 Strength, +$k2 Armor and +$k3 Fire Resistance
		[1543] = 15490, -- +$k1 Intellect, +$k2 Mana and +$k3 Fire Resistance
		[1597] = 60763, -- +$k1 Attack Power
		[1600] = 60616, -- +$k1 Attack Power
		[1603] = 60668, -- +$k1 Attack Power
		[1606] = 60621, -- +$k1 Attack Power
		[1704] = 16623, -- Thorium Spike (20-30)
		[1843] = 19057, -- Reinforced (+$k1 Armor)
		[1883] = 20008, -- +$k1 Intellect
		[1884] = 20009, -- +$k1 Spirit
		[1885] = 20010, -- +$k1 Strength
		[1886] = 20011, -- +$k1 Stamina
		[1887] = E.Wrath and 20012 or 20023, -- +$k1 Agility
		[1889] = 20015, -- +$k1 Armor
		[1890] = 20016, -- +$k1 Spirit and +$k2 Stamina
		[1891] = 20025, -- +$19988s1 All Stats
		[1892] = 20026, -- +$19990s1 Health
		[1893] = 20028, -- +$k1 Mana
		[1894] = 20029, -- Icy Chill
		[1896] = E.Wrath and 20030 or 20031, -- +$k1 Weapon Damage
		[1897] = 13695, -- +$k1 Weapon Damage
		[1898] = 20032, -- Lifestealing
		[1899] = 20033, -- Unholy Weapon
		[1900] = 20034, -- Crusader
		[1903] = 20035, -- +$k1 Spirit
		[1904] = 20036, -- +$k1 Intellect
		[1951] = 44591, -- +$k1 Dodge
		[1952] = 44489, -- +$k1 Dodge
		[1953] = 47766, -- +$k1 Dodge
		[2322] = 33999, -- +$k1 Spell Power
		[2326] = 44635, -- +$k1 Spell Power
		[2332] = 60767, -- +$k1 Spell Power
		[2381] = 44509, -- +$k1 Spirit
		[2443] = 21931, -- +$21930s1 Frost Spell Damage
		[2483] = 22593, -- +$k1 Fire Resistance
		[2484] = 22594, -- +$k1 Frost Resistance
		[2485] = 22598, -- +$k1 Arcane Resistance
		[2486] = 22597, -- +$k1 Nature Resistance
		[2487] = 22596, -- +$k1 Shadow Resistance
		[2488] = 22599, -- +$18676s1 All Resistances
		[2503] = 22725, -- +$k1 Dodge
		[2504] = 22749, -- +$k1 Spell Power
		[2505] = 22750, -- +$k1 Spell Power
		[2523] = 22779, -- +$k1 Ranged Critical Strike
		[2543] = 22840, -- +$k1 Haste
		[2544] = 22844, -- +$k1 Spell Power
		[2545] = 22846, -- +$k1 Dodge
		[2563] = 23799, -- +$k1 Strength
		[2564] = 23800, -- +$k1 Agility
		[2565] = 23801, -- +$k1 Spirit
		[2567] = 23803, -- +$k1 Spirit
		[2568] = 23804, -- +$k1 Intellect
		[2583] = 24149, -- +$k1 Dodge +$k2 Stamina +$k3 Parry
		[2584] = 24160, -- +$k1 Dodge +$k2 Stamina and +$k3 Intellect
		[2587] = 24163, -- +$k1 Spell Power and +$k2 Intellect
		[2588] = 24164, -- +$k1 Spell Power and +$k2 Critical Strike
		[2589] = 24165, -- +$k1 Spell Power and +$k2 Stamina
		[2590] = 24167, -- +$k1 Intellect +$k2 Stamina and +$k3 Spirit
		[2591] = 24168, -- +$k2 Intellect +$k3 Stamina +$k1 Spell Power
		[2603] = 13620, -- +$24303s1 Fishing
		[2604] = 24420, -- +$k1 Spell Power
		[2605] = 24421, -- +$k1 Spell Power
		[2606] = 24422, -- +$k1 Attack Power
		[2613] = 25072, -- +$25063s1% Threat
		[2614] = 25073, -- +$25064s1 Shadow Spell Power
		[2615] = 25074, -- +$25066s1 Frost Spell Power
		[2616] = 25078, -- +$25065s1 Fire Spell Power
		[2617] = 25079, -- +$k1 Spell Power
		[2621] = 25084, -- 2% Reduced Threat
		[2622] = 25086, -- +$k1 Dodge
		[2646] = 27837, -- +$k1 Agility
		[2647] = 27899, -- +$k1 Strength
		[2648] = 27906, -- +$k1 Dodge
		[2649] = 27914, -- +$k1 Stamina
		[2650] = 23802, -- +$k1 Spell Power
		[2653] = 27944, -- +$k1 Dodge
		[2654] = 27945, -- +$k1 Intellect
		[2655] = 27946, -- +$k1 Parry
		[2656] = 27948, -- +$k1 Spirit and +$k2 Stamina
		[2657] = 27951, -- +$k1 Agility
		[2658] = 27954, -- +$k1 Haste and +$k2 Critical Strike
		[2659] = 27957, -- +$k1 Health
		[2661] = 27960, -- +$144845s1 All Stats
		[2662] = 27961, -- +$k1 Armor
		[2666] = 27968, -- +$k1 Intellect
		[2667] = 27971, -- +$k1 Attack Power
		[2668] = 27972, -- +$k1 Strength
		[2669] = 27975, -- +$k1 Spell Power
		[2670] = 27977, -- +$k1 Agility
		[2671] = 27981, -- +$27979s1 Arcane and Fire Spell Power
		[2672] = 27982, -- +$27980s1 Shadow and Frost Spell Power
		[2673] = 27984, -- Mongoose
		[2674] = 28003, -- Spellsurge
		[2675] = 28004, -- Battlemaster
		[2679] = 27913, -- +$k1 Spirit
		[2681] = 28161, -- +$k1 Nature Resistance
		[2682] = 28163, -- +$k1 Frost Resistance
		[2683] = 28165, -- +$k1 Shadow Resistance
		[2714] = 29454, -- Felsteel Spike (26-38)
		[2715] = 29475, -- +$k1 Spell Power and $k2 Mana every 5 seconds
		[2716] = 29480, -- +$k1 Stamina and +$k2 Armor
		[2717] = 29483, -- +$k1 Attack Power and +$k2 Critical Strike
		[2721] = 29467, -- +$k1 Spell Power and +$k2 Critical Strike
		[2722] = 30250, -- Scope (+$k1 Damage)
		[2723] = 30252, -- Scope (+$k1 Damage)
		[2724] = 30260, -- Scope (+$k1 Critical Strike)
		[2745] = 31369, -- +$k1 Spell Power and +$k2 Stamina
		[2746] = 31370, -- +$k1 Spell Power and +$k2 Stamina
		[2747] = 31371, -- +$k1 Spell Power and +$k2 Stamina
		[2748] = 31372, -- +$k1 Spell Power and +$k2 Stamina
		[2792] = 32397, -- +$k1 Stamina
		[2793] = 32398, -- +$k1 Dodge
		[2794] = 32399, -- +$k1 Spirit
		[2841] = 44968, -- +$k1 Stamina
		[2933] = 33992, -- +$k1 PvP Resilience
		[2934] = 33993, -- +$k1 Critical Strike
		[2935] = 33994, -- +$k1 Critical Strike
		[2937] = 33997, -- +$k1 Spell Power
		[2938] = 34003, -- +$k1 PvP Power
		[2939] = 34007, -- Minor Speed and +$k2 Agility
		[2940] = 34008, -- Minor Speed and +$k2 Stamina
		[2977] = 35355, -- +$k1 Dodge
		[2978] = 35402, -- +$k1 Dodge and +$k2 Stamina
		[2979] = 35403, -- +$k1 Spell Power
		[2980] = 35404, -- +$k1 Intellect and +$k2 Spirit
		[2981] = 35405, -- +$k1 Spell Power
		[2982] = 35406, -- +$k1 Spell Power and +$k2 Critical Strike
		[2983] = 35407, -- +$k1 Attack Power
		[2984] = 35415, -- +$k1 Stamina
		[2985] = 35416, -- +$k1 Stamina
		[2986] = 35417, -- +$k1 Attack Power and +$k2 Critical Strike
		[2987] = 35418, -- +$k1 Stamina
		[2988] = 35419, -- +$k1 Stamina
		[2989] = 35420, -- +$k1 Stamina
		[2990] = 35432, -- +$k1 Dodge
		[2991] = 35433, -- +$k2 Parry and +$k1 Dodge
		[2992] = 35434, -- +$k1 Spirit
		[2993] = 35435, -- +$k1 Intellect and +$k2 Spirit
		[2994] = 35436, -- +$k1 Critical Strike
		[2995] = 35437, -- +$k2 Critical Strike and +$k1 Spell Power
		[2996] = 35438, -- +$k1 Critical Strike
		[2997] = 35439, -- +$k2 Critical Strike and +$k1 Attack Power
		[2998] = 35441, -- +$35442s1 All Resistances
		[2999] = 35443, -- +$k2 Parry and +$k1 Dodge
		[3001] = 35445, -- +$k1 Intellect and +$k2 Spirit
		[3002] = 35447, -- +$k1 Spell Power and +$k2 Critical Strike
		[3003] = 35452, -- +$k1 Attack Power and +$k2 Critical Strike
		[3004] = 35453, -- +$k2 Stamina and +$k1 PvP Resilience
		[3005] = 35454, -- +$k1 Nature Resistance
		[3006] = 35455, -- +$k1 Arcane Resistance
		[3007] = 35456, -- +$k1 Fire Resistance
		[3008] = 35457, -- +$k1 Frost Resistance
		[3009] = 35458, -- +$k1 Shadow Resistance
		[3010] = 35488, -- +$k2 Attack Power and +$k1 Critical Strike
		[3011] = 35489, -- +$k1 Stamina and +$k2 Agility
		[3012] = 35490, -- +$k2 Attack Power and +$k1 Critical Strike
		[3013] = 35495, -- +$k1 Stamina and +$k2 Agility
		[3095] = 37889, -- +$37890s1 Resist All
		[3096] = 37891, -- +$k1 Strength and +$k2 Intellect
		[3150] = 33991, -- +$k1 Spirit
		[3222] = 42620, -- +$k1 Agility
		[3223] = 42687, -- Adamantite Weapon Chain
		[3225] = 42974, -- Executioner
		[3228] = 44119, -- +$k1 Attack Power
		[3229] = 44383, -- +$k1 PvP Resilience
		[3231] = 44484, -- +$k1 Haste
		[3232] = 47901, -- +$k2 Stamina and Minor Speed Increase
		[3233] = 27958, -- +$k1 Mana
		[3234] = 44488, -- +$k1 Critical Strike
		[3236] = 44492, -- +$k1 Health
		[3238] = 44506, -- Gatherer
		[3239] = 44524, -- Icebreaker Weapon
		[3241] = 44576, -- Lifeward
		[3243] = 44582, -- +$k1 PvP Power
		[3244] = 44584, -- +$k1 Spirit and +$k2 Stamina
		[3245] = 44588, -- +$k1 PvP Resilience
		[3246] = 44592, -- +$k1 Spell Power
		[3247] = 44595, -- +$44594s1 Attack Power versus Undead
		[3249] = 44612, -- +$k1 Critical Strike
		[3251] = 44621, -- Giantslaying
		[3252] = 44623, -- +$44624s1 All Stats
		[3253] = 44625, -- +$25063s1% Threat and +$k2 Parry
		[3256] = 44631, -- +$k2 Agility and +$k1 Armor
		[3260] = 44769, -- +$k1 Stamina
		[3269] = 45697, -- +$45698s1 Fishing
		[3273] = 46578, -- Deathfrost
		[3289] = 47103, -- +10% Mount Speed
		[3294] = 47672, -- +$k1 Stamina
		[3296] = 47899, -- +$k2 Spirit and 2% Reduced Threat
		[3297] = 47900, -- +$k1 Health
		[3315] = 48401, -- +3% Mount Speed
		[3325] = 50901, -- +$k1 Stamina and +$k2 Agility
		[3326] = 50902, -- +$k2 Attack Power and +$k1 Critical Strike
		[3329] = 50906, -- +$k1 Stamina
		[3330] = 50909, -- +$k1 Stamina
		[3332] = 50913, -- +$k2 Attack Power and +$k1 Critical Strike
		[3366] = 53331, -- Rune of Lichbane
		[3367] = 53342, -- Rune of Spellshattering
		[3368] = 53344, -- Rune of the Fallen Crusader
		[3370] = 53343, -- Rune of Razorice
		[3595] = 54447, -- Rune of Spellbreaking
		[3599] = 54736, -- Electromagnetic Pulse Generator
		[3601] = 54793, -- Frag Belt
		[3605] = 55002, -- Flexweave Underlay
		[3607] = 55076, -- +$k1 Ranged Haste
		[3608] = 55135, -- +$k1 Critical Strike
		[3718] = 55630, -- +$k1 Spell Power and +$k2 Spirit
		[3719] = 55631, -- +$k1 Spell Power and +$k2 Spirit
		[3720] = 55632, -- +$k1 Spell Power and +$k2 Stamina
		[3721] = 55634, -- +$k1 Spell Power and +$k2 Stamina
		[3731] = 55836, -- Titanium Weapon Chain
		[3748] = 56353, -- Titanium Spike
		[3754] = 24162, -- +$k1 Attack Power +$k3 Stamina +$k2 Critical Strike
		[3755] = 24161, -- +$k1 Attack Power +$k2 Dodge
		[3775] = 58126, -- +$k1 Spell Power and +$k2 Critical Strike
		[3776] = 58128, -- +$k1 Attack Power and +$k2 Critical Strike
		[3777] = 58129, -- +$k2 Dodge and +$k1 Stamina
		[3788] = 59619, -- +$k1 Critical Strike
		[3789] = 59621, -- Berserking
		[3790] = 59625, -- Black Magic
		[3793] = 59771, -- +$k1 Attack Power
		[3794] = 59773, -- +$k1 Spell Power
		[3795] = 59777, -- +$k1 Attack Power and +$k2 PvP Resilience
		[3796] = 59778, -- +$k1 Spell Power and +$k2 PvP Resilience
		[3797] = 59784, -- +$k1 Spell Power and +$k2 PvP Resilience
		[3806] = 59927, -- +$k1 Spell Power and +$k2 Critical Strike
		[3807] = 59928, -- +$k1 Intellect and +$k2 Spirit
		[3808] = 59934, -- +$k1 Attack Power and +$k2 Critical Strike
		[3809] = 59936, -- +$k1 Intellect and +$k2 Spirit
		[3810] = 59937, -- +$k1 Spell Power and +$k2 Critical Strike
		[3811] = 59941, -- +$k1 Dodge and +$k2 Stamina
		[3812] = 59944, -- +$k1 Frost Resistance and +$k2 Stamina
		[3813] = 59945, -- +$k1 Nature Resistance and +$k2 Stamina
		[3814] = 59946, -- +$k1 Shadow Resistance and +$k2 Stamina
		[3815] = 59947, -- +$k1 Arcane Resistance and +$k2 Stamina
		[3816] = 59948, -- +$k1 Fire Resistance and +$k2 Stamina
		[3817] = 59954, -- +$k1 Attack Power and +$k2 Critical Strike
		[3818] = 59955, -- +$k1 Stamina and +$k2 Dodge
		[3819] = 59960, -- +$k1 Intellect and +$k2 Spirit
		[3820] = 59970, -- +$k1 Intellect and +$k2 Critical Strike
		[3822] = 60581, -- +$k1 Stamina and +$k2 Agility
		[3823] = 60582, -- +$k2 Attack Power and +$k1 Critical Strike
		[3824] = 60606, -- +$k1 Attack Power
		[3825] = 60609, -- +$k1 Haste
		[3826] = 60623, -- +$k1 Critical Strike
		[3827] = 60691, -- +$k1 Attack Power
		[3828] = 44630, -- +$k1 Attack Power
		[3829] = 44513, -- +$k1 Attack Power
		[3830] = 44629, -- +$k1 Spell Power
		[3831] = 47898, -- +$k1 Haste
		[3832] = 60692, -- +$60694s1 All Stats
		[3833] = 60707, -- +$k1 Attack Power
		[3834] = 60714, -- +$k1 Spell Power
		[3835] = 61117, -- +$k1 Attack Power and +$k2 Critical Strike
		[3836] = 61118, -- +$k1 Intellect and +$k2 Spirit
		[3837] = 61119, -- +$k2 Dodge and +$k1 Stamina
		[3838] = 61120, -- +$k1 Spell Power and +$k2 Critical Strike
		[3842] = 61271, -- +$k1 Stamina and +$k2 PvP Resilience
		[3843] = 61468, -- Scope (+$k1 Damage)
		[3844] = 44510, -- +$k1 Spirit
		[3845] = 44575, -- +$k1 Attack Power
		[3846] = 34010, -- +$k1 Spell Power
		[3847] = 62158, -- Rune of the Stoneskin Gargoyle
		[3849] = 62201, -- Titanium Plating
		[3850] = 62256, -- +$k1 Stamina
		[3851] = 62257, -- +$k1 Stamina
		[3852] = 62384, -- +$k1 Stamina and +$k2 PvP Resilience
		[3853] = 62447, -- +$k1 PvP Resilience and +$k2 Stamina
		[3854] = 62948, -- +$k1 Spell Power
		[3855] = 62959, -- +$k1 Spell Power
		[3858] = 63746, -- +$k1 Critical Strike
		[3869] = 64441, -- Blade Ward
		[3870] = 64579, -- Blood Draining
		[3872] = 56039, -- +$k1 Spell Power and +$k2 Spirit
		[3873] = 56034, -- +$k1 Spell Power and +$k2 Stamina
		[3875] = 59929, -- +$k1 Attack Power and +$k2 Critical Strike
		[3876] = 59932, -- +$k1 Dodge and +$k2 Parry
		[4061] = 74132, -- +$k1 Mastery
		[4062] = 74189, -- +$k1 Stamina and Minor Movement Speed
		[4063] = 74191, -- +$74190s1 All Stats
		[4064] = 74192, -- +$k1 PvP Power
		[4065] = 74193, -- +$k1 Haste
		[4066] = 74195, -- Mending
		[4067] = 74197, -- Avalanche
		[4068] = 74198, -- +$k1 Haste
		[4069] = 74199, -- +$k1 Haste
		[4070] = 74200, -- +$k1 Stamina
		[4071] = 74201, -- +$k1 Critical Strike
		[4072] = 74202, -- +$k1 Intellect
		[4073] = 74207, -- +$k1 Stamina
		[4074] = 74211, -- Elemental Slayer
		[4075] = 74212, -- +$k1 Strength
		[4076] = 74213, -- +$k1 Agility
		[4077] = 74214, -- +$k1 PvP Resilience
		[4082] = 74220, -- +$k1 Haste
		[4083] = 74223, -- Hurricane
		[4084] = 74225, -- Heartsong
		[4085] = 74226, -- +$k1 Mastery
		[4086] = 74229, -- +$k1 Dodge
		[4087] = 74230, -- +$k1 Critical Strike
		[4088] = 74231, -- +$k1 Spirit
		[4089] = 74232, -- +$k1 Critical Strike
		[4090] = 74234, -- +$k1 Stamina
		[4091] = 74235, -- +$k1 Intellect
		[4092] = 74236, -- +$k1 Critical Strike
		[4093] = 74237, -- +$k1 Spirit
		[4094] = 74238, -- +$k1 Mastery
		[4095] = 74239, -- +$k1 Haste
		[4096] = 74240, -- +$k1 Intellect
		[4097] = 74242, -- Power Torrent
		[4098] = 74244, -- Windwalk
		[4099] = 74246, -- Landslide
		[4100] = 74247, -- +$k1 Critical Strike
		[4101] = 74248, -- +$k1 Critical Strike
		[4102] = 74250, -- +$74249s1 All Stats
		[4103] = 74251, -- +$k1 Stamina
		[4104] = 74253, -- +$k1 Mastery and Minor Movement Speed
		[4105] = 74252, -- +$k1 Agility and Minor Movement Speed
		[4106] = 74254, -- +$k1 Strength
		[4107] = 74255, -- +$k1 Mastery
		[4108] = 74256, -- +$k1 Haste
		[4109] = 75149, -- +$k1 Intellect and +$k2 Spirit
		[4110] = 75150, -- +$k1 Intellect and +$k2 Spirit
		[4111] = 75151, -- +$k1 Intellect and +$k2 Stamina
		[4112] = 75152, -- +$k1 Intellect and +$k2 Stamina
		[4113] = 75154, -- +$k1 Intellect and +$k2 Stamina
		[4114] = 75155, -- +$k1 Intellect and +$k2 Spirit
		[4120] = 78165, -- +$k1 Stamina
		[4121] = 78166, -- +$k1 Stamina
		[4122] = 78169, -- +$k2 Attack Power and +$k1 Critical Strike
		[4124] = 78170, -- +$k1 Stamina and +$k2 Agility
		[4126] = 78171, -- +$k2 Attack Power and +$k1 Critical Strike
		[4127] = 78172, -- +$k1 Stamina and +$k2 Agility
		[4175] = 81932, -- Gnomish X-Ray Scope
		[4176] = 81933, -- +$k1 Critical Strike
		[4177] = 81934, -- +$k1 Ranged Haste
		[4187] = 84424, -- Invisibility Field
		[4188] = 84427, -- Grounded Plasma Shield
		[4193] = 86375, -- +$k1 Agility and +$k2 Mastery
		[4194] = 86401, -- +$k1 Strength and +$k2 Critical Strike
		[4195] = 86402, -- +$k1 Stamina and +$k2 Dodge
		[4196] = 86403, -- +$k1 Intellect and +$k2 Haste
		[4197] = 86847, -- +$k1 Stamina and +$k2 Dodge
		[4198] = 86854, -- +$k1 Stamina and +$k2 Dodge
		[4199] = 86898, -- +$k1 Intellect and +$k2 Haste
		[4200] = 86899, -- +$k1 Intellect and +$k2 Haste
		[4201] = 86900, -- +$k1 Strength and +$k2 Critical Strike
		[4202] = 86901, -- +$k1 Strength and +$k2 Critical Strike
		[4203] = 86906, -- +$k1 Agility and +$k2 Mastery
		[4204] = 86907, -- +$k1 Agility and +$k2 Mastery
		[4205] = 86909, -- +$k1 Agility and +$k2 Mastery
		[4206] = 86931, -- +$k1 Stamina and +$k2 Dodge
		[4207] = 86932, -- +$k1 Intellect and +$k2 Critical Strike
		[4208] = 86933, -- +$k1 Strength and +$k2 Mastery
		[4209] = 86934, -- +$k1 Agility and +$k2 Haste
		[4214] = 84425, -- Cardboard Assassin
		[4215] = 92433, -- Elementium Spike
		[4216] = 92437, -- Pyrium Spike
		[4217] = 93448, -- Pyrium Weapon Chain
		[4222] = 67839, -- Mind Amplification Dish
		[4223] = 55016, -- Nitro Boosts
		[3606] = 55016, -- Nitro Boosts
		[4227] = 95471, -- +$k1 Agility
		[4245] = 96245, -- +$k1 Intellect and +$k2 PvP Resilience
		[4246] = 96246, -- +$k1 Agility and +$k2 PvP Resilience
		[4247] = 96247, -- +$k1 Strength and +$k2 PvP Resilience
		[4248] = 96249, -- +$k1 Intellect and +$k2 PvP Resilience
		[4249] = 96250, -- +$k1 Strength and +$k2 PvP Resilience
		[4250] = 96251, -- +$k1 Agility and +$k2 PvP Resilience
		[4256] = 96261, -- +$k1 Strength
		[4257] = 96262, -- +$k1 Intellect
		[4258] = 96264, -- +$k1 Agility
		[4259] = 96286, -- +$96285s1 Fishing
		[4267] = 99623, -- Flintlocke's Woodchucker
		[4270] = 101598, -- +$k1 Stamina and +$k2 Dodge
		[4411] = 104338, -- +$k1 Mastery
		[4412] = 104385, -- +$k1 Dodge
		[4414] = 104389, -- +$k1 Intellect
		[4415] = 104390, -- +$k1 Strength
		[4416] = 104391, -- +$k1 Agility
		[4417] = 104392, -- +$k1 PvP Resilience
		[4418] = 104393, -- +$k1 Spirit
		[4419] = 104395, -- +$k1 All Stats
		[4420] = 104397, -- +$k1 Stamina
		[4421] = 104398, -- +$k1 Critical Strike
		[4422] = 104401, -- +$k1 Stamina
		[4423] = 104403, -- +$k1 Intellect
		[4424] = 104404, -- +$k1 Critical Strike
		[4426] = 104407, -- +$k1 Haste
		[4427] = 104408, -- +$k1 Critical Strike
		[4428] = 104409, -- +$k1 Agility & Minor Speed Increase
		[4429] = 104414, -- +$k1 Mastery & Minor Speed Increase
		[4430] = 104416, -- +$k1 Haste
		[4431] = 104417, -- +$k1 Haste
		[4432] = 104419, -- +$k1 Strength
		[4433] = 104420, -- +$k1 Mastery
		[4434] = 104445, -- +$k1 Intellect
		[4441] = 104425, -- Windsong
		[4442] = 104427, -- Jade Spirit
		[4443] = 104430, -- Elemental Force
		[4444] = 104434, -- Dancing Steel
		[4445] = 104440, -- Colossus
		[4446] = 104442, -- River's Song
		[4687] = 108115, -- +$k2 Agility
		[4699] = 109086, -- Lord Blastington's Scope of Doom
		[4700] = 109093, -- Mirror Scope
		[4717] = 110764, -- Pandamonium
		[4719] = 113011, -- Placeholder Shoulder Enchant
		[4720] = 7418, -- +$k1 Health
		[4721] = 7457, -- +$k1 Stamina
		[4722] = 13378, -- +$k1 Stamina
		[4723] = 7745, -- +$k1 Weapon Damage
		[4724] = 13419, -- +$k1 Agility
		[4725] = 7779, -- +$k1 Agility
		[4726] = 13687, -- +$k1 Spirit
		[4727] = 7859, -- +$k1 Spirit
		[4728] = 13485, -- +$k1 Spirit
		[4729] = 13622, -- +$k1 Intellect
		[4730] = 13501, -- +$k1 Stamina
		[4731] = 13631, -- +$k1 Stamina
		[4732] = 71692, -- +$71691s1 Fishing
		[4733] = 13464, -- +$k1 Armor
		[4734] = 13882, -- +$k1 Agility
		[4735] = 13642, -- +$k1 Spirit
		[4736] = 13659, -- +$k1 Spirit
		[4737] = 13648, -- +$k1 Stamina
		[4738] = 13817, -- +$k1 Stamina
		[4739] = 13887, -- +$k1 Strength
		[4740] = 13815, -- +$k1 Agility
		[4741] = 13905, -- +$k1 Spirit
		[4742] = 20013, -- +$k1 Strength
		[4743] = 13945, -- +$k1 Stamina
		[4744] = 20017, -- +$k1 Stamina
		[4745] = 13693, -- +$k1 Weapon Damage
		[4746] = 27967, -- +$k1 Weapon Damage
		[4747] = 44500, -- +$k1 Agility
		[4748] = 44589, -- +$k1 Agility
		[4750] = 82200, -- Spinal Healing Injector
		[4803] = 121192, -- +$k1 Strength and +$k2 Critical Strike
		[4804] = 121193, -- +$k1 Agility and +$k2 Critical Strike
		[4805] = 121194, -- +$k1 Stamina and +$k2 Dodge
		[4806] = 121195, -- +$k1 Intellect and +$k2 Critical Strike
		[4808] = 121988, -- Magic Weapon
		[4822] = 122387, -- +$k1 Agility and +$k2 Critical Strike
		[4823] = 122388, -- +$k1 Strength and +$k2 Critical Strike
		[4824] = 122386, -- +$k1 Stamina and +$k2 Dodge
		[4825] = 122392, -- +$k1 Intellect and +$k2 Critical Strike
		[4826] = 122393, -- +$k1 Intellect and +$k2 Spirit
		[4869] = 124091, -- +$k1 Stamina
		[4870] = 124116, -- +$k1 Stamina and +$k2 Dodge
		[4871] = 124118, -- +$k1 Agility and +$k2 Critical Strike
		[4872] = 124119, -- +$k1 Strength and +$k2 Critical Strike
		[4880] = 124559, -- +$k1 Agility and +$k2 Critical Strike
		[4881] = 124561, -- +$k1 Strength and +$k2 Critical Strike
		[4882] = 124563, -- +$k1 Stamina and +$k2 Dodge
		[4883] = 124564, -- +$k1 Agility and +$k2 Critical Strike
		[4884] = 124565, -- +$k1 Stamina and +$k2 Dodge
		[4885] = 124566, -- +$k1 Strength and +$k2 Critical Strike
		[4886] = 124567, -- +$k1 Agility and +$k2 Critical Strike
		[4887] = 124568, -- +$k1 Stamina and +$k2 Dodge
		[4888] = 124569, -- +$k1 Strength and +$k2 Critical Strike
		[4895] = 125496, -- +$k1 Intellect and +$k2 Critical Strike
		[4896] = 125497, -- +$k1 Intellect and +$k2 Spirit
		[4897] = 126392, -- Goblin Glider
		[4907] = 127015, -- +$k1 Strength and +$k2 Critical Strike
		[4908] = 127014, -- +$k1 Agility and +$k2 Critical Strike
		[4909] = 127013, -- +$k1 Intellect and +$k2 Critical Strike
		[4910] = 127012, -- +$k1 Stamina and +$k2 Dodge
		[4912] = 113048, -- +$k1 Stamina and +$k2 Dodge
		[4913] = 113047, -- +$k1 Strength and +$k2 Critical Strike
		[4914] = 113046, -- +$k1 Agility and +$k2 Critical Strike
		[4915] = 113045, -- +$k1 Intellect and +$k2 Critical Strike
		[4916] = 113044, -- +$k1 Spirit and +$k2 Critical Strike
		[4918] = 128286, -- Living Steel Weapon Chain
		[4992] = 130749, -- +$k1 Strength (Scaling)
		[4993] = 130758, -- +$k1 Parry
		[5000] = 109099, -- Watergliding Jets
		[5001] = 131464, -- Ghost Iron Spike
		[5003] = 131862, -- +$k1 Intellect and +$k2 Critical Strike
		[5004] = 131863, -- +$k1 Intellect and +$k2 Spirit
		[5035] = 139631, -- +$k1 PvP Power, Disarm Duration Reduction
		[5055] = 141167, -- +$k1 Intellect and +$k2 Critical Strike
		[5056] = 141168, -- +$k1 Intellect
		[5057] = 141170, -- +$k1 Intellect
		[5058] = 141173, -- +$k1 Haste
		[5059] = 141174, -- +$k1 Intellect and +$k2 Critical Strike
		[5060] = 141175, -- +$k1 Mastery & Minor Speed Increase
		[5061] = 141176, -- +$k1 Intellect
		[5062] = 141177, -- Jade Spirit
		[5063] = 141330, -- Synapse Springs
		[5076] = 141445, -- +$k1 PvP Resilience
		[5080] = 141862, -- +$k1 Mastery
		[5081] = 141868, -- +$k1 Mastery
		[5091] = 141971, -- +$k1 Intellect and +$k2 Critical Strike
		[5092] = 141973, -- +$k1 Intellect
		[5093] = 141974, -- +$k1 Intellect
		[5094] = 141975, -- +$k1 Haste
		[5095] = 141976, -- +$k1 Intellect and +$k2 Critical Strike
		[5096] = 141977, -- +$k1 Mastery & Minor Speed Increase
		[5097] = 141978, -- +$k1 Intellect
		[5098] = 141981, -- Jade Spirit
		[5099] = 141982, -- +$k1 PvP Resilience
		[5100] = 141983, -- +$k1 Mastery
		[5101] = 141984, -- +$k1 Mastery
		[5110] = 142173, -- Lightweave Embroidery
		[5111] = 142175, -- +$k1 All Stats
		[5112] = 142177, -- +$k1 Intellect
		[5113] = 142178, -- +$k1 Intellect
		[5124] = 142469, -- Spirit of Conquest
		[5125] = 142468, -- Bloody Dancing Steel
		[5183] = 27911, -- +$k1 Spell Power
		[5184] = 27917, -- +$k1 Spell Power
		[5237] = 33990, -- +$k1 Spirit
		[5250] = 33995, -- +$k1 Strength
		[5255] = 33996, -- +$k1 Attack Power
		[5257] = 34002, -- +$k1 Attack Power
		[5258] = 34004, -- +$k1 Agility
		[5259] = 44529, -- +$k1 Agility
		[5260] = 46594, -- +$k1 Dodge
		[5274] = 155692, -- +$25065s1 Fire Spell Power
		[5275] = 156050, -- Oglethorpe's Missile Splitter
		[5276] = 156061, -- Megawatt Filament
		[5281] = 158877, -- +$k1 Critical Strike
		[5284] = 158907, -- +$k1 Critical Strike
		[5285] = 158892, -- +$k1 Critical Strike
		[5292] = 158893, -- +$k1 Haste
		[5293] = 158894, -- +$k1 Mastery
		[5294] = 158895, -- +$k1 Multistrike
		[5295] = 158896, -- +$k1 Versatility
		[5297] = 158908, -- +$k1 Haste
		[5298] = 158878, -- +$k1 Haste
		[5299] = 158909, -- +$k1 Mastery
		[5300] = 158879, -- +$k1 Mastery
		[5301] = 158910, -- +$k1 Multistrike
		[5302] = 158880, -- +$k1 Multistrike
		[5303] = 158911, -- +$k1 Versatility
		[5304] = 158881, -- +$k1 Versatility
		[5310] = 158884, -- +$k1 Critical Strike & +$182495s1% Speed
		[5311] = 158885, -- +$k1 Haste & +$182495s1% Speed
		[5312] = 158886, -- +$k1 Mastery & +$182495s1% Speed
		[5313] = 158887, -- +$k1 Multistrike & +$182495s1% Speed
		[5314] = 158889, -- +$k1 Versatility & +$182495s1% Speed
		[5317] = 158899, -- +$k1 Critical Strike
		[5318] = 158900, -- +$k1 Haste
		[5319] = 158901, -- +$k1 Mastery
		[5320] = 158902, -- +$k1 Multistrike
		[5321] = 158903, -- +$k1 Versatility
		[5324] = 158914, -- +$k1 Critical Strike
		[5325] = 158915, -- +$k1 Haste
		[5326] = 158916, -- +$k1 Mastery
		[5327] = 158917, -- +$k1 Multistrike
		[5328] = 158918, -- +$k1 Versatility
		[5330] = 159235, -- Mark of the Thunderlord
		[5331] = 159236, -- Mark of the Shattered Hand
		[5334] = 159672, -- Mark of the Frostwolf
		[5335] = 159673, -- Mark of Shadowmoon
		[5336] = 159674, -- Mark of Blackrock
		[5337] = 159671, -- Mark of Warsong
		[5352] = 170627, -- Glory of the Thunderlord
		[5353] = 170628, -- Glory of the Shadowmoon
		[5354] = 170629, -- Glory of the Blackrock
		[5355] = 170630, -- Glory of the Warsong
		[5356] = 170631, -- Glory of the Frostwolf
		[5357] = 170886, -- +4 Fishing
		[5383] = 173287, -- Hemet's Heartseeker
		[5384] = 173323, -- Mark of Bleeding Hollow
	}
	local db = {
		-- Enchant Ranged Weapon
		[6195] = { 172921, 321535, nil }, -- Infra-green Reflex Sight
		[6196] = { 172920, 321536, nil }, -- Optical Target Embiggener

		-- Enchant Weapon
		[6229] = { 172366, 309627, nil }, -- Celestial Guidance
		[6227] = { 172365, 309622, nil }, -- Ascended Vigor
		[6226] = { 172367, 309621, nil }, -- Eternal Grace
		[6223] = { 172370, 309620, nil }, -- Lightless Force
		[6228] = { 172368, 309623, nil }, -- Sinful Revelation

		-- Enchant Cloak
		[6203] = { 172411, 309530, nil }, -- Fortified Avoidance
		[6204] = { 172412, 309531, nil }, -- Fortified Leech
		[6202] = { 172410, 309528, nil }, -- Fortified Speed
		[6208] = { 177660, 323755, nil }, -- Soul Vitality

		-- Enchant Chest
		[6216] = { 177716, 323762, nil }, -- Sacred Stats
		[6265] = { 183738, 342316, nil }, -- Eternal Insight
		[6213] = { 172418, 309535, nil }, -- Eternal Bulwark
		[6230] = { 177962, 324773, nil }, -- Eternal Stats
		[6217] = { 177715, 323761, nil }, -- Eternal Bounds
		[6214] = { 177659, 323760, nil }, -- Eternal Skirmish

		-- Enchant Bracers
		[6222] = { 172416, 309610, nil }, -- Shaded Hearthing
		[6219] = { 172414, 309608, nil }, -- Illuminated Soul
		[6220] = { 172415, 309609, nil }, -- Eternal Intellect

		-- Enchant Gloves
		[6205] = { 172406, 309524, nil }, -- Shadowlands Gathering
		[6209] = { 172407, 309525, nil }, -- Strength of Soul
		[6210] = { 172408, 309526, nil }, -- Eternal Strength

		-- Enchant Boots
		[6207] = { 177661, 323609, nil }, -- Soul Treads
		[6212] = { 172413, 309532, nil }, -- Agile Soulwalker
		[6211] = { 172419, 309534, nil }, -- Eternal Agility

		-- Death Knight Runes
		[6243] = { nil, 326911, nil }, -- Rune of Hysteria
		[6241] = { nil, 326805, nil }, -- Rune of Sanguination
		[6242] = { nil, 326855, nil }, -- Rune of Spellwarding
		[6244] = { nil, 326977, nil }, -- Rune of Unending Thirst
		[6245] = { nil, 327082, nil }, -- Rune of the Apocalypse

		--Enchant Ring
		[6163] = { 172357, 309612, nil }, -- Bargain of Critical Strike
		[6165] = { 172358, 309613, nil }, -- Bargain of Haste
		[6167] = { 172359, 309614, nil }, -- Bargain of Mastery
		[6169] = { 172360, 309615, nil }, -- Bargain of Versatility
		[6164] = { 172361, 309616, nil }, -- Tenet of Critical Strike
		[6166] = { 172362, 309617, nil }, -- Tenet of Haste
		[6168] = { 172363, 309618, nil }, -- Tenet of Mastery
		[6170] = { 172364, 309619, nil }, -- Tenet of Versatility

		--BfA
		--Enchant Ring
		[5942] = { 153442, 255075, 162716 }, -- Pact of Critical Strike
		[5943] = { 153443, 255076, 162717 }, -- Pact of Haste
		[5944] = { 153444, 255077, 162718 }, -- Pact of Mastery
		[5945] = { 153445, 255078, 162719 }, -- Pact of Versatility
		[5938] = { 153438, 255071, 162298 }, -- Seal of Critical Strike
		[5939] = { 153439, 255072, 162299 }, -- Seal of Haste
		[5940] = { 153440, 255073, 162300 }, -- Seal of Mastery
		[5941] = { 153441, 255074, 162301 }, -- Seal of Versatility

		-- Enchant Gloves
		[5932] = { 159464, 267458, nil }, -- Zandalari Herbalism
		[5933] = { 159466, 267482, nil }, -- Zandalari Mining
		[5934] = { 159467, 267486, nil }, -- Zandalari Skinning
		[5935] = { 159468, 267490, nil }, -- Zandalari Surveying
		[5937] = { 159471, 267498, nil }, -- Zandalari Crafting

		-- Enchant Bracers
		[5971] = { 160330, 271433, nil }, -- Cooled Hearthing
		[5970] = { 160328, 271366, nil }, -- Safe Hearthing
		[5936] = { 159469, 267495, nil }, -- Swift Hearthing

		-- Enchant Weapon
		[5946] = { 153476, 255103, nil }, --Coastal Surge
		[5650] = { 153480, 255141, nil }, --Gale-Force Striking
		[5949] = { 153479, 255129, nil }, --Torrent of Elements
		[5948] = { 153478, 255110, nil }, --Siphoning
		[5965] = { 159785, 268907, nil }, --Deadly Navigation
		[5964] = { 159787, 268901, nil }, --Masterful Navigation
		[5963] = { 159786, 268894, nil }, --Quick Navigation
		[5966] = { 159789, 268913, nil }, --Stalwart Navigation
		[5962] = { 159788, 268852, nil }, --Versatile Navigation

		[6108] = { 168446, 298009, nil }, -- Accord of Critical Strike
		[6109] = { 168447, 297989, nil }, -- Accord of Haste
		[6110] = { 168448, 297995, nil }, -- Accord of Mastery
		[6111] = { 168449, 297993, nil }, -- Accord of Versatility

		[6112] = { 168593, 298433, nil }, --Machinist's Brilliance
		[6148] = { 168596, 298440, nil }, --Force Multiplier
		[6149] = { 168592, 298438, nil }, --Oceanic Restoration
		[6150] = { 168598, 298442, nil }, --Naga Hide
		-- WoD:

		-- Enchant Ring
		[5284] = { 110617, 158907, 118448 }, -- Breath of Critical Strike
		[5297] = { 110618, 158908, 118449 }, -- Breath of Haste
		[5299] = { 110619, 158909, 118450 }, -- Breath of Mastery
		[5301] = { 110620, 158910, 118451 }, -- Breath of Multistrike
		[5303] = { 110621, 158911, 118452 }, -- Breath of Versatility
		[5324] = { 110638, 158914, 118453 }, -- Gift of Critical Strike
		[5325] = { 110639, 158915, 118454 }, -- Gift of Haste
		[5326] = { 110640, 158916, 118455 }, -- Gift of Mastery
		[5327] = { 110641, 158917, 118456 }, -- Gift of Multistrike
		[5328] = { 110642, 158918, 118457 }, -- Gift of Versatility

		-- Enchant Neck
		[5285] = { 110624, 158892, 118438 }, -- Breath of Critical Strike
		[5292] = { 110625, 158893, 118439 }, -- Breath of Haste
		[5293] = { 110626, 158894, 118440 }, -- Breath of Mastery
		[5294] = { 110627, 158895, 118441 }, -- Breath of Multistrike
		[5295] = { 110628, 158896, 118442 }, -- Breath of Versatility
		[5317] = { 110645, 158899, 118443 }, -- Gift of Critical Strike
		[5318] = { 110646, 158900, 118444 }, -- Gift of Haste
		[5319] = { 110647, 158901, 118445 }, -- Gift of Mastery
		[5320] = { 110648, 158902, 118446 }, -- Gift of Multistrike
		[5321] = { 110649, 158903, 118447 }, -- Gift of Versatility

		-- Enchant Cloak
		[5281] = { 110631, 158877, 118394 }, -- Breath of Critical Strike
		[5298] = { 110632, 158878, 118429 }, -- Breath of Haste
		[5300] = { 110633, 158879, 118430 }, -- Breath of Mastery
		[5302] = { 110634, 158880, 118431 }, -- Breath of Multistrike
		[5304] = { 110635, 158881, 118432 }, -- Breath of Versatility
		[5310] = { 110652, 158884, 118433 }, -- Gift of Critical Strike
		[5311] = { 110653, 158885, 118434 }, -- Gift of Haste
		[5312] = { 110654, 158886, 118435 }, -- Gift of Mastery
		[5313] = { 110655, 158887, 118436 }, -- Gift of Multistrike
		[5314] = { 110656, 158889, 118437 }, -- Gift of Versatility

		-- Enchant Ranged Weapon
		[5275] = { 109120, 156050, 118477 }, -- Oglethorpe's Missile Splitter
		[5276] = { 109122, 156061, 118478 }, -- Megawatt Filament
		[5383] = { 118008, 173287, 118495 }, -- Hemet's Heartseeker

		-- Enchant Fishing Pole
		[5357] = { 116117, 170886, nil }, -- Rook's Lucky Fishin' Line

		-- Enchant Weapon
		[5330] = { 110682, 159235, 159235 }, -- Mark of the Thunderlord
		[5331] = { 112093, 159236, 159236 }, -- Mark of the Shattered Hand
		[5335] = { 112115, 159673, 159673 }, -- Mark of Shadowmoon
		[5336] = { 112160, 159674, 159674 }, -- Mark of Blackrock
		[5337] = { 112164, 159671, 159671 }, -- Mark of Warsong
		[5334] = { 112165, 159672, 159672 }, -- Mark of the Frostwolf
		[5352] = { 115973, 170627, 170627 }, -- Glory of the Thunderlord
		[5353] = { 115975, 170628, 170628 }, -- Glory of the Shadowmoon
		[5354] = { 115976, 170629, 170629 }, -- Glory of the Blackrock
		[5355] = { 115977, 170630, 170630 }, -- Glory of the Warsong
		[5356] = { 115978, 170631, 170631 }, -- Glory of the Frostwolf

		-- Death Knight Runes
		[3370] = { nil, 53343, nil }, -- Rune of Razorice
		[3595] = { nil, 54447, nil }, -- Rune of Spellbreaking
		[3367] = { nil, 53342, nil }, -- Rune of Spellshattering
		[3366] = { nil, 53331, nil }, -- Rune of Lichbane
		[3368] = { nil, 53344, nil }, -- Rune of the Fallen Crusader
		[3847] = { nil, 62158, nil }, -- Rune of the Stoneskin Gargoyle

		-- Legion:

		-- Enchant Ring
		[5423] = { 128537, 190866, 128562 }, -- Word of Critical Strike
		[5424] = { 128538, 190867, 128563 }, -- Word of Haste
		[5425] = { 128539, 190868, 128564 }, -- Word of Mastery
		[5426] = { 128540, 190869, 128565 }, -- Word of Versatility
		[5427] = { 128541, 190870, 128566 }, -- Binding of Critical Strike
		[5428] = { 128542, 190871, 128567 }, -- Binding of Haste
		[5429] = { 128543, 190872, 128568 }, -- Binding of Mastery
		[5430] = { 128544, 190873, 128569 }, -- Binding of Versatility

		-- Enchant Cloak
		[5431] = { 128545, 190874, 128570 }, -- Word of Strength
		[5432] = { 128546, 190875, 128571 }, -- Word of Agility
		[5433] = { 128547, 190876, 128572 }, -- Word of Intellect
		[5434] = { 128548, 190877, 128573 }, -- Binding of Strength
		[5435] = { 128549, 190878, 128574 }, -- Binding of Agility
		[5436] = { 128550, 190879, 128575 }, -- Binding of Intellect

		-- Enchant Neck
		[5437] = { 128551, 190892, 128576 }, -- Mark of the Claw
		[5438] = { 128552, 190893, 128577 }, -- Mark of the Distant Army
		[5439] = { 128553, 190894, 128578 }, -- Mark of the Hidden Satyr
		[5889] = { 141908, 228402, 141911 }, -- Mark of the Heavy Hide
		[5890] = { 141909, 228405, 141912 }, -- Mark of the Trained Soldier
		[5891] = { 141910, 228408, 141913 }, -- Mark of the Ancient Priestess
		[5895] = { 144304, 235695, 144308 }, -- Mark of the Master
		[5896] = { 144305, 235696, 144311 }, -- Mark of the Versatile
		[5897] = { 144306, 235697, 144314 }, -- Mark of the Quick
		[5898] = { 144307, 235698, 144317 }, -- Mark of the Deadly

		-- Enchant Gloves
		[5444] = { 128558, 190988, 128617 }, -- Legion Herbalism
		[5445] = { 128559, 190989, 128618 }, -- Legion Mining
		[5446] = { 128560, 190990, 128619 }, -- Legion Skinning
		[5447] = { 128561, 190991, 128620 }, -- Legion Surveying

		-- Enchant Shoulder
		[5440] = { 128554, 190954, nil }, -- Boon of the Scavenger
		[5441] = { 140213, 190955, nil }, -- Boon of the Gemfinder
		[5442] = { 140214, 190956, nil }, -- Boon of the Harvester
		[5443] = { 140215, 190957, nil }, -- Boon of the Butcher
		[5881] = { 140217, 222851, nil }, -- Boon of the Salvager
		[5882] = { 140218, 222852, nil }, -- Boon of the Manaseeker
		[5883] = { 140219, 222853, nil }, -- Boon of the Bloodhunter
		[5888] = { 141861, 228139, nil }, -- Boon of the Nether
		[5931] = { 153247, 254706, nil }, -- Boon of the Lightbearer
		[5929] = { 153197, 254584, nil }, -- Boon of the Steadfast
	}

	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------POOL FUNCTION
	local Pool = {}
	Pool.__index = Pool
	ElvUI_EltreumUI.Pool = Pool
	function Pool:new(categorizeCallback, allocateCallback, reuseCallback, releaseCallback)
		return setmetatable({
			categorizeCallback = categorizeCallback,
			allocateCallback = allocateCallback,
			reuseCallback = reuseCallback,
			releaseCallback = releaseCallback,
			allocated = {},
			released = {},
			defaultCategory = {},
		}, self)
	end

	function Pool:Allocate(...)
		local category = self.categorizeCallback(...) or self.defaultCategory
		local result
		if self.released[category] and #self.released[category] > 0 then
			result = table.remove(self.released[category])
			self.allocated[result] = category
			self.reuseCallback(result, ...)
		else
			result = self.allocateCallback(...)
			self.allocated[result] = category
		end
		return result
	end

	function Pool:Release(ref)
		--print(ref)
		if not self.allocated[ref] then
			return --error("Pool:Release failed: bad reference")
		end
		local category = self.allocated[ref]
		self.allocated[ref] = nil
		if not self.released[category] then
			self.released[category] = {}
		end
		table.insert(self.released[category], ref)
		self.releaseCallback(ref)
	end

	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------SLOTICON
	local SlotIcon = {}
	SlotIcon.__index = SlotIcon
	ElvUI_EltreumUI.SlotIcon = SlotIcon
	function SlotIcon:new(parent)
		local frame = CreateFrame("FRAME", "EltruismSocketsEnchants", parent)
		frame.icon = frame:CreateTexture(nil, "OVERLAY", nil, 0)
		frame.icon:SetAllPoints()
		frame.overlay = frame:CreateTexture(nil, "OVERLAY", nil, 1)
		frame.overlay:SetPoint("TOPLEFT", frame, "TOPLEFT", -9, 9)
		frame.overlay:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 9, -9)
		return setmetatable({
			frame = frame,
			texture = nil,
			hidden = nil,
		}, self)
	end

	local function PostLink(link)
		if _G.MacroFrameText and _G.MacroFrameText:IsShown() and _G.MacroFrameText:HasFocus() then
			local text = _G.MacroFrameText:GetText()..link
			if 255 >= strlenutf8(text) then
				_G.MacroFrameText:Insert(link)
			end
		elseif ChatEdit_GetActiveWindow() then
			ChatEdit_InsertLink(link)
		end
	end

	function SlotIcon:Hide()
		self.frame:SetAlpha(0.0)
		self.frame:SetScript("OnEnter", nil)
		self.frame:SetScript("OnLeave", nil)
		self.frame:SetScript("OnMouseUp", nil)
		self.hidden = true
	end

	function SlotIcon:SetHyperlink(itemInfo)
		self.frame.icon:SetTexture(itemInfo:getTextureName())
		self.frame:SetAlpha(1.0)
		self.hidden = false
	end

	function SlotIcon:Render(textureName, tooltip, overlayAtlas)
		self:Hide()
		self.frame:SetAlpha(1.0)
		self.frame.icon:SetTexture(textureName)
		self.frame.icon:SetTexCoord(0.08,0.92,0.08,0.92) --trim the border
		if overlayAtlas ~= nil then
			self.frame.overlay:Show()
			self.frame.overlay:SetAtlas(overlayAtlas, true)
		else
			self.frame.overlay:Hide()
		end
		self.frame:SetScript("OnEnter", function ()
			tooltip:Show(self.frame)
		end)
		self.frame:SetScript("OnLeave", function ()
			tooltip:Hide()
		end)
		self.frame:SetScript("OnMouseUp", function ()
			if tooltip and tooltip:HasLink() and IsModifiedClick("CHATLINK") then
				PostLink(tooltip:GetLink())
			end
		end)
		self.hidden = false
	end

	function SlotIcon:isHidden()
		return self.hidden
	end

	local pool = ElvUI_EltreumUI.Pool:new(
		function (...)
			return nil
		end,
		function (parent)
			local ref = SlotIcon:new(parent)
			ref:Hide()
			return ref
		end,
		function (ref, parent)
			ref.frame:SetParent(parent)
		end,
		function (ref)
			ref:Hide()
			ref.frame:SetParent(nil)
			ref.frame:ClearAllPoints()
		end
	)
	ElvUI_EltreumUI.AllocateSlotIcon = function (parent)
		return pool:Allocate(parent)
	end
	ElvUI_EltreumUI.ReleaseSlotIcon = function (ref)
		pool:Release(ref)
	end
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------FRAMEADAPTER
	local AceEvent = LibStub('AceEvent-3.0')
	local FrameAdapter = {}
	local FrameAdapterMetaTable = { __index = FrameAdapter }
	function FrameAdapter:new(frame, utilityParentFrame, slotFramePrefix)
		local instance = {
			frame = frame,
			utilityParentFrame = utilityParentFrame,
			slotFramePrefix = slotFramePrefix,
			utilityChildFrame = nil,
			callbacks = {},
			onFrameShow = {},
			onFrameHide = {},
			messages = {
				contentChanged = 'FrameAdapter.contentChanged',
			},
		}
		instance.utilityChildFrame = CreateFrame('FRAME', nil, instance.utilityParentFrame)
		setmetatable(instance, FrameAdapterMetaTable)
		AceEvent:Embed(instance)
		return instance
	end

	function FrameAdapter:GetType()
		return self.slotFramePrefix
	end

	function FrameAdapter:GetFrame()
		return self.frame
	end

	function FrameAdapter:_OnUtilityFrameEvent(event, callback)
		if not self.callbacks[event] then
			self.callbacks[event] = {}

			self.frame:SetScript(event, function()
				for _, callback in ipairs(self.callbacks[event]) do
					callback()
				end
			end)
		end
		table.insert(self.callbacks[event], callback)
	end

	function FrameAdapter:OnShow(callback)
		self:_OnUtilityFrameEvent('OnShow', callback)
	end
	function FrameAdapter:OnHide(callback)
		self:_OnUtilityFrameEvent('OnHide', callback)
	end
	function FrameAdapter:OnContentChanged(callback, ...)
		self:RegisterMessage(self.messages.contentChanged, callback, ...)
	end
	function FrameAdapter:GetSlotFrame(slotName)
		return _G[self.slotFramePrefix .. slotName]
	end
	ElvUI_EltreumUI.FrameAdapter = FrameAdapter
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------CHARACTER FRAME ADAPTER
	local CharacterFrameAdapter = {}
	local CharacterFrameAdapterMetaTable = { __index = CharacterFrameAdapter }
	setmetatable(CharacterFrameAdapter, { __index = ElvUI_EltreumUI.FrameAdapter })
	function CharacterFrameAdapter:new()
		local instance = ElvUI_EltreumUI.FrameAdapter:new(_G.CharacterModelFrame, _G.CharacterModelFrame, 'Character')
		instance.messages = {
			contentChanged = 'CharacterFrameAdapter.contentChanged',
		}

		setmetatable(instance, CharacterFrameAdapterMetaTable)
		instance:RegisterEvent("UNIT_INVENTORY_CHANGED", function(_, unit)
			if unit == 'player' then
				instance:SendMessage(instance.messages.contentChanged)
			end
		end)
		instance:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", function()
			instance:SendMessage(instance.messages.contentChanged)
		end)
		instance:RegisterEvent("SOCKET_INFO_CLOSE", function()
			instance:SendMessage(instance.messages.contentChanged)
		end)
		instance:RegisterEvent("SOCKET_INFO_SUCCESS", function()
			instance:SendMessage(instance.messages.contentChanged)
		end)
		instance:RegisterEvent("SOCKET_INFO_UPDATE", function()
			instance:SendMessage(instance.messages.contentChanged)
		end)
		return instance
	end

	function CharacterFrameAdapter:GetUnit()
		return "player"
	end
	ElvUI_EltreumUI.CharacterFrameAdapter = CharacterFrameAdapter
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------INSPECTION FRAME ADAPTER
	local InspectionFrameAdapter = {}
	local InspectionFrameAdapterMetaTable = { __index = InspectionFrameAdapter }
	setmetatable(InspectionFrameAdapter, { __index = ElvUI_EltreumUI.FrameAdapter })
	function InspectionFrameAdapter:new()
		if E.db.ElvUI_EltreumUI.skins.socketsinspect then
			local instance = ElvUI_EltreumUI.FrameAdapter:new(_G.InspectModelFrame, _G.PaperDollFrame, 'Inspect')
			instance.messages = {
				contentChanged = 'InspectionFrameAdapter.contentChanged',
			}
			setmetatable(instance, InspectionFrameAdapterMetaTable)
			instance:RegisterEvent("UNIT_INVENTORY_CHANGED", function(_, unit)
				if unit ~= 'player' then
					instance:SendMessage(instance.messages.contentChanged)
				end
			end)
			return instance
		end
	end

	function InspectionFrameAdapter:GetUnit()
		if E.db.ElvUI_EltreumUI.skins.socketsinspect then
			return _G.InspectFrame.unit
		end
	end
	ElvUI_EltreumUI.InspectionFrameAdapter = InspectionFrameAdapter
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------SLOT ICON MANAGER
	local SlotIconManager = {
		STYLE = {
			UPGRADES = 1,
			UPGRADES_SUMMARY = 2,
			ENABLED = 4,
			SMALL = 8,
			COLOR = 16,
		}
	}
	local SlotIconManagerMetaTable = { __index = SlotIconManager }
	ElvUI_EltreumUI.SlotIconManager = SlotIconManager

	function SlotIconManager:new(adapter)
		local instance = {
			adapter = adapter,
			slotIcons = {},
			slotText = {},
			hostVisible = false,
			style = nil,
			slotNames = {
				'HeadSlot',
				'NeckSlot',
				'ShoulderSlot',
				'BackSlot',
				'ChestSlot',
				--'ShirtSlot',
				--'TabardSlot',
				'WristSlot',
				'HandsSlot',
				'WaistSlot',
				'LegsSlot',
				'FeetSlot',
				'Finger0Slot',
				'Finger1Slot',
				'Trinket0Slot',
				'Trinket1Slot',
				'MainHandSlot',
				'SecondaryHandSlot',
				'RangedSlot',
			},
			rightAlignedSlots = {
				HeadSlot = true,
				NeckSlot = true,
				ShoulderSlot = true,
				BackSlot = true,
				ChestSlot = true,
				ShirtSlot = true,
				TabardSlot = true,
				WristSlot = true,
			},

			topAlignedSlots = {
				RangedSlot = true,
				MainHandSlot = true,
				SecondaryHandSlot = true,
			},

			slotsWithRequiredEnchants = {
				HeadSlot = true,
				-- NeckSlot = true,
				ShoulderSlot = true,
				BackSlot = true,
				ChestSlot = true,
				WristSlot = true,
				HandsSlot = true,
				--WaistSlot = E.Wrath and true or false,
				LegsSlot = true,
				FeetSlot = true,
				--Finger0Slot = true,
				--Finger1Slot = true,
				-- Trinket0Slot = true,
				-- Trinket1Slot = true,
				MainHandSlot = true,
				--SecondaryHandSlot = E.Wrath and true or false,
			},
			itemInfos = nil,
			parentVisible = false,
			hasSomethingRendered = false,
			lastRefreshTime = nil,
			refreshTimer0 = nil,
			refreshTimer1 = nil,
			refreshTimer2 = nil,
		}
		--could check professions here
		setmetatable(instance, SlotIconManagerMetaTable)
		instance:Init()
		return instance
	end

	function SlotIconManager:Init()
		self.adapter:OnShow(function()
			self.parentVisible = true
			self:Refresh()
		end)
		self.adapter:OnHide(function()
			self.parentVisible = false
			self:Refresh()
		end)
		self.adapter:OnContentChanged(function()
			self:Refresh()
		end)
	end

	function SlotIconManager:Refresh()

		-- Both UNIT_INVENTORY_CHANGED and INSPECT_READY is called way before it is actually ready (~5-6 seconds early on inspect)
		-- Setup timers to update over the next period of time. This can probably be done smarter, but I don't know lua :D

		-- Cancel any refresh timers
		if self.refreshTimer0 ~= nil then
			self.refreshTimer0:Cancel()
			self.refreshTimer0 = nil
		end
		if self.refreshTimer1 ~= nil then
			self.refreshTimer1:Cancel()
			self.refreshTimer1 = nil
		end
		if self.refreshTimer2 ~= nil then
			self.refreshTimer2:Cancel()
			self.refreshTimer2 = nil
		end
		if self.refreshTimer3 ~= nil then
			self.refreshTimer3:Cancel()
			self.refreshTimer3 = nil
		end
		self:_Refresh()


		--[[self.refreshTimer0 = C_Timer.NewTimer(0.1, function()
			self:_Refresh()
		end)
		self.refreshTimer1 = C_Timer.NewTimer(1, function()
			self:_Refresh()
		end)
		self.refreshTimer2 = C_Timer.NewTimer(2, function()
			self:_Refresh()
		end)
		self.refreshTimer3 = C_Timer.NewTimer(3, function() --possible source of hara's error
			self:_Refresh()
		end)]]

		--Eltreum: use E:Delay to decrease memory/cpu usage and also possibly make it faster
		self.refreshTimer0 = C_Timer.After(0.1, function()
			self:_Refresh()
		end)
		self.refreshTimer1 = C_Timer.After(1, function()
			self:_Refresh()
		end)
		self.refreshTimer2 = C_Timer.After(2, function()
			self:_Refresh()
		end)
		self.refreshTimer3 = C_Timer.After(3, function()
			self:_Refresh()
		end)
	end

	function SlotIconManager:_Refresh()
		if self.parentVisible then
			local hasSomethingToRender = self:HasStyleFlag(self.STYLE.ENABLED) and self.adapter:GetUnit() and self.parentVisible
			if hasSomethingToRender then
				self:RefreshItemInfoForAllSlots()
			end
			if self.hasSomethingRendered then
				self:_Erase()
			end
			if hasSomethingToRender then
				self:_Render()
			end
		end
	end

	function SlotIconManager:_Render()
		self:_ShowAllLabels()
		self:_AddEnchants()
		self:_AddGems()
		self.hasSomethingRendered = true
	end

	function SlotIconManager:_Erase()
		self:_HideEnchantsAndGems()
		self:_HideAllLabels()
		self.hasSomethingRendered = false
	end

	function SlotIconManager:_GetSlotNames()
		return self.slotNames
	end

	function SlotIconManager:HasStyleFlag(styleFlag)
		return bit.band(self.style, styleFlag) == styleFlag
	end

	function SlotIconManager:SetStyle(value)
		if self.style ~= value then
			self.style = value
			self:Refresh()
		end
	end

	function SlotIconManager:_GetLabelText()
		return
	end

	function SlotIconManager:_ShowLabel(slotName)
		local value = self:_GetLabelText(slotName)
		if value then
			local key = slotName .. "-" .. self.style
			if not self.slotText[key] then
				local parent = self.adapter:GetSlotFrame(slotName)
				local alignment = self:GetSlotAlignment(slotName)
				self.slotText[key] = parent:CreateFontString(nil, "OVERLAY", self:_GetSlotTextFontStyle())
				local dx = 10
				local dy = -4
				if self:IsWeaponSlot(slotName) then
					--dx = -35
					dy = -25
				end
				if alignment == "LEFT" then
					self.slotText[key]:SetPoint("TOPRIGHT", parent, "TOPLEFT", -dx, dy)
				elseif alignment == "RIGHT" then
					self.slotText[key]:SetPoint("TOPLEFT", parent, "TOPRIGHT", dx, dy)
				end
				self.slotText[key]:SetShadowOffset(1, -1)
			end
			self.slotText[key]:Show()
			self.slotText[key]:SetText(value)
		end
	end

	function SlotIconManager:_ShowAllLabels()
		for _, slotName in pairs(self:_GetSlotNames()) do
			self:_ShowLabel(slotName)
		end
	end

	function SlotIconManager:_HideAllLabels()
		for _, slotText in pairs(self.slotText) do
			slotText:Hide()
		end
	end

	function SlotIconManager:_AddIcon(slotName, textureName, tooltip, overlayAtlas)
		local previousSlotIcon, slotIcon
		local slotIconIndex = 1
		if self.slotIcons[slotName] then
			for _, item in pairs(self.slotIcons[slotName]) do
				if item:isHidden() then
					slotIcon = item
					break
				end
				slotIconIndex = slotIconIndex + 1
				previousSlotIcon = item
			end
		else
			self.slotIcons[slotName] = {}
		end

		if not slotIcon then
			local parent = previousSlotIcon and previousSlotIcon.frame or self.adapter:GetSlotFrame(slotName)
			local alignment = self:GetSlotAlignment(slotName)
			local iconScale = 1
			local iconSize = 16 / iconScale
			local iconSpacing = (overlayAtlas == nil and 1 or 10) / iconScale
			local dx = previousSlotIcon and iconSpacing or 1 / iconScale
			local dy = not previousSlotIcon and (overlayAtlas == nil and 2 or 0) or 0
			if self:IsWeaponSlot(slotName) then
				dy = 15
			end
			slotIcon = ElvUI_EltreumUI.AllocateSlotIcon(parent)
			if alignment == "LEFT" then
				slotIcon.frame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT", -dx, dy)
			elseif alignment == "RIGHT" then
				slotIcon.frame:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", dx, dy)
			elseif alignment == "TOP" then
				slotIcon.frame:SetPoint("TOP", parent, "TOP", 0, dy+2)
			end
			slotIcon.frame:SetSize(iconSize, iconSize)
			slotIcon.frame:SetScale(iconScale)
			table.insert(self.slotIcons[slotName], slotIcon)
		end
		slotIcon:Render(textureName, tooltip, overlayAtlas)
	end

	function SlotIconManager:_AddEnchants()
		for slotName, itemInfo in pairs(self:GetItemInfoForAllSlots()) do
			if itemInfo then
				local tooltip = ElvUI_EltreumUI.Tooltip:new()
				local enchantInfo = itemInfo:getEnchantInfo()
				if enchantInfo ~= nil then
					local consumable = enchantInfo:getConsumableItem()
					local formula = enchantInfo:getFormulaItem()
					local receipe = enchantInfo:getReceipeSpell()
					local texture = consumable and consumable:getTextureName() or formula and formula:getTextureName() or receipe and receipe:getTextureName() or 134400--"INTERFACE/ICONS/INV_Misc_QuestionMark"
					if consumable then
						tooltip:AddHyperlink(consumable:getLink())
					elseif formula then
						tooltip:AddHyperlink(formula:getLink())
					elseif receipe then
						tooltip:AddHyperlink(receipe:getLink())
					elseif KIBC_EnchantToSpellID[enchantInfo:getId()] then
						local spellInfo = ElvUI_EltreumUI.SpellInfo:new("enchant:" .. KIBC_EnchantToSpellID[enchantInfo:getId()])
						texture = spellInfo:getTextureName()
						if texture == 136235 then --its samwise
							texture = 135913
						end
						tooltip:AddHyperlink(spellInfo:getLink())
					else
						local spellInfo = ElvUI_EltreumUI.SpellInfo:new("enchant:" .. KIBC_EnchantToSpellID[enchantInfo:getId()])
						tooltip:AddText(string.format("Unknown enchant #%d", enchantInfo:getId()).." ID:"..spellInfo.spellId)
					end
					self:_AddIcon(slotName, texture, tooltip)
				elseif self:IsSlotEnchantRequired(slotName) then
					tooltip:AddText("Missing enchant")
					self:_AddIcon(slotName, "INTERFACE/BUTTONS/UI-GROUPLOOT-PASS-UP", tooltip)
				end
			end
		end
	end

	function SlotIconManager:_AddGems()
		for slotName, itemInfo in pairs(self:GetItemInfoForAllSlots()) do
			if itemInfo then
				for _, socketInfo in pairs(itemInfo:getSockets()) do
					local texture
					local tooltip = ElvUI_EltreumUI.Tooltip:new()
					local relicType = socketInfo:getRelicType()
					local atlas
					if relicType ~= nil then
						atlas = 'Relic-' .. relicType .. '-Slot'
					end
					if not socketInfo:isEmpty() then
						texture = socketInfo:getGem():getTextureName()
						tooltip:AddHyperlink(socketInfo:getGem():getLink())
					else
						texture = socketInfo:getTextureName()
						tooltip:AddText(socketInfo:getMissingGemText())
					end
					if texture then
						self:_AddIcon(slotName, texture, tooltip, atlas)
					end
				end
			end
		end
	end

	function SlotIconManager:_HideEnchantsAndGems()
		for _, slotIcons in pairs(self.slotIcons) do
			for _, slotIcon in pairs(slotIcons) do
				ElvUI_EltreumUI.ReleaseSlotIcon(slotIcon)
			end
		end

		self.slotIcons = {}
	end

	function SlotIconManager:_GetSlotTextFontStyle()
		if self:HasStyleFlag(SlotIconManager.STYLE.SMALL) then
			return "SystemFont_Small"
		else
			return "SystemFont_Med1"
		end
	end

	function SlotIconManager:RefreshItemInfoForAllSlots()
		self.itemInfos = {}
		for _, slotName in pairs(self:_GetSlotNames()) do
			local itemString = GetInventoryItemLink(self.adapter:GetUnit(), GetInventorySlotInfo(slotName))
			self.itemInfos[slotName] = itemString and ElvUI_EltreumUI.ItemStringInfo:new(itemString) or nil
		end
		-- One-handed artifacts (i.e. ones with "imaginary" part which emerges into existance when artifcat is equipped)
		-- need special treatment: either main or secondary hand has real item level, the other one is always 750:
	end

	function SlotIconManager:GetItemInfoForAllSlots()
		return self.itemInfos
	end

	function SlotIconManager:GetTotalUpgrades()
		local totalCurrent = 0
		local totalMax = 0
		for _, itemInfo in pairs(self:GetItemInfoForAllSlots()) do
			if itemInfo then
				local current, max1 = itemInfo:GetUpgrades()
				if current and max1 then
					totalCurrent = totalCurrent + current
					totalMax = totalMax + max1
				end
			end
		end
		return totalCurrent, totalMax
	end

	function SlotIconManager:GetSlotAlignment(slotName)
		if self.rightAlignedSlots[slotName] ~= nil then
			return 'RIGHT'
		elseif self.topAlignedSlots[slotName] ~= nil then
			return 'TOP'
		else
			return 'LEFT'
		end
	end

	function SlotIconManager:IsWeaponSlot(slotName)
		return slotName == "MainHandSlot" or slotName == "SecondaryHandSlot" or slotName == "RangedSlot"
	end

	function SlotIconManager:IsAtMaxLevel()
		--return UnitLevel(self.adapter:GetUnit()) >= 60
		if E.Classic then
			return UnitLevel(self.adapter:GetUnit()) == 60
		elseif E.Wrath then
			return UnitLevel(self.adapter:GetUnit()) == 80
		end
	end

	function SlotIconManager:IsSlotEnchantRequired(slotName)
		return self.slotsWithRequiredEnchants[slotName] ~= nil and self:IsAtMaxLevel()
	end

	function SlotIconManager:IsSlotGemRequired()
		return self:IsAtMaxLevel()
	end

	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ITEM STRING INFO
	local ItemStringInfo = {}
	ItemStringInfo.__index = ItemStringInfo
	ElvUI_EltreumUI.ItemStringInfo = ItemStringInfo
	function ItemStringInfo:new(itemString)
		--itemString = string.match(itemString, "^|%x%x%x%x%x%x%x%x%x|H([^|]+)|h") or itemString
		local _, _, enchantId = strsplit(":",itemString)

		--[[
		_type, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId, linkLevel, specializationID, reforgeId = strsplit(
				":",
				itemString
			)
		]]
		return setmetatable({
			itemString = itemString,
			enchantId = tonumber(enchantId) or 0,
		}, self)
	end

	function ItemStringInfo:getItemString()
		return self.itemString
	end

	function ItemStringInfo:getLink()
		--local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(self.itemString)
		local _, itemLink = GetItemInfo(self.itemString)
		return itemLink
	end

	function ItemStringInfo:getEnchantInfo()
		return self.enchantId ~= 0 and ElvUI_EltreumUI.ItemEnchantInfo:new(self.enchantId) or nil
	end

	function ItemStringInfo:getTextureName()
		local _, _, _, _, _, _, _, _, _, itemTexture= GetItemInfo(self.itemString)
		return itemTexture
	end

	function ItemStringInfo:isTwoHandedWeapon()
		local _, _, _, _, _, _, _, _, itemEquipLoc, _, _, _, _ = GetItemInfo(self.itemString)
		return itemEquipLoc == 'INVTYPE_2HWEAPON' or itemEquipLoc == 'INVTYPE_RANGED' or itemEquipLoc == 'INVTYPE_RANGEDRIGHT'
	end

	function ItemStringInfo:getQualityColor()
		local quality = select(3, GetItemInfo(self.itemString))
		if quality then
			return select(4, GetItemQualityColor(quality))
		end
		return nil
	end

	local InvisibleTooltip = CreateFrame("GameTooltip", "EltruismKibsItemLevel" .. "InvisibleTooltip", nil, "GameTooltipTemplate")
	function ItemStringInfo:_getTooltipSockets(link)
		-- Based on Bimbo add-on code
		local result = {}
		local n = 30
		for i = 1, n do
			local texture = _G[InvisibleTooltip:GetName().."Texture"..i]
			if texture then
				texture:SetTexture(nil)
			end
		end
		InvisibleTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
		InvisibleTooltip:SetHyperlink(link)
		for i = 1, n do
			local texture = _G[InvisibleTooltip:GetName().."Texture"..i]
			local textureName = texture and texture:GetTexture()
			if textureName then
				local canonicalTextureName = string.gsub(string.upper(textureName), "\\", "/")
				local _, gemItemLink = GetItemGem(self:getLink(), i)
				table.insert(result, ElvUI_EltreumUI.SocketInfo:new(canonicalTextureName, gemItemLink and ItemStringInfo:new(gemItemLink) or nil))
			end
		end
		return result
	end

	function ItemStringInfo:_getEyeSockets()
		local result = {}
		local socketTypeId = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Prismatic"
		local _, gemItemLink = GetItemGem(self.itemString, 1)
		table.insert(result, ElvUI_EltreumUI.SocketInfo:new(socketTypeId, gemItemLink and ItemStringInfo:new(gemItemLink) or nil))
		return result
	end

	function ItemStringInfo:getSockets()
		local link = self:getLink()
		if not link then
			return {}
		elseif self:IsEye() then
			return self:_getEyeSockets()
		else
			return self:_getTooltipSockets(link)
		end
	end

	function ItemStringInfo:IsEye()
		local result = false
		local bitem = {}
		local itemS = self.itemString
		itemS = itemS:sub(1, -4)
		itemS = string.sub(itemS, 34)
		local sep = ":"
		local pattern = string.format("([^%s]+)", sep)
		string.gsub(itemS, pattern, function(c) bitem[#bitem + 1] = c end)
		for k,_ in pairs(bitem) do
			if bitem[k]=="6514" or bitem[k]=="6935" then
				result = true
			end
		end
		return result
	end

	function ItemStringInfo:GetUpgrades()
		if not self.upgrades then
			self.upgrades = { nil, nil }
			local link = self:getLink()
			if link then
				InvisibleTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
				InvisibleTooltip:SetHyperlink(self:getLink())
				for i = 1, 5 do
					local text = _G[InvisibleTooltip:GetName() .. "TextLeft" .. i]

					if text then
						local current, max2 = (text:GetText() or ""):match("(%d+)/(%d+)$")
						if current and max2 then
							self.upgrades = { current, max2 }
							break
						end
					end
				end
			end
		end
		return unpack(self.upgrades)
	end

	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ITEM ENCHANT INFO
	local ItemEnchantInfo = {}
	ItemEnchantInfo.__index = ItemEnchantInfo
	ElvUI_EltreumUI.ItemEnchantInfo = ItemEnchantInfo
	local CONSUMABLE_ID = 1
	local RECEIPE_ID = 2
	local FORMULA_ID = 3



	function ItemEnchantInfo:new(enchantId)
		return setmetatable({
			enchantId = tonumber(enchantId),
		}, self)
	end

	function ItemEnchantInfo:getId()
		return self.enchantId
	end

	function ItemEnchantInfo:getConsumableItem()
		local rec = db[self.enchantId]
		return rec and rec[CONSUMABLE_ID] and ElvUI_EltreumUI.ItemStringInfo:new("item:"..rec[CONSUMABLE_ID]..":0:0:0:0:0:0:0:0:0:0")
	end

	function ItemEnchantInfo:getReceipeSpell()
		local rec = db[self.enchantId]
		return rec and rec[RECEIPE_ID] and ElvUI_EltreumUI.SpellInfo:new("spell:"..rec[RECEIPE_ID])
	end

	function ItemEnchantInfo:getFormulaItem()
		local rec = db[self.enchantId]
		return rec and rec[FORMULA_ID] and ElvUI_EltreumUI.ItemStringInfo:new("item:"..rec[FORMULA_ID]..":0:0:0:0:0:0:0:0:0:0")
	end

	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------TOOLTIP
	local Tooltip = {}
	Tooltip.__index = Tooltip
	ElvUI_EltreumUI.Tooltip = Tooltip
	local TYPE_HYPERLINK = 1
	local TYPE_TEXT = 2
	local FIELD_TYPE = 1
	local FIELD_CONTENT = 2

	function Tooltip:new()
		return setmetatable({
			items = {},
			link = nil,
		}, self)
	end

	function Tooltip:AddHyperlink(link)
		if link then
			table.insert(self.items, {
				TYPE_HYPERLINK,
				link,
			})
		end
		return self
	end

	function Tooltip:AddText(text)
		table.insert(self.items, {
			TYPE_TEXT,
			text,
		})
		return self
	end

	local Tooltips = {}
	function Tooltip:_HideTooltips()
		for _, tooltip in pairs(Tooltips) do
			tooltip:Hide()
		end
	end

	function Tooltip:_ShowTooltips(parent, items)
		self:_HideTooltips()
		local i = 1
		local maxSize = 0
		self.link = nil
		for _, item in pairs(items) do
			if item then
				if not Tooltips[i] then
					Tooltips[i] = CreateFrame("GameTooltip", "EltruismKibsItemLevel" .. "Tooltip" .. i, GameTooltip:GetParent(), "GameTooltipTemplate")
					Tooltips[i]:SetScale(GameTooltip:GetScale())
				end
				if i == 1 then
					Tooltips[i]:SetOwner(parent, "ANCHOR_RIGHT")
				else
					Tooltips[i]:SetOwner(Tooltips[i - 1], "ANCHOR_NONE")
					Tooltips[i]:SetPoint("TOPLEFT", Tooltips[i - 1], "TOPRIGHT")
				end
				if E.Wrath then
					if item[FIELD_TYPE] == TYPE_HYPERLINK then
						Tooltips[i]:SetHyperlink(item[FIELD_CONTENT])
						self.link = item[FIELD_CONTENT]
					elseif item[FIELD_TYPE] == TYPE_TEXT then
						Tooltips[i]:SetText(item[FIELD_CONTENT])
					end
				elseif E.Classic then
					Tooltips[i]:SetText(item[FIELD_CONTENT])
				end
				maxSize = max(Tooltips[i]:GetHeight(), maxSize)
			end
			i = i + 1
		end
	end

	function Tooltip:HasLink()
		return not not self.link
	end
	function Tooltip:GetLink()
		return self.link
	end
	function Tooltip:Show(parent)
		self:_ShowTooltips(parent, self.items)
	end
	function Tooltip:Hide()
		self:_HideTooltips()
	end
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------SOCKET INFO
	local SocketInfo = {
		TYPE = {
			UNKNOWN = 0,
			PRISMATIC = 1,
			RED = 2,
			BLUE = 3,
			YELLOW = 4,
			META = 5,
		}
	}
	SocketInfo.__index = SocketInfo
	ElvUI_EltreumUI.SocketInfo = SocketInfo
	function SocketInfo:new(typeId, gemItemInfo, relicType, missingGemText)
		return setmetatable({
			typeId = typeId,
			gemItemInfo = gemItemInfo,
			relicType = relicType,
			missingGemText = missingGemText,
		}, self)
	end
	function SocketInfo:getTypeId()
		return self.typeId
	end
	function SocketInfo:isEmpty()
		return self.gemItemInfo == nil
	end
	function SocketInfo:getGem()
		return self.gemItemInfo
	end
	function SocketInfo:getTextureName()
		return self.typeId
	end
	function SocketInfo:getRelicType()
		return self.relicType
	end
	function SocketInfo:getMissingGemText()
		return self.missingGemText ~= nil and self.missingGemText or 'Missing gem'
	end
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------SPELL INFO
	local SpellInfo = {}
	SpellInfo.__index = SpellInfo
	ElvUI_EltreumUI.SpellInfo = SpellInfo
	function SpellInfo:new(itemString)
		local _type, spellId
		if type(itemString) == "string" then
			itemString = string.match(itemString,"^|%x%x%x%x%x%x%x%x%x|H([^|]+)|h") or itemString
			_type, spellId = strsplit(
				":",
				itemString
			)
		end
		return setmetatable({
			itemString = itemString,
			type = _type,
			spellId = tonumber(spellId) or 0,
		}, self)
	end

	function SpellInfo:getLink()
		return GetSpellLink(self.spellId) or ("|cffffd000|Henchant:"..self.spellId.."|h["..GetSpellInfo(self.spellId).."]|h|r")
	end
	function SpellInfo:getTextureName()
		return GetSpellTexture(self.spellId)
	end
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------SPINNER
	local Spinner = {}
	Spinner.__index = Spinner
	function Spinner:new(parent)
		local frame = CreateFrame("FRAME", nil, parent, "EltruismKibsItemLevel".."Spinner")

		return setmetatable({
			frame = frame,
		}, self)
	end
	local pool = ElvUI_EltreumUI.Pool:new(
		function (...)
			return nil
		end,
		function (parent)
			return Spinner:new(parent)
		end,
		function (ref, parent)
			ref.frame:SetParent(parent)
		end,
		function (ref)
			ref.frame:SetParent(nil)
		end
	)
	ElvUI_EltreumUI.AllocateSpinner = function (parent)
		return pool:Allocate(parent)
	end
	ElvUI_EltreumUI.ReleaseSpinner = function (ref)
		pool:Release(ref)
	end
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------APPLYSTYLE
	function ElvUI_EltreumUI:ApplyStyle()
		local style = 0
		style = style + ElvUI_EltreumUI.SlotIconManager.STYLE.COLOR
		local playerSlotIconManager = style
		playerSlotIconManager = playerSlotIconManager + ElvUI_EltreumUI.SlotIconManager.STYLE.ENABLED
		self.playerSlotIconManager:SetStyle(playerSlotIconManager)
		if IsAddOnLoaded("Blizzard_InspectUI") and E.db.ElvUI_EltreumUI.skins.socketsinspect then
			local inspectorSlotIconManager = style
			inspectorSlotIconManager = inspectorSlotIconManager + ElvUI_EltreumUI.SlotIconManager.STYLE.ENABLED
			self.inspectorSlotIconManager:SetStyle(inspectorSlotIconManager)
		end
	end
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------INITIALIZE
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	--frame:RegisterEvent("INSPECT_READY")
	--frame:SetScript("OnEvent", function(_, event,...)
		--local args = {...}
		--if event == "ADDON_LOADED" and args[1] == "Blizzard_InspectUI" then
	frame:SetScript("OnEvent", function(_, event)
		if event == "ADDON_LOADED" and IsAddOnLoaded("Blizzard_InspectUI") and E.db.ElvUI_EltreumUI.skins.socketsinspect then
			self.inspectorSlotIconManager = ElvUI_EltreumUI.SlotIconManager:new(ElvUI_EltreumUI.InspectionFrameAdapter:new())
			local style = 0
			style = style + ElvUI_EltreumUI.SlotIconManager.STYLE.COLOR
			local inspectorSlotIconManager = style
			inspectorSlotIconManager = inspectorSlotIconManager + ElvUI_EltreumUI.SlotIconManager.STYLE.ENABLED
			self.inspectorSlotIconManager:SetStyle(inspectorSlotIconManager)
			frame:UnregisterEvent("ADDON_LOADED")
		end
	end)
	self.playerSlotIconManager = ElvUI_EltreumUI.SlotIconManager:new(ElvUI_EltreumUI.CharacterFrameAdapter:new())
	self:ApplyStyle()

	function ElvUI_EltreumUI:FindFrames(prefix)
		local result = {}
		if type(prefix) == "string" then
			local len = string.len(prefix)

			for name, ref in pairs(_G) do
				if ref and type(ref) == "table" and ref.GetObjectType and string.sub(name, 1, len) == prefix then
					result[name] = ref
				end
			end
		end
		return result
	end

	--is this even needed?
	--[[function ElvUI_EltreumUI:EnhanceControls(rootFrame)
		for name, frame in pairs(self:FindFrames(rootFrame:GetName())) do
			local type = frame:GetObjectType()
			if type == "FontString" then
				local text = frame:GetText()
				if text then
					frame:SetText(text)
				end
			elseif type == "CheckButton" then
				if frame.tooltipText then
					frame.tooltipText = frame.tooltipText
				end
				local text = _G[name .. "Text"]
				frame.Disable = function(self)
					getmetatable(self).__index.Disable(self)
					text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
				end
				frame.Enable = function(self)
					getmetatable(self).__index.Enable(self)
					text:SetTextColor(text:GetFontObject():GetTextColor())
				end
			end
		end
	end]]
end
