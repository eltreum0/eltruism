local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded
local table = _G.table

-- Capping profile setup
function ElvUI_EltreumUI:GetBattleGroundEnemiesProfile()
	if IsAddOnLoaded("BattleGroundEnemies") then
		if BattleGroundEnemiesDB.profiles.Eltreum then
			--local key = {[E.mynameRealm] = "Eltreum"}
			--table.insert(CappingSettings.profileKeys, key)
			table.insert(BattleGroundEnemiesDB.profileKeys, E.mynameRealm)
			BattleGroundEnemiesDB["profileKeys"][E.mynameRealm] = "Eltreum"
		else
			BattleGroundEnemiesDB["profileKeys"][E.mynameRealm] = "Eltreum"
			BattleGroundEnemiesDB["profiles"]["Eltreum"] = {}
			BattleGroundEnemiesDB["profiles"]["Eltreum"] = {
				["onlyShowWhenNewVersion"] = true,
				["dbVersion"] = 2,
				["lastReadVersion"] = "11.0.5.9",
				["Locked"] = true,
				["MyFocus_Color"] = {0, 0.988235294117647, 0.729411764705882, 1},
				["Text"] = {
					["Font"] = E.db.general.font,
					["FontOutline"] = ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle),
					["EnableShadow"] = true,
				},
				["RBG"] = {
					["TargetCalling_NotificationSound"] = "Warcraft 3 - Blademaster Twinblade ",
					["TargetCalling_NotificationEnable"] = true,
					["TargetCalling_SetMark"] = true,
					["EnemiesTargetingMe_Amount"] = 2,
					["EnemiesTargetingMe_Enabled"] = true,
					["EnemiesTargetingMe_Sound"] = "! - Metal Gear Solid",
				},
				["ButtonModules"] = {
					["healthBar"] = {
						["Background"] = {
							nil,
							nil,
							nil,
							0.701864093542099,
						},
						["Texture"] = "ElvUI Norm1",
					},
					["Power"] = {
						["Background"] = {
							nil,
							nil,
							nil,
							0.7000000178813934,
						},
						["Texture"] = "ElvUI Norm1",
					},
				},
				["Allies"] = {
					["playerCountConfigs"] = {
						{
							["Framescale"] = 0.75,
							["Position_Y"] = 538,
							["Position_X"] = 160,
						},
						{
							["Framescale"] = 0.75,
							["Position_Y"] = 545,
							["Position_X"] = 95,
						},
						{
							["Framescale"] = 0.75,
							["Position_Y"] = 570,
							["Position_X"] = 95,
						},
					},
				},
				["Enemies"] = {
					["playerCountConfigs"] = {
						{
							["Framescale"] = 0.75,
							["Position_Y"] = 538,
							["Position_X"] = 1149,
						},
						{
							["Framescale"] = 0.75,
							["Position_Y"] = 545,
							["Position_X"] = 1188,
						},
						{
							["Framescale"] = 0.75,
							["Position_Y"] = 570,
							["Position_X"] = 1207,
						},
					},
				},
			}
		end

		ElvUI_EltreumUI:Print(L["BattleGroundEnemies profile has been set."])
	else
		ElvUI_EltreumUI:Print(L["BattleGroundEnemies is not loaded"])
	end
end
