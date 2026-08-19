local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local WorldFrame = _G.WorldFrame
local UIParent = _G.UIParent
local IsInInstance = _G.IsInInstance
local select = _G.select
local IsEncounterSuppressingRelease = _G.IsEncounterSuppressingRelease
local ObjectiveTrackerFrame = _G.ObjectiveTrackerFrame
local Minimap = _G.Minimap
local PlaySoundFile = _G.PlaySoundFile
local UIFrameFadeIn = _G.UIFrameFadeIn
local UIFrameFadeOut = _G.UIFrameFadeOut

--Dark Souls Death, my first weakaura adapted
local deathFrame = CreateFrame("FRAME", "EltruismDeathFrame", WorldFrame)
deathFrame:SetParent(WorldFrame)
deathFrame:Hide()
local deathBg = deathFrame:CreateTexture()
deathBg:SetAllPoints(deathFrame)

local deathContent = CreateFrame("FRAME", nil, deathFrame)
deathContent:SetAllPoints(deathFrame)
local deathBanner = deathContent:CreateTexture()

deathFrame.Text = deathContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
deathFrame.scaler = deathFrame.Text:CreateAnimationGroup()

local scaleOut = deathFrame.scaler:CreateAnimation("Scale")
local moveOut = deathFrame.scaler:CreateAnimation("Translation")
local isAnimationPlaying = false

local IGNORED_SPELLS = {
	[20711] = true, -- Spirit of Redemption
	[5384] = true, -- Feign Death
}
local function HasIgnoredDeathSpell()
	for i = 1, 40 do
		local spellId
		if _G.C_UnitAuras and _G.C_UnitAuras.GetAuraDataByIndex then
			local data = _G.C_UnitAuras.GetAuraDataByIndex("player", i)
			if not data then break end
			spellId = data.spellId
		else
			spellId = select(10, _G.UnitAura("player", i))
			if not spellId then break end
		end

		if IGNORED_SPELLS[spellId] then
			return true
		end
	end
	return false
end

