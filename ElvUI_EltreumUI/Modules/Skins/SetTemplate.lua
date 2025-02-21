local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local EnumerateFrames = _G.EnumerateFrames
local getmetatable = _G.getmetatable
local type = _G.type
local BackdropTemplateMixin = _G.BackdropTemplateMixin
local valuecolors = E:ClassColor(E.myclass, true)
local atlas
local S = E:GetModule('Skins')
local GetItemQualityColor = _G.C_Item and _G.C_Item.GetItemQualityColor or _G.GetItemQualityColor

local widgetAtlas = {
	["widgetstatusbar-fill-blue"] = { r = 0, g = 0, b = 255, a = 1},
	["widgetstatusbar-fill-green"] = { r = 0, g = 255, b = 0, a = 1},
	["widgetstatusbar-fill-red"] = { r = 255, g = 0, b = 0, a = 1},
	["widgetstatusbar-fill-white"] = { r = 255, g = 255, b = 255, a = 1},
	["widgetstatusbar-fill-yellow"] = { r = 255, g = 255, b = 0, a = 1},
}

local function togglebackdrop(frame,show)
	if show then
		frame.TopLeftCorner:Show()
		frame.TopRightCorner:Show()
		frame.BottomLeftCorner:Show()
		frame.BottomRightCorner:Show()

		frame.LeftEdge:Show()
		frame.RightEdge:Show()
		frame.BottomEdge:Show()
		frame.TopEdge:Show()
	else
		frame.TopLeftCorner:Hide()
		frame.TopRightCorner:Hide()
		frame.BottomLeftCorner:Hide()
		frame.BottomRightCorner:Hide()

		frame.LeftEdge:Hide()
		frame.RightEdge:Hide()
		frame.BottomEdge:Hide()
		frame.TopEdge:Hide()
	end
end

--based on elvui toolkit
local loopframe = CreateFrame("Frame")
local frametypes = {
	["Region"] = true,
	["Texture"] = true,
	["Cooldown"] = true,
	["Slider"] = true,
	["ScrollFrame"] = true,
	["ModelScene"] = true,
}

