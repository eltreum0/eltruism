local ElvUI_EltreumUI, E, L, V, P, G = unpack((select(2, ...)))
local S = E:GetModule('Skins')
local _G = _G
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

--skin simc
function ElvUI_EltreumUI:EltruismSimulationCraft()
	if E.db.ElvUI_EltreumUI.skins.simulationcraft then
		local Simc = E.Libs.AceAddon:GetAddon("Simulationcraft")

		--like bugsack the frame is not generated on load
		hooksecurefunc(Simc, 'GetMainFrame', function()
			if not _G["SimcFrame"].isSkinned then
				S:HandleFrame(_G["SimcFrame"])
				S:HandleButton(_G["SimcFrameButton"])
				S:HandleScrollBar(_G["SimcScrollFrameScrollBar"])

				if E.db.ElvUI_EltreumUI.skins.shadow.enable then
					if not E.Classic then
						if _G["SimcFrame"] and not _G["SimcFrame"].shadow then
							_G["SimcFrame"]:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["SimcFrame"].shadow) end
						end
					else
						if _G["SimcFrame"] and _G["SimcFrame"].backdrop and not _G["SimcFrame"].backdrop.shadow then
							_G["SimcFrame"].backdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(_G["SimcFrame"].backdrop.shadow) end
						end
					end
				end

				_G["SimcFrame"].isSkinned = true
			end
		end)
	end
end
S:AddCallbackForAddon('SimulationCraft', "EltruismSimulationCraft", ElvUI_EltreumUI.EltruismSimulationCraft)