function ElvUI_EltreumUI.PlayerDeathAnimation()
	local db = E.db.ElvUI_EltreumUI.skins
	local isDarkSouls = db.playerdeath or db.playerdeathcustom
	local isGTA = db.playerdeathgta

	if isDarkSouls or isGTA then
		deathFrame:RegisterEvent("PLAYER_DEAD")
	else
		deathFrame:UnregisterEvent("PLAYER_DEAD")
		return
	end

	deathFrame:SetScript("OnEvent", function()
		if isAnimationPlaying then return end

		local _, instanceType = IsInInstance()

		if IsEncounterSuppressingRelease() or instanceType ~= "none" or HasIgnoredDeathSpell() then
			return
		end

		isAnimationPlaying = true

		E:Delay(0.08, function()
			if _G["ElvUF_Player"] and _G["ElvUF_Player"].Portrait3D then
				_G["ElvUF_Player"].Portrait3D:Hide()
			end
			if _G["EltruismPlayerEffect"] then
				_G["EltruismPlayerEffect"]:SetAlpha(0)
			end
			if _G["EltruismPlayerPowerBarEffect"] then
				_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0)
			end
		end)

		local x, y = E.UIParent:GetSize()
		deathFrame:SetSize(x, y)
		deathFrame.Text:ClearAllPoints()
		deathFrame.Text:SetPoint("CENTER", E.UIParent, "CENTER", 0, 0)
		deathFrame.Text:SetJustifyH("CENTER")
		deathFrame.Text:SetJustifyV("MIDDLE")
		deathBanner:ClearAllPoints()

		UIParent:SetAlpha(0)
		if E.Retail then
			ObjectiveTrackerFrame:SetAlpha(0)
		end
		Minimap:Hide()
		Minimap:SetAlpha(0)

		deathContent:SetAlpha(1)

		local fadeOutDelay = 4
		local uiRestoreDelay = 5

		if isDarkSouls then
			deathBg:SetTexture(186185)
			deathBg:SetVertexColor(0, 0, 0)
			deathBg:SetAlpha(0.60)
			deathBg:SetDrawLayer("BACKGROUND")

			deathFrame.Text:SetTextColor(1, 0.18, 0.20, 0.5)
			deathFrame.Text:SetShadowColor(0, 0, 0, 0)

			local fontsize = 240
			if db.playerdeathcustom then
				deathFrame.Text:SetText(db.playerdeathcustomtext)
				deathFrame.Text:SetFont("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Fonts\\OptimusPrinceps.TTF", 64, "OUTLINE")
				local textwidth = deathFrame.Text:GetStringWidth()
				moveOut:SetOffset(-textwidth/2, -fontsize/4)
			else
				deathFrame.Text:SetText("YOU DIED")
				deathFrame.Text:SetFont("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Fonts\\OptimusPrinceps.TTF", fontsize, "OUTLINE")
				moveOut:SetOffset(-fontsize*1.25, fontsize/8)
			end

			deathBanner:SetSize(x, 200)
			deathBanner:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\YouDied.TGA")
			deathBanner:SetAlpha(0.60)
			deathBanner:SetPoint("CENTER", WorldFrame)

			scaleOut:SetOrder(1)
			scaleOut:SetDuration(5)
			scaleOut:SetStartDelay(0.1)
			scaleOut:SetSmoothing("OUT")
			scaleOut:SetScaleFrom(1, 1)
			scaleOut:SetScaleTo(2, 2)
			moveOut:SetOrder(1)
			moveOut:SetDuration(5)
			moveOut:SetSmoothing("OUT")
			moveOut:SetStartDelay(0.1)

			if not E.ClassicHC then
				PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\You_Died.ogg", "Master")
			end

			UIFrameFadeIn(deathFrame, 1, 0, 1)
			deathFrame.scaler:Play()
		elseif isGTA then
			fadeOutDelay = 5
			uiRestoreDelay = 6

			deathBg:SetTexture("Interface\\AddOns\\ElvUI\\Game\\Shared\\Media\\Textures\\White8x8.tga")
			deathBg:SetVertexColor(0.03, 0.03, 0)
			deathBg:SetAlpha(0.40)
			deathBg:SetDrawLayer("BACKGROUND")

			deathFrame.Text:SetTextColor(1, 0.1, 0.10, 1)
			deathFrame.Text:SetFont("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Fonts\\pricedown.TTF", 200, "OUTLINE")
			deathFrame.Text:SetShadowColor(0, 0, 0, 1)
			deathFrame.Text:SetShadowOffset(4, -4)
			deathFrame.Text:SetText("WASTED")

			if E.ClassicHC then
				deathBanner:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Wasted.tga")
			else
				deathBanner:SetTexture(nil)
			end

			deathBanner:SetAlpha(0.60)
			deathBanner:SetSize(x, 300)
			deathBanner:SetPoint("CENTER", deathFrame.Text)

			deathContent:SetAlpha(0)
			UIFrameFadeIn(deathFrame, 1, 0, 1)

			E:Delay(2.6, function()
				UIFrameFadeIn(deathContent, 0, 0, 1)
			end)

			if E.ClassicHC then
				PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\wasted.ogg", "Master")
			end
		end

		E:Delay(fadeOutDelay, function()
			UIFrameFadeOut(deathFrame, 1, 1, 0)
			if isGTA then
				UIFrameFadeOut(deathContent, 1, 1, 0)
			end
		end)

		E:Delay(uiRestoreDelay, function()
			if _G["ElvUF_Player"] and _G["ElvUF_Player"].Portrait3D then
				_G["ElvUF_Player"].Portrait3D:Show()
			end
			if _G["EltruismPlayerEffect"] then
				_G["EltruismPlayerEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
			end
			if _G["EltruismPlayerPowerBarEffect"] then
				_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0.4)
			end
			UIParent:SetAlpha(1)
			if E.Retail then ObjectiveTrackerFrame:SetAlpha(1) end
			Minimap:SetAlpha(1)
			Minimap:Show()

			isAnimationPlaying = false
		end)
	end)
end
