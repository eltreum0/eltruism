local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local EnumerateFrames = _G.EnumerateFrames
local valuecolors = E:ClassColor(E.myclass, true)

--based on elvui toolkit
function ElvUI_EltreumUI:SetTemplateSkin()
	if E.db.ElvUI_EltreumUI.skins.elvui.SetTemplate then
		local frame = CreateFrame("Frame")
		local frametypes = {
			["Region"] = true,
			["Texture"] = true,
			["Cooldown"] = true,
			["Slider"] = true,
			["ScrollFrame"] = true,
			["ModelScene"] = true,
		}
		local function SkinFrame(frame)
			if frame:GetObjectType() == "Texture" then frame = frame:GetParent() end
			local mt = getmetatable(frame).__index
			if mt.SetTemplate then
				hooksecurefunc(mt, "SetTemplate", function(frame, template, _, _, _, isUnitFrameElement, isNamePlateElement)
					if isUnitFrameElement and not E.db.ElvUI_EltreumUI.skins.elvui.unitframes then return end
					if isNamePlateElement and not E.db.ElvUI_EltreumUI.skins.elvui.nameplates then return end
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
							if frame:GetParent() and frame:GetParent():GetObjectType() == "Button" and frame:GetParent().icon then --fix for buttons since the texture could overlap over the icon
								frame.eltruismbgtexture:SetDrawLayer("BACKGROUND")
							end
							if frame:GetParent() and frame:GetParent().TransmogStateTexture then --transmog stuff
								frame.eltruismbgtexture:SetVertexColor(1,0,0,0)
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
					else
						if frame.eltruismbgtexture then
							frame.eltruismbgtexture:Hide()
						end
					end
				end)
			end
		end
		SkinFrame(frame)
		frame = EnumerateFrames()
		while frame do
			if (not frame:IsForbidden()) and not frametypes[frame:GetObjectType()] then
				SkinFrame(frame)
				frametypes[frame:GetObjectType()] = true
			end
			frame = EnumerateFrames(frame)
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
