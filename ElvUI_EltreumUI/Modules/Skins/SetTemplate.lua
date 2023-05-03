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
									frame.eltruismbgtexture:Hide()
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
						--[[if not frame.shadow then
							frame:CreateShadow(E.db.ElvUI_EltreumUI.skins.shadow.length)
							ElvUI_EltreumUI:ShadowColor(frame.shadow)
						end]]
						--[[if not frame.eltruismbordertest then
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
						end]]
					else
						if frame.eltruismbgtexture then
							frame.eltruismbgtexture:Hide()
						end
						--[[if frame.eltruismbordertest then
							frame.eltruismbordertest:Hide()
						end]]
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
