local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local pairs = pairs
local SetCVar = SetCVar
local IsAddOnLoaded = IsAddOnLoaded


local PlaySoundFile = PlaySoundFile

--Simpy:
--it would be far more efficient if you managed the group list table outside
--of the combat calling function (using GROUP_ROSTER_UPDATE),
--emptied it when you aren't in a group,
--and only looked for names on that list when the combat event fires

-- Conversion of the party/raid death weakaura into an addon option
function ElvUI_EltreumUI:RaidDeath()
	if E.private.ElvUI_EltreumUI.partyraiddeath.enable then
		local _, eventType, _, _, _, _, _, _, destName, _, _ = CombatLogGetCurrentEventInfo()
		local name = name
		if eventType == "UNIT_DIED" then
			if IsInGroup() then
					for ii=1, GetNumGroupMembers() do
						name = GetRaidRosterInfo(ii)
					end
				if destName == name then
					if E.private.ElvUI_EltreumUI.partyraiddeath.bruh then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\bruh.mp3", "Master")
					end
					if E.private.ElvUI_EltreumUI.partyraiddeath.robloxoof then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\oof.mp3", "Master")
					end
					if E.private.ElvUI_EltreumUI.partyraiddeath.shame then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\shame.mp3", "Master")
					end
					if E.private.ElvUI_EltreumUI.partyraiddeath.wow then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\wow.mp3", "Master")
					end
					if E.private.ElvUI_EltreumUI.partyraiddeath.mario then
					PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\mariodeath.mp3", "Master")
					end
				end
			end
		end
	end
end
