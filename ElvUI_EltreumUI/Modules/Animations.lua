local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

--Dark Souls Death, my first weakaura adapted
local darksouls = CreateFrame("FRAME", nil, WorldFrame)
local darksoulstex = darksouls:CreateTexture()
darksouls:Hide()
local darksoulsbar = darksouls:CreateTexture()
darksouls.Text = darksouls:CreateFontString(nil, "OVERLAY", "GameFontNormal")
darksouls.scaler = darksouls.Text:CreateAnimationGroup()
local scaleOut = darksouls.scaler:CreateAnimation("Scale")
local moveOut = darksouls.scaler:CreateAnimation("Translation")

-- GTA version
local gta = CreateFrame("FRAME", nil, WorldFrame)
local gtatex = gta:CreateTexture()
gta:Hide()
local gtatext = CreateFrame("FRAME", nil, WorldFrame)
gta.Text = gtatext:CreateFontString(nil, "OVERLAY", "GameFontNormal")

function ElvUI_EltreumUI.PlayerDeathAnimation()
	--Dark Souls
	darksouls:RegisterEvent("PLAYER_DEAD")
	--darksouls:RegisterEvent("PLAYER_STARTED_MOVING")
	darksouls:SetScript("OnEvent", function()
		local x, y = UIParent:GetSize()
		darksouls:SetSize(x,y)
		darksoulstex:SetTexture(186185)
		darksoulstex:SetVertexColor(0, 0, 0)
		darksoulstex:SetAlpha(0.60)
		darksoulstex:SetAllPoints(darksouls)
		darksouls:SetPoint("Center", UIParent)

		darksouls.Text:SetJustifyH("CENTER")
		darksouls.Text:SetJustifyV("MIDDLE")
		darksouls.Text:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		darksouls.Text:SetTextColor(1, 0.1803921568627451, 0.196078431372549, 0.5)
		local fontsize = 240
		darksouls.Text:SetFont("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Fonts\\OptimusPrinceps.TTF", fontsize, "OUTLINE")
		darksouls:SetParent(WorldFrame)
		darksoulstex:SetParent(darksouls)
		darksouls.Text:SetParent(darksouls)
		darksouls.Text:SetText("YOU DIED")

		darksoulsbar:SetSize(x,200)
		darksoulsbar:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\YouDied.TGA")
		darksoulsbar:SetAlpha(0.60)
		darksoulsbar:SetPoint("CENTER", WorldFrame)
		scaleOut:SetOrder(1)
		scaleOut:SetDuration(5)
		scaleOut:SetStartDelay(0.1)
		scaleOut:SetSmoothing("OUT")
		scaleOut:SetFromScale(1, 1)
		scaleOut:SetToScale(2, 2)
			moveOut:SetOrder(1)
		moveOut:SetDuration(5)
		moveOut:SetSmoothing("OUT")
		moveOut:SetStartDelay(0.1)
		moveOut:SetOffset(-fontsize, -fontsize/4)

		local _, instanceType = IsInInstance()
		local tbccheck = false
		if E.Retail then
			tbccheck = true
		elseif E.TBC or E.Classic then
			if instanceType ~= "raid" and instanceType ~= "party" then
				tbccheck = true
			end
		end
		local spellId
		for i= 1, 10 do
			spellId = select(10, UnitAura("player", i))
		end
		if E.db.ElvUI_EltreumUI.otherstuff.playerdeath and IsEncounterSuppressingRelease() == false and instanceType ~= "arena" and instanceType ~= "pvp" and tbccheck == true and (spellId ~= 20711 and spellId ~= 5384) then
			UIParent:SetAlpha(0)
			if E.Retail then
				ObjectiveTrackerFrame:SetAlpha(0)
			end
			Minimap:Hide()
			Minimap:SetAlpha(0)
			PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\You_Died.ogg" , "Master")
			UIFrameFadeIn(darksouls, 1, 0, 1)
			darksouls.scaler:Play()
			C_Timer.After(4, function() UIFrameFadeOut(darksouls, 1, 1, 0) end)
			C_Timer.After(5, function()
				UIParent:SetAlpha(1)
				if E.Retail then
					ObjectiveTrackerFrame:SetAlpha(1)
				end
				Minimap:SetAlpha(1)
				Minimap:Show()
			end)
		end
	end)

	--Grand Theft Auto (5/Online)
	gta:RegisterEvent("PLAYER_DEAD")
	--gta:RegisterEvent("PLAYER_STARTED_MOVING")
	gta:SetScript("OnEvent", function()
		local x, y = UIParent:GetSize()
		gta:SetSize(x,y)
		gtatex:SetTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\White8x8.tga")
		gtatex:SetVertexColor(0.03, 0.03, 0)
		gtatex:SetAlpha(0.40)
		gtatex:SetAllPoints(gta)
		gta:SetPoint("Center", UIParent)
		gta:SetParent(WorldFrame)
		gtatex:SetDrawLayer("BACKGROUND")
		gtatext:SetParent(WorldFrame)

		gta.Text:SetJustifyH("CENTER")
		gta.Text:SetJustifyV("MIDDLE")
		gta.Text:SetTextColor(1, 0.1, 0.10, 1)
		gta.Text:SetFont("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Fonts\\pricedown.TTF", 200, "OUTLINE")
		gta.Text:SetShadowColor(0, 0, 0, 1)
		gta.Text:SetShadowOffset(4, -4)
		gta.Text:SetText("WASTED")
		gta.Text:SetDrawLayer("OVERLAY")
		gtatext:Hide()
		local _, instanceType = IsInInstance()
		local tbccheck = false
		if E.Retail then
			tbccheck = true
		elseif E.TBC or E.Classic then
			if instanceType ~= "raid" and instanceType ~= "party" then
				tbccheck = true
			end
		end
		local spellId
		for i= 1, 10 do
			spellId = select(10, UnitAura("player", i))
		end
		if E.db.ElvUI_EltreumUI.otherstuff.playerdeathgta and IsEncounterSuppressingRelease() == false and instanceType ~= "arena" and instanceType ~= "pvp" and tbccheck == true and (spellId ~= 20711 and spellId ~= 5384) then
			UIParent:SetAlpha(0)
			if E.Retail then
				ObjectiveTrackerFrame:SetAlpha(0)
			end
			Minimap:Hide()
			Minimap:SetAlpha(0)
			PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\wasted.ogg" , "Master")
			UIFrameFadeIn(gta, 1, 0, 1)

			C_Timer.After(2.6, function()
				gta.Text:SetPoint("CENTER", WorldFrame, "CENTER", math.random(-200,200), math.random(-200,200))
				UIFrameFadeIn(gtatext, 0, 0, 1)
			end)

			C_Timer.After(5, function()
				UIFrameFadeOut(gta, 1, 1, 0)
				UIFrameFadeOut(gtatext, 1, 1, 0)
			end)

			C_Timer.After(6, function()
				UIParent:SetAlpha(1)
				if E.Retail then
					ObjectiveTrackerFrame:SetAlpha(1)
				end
				Minimap:SetAlpha(1)
				Minimap:Show()
			end)
		end
	end)
end
