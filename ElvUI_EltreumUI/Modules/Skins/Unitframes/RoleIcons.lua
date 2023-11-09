local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local unpack = _G.unpack
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

--Unitframe Role Icons
function ElvUI_EltreumUI:UnitframeRoleIcons()
	if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then
		if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == nil then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\ELTRUISM\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\ELTRUISM\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\ELTRUISM\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
			UF.RoleIconTextures = {
				TANK = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank,
				HEALER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer,
				DAMAGER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps,
			}
		else
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\'..E.db.ElvUI_EltreumUI.otherstuff.roleiconstype..'\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\'..E.db.ElvUI_EltreumUI.otherstuff.roleiconstype..'\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\'..E.db.ElvUI_EltreumUI.otherstuff.roleiconstype..'\\DPS.tga',
			}
		end
		if IsAddOnLoaded("ElvUI_SLE") then
			local SLE = unpack(ElvUI_SLE)
			local styles = {
				["Eltruism"] = "ELTRUISM",
				["Atwood ElvUI"] = "ATWOODELVUI",
				["Atwood Glow"] = "ATWOODGLOW",
				["Atwood Graved"] = "ATWOODGRAVED",
				["Atwood Grey"] = "ATWOODGREY",
				["Atwood White"] = "ATWOODWHITE",
				["RELEAF"] = "RELEAF",
				["iOS"] = "IOS",
				["Material"] = "MATERIAL",
				["Emoji"] = "EMOJI",
				["Iconic"] = "ICONIC",
				["RPG"] = "RPG",
				["Simple"] = "Simple",
			}
			for k,v in pairs(styles) do
				SLE.rolePaths[k] = {
					TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\"..v.."\\Tank.tga",
					HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\"..v.."\\Healer.tga",
					DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\"..v.."\\DPS.tga"
				}
			end
			if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
				SLE.rolePaths["Eltruism Custom"] = {
					TANK = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank,
					HEALER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer,
					DAMAGER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps,
				}
			end
		end

		--option to disable dps icons in party/raid
		if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconsdisabledps then
			UF.RoleIconTextures.DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Statusbar\\None.tga"
		end
	end
end
