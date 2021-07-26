local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G
local IsAddOnLoaded = _G.IsAddOnLoaded
local ElvUF_Player_PowerBar = _G['ElvUF_Player_PowerBar']
local ElvUF_Player_HealthBar = _G['ElvUF_Player_HealthBar']
local ElvUF_TargetTarget_HealthBar = _G['ElvUF_TargetTarget_HealthBar']
local ElvUF_TargetTarget_PowerBar = _G['ElvUF_TargetTarget_PowerBar']
local ElvUF_Target_HealthBar = _G['ElvUF_Target_HealthBar']
local ElvUF_Target_PowerBar = _G['ElvUF_Target_PowerBar']
local ElvUF_Focus_HealthBar = _G['ElvUF_Focus_HealthBar']
local ElvUF_Focus_PowerBar = _G['ElvUF_Focus_PowerBar']
local ElvUF_Pet = _G['ElvUF_Pet']
local pairs = _G.pairs
local CreateFrame = _G.CreateFrame


--turns out elvui includes shadows! Ty azilroka
function ElvUI_EltreumUI:Shadows()
	--disable if Shadow and Light is loaded since im pretty sure SLE does shadows better than me doing it like my borders
	if (not IsAddOnLoaded("ElvUI_SLE")) then
		if E.db.ElvUI_EltreumUI.skins.quests then
		    ElvUF_Player_HealthBar:CreateShadow()
		    ElvUF_Player_PowerBar:CreateShadow()

		    ElvUF_TargetTarget_HealthBar:CreateShadow()
		    ElvUF_TargetTarget_PowerBar:CreateShadow()
		    ElvUF_Target_HealthBar:CreateShadow()
		    ElvUF_Target_PowerBar:CreateShadow()
		    ElvUF_Focus_HealthBar:CreateShadow()
		    ElvUF_Focus_PowerBar:CreateShadow()
		    ElvUF_Pet:CreateShadow()

		    --action bars, from borders
		    for i = 1, 10 do
				local actionbars = {_G['ElvUI_Bar'..i]}
				for _, frame in pairs(actionbars) do
					for k = 1, 12 do
						local slots = {_G['ElvUI_Bar'..i..'Button'..k]}
						for _, button in pairs(slots) do
							button.shadow = button:CreateShadow(nil, true)
							button.shadow:SetParent(button)
							button.shadow.size = 2
						end
					end
				end
			end

			--same as above but for party
			for i = 1, 5 do
				local partymembers = {_G['ElvUF_PartyGroup1UnitButton'..i]}
				for _, frame in pairs(partymembers) do
					for _, button in pairs(partymembers) do
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2
					end
				end
			end

			--boss
			for i = 1, 5 do
				local bossmembers = {_G['ElvUF_Boss'..i]}
				for _, frame in pairs(bossmembers) do
					for _, button in pairs(bossmembers) do
						button.shadow = button:CreateShadow(nil, true)
						button.shadow:SetParent(button)
						button.shadow.size = 2
					end
				end
			end

			--pets
			for i = 1, 12 do
				local button = _G['PetActionButton'..i]
				if not button then
					break
				else
					button.shadow = button:CreateShadow(nil, true)
					button.shadow:SetParent(button)
					button.shadow.size = 2
				end
			end

		    local RightChatShadow = CreateFrame("Frame")
		    local rightsizex, rightsizey = _G['RightChatMover']:GetSize()
		    RightChatShadow:SetSize(rightsizex, rightsizey)
		    RightChatShadow:SetParent(_G['RightChatPanel'])
		    RightChatShadow.shadow = RightChatShadow:CreateShadow(nil, true)
		    RightChatShadow:SetPoint("TOPRIGHT", _G['RightChatPanel'] ,"TOPRIGHT", 0, 0)
			RightChatShadow:SetPoint("BOTTOMLEFT", _G['RightChatDataPanel'] ,"BOTTOMLEFT", 0, 0)
		    RightChatShadow:Show()

		    local LeftChatShadow = CreateFrame("Frame")
		    local leftsizex, leftsizey = _G['LeftChatMover']:GetSize()
		    LeftChatShadow:SetSize(leftsizex, leftsizey)
		    LeftChatShadow:SetParent(_G['LeftChatPanel'])
		    LeftChatShadow.shadow = LeftChatShadow:CreateShadow(nil, true)
		    LeftChatShadow:SetPoint("TOPLEFT", _G['LeftChatPanel'] ,"TOPLEFT", 0, 0)
			LeftChatShadow:SetPoint("BOTTOMRIGHT", _G['LeftChatDataPanel'] ,"BOTTOMRIGHT", 0, 0)
		    LeftChatShadow:Show()


		    local MinimapShadow = CreateFrame("Frame")
		    local Minimapsizex, Minimapsizey = _G['Minimap']:GetSize()
		    MinimapShadow:SetSize(Minimapsizex, Minimapsizey)
		    MinimapShadow:SetParent(_G['RightChatPanel'])
		    MinimapShadow.shadow = MinimapShadow:CreateShadow(nil, true)
		    MinimapShadow:SetPoint("TOPRIGHT", _G['Minimap'] ,"TOPRIGHT", 0, 0)
			MinimapShadow:SetPoint("BOTTOMLEFT", _G['MinimapPanel'] ,"BOTTOMLEFT", 0, 0)
		    MinimapShadow:Show()

		end
	end
end
