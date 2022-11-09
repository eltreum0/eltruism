local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local S = E:GetModule('Skins')
local _G = _G
local EnhancedShadows = nil
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

--gradient bigwigs bars
function ElvUI_EltreumUI:EltruismBigWigs()
	if E.db.ElvUI_EltreumUI.skins.bigwigs then
		local candy = _G.LibStub("LibCandyBar-3.0")
		function candy.barPrototype:SetColor(...)
			self.candyBarBar:SetStatusBarColor(...)
			local r,g,b = self.candyBarBar:GetStatusBarColor()
			if E.Retail then
				self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r-0.4, g-0.4, b-0.4, 0.7}, {r, g, b, 0.7})
			else
				self.candyBarBar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.4, g-0.4, b-0.4, 0.7, r, g, b, 0.7)
			end
			if E.db.ElvUI_EltreumUI.skins.shadow.bigwigs then
				if not self.candyBarBar.shadow then
					self.candyBarBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(self.candyBarBar.shadow) end
				end
				if not self.candyBarIconFrameBackdrop.shadow then
					self.candyBarIconFrameBackdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
					if EnhancedShadows then EnhancedShadows:RegisterShadow(self.candyBarIconFrameBackdrop.shadow) end
				end
			end
		end
	end
end
S:AddCallbackForAddon('BigWigs_Plugins', "EltruismBigWigs", ElvUI_EltreumUI.EltruismBigWigs)
--S:AddCallbackForAddon('Capping', "EltruismBigWigs", ElvUI_EltreumUI.EltruismBigWigs)
