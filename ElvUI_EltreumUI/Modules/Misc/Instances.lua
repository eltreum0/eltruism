local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local Minimap = _G.Minimap
local IsInInstance = _G.IsInInstance
local WorldMapFrame = _G.WorldMapFrame
local select = _G.select
local GetInstanceInfo = _G.GetInstanceInfo
local C_ChallengeMode = _G.C_ChallengeMode
local classcolors = E:ClassColor(E.myclass, true)
local textgradient,backuptext

local instancedifficulty = CreateFrame("FRAME")
instancedifficulty:SetSize(10, 10)
instancedifficulty:SetPoint("CENTER", Minimap , -50, 50)
instancedifficulty:SetParent(Minimap)
instancedifficulty:Hide()
instancedifficulty.Text = instancedifficulty:CreateFontString(nil,"ARTWORK")
instancedifficulty.Text:SetPoint("CENTER", instancedifficulty)
instancedifficulty:RegisterEvent("ZONE_CHANGED_NEW_AREA")
instancedifficulty:RegisterEvent("PLAYER_ENTERING_WORLD")
if E.Retail then
	instancedifficulty:RegisterEvent("CHALLENGE_MODE_START")
	instancedifficulty:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
	instancedifficulty:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
end
E:CreateMover(instancedifficulty, "MoverEltruismInstanceDifficulty", "EltruismInstanceDifficulty", nil, nil, nil, "ALL,SOLO,ELTREUMUI,PARTY,RAID", nil, 'ElvUI_EltreumUI,party,instances')

