local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local _G = _G

--Dark Souls Death, my first weakaura adapted

--create frame/texture/font
local darksouls = CreateFrame("FRAME", nil, WorldFrame)
darksouls:SetSize(1920,1080)
local darksoulstex = darksouls:CreateTexture()
darksoulstex:SetTexture(186185)
darksoulstex:SetVertexColor(0, 0, 0)
darksoulstex:SetAlpha(0.72)
darksoulstex:SetAllPoints(darksouls)
darksouls:SetPoint("Center", UIParent)
darksouls.Text = darksouls:CreateFontString(nil, "OVERLAY", "GameFontNormal")
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
darksouls:Hide()

--create animation
darksouls.scaler = darksouls.Text:CreateAnimationGroup()
local scaleOut = darksouls.scaler:CreateAnimation("Scale")
scaleOut:SetOrder(1)
scaleOut:SetDuration(5)
scaleOut:SetStartDelay(0.1)
scaleOut:SetSmoothing("OUT")
scaleOut:SetFromScale(1, 1)
scaleOut:SetToScale(2, 2)
local moveOut = darksouls.scaler:CreateAnimation("Translation")
moveOut:SetOrder(1)
moveOut:SetDuration(5)
moveOut:SetSmoothing("OUT")
moveOut:SetStartDelay(0.1)
moveOut:SetOffset(-fontsize, -fontsize/4)

--run
darksouls:RegisterEvent("PLAYER_DEAD")
--darksouls:RegisterEvent("PLAYER_STARTED_MOVING")
darksouls:SetScript("OnEvent", function()
	local _, instanceType = IsInInstance()
	if E.db.ElvUI_EltreumUI.otherstuff.playerdeath and IsEncounterSuppressingRelease() == false and instanceType ~= "arena" and instanceType ~= "pvp" then
		UIParent:SetAlpha(0)
		PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\You_Died.ogg" , "Master")
		UIFrameFadeIn(darksouls, 1, 0, 1)
		darksouls.scaler:Play()
		C_Timer.After(4, function()
			UIFrameFadeOut(darksouls, 1, 1, 0)
		end)
		C_Timer.After(5, function()
			--if not InCombatLockdown() then
				UIParent:SetAlpha(1)
			--end
		end)
	end
end)
