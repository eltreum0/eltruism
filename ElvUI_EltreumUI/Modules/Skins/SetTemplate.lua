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
					if template ~= "NoBackdrop" and not frame.EltruismBackground then
						local bgtexture = frame:CreateTexture(nil, "BORDER")
						bgtexture:SetParent(frame)
						bgtexture:ClearAllPoints()
						bgtexture:SetPoint("TOPLEFT", 1, -1)
						bgtexture:SetPoint("BOTTOMRIGHT", -1, 1)
						bgtexture:SetTexture(E.LSM:Fetch("background", E.db.ElvUI_EltreumUI.skins.elvui.texture), true, true)
						bgtexture:SetHorizTile(true)
						bgtexture:SetVertTile(true)
						bgtexture:SetBlendMode("ADD")
						frame.EltruismBackground = true
						if E.db.ElvUI_EltreumUI.skins.elvui.color.classcolor then
							bgtexture:SetVertexColor(valuecolors.r,valuecolors.g,valuecolors.b,1)
						else
							bgtexture:SetVertexColor(E.db.ElvUI_EltreumUI.skins.elvui.color.r,E.db.ElvUI_EltreumUI.skins.elvui.color.g,E.db.ElvUI_EltreumUI.skins.elvui.color.b,E.db.ElvUI_EltreumUI.skins.elvui.color.a)
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
