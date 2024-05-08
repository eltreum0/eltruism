local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local WorldFrame = _G.WorldFrame
local UIParent = _G.UIParent
local IsInInstance = _G.IsInInstance
local select = _G.select
local UnitAura = _G.C_UnitAuras and _G.C_UnitAuras.GetAuraDataByIndex or _G.UnitAura
local IsEncounterSuppressingRelease = _G.IsEncounterSuppressingRelease
local ObjectiveTrackerFrame = _G.ObjectiveTrackerFrame
local Minimap = _G.Minimap
local PlaySoundFile = _G.PlaySoundFile
local UIFrameFadeIn = _G.UIFrameFadeIn
local UIFrameFadeOut = _G.UIFrameFadeOut

--Dark Souls Death, my first weakaura adapted
local darksouls = CreateFrame("FRAME", nil, WorldFrame)
local darksoulstex = darksouls:CreateTexture()
darksouls:SetParent(WorldFrame)
darksoulstex:SetParent(darksouls)
darksouls:Hide()
local darksoulsbar = darksouls:CreateTexture()
darksouls.Text = darksouls:CreateFontString(nil, "OVERLAY", "GameFontNormal")
darksouls.Text:SetParent(darksouls)
darksouls.scaler = darksouls.Text:CreateAnimationGroup()
local scaleOut = darksouls.scaler:CreateAnimation("Scale")
local moveOut = darksouls.scaler:CreateAnimation("Translation")

-- GTA version
local gta = CreateFrame("FRAME", nil, WorldFrame)
local gtatex = gta:CreateTexture()
gta:SetParent(WorldFrame)
gta:Hide()
local gtatext = CreateFrame("FRAME", nil, WorldFrame)
gtatext:SetParent(WorldFrame)
gtatext:Hide()
local gtabanner = gtatext:CreateTexture()
gta.Text = gtatext:CreateFontString(nil, "OVERLAY", "GameFontNormal")
local isAnimationPlaying = false

