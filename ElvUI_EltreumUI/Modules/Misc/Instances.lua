local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))

local instancedifficulty = CreateFrame("FRAME")
instancedifficulty:SetSize(40, 40)
instancedifficulty:SetPoint("CENTER", _G.Minimap , -50, 50)
instancedifficulty:Hide()
instancedifficulty.Text = instancedifficulty:CreateFontString(nil,"ARTWORK")
instancedifficulty:RegisterEvent("ZONE_CHANGED_NEW_AREA")
instancedifficulty:RegisterEvent("PLAYER_ENTERING_WORLD")
E:CreateMover(instancedifficulty, "MoverEltruismInstanceDifficulty", "EltruismInstanceDifficulty", nil, nil, nil, "ALL,SOLO,PARTY,RAID")
instancedifficulty:SetScript("OnEvent", function(_,event)
	local _, instanceType = IsInInstance()
	if (instanceType == "raid" or instanceType == "party" or instanceType == "scenario") and E.db.ElvUI_EltreumUI.instances.enable then
		instancedifficulty.Text:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.ElvUI_EltreumUI.instances.fontsize, E.db.general.fontStyle)
		instancedifficulty.Text:SetTextColor(E.db.ElvUI_EltreumUI.instances.r, E.db.ElvUI_EltreumUI.instances.g, E.db.ElvUI_EltreumUI.instances.b)
		instancedifficulty.Text:SetPoint("CENTER", _G["MoverEltruismInstanceDifficulty"])
		instancedifficulty.Text:SetParent(_G.Minimap)
		local DifficultyID = select(3, GetInstanceInfo())  --https://wowpedia.fandom.com/wiki/DifficultyID
		if DifficultyID == 1 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.DungeonNormal)
		elseif DifficultyID == 2 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.DungeonHeroic)
		elseif DifficultyID == 23 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.DungeonMythic)
		elseif DifficultyID == 8 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.DungeonMythicPlus)
		elseif DifficultyID == 24 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.DungeonTimewalker)
		elseif DifficultyID == 3 or DifficultyID == 4 or DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.Raid)
		elseif DifficultyID == 5 or DifficultyID == 6 or DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 148 or DifficultyID == 175 or DifficultyID == 176 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.RaidHeroic)
		elseif DifficultyID == 16 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.MythicRaid)
		elseif DifficultyID == 7 or DifficultyID == 17 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.RaidLFR)
		elseif DifficultyID == 33 then
			instancedifficulty.Text:SetText(E.db.ElvUI_EltreumUI.instances.RaidTimewalker)
		--else
			--print("unknown instance type")
			--instancedifficulty.Text:SetText(DifficultyID)
		end
		if E.Retail then
			if _G["MiniMapInstanceDifficulty"] then
				_G["MiniMapInstanceDifficulty"]:Hide()
			elseif _G["MiniMapChallengeMode"] then
				_G["MiniMapChallengeMode"]:Hide()
			end

			if _G["GuildInstanceDifficulty"] then
				instancedifficulty.Text:SetText(instancedifficulty.Text:GetText().." "..E.db.ElvUI_EltreumUI.instances.guild)
				--_G["GuildInstanceDifficulty"]:Hide()
				_G["GuildInstanceDifficulty"]:SetAlpha(0)
			end
		end
		instancedifficulty:Show()
	else
		instancedifficulty:Hide()
	end
end)
