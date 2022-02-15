local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

-- Capping profile setup
function ElvUI_EltreumUI:GetCappingProfile()
	if CappingSettings.profiles.Eltreum then
		--local key = {[E.mynameRealm] = "Eltreum"}
		--table.insert(CappingSettings.profileKeys, key)
		table.insert(CappingSettings.profileKeys, E.mynameRealm)
		CappingSettings["profileKeys"][E.mynameRealm] = "Eltreum"
	else
		CappingSettings = {
			["profileKeys"] = {
				[E.mynameRealm] = "Eltreum"
			},
			["profiles"] = {
				["Eltreum"] = {
					["spacing"] = 1,
					["lock"] = true,
					["barTexture"] = "Eltreum-Elvui-Norm",
					["width"] = 408,
					["font"] = "Kimberley",
					["outline"] = "OUTLINE",
					["position"] = {
						"BOTTOMRIGHT", -- [1]
						"BOTTOMRIGHT", -- [2]
						-117.237907409668, -- [3]
						213.9608612060547, -- [4]
					},
					["growUp"] = true,
					["colorBarBackground"] = {
						nil, -- [1]
						nil, -- [2]
						nil, -- [3]
						0.4000000357627869, -- [4]
					},
				},
			},
		}
	end
end
