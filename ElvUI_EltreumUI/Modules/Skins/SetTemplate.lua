local E = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local EnumerateFrames = _G.EnumerateFrames
local valuecolors = E:ClassColor(E.myclass, true)

--based on elvui toolkit
function ElvUI_EltreumUI:SetTemplateSkin()
	if E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate then
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
			if object:GetObjectType() == "Texture" then object = object:GetParent() end
			local mt = getmetatable(object).__index
			if type(mt) == 'function' then return end
			if mt.SetTemplate then
				hooksecurefunc(mt, "SetTemplate", function(frame, template, _, _, _, isUnitFrameElement, isNamePlateElement)
					if isUnitFrameElement and not E.db.ElvUI_EltreumUI.skins.elvui.unitframes then return end
					if isNamePlateElement and not E.db.ElvUI_EltreumUI.skins.elvui.nameplates then return end
					if frame:GetObjectType() == "Button" and not E.db.ElvUI_EltreumUI.skins.elvui.button then return end
					if frame:GetParent() and frame:GetParent():GetObjectType() == "Button" and not E.db.ElvUI_EltreumUI.skins.elvui.button then return end

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
							frame:SetBackdrop({
								edgeFile = "Interface\\Addons\\ElvUI_EltreumUI\\Media\\border\\Eltreum-Border-1.tga",
								bgFile = glossTex and (type(glossTex) == 'string' and glossTex or E.media.glossTex) or E.media.blankTex,
								edgeSize = 3,
							})
							--frame.backdrop:SetOutside()
							if frame.callbackBackdropColor then
								frame:callbackBackdropColor()
							else
								frame:SetBackdropColor(0, 0, 0, frame.customBackdropAlpha or (template == 'Transparent' and 1) or 1)
							end
							local borderr, borderg, borderb, bordera = 0,0,0,1
							if frame.forcedBorderColors then
								borderr, borderg, borderb, bordera = unpack(frame.forcedBorderColors)
							end

							frame:SetBackdropBorderColor(borderr, borderg, borderb, bordera)
						]]

						--[[
							frame.testmask = frame:CreateMaskTexture()
							frame.testmask:SetAllPoints(frame)
							frame.testmask:SetTexture("Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\circle_mask.TGA", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
							frame:AddMaskTexture(frame.testmask) --errors because frame doesnt have method, needs texture...
						]]

						--[[
							if not frame.shadow then
								frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
								ElvUI_EltreumUI:ShadowColor(frame.shadow)
							end
						]]
						--[[
							if not frame.eltruismbordertest then
								local classcolor = E:ClassColor(E.myclass, true)
								local offset = (E.PixelMode and 13) or 14
								frame.eltruismbordertest = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
								frame.eltruismbordertest:SetPoint("CENTER", frame, "CENTER", 0, 0)
								frame.eltruismbordertest:SetBackdrop({
									edgeFile = E.LSM:Fetch("border", E.db.ElvUI_EltreumUI.borders.texture),
									edgeSize = offset,
								})
								frame.eltruismbordertest:SetBackdropBorderColor(classcolor.r, classcolor.g, classcolor.b, 1)
								--frame.eltruismbordertest:SetFrameLevel(1)
								frame.eltruismbordertest:SetFrameStrata(frame:GetFrameStrata())
								frame.eltruismbordertest:SetOutside(frame, offset-1.5, offset-1.5, nil, true)
							else
								frame.eltruismbordertest:Show()
							end
						]]
					else
						if frame.eltruismbgtexture then
							frame.eltruismbgtexture:Hide()
						end
						--[[if frame.eltruismbordertest then
							frame.eltruismbordertest:Hide()
						end]]
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

							if frame.Name and frame.Name.SetText then
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
										frame:GetParent():GetParent().Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
									end

									-- hook for when label gets added
									if not frame:GetParent():GetParent().EltruismLabelHook then
										frame:GetParent():GetParent():HookScript("OnShow", function(widget)
											if widget.Label then
												local _,size = widget.Label:GetFont()
												widget.Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
											end
											if widget.Bar then
												widget.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
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
										frame:GetParent().Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
									end

									-- hook for when label gets added
									if not frame:GetParent().EltruismLabelHook then
										frame:GetParent():HookScript("OnShow", function(widget)
											if widget.Label then
												local _,size = widget.Label:GetFont()
												widget.Label:SetFont(E.LSM:Fetch("font", E.db.general.font), size, ElvUI_EltreumUI:FontFlag(E.db.general.fontStyle))
											end
											if widget.Bar then
												widget.Bar:SetStatusBarTexture(E.LSM:Fetch("statusbar", "ElvUI Norm1"))
											end
										end)
										frame:GetParent():GetParent().EltruismLabelHook = true
									end
								end
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
			end
		end
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
