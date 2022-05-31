local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')

--PlaySound(61850)
--PlaySound(61851)
--PlaySound(61852)
--PlaySound(61853)
--PlaySound(61854)

-- Conversion of the party/raid death weakaura into an addon option
local deaththrottle
function ElvUI_EltreumUI:RaidDeathGroupCheck()
	local _, instanceType = IsInInstance()
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		if IsInGroup() == true then
			if E.db.ElvUI_EltreumUI.partyraiddeath.bgdisable then --to disable it in arena/bg
				if instanceType == "arena" or instanceType == "pvp" then
					ElvUI_EltreumUI:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
				else
					deaththrottle = 1
					ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath()
				end
			else
				deaththrottle = 1
				ElvUI_EltreumUI:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath()
			end
		elseif IsInGroup() == false then
			deaththrottle = 0
			ElvUI_EltreumUI:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED') --for ElvUI_EltreumUI:RaidDeath() to not fire when not in a group
		end
	end
end

local deathsound
function ElvUI_EltreumUI:DeathSound()
	deathsound = E.LSM:Fetch("sound", E.db.ElvUI_EltreumUI.partyraiddeath.playerdeathsound)
end

function ElvUI_EltreumUI:RaidDeath(destFlags)
	if E.db.ElvUI_EltreumUI.partyraiddeath.enable then
		if deaththrottle == 1 then
			if bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0 then
				if bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_RAID) > 0 or bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0 then
					PlaySoundFile(deathsound , "Master")
				end
			end
		end
	end
end

-- Role icons, ty a lot Darth Predator for the help!
if E.Retail then
	if IsAddOnLoaded("ElvUI_SLE") then
		local SLE = unpack(ElvUI_SLE)
		SLE.rolePaths["Eltruism"] = {
			TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga",
			HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga",
			DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga"
		}
	else
		local UF = E:GetModule('UnitFrames')
			UF.RoleIconTextures = {
			TANK = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\shield.tga",
			HEALER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\pharmacy.tga",
			DAMAGER = "Interface\\addons\\ElvUI_EltreumUI\\Media\\Textures\\Unitframes\\sword.tga"
		}
	end
end

--bres
local bresframe = CreateFrame("Frame")
local spellicon = bresframe:CreateTexture()
local spellcount = bresframe:CreateFontString(nil, "OVERLAY", "GameFontNormal")
local spellcd = bresframe:CreateFontString(nil, "OVERLAY", "GameFontNormal")
bresframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 342, -28)
if E.Retail then
	E:CreateMover(bresframe, "MoverEltruismBRES", "EltruismBattleRes", nil, nil, nil, "ALL,PARTY,RAID")
end
bresframe:SetParent(UIParent)
bresframe:SetAlpha(0)
--bresframe:RegisterEvent("PLAYER_REGEN_DISABLED")
bresframe:SetSize(97, 30)
S:HandleFrame(bresframe)

