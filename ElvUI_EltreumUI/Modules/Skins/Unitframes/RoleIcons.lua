local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local unpack = _G.unpack
local IsAddOnLoaded = _G.IsAddOnLoaded --TODO 10.2, might need C_AddOns.

--Unitframe Role Icons
function ElvUI_EltreumUI:UnitframeRoleIcons()
	if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleicons then
		if E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ELTRUISM" or E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == nil then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "CUSTOM" then
			UF.RoleIconTextures = {
				TANK = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank,
				HEALER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer,
				DAMAGER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps,
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODELVUI" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGLOW" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGRAVED" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODGREY" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "ATWOODWHITE" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "RELEAF" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "IOS" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "MATERIAL" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\DPS.tga',
			}
		elseif E.db.ElvUI_EltreumUI.otherstuff.roleiconstype == "EMOJI" then
			UF.RoleIconTextures = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Emoji\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Emoji\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Emoji\\DPS.tga',
			}
		end
		if IsAddOnLoaded("ElvUI_SLE") then --TODO 10.2, might need C_AddOns.
			local SLE = unpack(ElvUI_SLE)
			SLE.rolePaths["Eltruism"] = {
				TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga",
				HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga",
				DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga"
			}
			SLE.rolePaths["Atwood ElvUI"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\ElvUI\\DPS.tga',
			}
			SLE.rolePaths["Atwood Glow"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Glow\\DPS.tga',
			}
			SLE.rolePaths["Atwood Graved"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Graved\\DPS.tga',
			}
			SLE.rolePaths["Atwood Grey"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\Grey\\DPS.tga',
			}
			SLE.rolePaths["Atwood White"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Atwood\\White\\DPS.tga',
			}
			SLE.rolePaths["RELEAF"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Releaf\\DPS.tga',
			}
			SLE.rolePaths["iOS"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\iOS\\DPS.tga',
			}
			SLE.rolePaths["Material"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Material\\DPS.tga',
			}
			SLE.rolePaths["Emoji"] = {
				TANK = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Emoji\\Tank.tga',
				HEALER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Emoji\\Healer.tga',
				DAMAGER = 'Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\Emoji\\DPS.tga',
			}
			SLE.rolePaths["Eltruism Custom"] = {
				TANK = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomtank,
				HEALER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomhealer,
				DAMAGER = [[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconscustomdps,
			}
		end

		--option to disable dps icons in party/raid
		if E.db.ElvUI_EltreumUI.otherstuff.eltruismroleiconsdisabledps then
			UF.RoleIconTextures.DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Statusbar\\None.tga"
		end
	end
end
