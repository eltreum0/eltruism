local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local tostring = _G.tostring

do

	--gradient bigwigs bars
	function ElvUI_EltreumUI:EltruismBigWigs()
		if E.db.ElvUI_EltreumUI.skins.bigwigs then
			local candy = _G.LibStub("LibCandyBar-3.0")
			function candy.barPrototype:SetColor(...)
				self.candyBarBar:SetStatusBarColor(...)
				local r,g,b = self.candyBarBar:GetStatusBarColor()
				if E.db.ElvUI_EltreumUI.skins.bigwigscustomcolor then
					local bigwigstype
					if E.Retail then
						bigwigstype = BigWigs3DB
					else
						bigwigstype = BigWigsClassicDB
					end
					local currentprofile = bigwigstype["profileKeys"][E.mynameRealm]
					local r1,g1,b1

					--so there is something strange going on where if not converted to string the values are not equal, guess wow drops some decimal places and rounds them differently so tostring is used to avoid that issue
					r = tostring(r)
					g = tostring(g)
					b = tostring(b)
					if currentprofile ~= "Default" then
						r1 = tostring(bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"]["BigWigs_Plugins_Colors"]["default"][1])
						g1 = tostring(bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"]["BigWigs_Plugins_Colors"]["default"][2])
						b1 = tostring(bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"]["BigWigs_Plugins_Colors"]["default"][3])
					else
						if r ~= tostring(0.25098040699959) and g ~= tostring(0.32941177487373) and b ~= tostring(0.678431391716) then
							r1 = tostring(bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"]["BigWigs_Plugins_Colors"]["default"][1])
							g1 = tostring(bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"]["BigWigs_Plugins_Colors"]["default"][2])
							b1 = tostring(bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"]["BigWigs_Plugins_Colors"]["default"][3])
						else
							r1 = tostring(0.25098040699959)
							g1 = tostring(0.32941177487373)
							b1 = tostring(0.678431391716)
						end
					end
					local r2 = tostring(bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barEmphasized"]["BigWigs_Plugins_Colors"]["default"][1])
					local g2 = tostring(bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barEmphasized"]["BigWigs_Plugins_Colors"]["default"][2])
					local b2 = tostring(bigwigstype["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barEmphasized"]["BigWigs_Plugins_Colors"]["default"][3])
					if (r == r1 and g == g1 and b == b1) then -- its normal bar
						if E.Retail or E.Wrath then
							self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalr1,g= E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalg1,b= E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalb1,a= 0.7}, {r=E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalr2,g=E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalg2,b=E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalb2,a= 0.7})
						else
							self.candyBarBar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalr1, E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalg1, E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalb1, 0.7, E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalr2, E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalg2, E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalb2, 0.7)
						end
					elseif (r == r2 and g == g2 and b == b2) then --its emphasized bar]
						if E.Retail or E.Wrath then
							self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedr1,g= E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedg1,b= E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedb1,a= 0.7}, {r=E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedr2,g=E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedg2,b=E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedb2,a= 0.7})
						else
							self.candyBarBar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedr1, E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedg2, E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedb2, 0.7, E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedr2, E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedg2, E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedb2, 0.7)
						end
					else -- its something else
						if E.Retail or E.Wrath then
							self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.4,g= g-0.4,b= b-0.4,a= 0.7}, {r=r+0.2,g=g+0.2,b=b+0.2,a= 0.7})
						else
							self.candyBarBar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.4, g-0.4, b-0.4, 0.7, r+0.2, g+0.2, b+0.2, 0.7)
						end
					end
				else
					if E.Retail or E.Wrath then
						self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.4,g= g-0.4,b= b-0.4,a= 0.7}, {r=r+0.2,g=g+0.2,b=b+0.2,a= 0.7})
					else
						self.candyBarBar:GetStatusBarTexture():SetGradientAlpha(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, r-0.4, g-0.4, b-0.4, 0.7, r+0.2, g+0.2, b+0.2, 0.7)
					end
				end

				if E.db.ElvUI_EltreumUI.skins.shadow.bigwigs then
					if not self.candyBarBar.shadow then
						self.candyBarBar:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(self.candyBarBar.shadow)
					end
					if not self.candyBarIconFrameBackdrop.shadow then
						self.candyBarIconFrameBackdrop:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(self.candyBarIconFrameBackdrop.shadow)
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
						frame:SetWidth(width-1)
						if not frame.shadow then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.shadow)
						end
					end
				end
			end)
		end
	end
	S:AddCallbackForAddon('BigWigs', "EltruismBigWigsQueue", ElvUI_EltreumUI.BigWigsQueue)

end
