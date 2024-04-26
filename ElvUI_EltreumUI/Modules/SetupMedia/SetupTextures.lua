local E, L = unpack(ElvUI)

--set texture to all elements
function ElvUI_EltreumUI:SetupTexture(texturevalue)
	E.db["ElvUI_EltreumUI"]["nameplates"]["nameplatepower"]["texture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["skins"]["ace3"]["texture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["skins"]["questsettings"]["texture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["skins"]["queststatusbartexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["gradientmode"]["texture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["backdroptexture"] = texturevalue
	--[[
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["deathknighttexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["demonhuntertexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["druidtexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["evokertexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["focustexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["huntertexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["magetexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["monktexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["npcfriendly"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["npchostile"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["npcneutral"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["npcunfriendly"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["paladintexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["pettexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["playertexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["priesttexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["roguetexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["shamantexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["tappedtexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["targettargettargettexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["targettargettexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["targettexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["warlocktexture"] = texturevalue
	E.db["ElvUI_EltreumUI"]["unitframes"]["ufcustomtexture"]["warriortexture"] = texturevalue
	]]

	E.db["auras"]["buffs"]["barTexture"] = texturevalue
	E.db["auras"]["debuffs"]["barTexture"] = texturevalue
	E.db["databars"]["statusbar"] = texturevalue
	E.db["general"]["altPowerBar"]["statusBar"] = texturevalue
	E.db["general"]["lootRoll"]["statusBarTexture"] = texturevalue
	E.db["nameplates"]["statusbar"] = texturevalue
	E.db["unitframe"]["statusbar"] = texturevalue

	E.private["general"]["glossTex"] = texturevalue
	E.private["general"]["normTex"] = texturevalue

	--stylefilters
	for profile,data in pairs(ElvDB.global) do
		if profile == "nameplates" and data then
			if data.filters then
				for _, styleFilter in next, data.filters do
					if styleFilter then
						if styleFilter.actions then
							if styleFilter.actions.texture then
								if styleFilter.actions.texture.enable and styleFilter.actions.texture.texture then
									styleFilter.actions.texture.texture = texturevalue
								end
							end
						end
					end
				end
			end
		end
	end

	ElvUI_EltreumUI:Print(texturevalue.." "..L["Texture has been set."])
end
