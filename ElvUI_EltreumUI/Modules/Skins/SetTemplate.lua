local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local EnumerateFrames = _G.EnumerateFrames

--based on elvui toolkit
function ElvUI_EltreumUI:SetTemplateSkin()
	local frame = CreateFrame("Frame")
	local frametypes = {
		["Region"] = true,
		["Texture"] = true,
		["Cooldown"] = true,
		["Slider"] = true,
		["ScrollFrame"] = true,
		["ModelScene"] = true,
	}
	local function test(frame)
		if frame:GetObjectType() == "Texture" then frame = frame:GetParent() end
		local mt = getmetatable(frame).__index
		hooksecurefunc(mt, "SetTemplate", function(frame, template, glossTex, ignoreUpdates, forcePixelMode, isUnitFrameElement, isNamePlateElement, noScale)
			--if isUnitFrameElement then return end
			--if isNamePlateElement then return end
			if template ~= "NoBackdrop" and not frame.EltruismBackground then
				local skin = frame:CreateTexture(nil, "BORDER")
				skin:SetParent(frame)
				skin:ClearAllPoints()
				skin:SetPoint("TOPLEFT", 1, -1)
				skin:SetPoint("BOTTOMRIGHT", -1, 1)
				skin:SetTexture([[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\framebg1]], true, true) --custom texture? although getting even one to work was hard
				skin:SetHorizTile(true)
				skin:SetVertTile(true)
				skin:SetBlendMode("ADD")
				frame.EltruismBackground = true
				--frame:SetAlpha(E.db.general.backdropfadecolor.a)
			end
		end)
	end
	test(frame)
	frame = EnumerateFrames()
	while frame do
		if (not frame:IsForbidden()) and not frametypes[frame:GetObjectType()] then
			test(frame)
			frametypes[frame:GetObjectType()] = true
		end
		frame = EnumerateFrames(frame)
	end
	E:StaggeredUpdateAll()
end
