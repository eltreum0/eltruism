local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc

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
				S:HandleCheckBox(_G["SimcFrame"].CheckButton)

				if E.db.ElvUI_EltreumUI.skins.shadow.enable and not E.db.ElvUI_EltreumUI.borders.universalborders then
					if not E.Classic then
						if _G["SimcFrame"] and not _G["SimcFrame"].shadow then
							ElvUI_EltreumUI:CreateFastShadow(_G["SimcFrame"], E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					else
						if _G["SimcFrame"] and _G["SimcFrame"].backdrop and not _G["SimcFrame"].backdrop.shadow then
							ElvUI_EltreumUI:CreateFastShadow(_G["SimcFrame"].backdrop, E.db.ElvUI_EltreumUI.skins.shadow.length)
						end
					end
				end

				_G["SimcFrame"].isSkinned = true
			end
		end)
	end
end
S:AddCallbackForAddon('SimulationCraft', "EltruismSimulationCraft", ElvUI_EltreumUI.EltruismSimulationCraft)