function ElvUI_EltreumUI.PlayerDeathAnimation()

	--Dark Souls
	if E.db.ElvUI_EltreumUI.skins.playerdeath or E.db.ElvUI_EltreumUI.skins.playerdeathcustom then
		darksouls:RegisterEvent("PLAYER_DEAD")
		--darksouls:RegisterEvent("PLAYER_STARTED_MOVING")
		darksouls:SetScript("OnEvent", function()
			if not isAnimationPlaying then
				local _, instanceType = IsInInstance()
				local spellId
				for i= 1, 10 do
					spellId = select(10, UnitAura("player", i))
				end
				if not IsEncounterSuppressingRelease() and instanceType == "none" and (spellId ~= 20711 and spellId ~= 5384) then
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
					if E.db.ElvUI_EltreumUI.skins.playerdeathcustom then
						darksouls.Text:SetText(E.db.ElvUI_EltreumUI.skins.playerdeathcustomtext)
						darksouls.Text:SetFont("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Fonts\\OptimusPrinceps.TTF", 64, "OUTLINE")
					else
						darksouls.Text:SetText("YOU DIED")
						darksouls.Text:SetFont("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Fonts\\OptimusPrinceps.TTF", fontsize, "OUTLINE")
					end
					darksoulsbar:SetSize(x,200)
					darksoulsbar:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\YouDied.TGA")
					darksoulsbar:SetAlpha(0.60)
					darksoulsbar:SetPoint("CENTER", WorldFrame)
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
					if E.db.ElvUI_EltreumUI.skins.playerdeathcustom then
						local textwidth = darksouls.Text:GetStringWidth()
						moveOut:SetOffset(-textwidth/2, -fontsize/4)
					else
						moveOut:SetOffset(-fontsize*1.25, fontsize/8)
					end

					UIParent:SetAlpha(0)
					if E.Retail then
						ObjectiveTrackerFrame:SetAlpha(0)
					end
					Minimap:Hide()
					Minimap:SetAlpha(0)
					if not E.ClassicHC then
						PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\You_Died.ogg" , "Master")
					end
					UIFrameFadeIn(darksouls, 1, 0, 1)
					darksouls.scaler:Play()
					isAnimationPlaying = true
					E:Delay(4, function() UIFrameFadeOut(darksouls, 1, 1, 0) end)
					E:Delay(5, function()
						if _G["ElvUF_Player"].Portrait3D then
							_G["ElvUF_Player"].Portrait3D:Show()
						end
						if _G["EltruismPlayerEffect"] then
							_G["EltruismPlayerEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
						end
						if _G["EltruismPlayerPowerBarEffect"] then
							_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0.4)
						end
						UIParent:SetAlpha(1)
						if E.Retail then
							ObjectiveTrackerFrame:SetAlpha(1)
						end
						Minimap:SetAlpha(1)
						Minimap:Show()
						isAnimationPlaying = false
					end)
				end
			end
		end)
	else
		darksouls:UnregisterAllEvents()
	end

	--Grand Theft Auto (5/Online)
	if E.db.ElvUI_EltreumUI.skins.playerdeathgta then
		gta:RegisterEvent("PLAYER_DEAD")
		--gta:RegisterEvent("PLAYER_STARTED_MOVING")
		gta:SetScript("OnEvent", function()
			if not isAnimationPlaying then
				local _, instanceType = IsInInstance()
				local spellId
				for i= 1, 10 do
					spellId = select(10, UnitAura("player", i))
				end
				if not IsEncounterSuppressingRelease() and instanceType == "none" and (spellId ~= 20711 and spellId ~= 5384) then

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

					local x, y = UIParent:GetSize()
					gta:SetSize(x,y)
					gta:SetPoint("Center", UIParent)

					gtatex:SetTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\White8x8.tga")
					gtatex:SetVertexColor(0.03, 0.03, 0)
					gtatex:SetAlpha(0.40)
					gtatex:SetAllPoints(gta)
					gtatex:SetDrawLayer("BACKGROUND")

					gta.Text:SetJustifyH("CENTER")
					gta.Text:SetJustifyV("MIDDLE")
					gta.Text:SetTextColor(1, 0.1, 0.10, 1)
					gta.Text:SetFont("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Fonts\\pricedown.TTF", 200, "OUTLINE")
					gta.Text:SetShadowColor(0, 0, 0, 1)
					gta.Text:SetShadowOffset(4, -4)
					gta.Text:SetText("WASTED")
					gta.Text:SetDrawLayer("OVERLAY")
					if E.ClassicHC then
						gtabanner:SetTexture("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Wasted.tga")
					end
					gtabanner:SetAlpha(0.60)
					gtabanner:SetSize(x, 300)

					--gta.Text:SetPoint("CENTER", WorldFrame, "CENTER", math.random(-200,200), math.random(-200,200))
					gta.Text:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)
					gtabanner:SetPoint("CENTER", gta.Text)

					UIParent:SetAlpha(0)
					if E.Retail then
						ObjectiveTrackerFrame:SetAlpha(0)
					end
					Minimap:Hide()
					Minimap:SetAlpha(0)
					if E.ClassicHC then
						PlaySoundFile("Interface\\AddOns\\ElvUI_EltreumUI\\Media\\sound\\wasted.ogg" , "Master")
					end
					UIFrameFadeIn(gta, 1, 0, 1)
					isAnimationPlaying = true

					E:Delay(2.6, function()
						UIFrameFadeIn(gtatext, 0, 0, 1)
					end)

					E:Delay(5, function()
						UIFrameFadeOut(gta, 1, 1, 0)
						UIFrameFadeOut(gtatext, 1, 1, 0)
					end)

					E:Delay(6, function()
						if _G["ElvUF_Player"].Portrait3D then
							_G["ElvUF_Player"].Portrait3D:Show()
						end
						if _G["EltruismPlayerEffect"] then
							_G["EltruismPlayerEffect"]:SetAlpha(E.db.ElvUI_EltreumUI.unitframes.models.ufalpha)
						end
						if _G["EltruismPlayerPowerBarEffect"] then
							_G["EltruismPlayerPowerBarEffect"]:SetAlpha(0.4)
						end
						UIParent:SetAlpha(1)
						if E.Retail then
							ObjectiveTrackerFrame:SetAlpha(1)
						end
						Minimap:SetAlpha(1)
						Minimap:Show()
						isAnimationPlaying = false
					end)
				end
			end
		end)
	else
		gta:UnregisterAllEvents()
	end
end
