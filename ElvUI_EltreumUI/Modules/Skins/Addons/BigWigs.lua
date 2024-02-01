local E = unpack(ElvUI)
local S = E:GetModule('Skins')
local _G = _G
local tostring = _G.tostring

do

	--gradient bigwigs bars
	function ElvUI_EltreumUI:EltruismBigWigs()
		if E.db.ElvUI_EltreumUI.skins.bigwigs then
			local candy = _G.LibStub("LibCandyBar-3.0")
			local currentprofile = BigWigs3DB["profileKeys"][E.mynameRealm]

			--fix db since colors are missing
			if BigWigs3DB["namespaces"] then
				if not BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"] then
					BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"] = {}
					BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"] = {}
					BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile] = {
						["barColor"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.5098039507865906, -- [1]
									0.7019608020782471, -- [2]
									1, -- [3]
								},
							},
						},
						["barEmphasized"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.7098039388656616, -- [1]
									0.03529411926865578, -- [2]
									0.03529411926865578, -- [3]
								},
							},
						},
					}
				end
				BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"] or {}
				if not BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile] then
					BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile] = {
						["barColor"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.5098039507865906, -- [1]
									0.7019608020782471, -- [2]
									1, -- [3]
								},
							},
						},
						["barEmphasized"] = {
							["BigWigs_Plugins_Colors"] = {
								["default"] = {
									0.7098039388656616, -- [1]
									0.03529411926865578, -- [2]
									0.03529411926865578, -- [3]
								},
							},
						},
					}
				end
				if not BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"] then
					BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"] = {
						["BigWigs_Plugins_Colors"] = {
							["default"] = {
								0.5098039507865906, -- [1]
								0.7019608020782471, -- [2]
								1, -- [3]
							},
						},
					}
				end
				if not BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barEmphasized"] then
					BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barEmphasized"] = {
						["BigWigs_Plugins_Colors"] = {
							["default"] = {
								0.7098039388656616, -- [1]
								0.03529411926865578, -- [2]
								0.03529411926865578, -- [3]
							},
						},
					}
				end
			end

			function candy.barPrototype:SetColor(...)
				self.candyBarBar:SetStatusBarColor(...)
				local r,g,b = self.candyBarBar:GetStatusBarColor()

				if E.db.ElvUI_EltreumUI.skins.bigwigscustomcolor then
					currentprofile = BigWigs3DB["profileKeys"][E.mynameRealm]
					r = tostring(r)
					g = tostring(g)
					b = tostring(b)

					--so there is something strange going on where if not converted to string the values are not equal, guess wow drops some decimal places and rounds them differently so tostring is used to avoid that issue
					local r1 = tostring(BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"]["BigWigs_Plugins_Colors"]["default"][1])
					local g1 = tostring(BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"]["BigWigs_Plugins_Colors"]["default"][2])
					local b1 = tostring(BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barColor"]["BigWigs_Plugins_Colors"]["default"][3])
					local r2 = tostring(BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barEmphasized"]["BigWigs_Plugins_Colors"]["default"][1])
					local g2 = tostring(BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barEmphasized"]["BigWigs_Plugins_Colors"]["default"][2])
					local b2 = tostring(BigWigs3DB["namespaces"]["BigWigs_Plugins_Colors"]["profiles"][currentprofile]["barEmphasized"]["BigWigs_Plugins_Colors"]["default"][3])

					if (r == r1 and g == g1 and b == b1) then -- its normal bar
						self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalr1,g= E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalg1,b= E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalb1,a= 0.7}, {r=E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalr2,g=E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalg2,b=E.db.ElvUI_EltreumUI.skins.bigwigscustomnormalb2,a= 0.7})
					elseif (r == r2 and g == g2 and b == b2) then --its emphasized bar
						self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedr1,g= E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedg1,b= E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedb1,a= 0.7}, {r=E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedr2,g=E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedg2,b=E.db.ElvUI_EltreumUI.skins.bigwigscustomemphasizedb2,a= 0.7})
					else -- its something else
						self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.4,g= g-0.4,b= b-0.4,a= 0.7}, {r=r+0.2,g=g+0.2,b=b+0.2,a= 0.7})
					end
				else
					self.candyBarBar:GetStatusBarTexture():SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, {r=r-0.4,g= g-0.4,b= b-0.4,a= 0.7}, {r=r+0.2,g=g+0.2,b=b+0.2,a= 0.7})
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
				if bar.iconPosition == "RIGHT" then --icon position
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

		--vertical bars attempt with icon on the bar texture, multiple bars made this not happen
		--[[
		local function styleBarVertical(bar)
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

				local width, height = bar:GetSize()
				bar:SetSize(height,width)
				bar.candyBarBar:SetSize(height,width)
				bar.candyBarBar:SetOrientation("VERTICAL")
				--bar:SetOrientation("VERTICAL")

				E:SetSmoothing(bar.candyBarBar,true)

				bar.candyBarDuration:ClearAllPoints()
				bar.candyBarDuration:SetPoint("CENTER", bar.candyBarBar:GetStatusBarTexture(), "TOP")
				--print(bar.candyBarIconFrame:GetObjectType()) -- texture

				bar.candyBarLabel:ClearAllPoints()
				bar.candyBarLabel:SetPoint("RIGHT", bar.candyBarBar, "LEFT")

				bar:SetIcon(nil)
				icon:SetTexture(tex)
				icon:Show()
				icon:SetSize(bar:GetWidth()*1.5, bar:GetWidth()*1.5) --icon size
				bar:Set("bigwigs:restoreicon", tex)



				--set icon to the statusbar
				icon:ClearAllPoints()
				icon:SetPoint("CENTER", bar.candyBarBar:GetStatusBarTexture(), "TOP")
				--icon:SetDrawLayer('HIGHLIGHT',1)
				--bar:SetFrameStrata("BACKGROUND")

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
		]]

		_G.BigWigsAPI:RegisterBarStyle("Eltruism", {
			apiVersion = 1,
			version = 10,
			barSpacing = E.PixelMode and 20 or 15, --bar space
			barHeight = 15, --bar height
			ApplyStyle = styleBar,
			BarStopped = removeStyle,
			GetStyleName = function() return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:14:14:0:0|t |cff82B4ffEltruism|r" end,
		})

		local function styleBar2(bar)
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
				if bar.iconPosition == "RIGHT" then --icon position
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

			--bw offsets fonts down, use font height to offset it back up
			local _, fontHeightLabel = bar.candyBarLabel:GetFont()
			local _, fontHeightDuration = bar.candyBarDuration:GetFont()

			bar.candyBarLabel:ClearAllPoints()
			bar.candyBarLabel:SetPoint("TOPLEFT", bar.candyBarBar, "TOPLEFT", 0, 2+fontHeightLabel)

			bar.candyBarDuration:ClearAllPoints()
			bar.candyBarDuration:SetPoint("TOPRIGHT", bar.candyBarBar, "TOPRIGHT", 0, 2+fontHeightDuration)

			bd:Show()
		end

		_G.BigWigsAPI:RegisterBarStyle("Eltruism Top Text", {
			apiVersion = 1,
			version = 10,
			barSpacing = E.PixelMode and 20 or 15, --bar space
			barHeight = 15, --bar height
			ApplyStyle = styleBar2,
			BarStopped = removeStyle,
			GetStyleName = function() return "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo.tga:14:14:0:0|t |cff82B4ffEltruism Top Text|r" end,
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
					frame.text:SetFont(E.LSM:Fetch("font", E.db.general.font), E.db.general.fontSize, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
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

	function ElvUI_EltreumUI:ElWigo()
		if E.db.ElvUI_EltreumUI.skins.bigwigs then
			local ElWigoAddon = E.Libs.AceAddon:GetAddon("ElWigo")
			hooksecurefunc(ElWigoAddon,"spawnIcon", function()
				for i = 1, 4 do
					local elwigobars = {_G["ElWigoBar"..i]}
					for _, frame in pairs(elwigobars) do
						if frame then

							if not frame.EltruismSkin then
								S:HandleFrame(frame)
								if E.db.ElvUI_EltreumUI.skins.shadow.bigwigs then
									if not frame.shadow then
										frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
										ElvUI_EltreumUI:ShadowColor(frame.shadow)
									end
								end
								frame.EltruismSkin = true
							end

							if frame.frames and #frame.frames ~= 0 then
								for framenumber = 1, #frame.frames do
									local iconparent = frame.frames[framenumber]
									if iconparent then
										--iconparent:SetTemplate()
										iconparent:CreateBackdrop()
										if iconparent.icon then --crop icon
											iconparent.icon:SetTexCoord(0.08,0.92,0.08,0.92)
										end
										if E.db.ElvUI_EltreumUI.skins.shadow.bigwigs then
											if not iconparent.shadow then
												iconparent:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
												ElvUI_EltreumUI:ShadowColor(iconparent.shadow)
											end
										end
									end
								end
							end
						end
					end
				end
			end)
		end
	end
	S:AddCallbackForAddon('elWigo', "EltruismElWigo", ElvUI_EltreumUI.ElWigo)

end