local TimeSinceLastUpdate = 0
local ONUPDATE_INTERVAL = 1
function ElvUI_EltreumUI:BattleRes()
	if E.Retail and E.db.ElvUI_EltreumUI.otherstuff.bres then
		local _, instanceType = IsInInstance()
		local DifficultyID = select(3, GetInstanceInfo())
		local ingroup = IsInGroup()

		local difficultyok
		if (DifficultyID == 8 or DifficultyID == 3 or DifficultyID == 4 or DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 or DifficultyID == 5 or DifficultyID == 6 or DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 148 or DifficultyID == 175 or DifficultyID == 176 or DifficultyID == 16) then
			difficultyok = true
		end
		local instanceok
		if instanceType == 'raid' or instanceType == 'party' then
			instanceok = true
		end

		--if ingroup == true and (instanceType == 'raid' or instanceType == 'party') and (DifficultyID == 8 or DifficultyID == 3 or DifficultyID == 4 or DifficultyID == 9 or DifficultyID == 14 or DifficultyID == 173 or DifficultyID == 5 or DifficultyID == 6 or DifficultyID == 174 or DifficultyID == 15 or DifficultyID == 148 or DifficultyID == 175 or DifficultyID == 176 or DifficultyID == 16) then
		if ingroup == true and instanceok == true and difficultyok == true then
			bresframe:SetAlpha(1)
			spellicon:SetSize(30, 30)
			spellicon:SetPoint("LEFT", bresframe)
			spellicon:SetTexture(GetSpellTexture(20484))
			if E.myclass == "DEATHKNIGHT" then
				spellicon:SetTexture(GetSpellTexture(61999))
			elseif E.myclas == "WARLOCK" then
				spellicon:SetTexture(GetSpellTexture(20707))
			end
			spellicon:SetTexCoord(0.08,0.92,0.08,0.92)

			spellcount:SetParent(bresframe)
			spellcount:SetPoint("CENTER", spellicon)
			spellcount:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 4, E.db.general.fontStyle)
			spellcount:SetTextColor(1, 1, 1)

			spellcd:SetParent(bresframe)
			spellcd:SetPoint("LEFT", spellicon, "RIGHT", 10, 0)
			spellcd:SetFont(E.LSM:Fetch('font', E.db.general.font), E.db.general.fontSize + 4, E.db.general.fontStyle)
			spellcd:SetTextColor(1, 1, 1)
			bresframe:SetScript('OnUpdate', function(_, elapsed)
				TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
				if TimeSinceLastUpdate >= ONUPDATE_INTERVAL then
					TimeSinceLastUpdate = 0
					--currentCharges, maxCharges, cooldownStart, cooldownDuration, chargeModRate = GetSpellCharges(spellId or spellName)
					local currentCharges, _, cooldownStart, cooldownDuration = GetSpellCharges(20484)
					if currentCharges ~= nil and cooldownStart ~= nil and cooldownDuration ~= nil then
						bresframe:SetAlpha(1)
						local cooldown = math.floor(cooldownDuration - (GetTime() - cooldownStart))
						if cooldown <= 0 then
							spellcd:SetText(_G.READY)
						else
							if cooldown > 60 then
								--from https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/LFGList.lua#L2551, https://www.wowinterface.com/forums/showthread.php?t=36884
								spellcd:SetFormattedText("%d:%.2d", cooldown/60, cooldown%60)
							elseif cooldown < 60 then
								spellcd:SetText(cooldown)
							end
						end
						spellcount:SetText(currentCharges)
						if currentCharges == 0 then
							spellcount:SetTextColor(1, 0, 0)
							spellicon:SetDesaturated(true)
						else
							spellcount:SetTextColor(1, 1, 1)
							spellicon:SetDesaturated(false)
						end
					elseif currentCharges == nil then
						bresframe:SetAlpha(0)
						--spellcd:SetText(_G.READY)
						--spellicon:SetDesaturated(true)
					end
				end
			end)
		else
			bresframe:SetScript('OnUpdate', nil)
		end
	end
end



--test for neo
local function SkinLocale()
	if E.locale == "koKR" or E.locale == "ruRU" or E.locale == "zhCN" or E.locale == "zhTW" then
		local ime = _G['IMECandidatesFrame']
		S:HandleFrame(ime)
		S:HandleFrame(_G['GeneralDockManagerOverflowButtonList'])
	end
end
SkinLocale()


