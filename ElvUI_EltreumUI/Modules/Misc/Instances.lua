local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local CreateFrame = _G.CreateFrame
local Minimap = _G.Minimap
local IsInInstance = _G.IsInInstance
local WorldMapFrame = _G.WorldMapFrame
local select = _G.select
local GetInstanceInfo = _G.GetInstanceInfo
local C_ChallengeMode = _G.C_ChallengeMode
local C_Timer = _G.C_Timer

local instancedifficulty = CreateFrame("FRAME")
instancedifficulty:SetSize(40, 40)
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
E:CreateMover(instancedifficulty, "MoverEltruismInstanceDifficulty", "EltruismInstanceDifficulty", nil, nil, nil, "ALL,SOLO,ELTREUMUI,PARTY,RAID", nil, 'ElvUI_EltreumUI,partyraidsettings')

instancedifficulty:SetScript("OnEvent", function(_,event)
	local _, instanceType = IsInInstance()
	local mapID = WorldMapFrame:GetMapID()
	if (instanceType == "raid" or instanceType == "party" or instanceType == "scenario") and E.db.ElvUI_EltreumUI.skins.instances.enable and not (mapID == 1662 or mapID == 582 or mapID == 590) then
		instancedifficulty:Show()
		instancedifficulty.Text:Show()
		instancedifficulty.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.skins.instances.fontsize, E.db.general.fontStyle)
		instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.instances.r, E.db.ElvUI_EltreumUI.skins.instances.g, E.db.ElvUI_EltreumUI.skins.instances.b)
		local DifficultyID = select(3, GetInstanceInfo()) --https://wowpedia.fandom.com/wiki/DifficultyID

		if DifficultyID == 1 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonNormal)
		elseif DifficultyID == 2 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonHeroic)
		elseif DifficultyID == 3 then --10man wrath
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid10)
		elseif DifficultyID == 4 then --25man wrath
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid25)
		elseif DifficultyID == 5 then --10man heroic wrath
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid10Heroic)
		elseif DifficultyID == 6 then --25man heroic wrath
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid25Heroic)
		elseif DifficultyID == 23 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonMythic)
		elseif DifficultyID == 8 then
			local keylevel = C_ChallengeMode.GetActiveKeystoneInfo()
			if keylevel == 0 then
				instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlus)
			else
				instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonMythicPlus.." +"..keylevel)
			end
		elseif DifficultyID == 24 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.DungeonTimewalker)
		elseif DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.Raid)
		elseif DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 148 or DifficultyID == 175 or DifficultyID == 176 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.RaidHeroic)
		elseif DifficultyID == 16 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.MythicRaid)
		elseif DifficultyID == 7 or DifficultyID == 17 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.RaidLFR)
		elseif DifficultyID == 33 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.skins.instances.RaidTimewalker)
		--else
			--print("unknown instance type")
			--instancedifficulty.Text:SetText(DifficultyID)
		end

		if E.Retail then
			if _G["MiniMapInstanceDifficulty"] and (_G["MiniMapInstanceDifficulty"]:IsShown() == true or _G["MiniMapInstanceDifficulty"]:GetAlpha() == 1) then
				_G["MiniMapInstanceDifficulty"]:SetAlpha(0)
			end
			if _G["MiniMapChallengeMode"] and (_G["MiniMapChallengeMode"]:IsShown() == true or _G["MiniMapChallengeMode"]:GetAlpha() == 1) then
				_G["MiniMapChallengeMode"]:SetAlpha(0)
			end
			if _G["GuildInstanceDifficulty"] then
				_G["GuildInstanceDifficulty"]:SetAlpha(0)
				if _G["GuildInstanceDifficulty"]:IsShown() then
					local normaltext = instancedifficulty.Text:GetText()
					if normaltext ~= nil then
						instancedifficulty.Text:SetText(normaltext.." "..E.db.ElvUI_EltreumUI.skins.instances.guild)
					end
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
	C_Timer.After(5, function()
		_, instanceType = IsInInstance()
		mapID = WorldMapFrame:GetMapID()
		if instanceType == "none" or mapID == 1662 or mapID == 582 or mapID == 590 or instanceType == "pvp" or instanceType == "arena" then
			instancedifficulty:Hide()
			instancedifficulty.Text:Hide()
		end
	end)
end)
