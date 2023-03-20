local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local EnhancedShadows = nil
local IsAddOnLoaded = _G.IsAddOnLoaded
if IsAddOnLoaded("ProjectAzilroka") then
	EnhancedShadows = _G.ProjectAzilroka:GetModule('EnhancedShadows')
end

do

	--gradient bigwigs bars
	function ElvUI_EltreumUI:EltruismBigWigs()
		if E.db.ElvUI_EltreumUI.skins.bigwigs then
			local candy = _G.LibStub("LibCandyBar-3.0")
			function candy.barPrototype:SetColor(...)
				self.candyBarBar:SetStatusBarColor(...)
				local r,g,b = self.candyBarBar:GetStatusBarColor()
				if E.Retail or E.Wrath then
					self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.4,g= g-0.4,b= b-0.4,a= 0.7}, {r=r+0.2,g=g+0.2,b=b+0.2,a= 0.7})
				else
					self.candyBarBar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.4, g-0.4, b-0.4, 0.7, r+0.2, g+0.2, b+0.2, 0.7)
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

	--from BigWigs's bars file, modified ElvUI Skin
	function ElvUI_EltreumUI:BigWigsStyle()
		local backdropBorder = {
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			tile = false,
			tileSize = 0,
			edgeSize = 1,
			insets = {left = 0, right = 0, top = 0, bottom = 0}
		}

		local function removeStyle(bar)
			local bd = bar.candyBarBackdrop
			bd:Hide()
			if bd.iborder then
				bd.iborder:Hide()
				bd.oborder:Hide()
			end

			local tex = bar:Get("bigwigs:restoreicon")
			if tex then
				bar:SetIcon(tex)
				bar:Set("bigwigs:restoreicon", nil)

				local iconBd = bar.candyBarIconFrameBackdrop
				iconBd:Hide()
				if iconBd.iborder then
					iconBd.iborder:Hide()
					iconBd.oborder:Hide()
				end
			end
		end

		local function styleBar(bar)
			local bd = bar.candyBarBackdrop

			bd:SetTemplate("Transparent")
			bd:SetOutside(bar)
			if not E.PixelMode and bd.iborder then
				bd.iborder:Show()
				bd.oborder:Show()
			end

			local tex = bar:GetIcon()
			if tex then
				local icon = bar.candyBarIconFrame
				bar:SetIcon(nil)
				icon:SetTexture(tex)
				icon:Show()
				if bar.iconPosition == "RIGHT" then  --icon position
					icon:SetPoint("BOTTOMLEFT", bar, "BOTTOMRIGHT", E.PixelMode and 1 or 5, 0)
				else
					icon:SetPoint("BOTTOMRIGHT", bar, "BOTTOMLEFT", E.PixelMode and -5 or -10, 0)
				end
				icon:SetSize(bar:GetHeight()*1.5, bar:GetHeight()*1.5) --icon size
				bar:Set("bigwigs:restoreicon", tex)

				local iconBd = bar.candyBarIconFrameBackdrop

				iconBd:SetTemplate("Transparent")
				iconBd:SetOutside(bar.candyBarIconFrame)
				if not E.PixelMode and iconBd.iborder then
					iconBd.iborder:Show()
					iconBd.oborder:Show()
				end
				iconBd:Show()
			end

			bd:Show()
		end

		_G.BigWigsAPI:RegisterBarStyle("Eltruism", {
			apiVersion = 1,
			version = 10,
			barSpacing = E.PixelMode and 20 or 15, --bar space
			barHeight = 15,  --bar height
			ApplyStyle = styleBar,
			BarStopped = removeStyle,
			GetStyleName = function() return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:14:14:0:0|t |cff82B4ffEltruism|r" end,
		})
	end
	S:AddCallbackForAddon('BigWigs_Plugins', "EltruismBigWigsStyle", ElvUI_EltreumUI.BigWigsStyle)

	--so queue timer doesnt use candybar...
	--from bigwigs core.lua line 90, seems like bigwigs exposes frames being created
	--then on line 1259 of loader.lua
	--public:SendMessage("BigWigs_FrameCreated", timerBar, "QueueTimer")
	function ElvUI_EltreumUI:BigWigsQueue()
		if E.db.ElvUI_EltreumUI.skins.bigwigs then
			_G.BigWigsLoader.RegisterMessage("Eltruism","BigWigs_FrameCreated", function(_, frame, bar)
				if bar == "QueueTimer" then
					S:HandleStatusBar(frame)
					local width = _G.LFGDungeonReadyPopup:GetWidth()
					frame:SetWidth(width)
					frame:SetHeight(18)
					if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor then
						frame:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, false))
					else
						frame:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, false, false))
					end
					frame.text:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, E.db.general.fontStyle)
					if E.db.ElvUI_EltreumUI.skins.shadow.bigwigs then
						frame:SetWidth(width-2)
						if not frame.shadow then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							if EnhancedShadows then EnhancedShadows:RegisterShadow(frame.shadow) end
						end
					end
				end
			end)
		end
	end
	S:AddCallbackForAddon('BigWigs', "EltruismBigWigsQueue", ElvUI_EltreumUI.BigWigsQueue)

end