local handlemeetinghorn = CreateFrame("FRAME")
handlemeetinghorn:RegisterEvent("ADDON_LOADED")
handlemeetinghorn:SetScript("OnEvent", function(_, _, arg)
	if (arg == "MeetingHorn") then
		--S:HandleFrame(_G['MeetingHornDataBroker'])
		_G['MeetingHornMainPanel']:SetScript("OnShow", function()
			S:HandleFrame(_G['MeetingHornMainPanel'])
			S:HandleScrollBar(_G.MeetingHornMainPanelScrollBar)

			--search
			S:HandleFrame(_G.MeetingHornMainPanel.Browser)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Activity)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Mode)
			S:HandleFrame(_G.MeetingHornMainPanelScrollChild)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header1)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header2)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header3)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header4)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header5)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header6)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header7)
			S:HandleFrame(_G.MeetingHornMainPanel.Browser.Header8)
			S:HandleEditBox(_G.MeetingHornMainPanel.Browser.Input)
			S:HandleButton(_G.MeetingHornMainPanel.Browser.Refresh)
			S:HandleButton(_G.MeetingHornMainPanel.Browser.Reset)
			S:HandleButton(_G.MeetingHornMainPanel.Browser.RechargeBtn)
			S:HandleButton(_G.MeetingHornMainPanel.Browser.ApplyLeaderBtn)
			S:HandleScrollBar(_G.MeetingHornMainPanel.Browser.ActivityList.scrollBar)

			--create
			S:HandleFrame(_G.MeetingHornMainPanel.Manage)
			S:HandleFrame(_G.MeetingHornMainPanel.Manage.Creator)
			S:HandleFrame(_G.MeetingHornMainPanel.Manage.Creator.Activity)
			S:HandleFrame(_G.MeetingHornMainPanel.Manage.Creator.Mode)
			S:HandleScrollBar(_G.MeetingHornMainPanel.Manage.Chat.ChatFrame.scrollBar)
			S:HandleFrame(_G.MeetingHornMainPanel.Manage.Creator.Comment)
			S:HandleButton(_G.MeetingHornMainPanel.Manage.Creator.CreateButton)
			S:HandleButton(_G.MeetingHornMainPanel.Manage.Creator.RecruitButton)
			S:HandleButton(_G.MeetingHornMainPanel.Manage.Creator.CloseButton)
			S:HandleFrame(_G.MeetingHornMainPanel.Manage.Chat)
			S:HandleFrame(_G.MeetingHornMainPanel.Manage.Chat.ChatFrame)
			_G.MeetingHornMainPanel.Manage.Chat.ChatBg:Hide()
			_G.MeetingHornMainPanel.Manage.Creator.RecruitButton.RightSeparator:Hide()
			_G.MeetingHornMainPanel.Manage.Creator.CreateButton.RightSeparator:Hide()
			_G.MeetingHornMainPanel.Manage.Creator.CloseButton.Texture:Hide()


			--leader
			S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader)
			S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader.First)
			S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader.First.Footer)
			S:HandleFrame(_G.MeetingHornMainPanel.GoodLeader.First.Header)
			S:HandleButton(_G.MeetingHornMainPanel.GoodLeader.First.Header.ApplyLeaderBtn)

			--announcement
			S:HandleFrame(_G.MeetingHornMainPanel.Announcement)
			S:HandleFrame(_G.MeetingHornMainPanel.Announcement.loading)

			--mission guidance
			S:HandleFrame(_G.MeetingHornMainPanel.MissionGuidance)

			--recent
			S:HandleFrame(_G.MeetingHornMainPanel.Recent)
			S:HandleFrame(_G.MeetingHornMainPanel.Recent.Left)
			S:HandleFrame(_G.MeetingHornMainPanel.Recent.Members)
			S:HandleFrame(_G.MeetingHornMainPanel.Recent.Instance)
			S:HandleButton(_G.MeetingHornMainPanel.Recent.Invite)
			_G.MeetingHornMainPanel.Recent.Invite.RightSeparator:Hide()
			_G.MeetingHornMainPanel.Recent.Invite.LeftSeparator:Hide()

			--quest
			S:HandleFrame(_G.MeetingHornMainPanel.Loading)
			S:HandleFrame(_G.MeetingHornMainPanel.Quest)
			S:HandleFrame(_G.MeetingHornMainPanel.Quest.Body)
			S:HandleFrame(_G.MeetingHornMainPanel.Quest.Body.Quests)
			S:HandleButton(_G.MeetingHornMainPanel.Quest.Body.Refresh)
			S:HandleScrollBar(_G.MeetingHornMainPanel.Quest.Body.Quests.scrollBar)
			S:HandleFrame(_G.MeetingHornMainPanel.Quest.Summary)

			--options
			S:HandleFrame(_G.MeetingHornMainPanel.Options)
			S:HandleFrame(_G.MeetingHornMainPanel.Options.Options)
			S:HandleFrame(_G.MeetingHornMainPanel.Options.Filters)
			S:HandleFrame(_G.MeetingHornMainPanel.Options.Filters.FilterList)
			S:HandleScrollBar(_G.MeetingHornMainPanel.Options.Filters.FilterList.scrollBar)

			S:HandleButton(_G.MeetingHornMainPanel.Options.Filters.Add)
			S:HandleButton(_G.MeetingHornMainPanel.Options.Filters.Import)
			S:HandleButton(_G.MeetingHornMainPanel.Options.Filters.Export)

			--help
			S:HandleFrame(_G.MeetingHornMainPanel.Help)

			_G.MeetingHornMainPanelPortraitFrame:Hide()

		end)
	end
end)