local function SkinFrame(object)
	if not object then return end --rare but not impossible nil error
	if object:GetObjectType() == "Texture" then object = object:GetParent() end
	local mt = getmetatable(object).__index
	if type(mt) == 'function' then return end
	if mt.SetTemplate and not mt.SetTemplateEltruismHook then
		hooksecurefunc(mt, "SetTemplate", function(frame, template, _, _, _, isUnitFrameElement, isNamePlateElement)

			if isUnitFrameElement and not E.db.ElvUI_EltreumUI.skins.elvui.unitframes then return end
			if isNamePlateElement and not E.db.ElvUI_EltreumUI.skins.elvui.nameplates then return end
			if frame:GetObjectType() == "Button" and not E.db.ElvUI_EltreumUI.skins.elvui.button then return end
			if frame:GetParent() and frame:GetParent():GetObjectType() == "Button" and not E.db.ElvUI_EltreumUI.skins.elvui.button then return end
			if frame:GetObjectType() == "CheckButton" and frame.mask then return end --actionbar masks fix
			if frame.bgrElvUISkin then return end --baganator elvui skin

			--if frame.showDispellableDebuff then return end --fix RaidDebufs
			if template ~= "NoBackdrop" then
				if not frame.EltruismBackground then
					frame.eltruismbgtexture = frame:CreateTexture(nil, "BORDER")
					frame.eltruismbgtexture:SetParent(frame)
					frame.eltruismbgtexture:ClearAllPoints()
					frame.eltruismbgtexture:SetPoint("TOPLEFT", 1, -1)
					frame.eltruismbgtexture:SetPoint("BOTTOMRIGHT", -1, 1)
					frame.eltruismbgtexture:SetTexture(E.LSM:Fetch("background", E.db.ElvUI_EltreumUI.skins.elvui.texture), true, true)
					frame.eltruismbgtexture:SetHorizTile(true)
					frame.eltruismbgtexture:SetVertTile(true)
					frame.eltruismbgtexture:SetBlendMode("ADD")
					if (frame:GetObjectType() == "Button" or frame:GetObjectType() == "CheckButton") and frame.icon then --fix for buttons since the texture could overlap over the icon
						frame.eltruismbgtexture:SetDrawLayer("BACKGROUND")
					end
					if frame:GetParent() then
						if frame:GetParent():GetObjectType() == "Button" and frame:GetParent().icon and not isUnitFrameElement then --fix for buttons since the texture could overlap over the icon
							frame.eltruismbgtexture:SetDrawLayer("BACKGROUND")
						end
						if frame:GetParent().TransmogStateTexture then --transmog stuff
							frame.eltruismbgtexture:SetTexture("")
						end
						if frame:GetParent().TransmogSelectedAnim then --transmog stuff
							frame.eltruismbgtexture:SetTexture("")
						end
					end
					if (frame.SelectedTexture or frame.glossTex) and not E.db.ElvUI_EltreumUI.skins.elvui.button then --fix some more buttons
						frame.eltruismbgtexture:Hide()
					end
					if isUnitFrameElement and (frame:GetParent() and frame:GetParent().isTransparent == false) then --only on health
						frame.eltruismbgtexture:SetDrawLayer("ARTWORK")
						frame.eltruismbgtexture:SetParent(frame:GetParent())
					end
					if E.db.ElvUI_EltreumUI.skins.elvui.color.classcolor then
						frame.eltruismbgtexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,0.15)
					else
						frame.eltruismbgtexture:SetVertexColor(E.db.ElvUI_EltreumUI.skins.elvui.color.r,E.db.ElvUI_EltreumUI.skins.elvui.color.g,E.db.ElvUI_EltreumUI.skins.elvui.color.b,E.db.ElvUI_EltreumUI.skins.elvui.color.a)
					end

					frame.EltruismBackground = true
				else
					if frame.eltruismbgtexture then
						frame.eltruismbgtexture:Show()
					end
				end


				--[[
					if not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				]]

				if E.db.ElvUI_EltreumUI.borders.bordertest and not frame.eltruismbordertest then
					local classcolor
					if E.db.ElvUI_EltreumUI.borders.classcolor then
						classcolor = E:ClassColor(E.myclass, true)
					elseif not E.db.ElvUI_EltreumUI.borders.classcolor then
						classcolor = {
							r = E.db.ElvUI_EltreumUI.borders.bordercolors.r,
							g = E.db.ElvUI_EltreumUI.borders.bordercolors.g,
							b = E.db.ElvUI_EltreumUI.borders.bordercolors.b
						}
					end


					--local offset = (E.PixelMode and 13) or 14
					local size = 11
					local offset = (E.PixelMode and size) or (size + 1)
					frame.eltruismbordertest = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
					frame.eltruismbordertest:SetPoint("CENTER", frame, "CENTER", 0, 0)
					frame.eltruismbordertest:SetBackdrop({
						edgeFile = E.LSM:Fetch("border", "Eltreum-Border-1"),
						edgeSize = offset,
					})
					frame.eltruismbordertest:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
					frame.eltruismbordertest:SetFrameLevel(frame:GetFrameLevel()+1)
					frame.eltruismbordertest:SetFrameStrata(frame:GetFrameStrata())
					--SetOutside(obj, anchor, xOffset, yOffset, anchor2, noScale)
					frame.eltruismbordertest:SetOutside(frame, offset-2, offset-2)
					if frame.IconBorder then --items are different
						local itemoffset = 20
						local itemoutside = 14
						frame.eltruismbordertest:SetBackdrop({
							edgeFile = E.LSM:Fetch("border", "Eltreum-Border-1"),
							edgeSize = itemoffset,
						})
						frame.eltruismbordertest:SetOutside(frame, itemoutside, itemoutside)
						if frame.rarity then
							local r,g,b = GetItemQualityColor(frame.rarity)
							frame.eltruismbordertest:SetBackdropBorderColor(r, g, b, 1)
							frame.eltruismbordertest:Show()
							togglebackdrop(frame,false)
						else
							frame.eltruismbordertest:Hide()
							togglebackdrop(frame,true)
						end
						hooksecurefunc(frame, "SetBackdropBorderColor", function(frametable)
							frametable.eltruismbordertest:SetBackdrop({
								edgeFile = E.LSM:Fetch("border", "Eltreum-Border-1"),
								edgeSize = itemoffset,
							})
							frametable.eltruismbordertest:SetOutside(frametable, itemoutside, itemoutside)
							if frametable.rarity then
								local r,g,b = GetItemQualityColor(frametable.rarity)
								frametable.eltruismbordertest:SetBackdropBorderColor(r, g, b, 1)
								frametable.eltruismbordertest:Show()
								togglebackdrop(frame,false)
							else
								frame.eltruismbordertest:Hide()
								togglebackdrop(frame,true)
							end
						end)
						if frame.shadow then frame.shadow:Hide() end
					end
				end
			else
				if frame.eltruismbgtexture then
					frame.eltruismbgtexture:Hide()
				end
			end

			--skin here because it needs to enumerate frames
			if E.db.ElvUI_EltreumUI.skins.ace3.enable then
				E:Delay(0,function()
					if frame:GetParent() then
						if frame:GetParent().obj then
							if frame:GetParent().obj.SetValue then
								if not frame:GetParent().obj.EltruismHookLabel then
									hooksecurefunc(frame:GetParent().obj,"SetValue", function(frametext)
										E:Delay(0, function()
											if frametext.label then
												if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
													frametext.label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
												else
													frametext.label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
												end
											end
											if frametext.titletext then
												if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
													frametext.titletext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
												else
													frametext.titletext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
												end
											end
										end)
									end)
									frame:GetParent().obj.EltruismHookLabel = true
								end
							end
							if frame:GetParent().obj.SetText then
								if not frame:GetParent().obj.EltruismHookSetText then
									hooksecurefunc(frame:GetParent().obj,"SetText", function(frametext)
										E:Delay(0, function()
											if frametext.label then
												if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
													frametext.label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
												else
													frametext.label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
												end
											end
											if frametext.titletext then
												if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
													frametext.titletext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
												else
													frametext.titletext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
												end
											end
										end)
									end)
									frame:GetParent().obj.EltruismHookSetText = true
								end
							end
							if frame:GetParent().obj.label and frame:GetParent().obj.label.SetTextColor then
								if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
									frame:GetParent().obj.label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
								else
									frame:GetParent().obj.label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
								end
							end
							if frame:GetParent().obj.titletext and frame:GetParent().obj.titletext.SetTextColor then
								if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
									frame:GetParent().obj.titletext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
								else
									frame:GetParent().obj.titletext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
								end
							end
						end
						if frame:GetParent().label then
							if frame:GetParent().label.SetText then
								if not frame:GetParent().EltruismHookSetTextLabel then
									hooksecurefunc(frame:GetParent().label,"SetText", function(frametext)
										E:Delay(0, function()
											if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
												frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
											else
												frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
											end
										end)
									end)
									frame:GetParent().EltruismHookSetTextLabel = true
								end
								if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
									frame:GetParent().label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
								else
									frame:GetParent().label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
								end
							end
						end
						if frame:GetParent().titletext then
							if frame:GetParent().titletext.SetText then
								if not frame:GetParent().EltruismHookSetTextTitleText then
									hooksecurefunc(frame:GetParent().titletext,"SetText", function(frametext)
										E:Delay(0, function()
											if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
												frametext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
											else
												frametext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
											end
										end)
									end)
									frame:GetParent().EltruismHookSetTextTitleText = true
								end
								if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
									frame:GetParent().titletext:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
								else
									frame:GetParent().titletext:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
								end
							end
						end
						if frame:GetParent().Label then
							if frame:GetParent().Label.SetText then
								if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
									frame:GetParent().Label:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
								else
									frame:GetParent().Label:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
								end
							end
						end
					end

					if frame.name and frame.name.SetText then
						if frame.objectType and frame.objectType == "item" then
							return
						end
						if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
							frame.name:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
						else
							frame.name:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
						end
					end

					if frame.TitleText and frame.TitleText.SetText then
						if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
							frame.TitleText:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
						else
							frame.TitleText:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
						end
					end

					if frame.TitleContainer and frame.TitleContainer.TitleText and frame.TitleContainer.TitleText.SetText then
						if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
							frame.TitleContainer.TitleText:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
						else
							frame.TitleContainer.TitleText:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
						end
					end

					if frame.Name and frame.Name.SetText and not frame.HotKey then
						if frame.objectType and frame.objectType == "item" then
							return
						end
						if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
							frame.Name:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
						else
							frame.Name:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
						end
					end

					if frame.Header and frame.Header.Text and frame.Header.Text.SetText then
						if not E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.classcolor then
							frame.Header.Text:SetTextColor(E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.r, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.g, E.db.ElvUI_EltreumUI.skins.ace3.tab.TextEnabled.b)
						else
							frame.Header.Text:SetTextColor(valuecolors.r, valuecolors.g, valuecolors.b)
						end
					end
				end)
			end

			if E.db.ElvUI_EltreumUI.skins.shadow.enable then
				--saved instances shadow
				if frame:GetParent() and frame:GetParent().key and frame:GetParent().key == "SavedInstancesTooltip" then
					if not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end

				--possible widget shadows
				if frame:GetParent() and frame:GetParent():GetParent() then
					if frame:GetParent():GetParent().widgetContainer then
						if not frame.shadow then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.shadow)

							--font/texture
							if frame:GetParent():GetParent().Label then
								local _,size = frame:GetParent():GetParent().Label:GetFont()
								frame:GetParent():GetParent().Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							end
							if frame:GetParent():GetParent().Bar then
								atlas = frame:GetParent():GetParent().Bar:GetStatusBarTexture():GetAtlas()
								frame:GetParent():GetParent().Bar.EltruismAtlas = atlas
								frame:GetParent():GetParent().Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
								frame:GetParent():GetParent().Bar:SetStatusBarColor(widgetAtlas[atlas].r,widgetAtlas[atlas].g,widgetAtlas[atlas].b,widgetAtlas[atlas].a)
								if not frame:GetParent():GetParent().Bar.EltruismColorHook and frame:GetParent():GetParent().Bar.DisplayBarValue then
									hooksecurefunc(frame:GetParent():GetParent().Bar, "DisplayBarValue", function(widget)
										local _, maxValue = widget:GetMinMaxValues()
										S:StatusBarColorGradient(widget, widget:GetValue(), maxValue)
										widget.backdrop:SetAlpha(E.db.general.backdropfadecolor.a)
										widget.backdrop:SetBackdropColor(0,0,0)
										widget:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))

										--[[if not atlas then
											atlas = widget:GetStatusBarTexture():GetAtlas()
										end
										if not atlas then
											atlas = widget.EltruismAtlas
										end]]
										--widget:SetStatusBarColor(widgetAtlas[atlas].r,widgetAtlas[atlas].g,widgetAtlas[atlas].b,widgetAtlas[atlas].a)
									end)
									frame:GetParent():GetParent().Bar.EltruismColorHook = true

								end
							end

							-- hook for when label gets added
							if not frame:GetParent():GetParent().EltruismLabelHook then
								frame:GetParent():GetParent():HookScript("OnShow", function(widget)
									if widget.Label then
										local _,size = widget.Label:GetFont()
										widget.Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									end
									if widget.Bar then
										atlas = widget.Bar:GetStatusBarTexture():GetAtlas()
										if atlas then
											widget.Bar:GetStatusBarTexture():SetColorTexture(widgetAtlas[atlas].r,widgetAtlas[atlas].g,widgetAtlas[atlas].b,widgetAtlas[atlas].a)
											widget.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
										end
									end
								end)
								frame:GetParent():GetParent().EltruismLabelHook = true
							end

							--same as above, but for when its the first parent
							if frame:GetParent().Label then
								local _,size = frame:GetParent().Label:GetFont()
								frame:GetParent().Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
							end
							if frame:GetParent().Bar then
								atlas = frame:GetParent().Bar:GetStatusBarTexture():GetAtlas()
								if atlas then
									frame:GetParent().Bar:GetStatusBarTexture():SetColorTexture(widgetAtlas[atlas].r,widgetAtlas[atlas].g,widgetAtlas[atlas].b,widgetAtlas[atlas].a)
									frame:GetParent().Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
								end
							end

							-- hook for when label gets added
							if not frame:GetParent().EltruismLabelHook then
								frame:GetParent():HookScript("OnShow", function(widget)
									if widget.Label then
										local _,size = widget.Label:GetFont()
										widget.Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
									end
									if widget.Bar then
										atlas = widget.Bar:GetStatusBarTexture():GetAtlas()
										if atlas then
											widget.Bar:GetStatusBarTexture():SetColorTexture(widgetAtlas[atlas].r,widgetAtlas[atlas].g,widgetAtlas[atlas].b,widgetAtlas[atlas].a)
											widget.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
										end
									end
								end)
								frame:GetParent():GetParent().EltruismLabelHook = true
							end
						end
					end
				end

				--new dropdowns?
				if frame:GetParent() and frame:GetParent().InitScrollLayout then
					if not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end

				--petbattle
				if frame:GetParent() and frame:GetParent().PetType then
					if not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end
				if frame:GetParent() and frame:GetParent() == _G["ElvUIPetBattleActionBar"] then
					if not frame.shadow then
						frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
						ElvUI_EltreumUI:ShadowColor(frame.shadow)
					end
				end
			end

			if not E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate then
				if frame.eltruismbgtexture then
					frame.eltruismbgtexture:Hide()
				end
			else
				if frame.eltruismbgtexture then
					frame.eltruismbgtexture:Show()
				end
			end

			if frame == _G.QuestInfoItemHighlight then --fix the highlight
				frame:SetBackdropBorderColor(1, 1, 0)
				frame:SetBackdropColor(0, 0, 0, 0)
			end
		end)
		mt.SetTemplateEltruismHook = true
	end
end

function ElvUI_EltreumUI:SetTemplateSkin()
	if E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate then
		SkinFrame(loopframe)
		loopframe = EnumerateFrames()
		while loopframe do
			if (not loopframe:IsForbidden()) and not frametypes[loopframe:GetObjectType()] then
				SkinFrame(loopframe)
				frametypes[loopframe:GetObjectType()] = true
			end
			loopframe = EnumerateFrames(loopframe)
		end
		E:StaggeredUpdateAll()
		E:Delay(10, function()
			if E.db.ElvUI_EltreumUI.chat.chattoggles then
				_G.LeftChatToggleButton:SetAlpha(1)
				_G.LeftChatToggleButton:Show()
				_G.RightChatToggleButton:SetAlpha(1)
				_G.RightChatToggleButton:Show()
			end
		end)
	end
end