instancedifficulty:SetScript("OnEvent", function()
	if not E.private.ElvUI_EltreumUI then return end
	if not E.private.ElvUI_EltreumUI.install_version then return end

	local _, instanceType = IsInInstance()
	local mapID = WorldMapFrame:GetMapID()
	if (instanceType == "raid" or instanceType == "party" or instanceType == "scenario") and E.db.ElvUI_EltreumUI.skins.instances.enable and not (mapID == 1662 or mapID == 582 or mapID == 590) then
		instancedifficulty:Show()
		instancedifficulty.Text:Show()
		instancedifficulty.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.instances.fontsize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))

		local DifficultyID = select(3, GetInstanceInfo()) --https://wowpedia.fandom.com/wiki/DifficultyID

		if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors and E.db.ElvUI_EltreumUI.skins.instances.classcolor then --fix in case both are on
			E.db.ElvUI_EltreumUI.skins.instances.difficultycolors = false
		end

		if DifficultyID == 1 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonNormal)
			backuptext = (E.db.ElvUI_EltreumUI.skins.instances.DungeonNormal)
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.DungeonNormal, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.b, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.b)
				end
			end
		elseif DifficultyID == 2 or DifficultyID == 39 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroic)
			backuptext = (E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroic)
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroic, E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroicColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroicColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroicColor.b, E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroicColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroicColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroicColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroicColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroicColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroicColor.b)
				end
			end
		elseif DifficultyID == 3 then --10man wrath
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid10)
			backuptext = (E.db.ElvUI_EltreumUI.skins.instances.Raid10)
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.Raid10, E.db.ElvUI_EltreumUI.skins.instances.Raid10Color.r, E.db.ElvUI_EltreumUI.skins.instances.Raid10Color.g, E.db.ElvUI_EltreumUI.skins.instances.Raid10Color.b, E.db.ElvUI_EltreumUI.skins.instances.Raid10Color.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.Raid10Color.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.Raid10Color.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.Raid10Color.r, E.db.ElvUI_EltreumUI.skins.instances.Raid10Color.g, E.db.ElvUI_EltreumUI.skins.instances.Raid10Color.b)
				end
			end
		elseif DifficultyID == 4 then --25man wrath
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid25)
			backuptext = (E.db.ElvUI_EltreumUI.skins.instances.Raid25)
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.Raid25, E.db.ElvUI_EltreumUI.skins.instances.Raid25Color.r, E.db.ElvUI_EltreumUI.skins.instances.Raid25Color.g, E.db.ElvUI_EltreumUI.skins.instances.Raid25Color.b, E.db.ElvUI_EltreumUI.skins.instances.Raid25Color.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.Raid25Color.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.Raid25Color.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.Raid25Color.r, E.db.ElvUI_EltreumUI.skins.instances.Raid25Color.g, E.db.ElvUI_EltreumUI.skins.instances.Raid25Color.b)
				end
			end
		elseif DifficultyID == 5 then --10man heroic wrath
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid10Heroic)
			backuptext = (E.db.ElvUI_EltreumUI.skins.instances.Raid10Heroic)
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.Raid10Heroic, E.db.ElvUI_EltreumUI.skins.instances.Raid10HeroicColor.r, E.db.ElvUI_EltreumUI.skins.instances.Raid10HeroicColor.g, E.db.ElvUI_EltreumUI.skins.instances.Raid10HeroicColor.b, E.db.ElvUI_EltreumUI.skins.instances.Raid10HeroicColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.Raid10HeroicColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.Raid10HeroicColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.Raid10HeroicColor.r, E.db.ElvUI_EltreumUI.skins.instances.Raid10HeroicColor.g, E.db.ElvUI_EltreumUI.skins.instances.Raid10HeroicColor.b)
				end
			end
		elseif DifficultyID == 6 then --25man heroic wrath
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid25Heroic)
			backuptext = (E.db.ElvUI_EltreumUI.skins.instances.Raid25Heroic)
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.Raid25Heroic, E.db.ElvUI_EltreumUI.skins.instances.Raid25HeroicColor.r, E.db.ElvUI_EltreumUI.skins.instances.Raid25HeroicColor.g, E.db.ElvUI_EltreumUI.skins.instances.Raid25HeroicColor.b, E.db.ElvUI_EltreumUI.skins.instances.Raid25HeroicColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.Raid25HeroicColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.Raid25HeroicColor.b + E.db.ElvUI_EltreumUI.skins.instances.redoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.Raid25HeroicColor.r, E.db.ElvUI_EltreumUI.skins.instances.Raid25HeroicColor.g, E.db.ElvUI_EltreumUI.skins.instances.Raid25HeroicColor.b)
				end
			end
		elseif DifficultyID == 23 or DifficultyID == 40 then --m0
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonMythic)
			backuptext = E.db.ElvUI_EltreumUI.skins.instances.DungeonMythic
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.DungeonMythic, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicColor.b, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicColor.b)
				end
			end
		elseif DifficultyID == 8 then --m+
			local keylevel = C_ChallengeMode.GetActiveKeystoneInfo()
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlus.." +"..keylevel)
			backuptext = (E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlus.." +"..keylevel)
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlus.." +"..keylevel, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlusColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlusColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlusColor.b, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlusColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlusColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlusColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlusColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlusColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlusColor.b)
				end
			end
		elseif DifficultyID == 24 then --timewwalking dungeon
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalker)
			backuptext = E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalker
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalker, E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalkerColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalkerColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalkerColor.b, E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalkerColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalkerColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalkerColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalkerColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalkerColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalkerColor.b)
				end
			end
		elseif DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 or DifficultyID == 148 or DifficultyID == 185 or DifficultyID == 186 then --regular raid
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid)
			backuptext = E.db.ElvUI_EltreumUI.skins.instances.Raid
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.Raid, E.db.ElvUI_EltreumUI.skins.instances.RaidColor.r, E.db.ElvUI_EltreumUI.skins.instances.RaidColor.g, E.db.ElvUI_EltreumUI.skins.instances.RaidColor.b, E.db.ElvUI_EltreumUI.skins.instances.RaidColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.RaidColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.RaidColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.RaidColor.r, E.db.ElvUI_EltreumUI.skins.instances.RaidColor.g, E.db.ElvUI_EltreumUI.skins.instances.RaidColor.b)
				end
			end
		elseif DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 175 or DifficultyID == 176 or DifficultyID == 149 or DifficultyID == 193 or DifficultyID == 194 then --heroic raid
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.RaidHeroic)
			backuptext = E.db.ElvUI_EltreumUI.skins.instances.RaidHeroic
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.RaidHeroic, E.db.ElvUI_EltreumUI.skins.instances.RaidHeroicColor.r, E.db.ElvUI_EltreumUI.skins.instances.RaidHeroicColor.g, E.db.ElvUI_EltreumUI.skins.instances.RaidHeroicColor.b, E.db.ElvUI_EltreumUI.skins.instances.RaidHeroicColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.RaidHeroicColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.RaidHeroicColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.RaidHeroicColor.r, E.db.ElvUI_EltreumUI.skins.instances.RaidHeroicColor.g, E.db.ElvUI_EltreumUI.skins.instances.RaidHeroicColor.b)
				end
			end
		elseif DifficultyID == 16 then --mythic raid
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.MythicRaid)
			backuptext = E.db.ElvUI_EltreumUI.skins.instances.MythicRaid
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.MythicRaid, E.db.ElvUI_EltreumUI.skins.instances.MythicRaidColor.r, E.db.ElvUI_EltreumUI.skins.instances.MythicRaidColor.g, E.db.ElvUI_EltreumUI.skins.instances.MythicRaidColor.b, E.db.ElvUI_EltreumUI.skins.instances.MythicRaidColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.MythicRaidColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.MythicRaidColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.MythicRaidColor.r, E.db.ElvUI_EltreumUI.skins.instances.MythicRaidColor.g, E.db.ElvUI_EltreumUI.skins.instances.MythicRaidColor.b)
				end
			end
		elseif DifficultyID == 7 or DifficultyID == 17 or DifficultyID == 151 then --LFR raid
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.RaidLFR)
			backuptext = E.db.ElvUI_EltreumUI.skins.instances.RaidLFR
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.RaidLFR, E.db.ElvUI_EltreumUI.skins.instances.RaidLFRColor.r, E.db.ElvUI_EltreumUI.skins.instances.RaidLFRColor.g, E.db.ElvUI_EltreumUI.skins.instances.RaidLFRColor.b, E.db.ElvUI_EltreumUI.skins.instances.RaidLFRColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.RaidLFRColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.RaidLFRColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.RaidLFRColor.r, E.db.ElvUI_EltreumUI.skins.instances.RaidLFRColor.g, E.db.ElvUI_EltreumUI.skins.instances.RaidLFRColor.b)
				end
			end
		elseif DifficultyID == 33 then --timewalking raid
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalker)
			backuptext = E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalker
			if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalker, E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalkerColor.r, E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalkerColor.g, E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalkerColor.b, E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalkerColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalkerColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalkerColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
					instancedifficulty.Text:SetText(textgradient)
					backuptext = textgradient
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalkerColor.r, E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalkerColor.g, E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalkerColor.b)
				end
			end
		else
			if E.db.ElvUI_EltreumUI.dev then
				ElvUI_EltreumUI:Print("Unknown instance type, please report in discord: "..DifficultyID)
				instancedifficulty.Text:SetText("Report this: "..DifficultyID)
				backuptext = ("Report this: "..DifficultyID)
			else
				instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonNormal)
				backuptext = (E.db.ElvUI_EltreumUI.skins.instances.DungeonNormal)
				if E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
					if E.db.ElvUI_EltreumUI.skins.instances.gradient then
						textgradient = (E:TextGradient(" "..E.db.ElvUI_EltreumUI.skins.instances.DungeonNormal, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.b, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset))
						instancedifficulty.Text:SetText(textgradient)
						backuptext = textgradient
					else
						instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.r, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.g, E.db.ElvUI_EltreumUI.skins.instances.DungeonNormalColor.b)
					end
				end
			end
		end

		if not E.db.ElvUI_EltreumUI.skins.instances.difficultycolors then
			if not E.db.ElvUI_EltreumUI.skins.instances.classcolor then -- player set color
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					textgradient = E:TextGradient(" "..backuptext, E.db.ElvUI_EltreumUI.skins.instances.r, E.db.ElvUI_EltreumUI.skins.instances.g, E.db.ElvUI_EltreumUI.skins.instances.b, E.db.ElvUI_EltreumUI.skins.instances.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, E.db.ElvUI_EltreumUI.skins.instances.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, E.db.ElvUI_EltreumUI.skins.instances.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset)
					instancedifficulty.Text:SetText(textgradient)
				else
					instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.r, E.db.ElvUI_EltreumUI.skins.instances.g, E.db.ElvUI_EltreumUI.skins.instances.b)
				end
			elseif E.db.ElvUI_EltreumUI.skins.instances.classcolor then --class color
				if E.db.ElvUI_EltreumUI.skins.instances.gradient then
					--textgradient = E:TextGradient(" "..backuptext, classcolors.r, classcolors.g, classcolors.b, classcolors.r + E.db.ElvUI_EltreumUI.skins.instances.redoffset, classcolors.g + E.db.ElvUI_EltreumUI.skins.instances.greenoffset, classcolors.b + E.db.ElvUI_EltreumUI.skins.instances.blueoffset)
					--instancedifficulty.Text:SetText(textgradient)
					instancedifficulty.Text:SetText(ElvUI_EltreumUI:GradientName(backuptext, E.myclass))
				else
					instancedifficulty.Text:SetTextColor(classcolors.r, classcolors.g, classcolors.b)
				end
			end
		end

		if _G["MiniMapInstanceDifficulty"] and (_G["MiniMapInstanceDifficulty"]:IsShown() or _G["MiniMapInstanceDifficulty"]:GetAlpha() == 1) then
			_G["MiniMapInstanceDifficulty"]:SetAlpha(0)
		end

		if _G["MinimapCluster"] and _G["MinimapCluster"].InstanceDifficulty then
			_G["MinimapCluster"].InstanceDifficulty:Hide()
			_G["MinimapCluster"].InstanceDifficulty:SetAlpha(0)
		end

		if E.Retail then
			if _G["MiniMapChallengeMode"] and (_G["MiniMapChallengeMode"]:IsShown() or _G["MiniMapChallengeMode"]:GetAlpha() == 1) then
				_G["MiniMapChallengeMode"]:SetAlpha(0)
			end
			if _G["GuildInstanceDifficulty"] then
				_G["GuildInstanceDifficulty"]:SetAlpha(0)
				if _G["GuildInstanceDifficulty"]:IsShown() then
					instancedifficulty.Text:SetText(backuptext.." "..E.db.ElvUI_EltreumUI.skins.instances.guild)
				end
			end
			for i = 1, _G["Minimap"]:GetNumChildren() do
				local v = select(i, _G["Minimap"]:GetChildren())
				 if v then
					if v.Instance then
						v:SetAlpha(0)
					end
					if v.HeroicTexture then
						v:SetAlpha(0)
					end
					if v.ChallengeModeTexture then
						v:SetAlpha(0)
					end
				end
			end
		end
		instancedifficulty:Show()
	else
		instancedifficulty:Hide()
		instancedifficulty.Text:Hide()
	end
	--confirm its instance because once again the zone_changed event is not reliable when changing into and out of places like the garrison
	E:Delay(5, function()
		_, instanceType = IsInInstance()
		mapID = WorldMapFrame:GetMapID()
		if instanceType == "none" or mapID == 1662 or mapID == 582 or mapID == 590 or instanceType == "pvp" or instanceType == "arena" then
			instancedifficulty:Hide()
			instancedifficulty.Text:Hide()
		end
	end)
end)
