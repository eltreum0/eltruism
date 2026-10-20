local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')

--glow dispellable debuffs
function ElvUI_EltreumUI:UFGlow(_, frame, _, _, debuffType, _, wasFiltered)
	if not frame or not frame.GetName then return end
	local object = frame

	if E.private.unitframe.enable and E.db.ElvUI_EltreumUI.unitframes.UFmodifications then
		if E.db.ElvUI_EltreumUI.glow.enableUFs then
			local name = object:GetName()
			if (name ~= "ElvUF_Player" and name ~= "ElvUF_Target") then
				if debuffType and UF.db.colors.debuffHighlight[debuffType] then
					if not wasFiltered then
						--local canDispel = filtercheck:StyleFilterDispelCheck(object, debuffType)
						local color = UF.db.colors.debuffHighlight[debuffType]
						ElvUI_EltreumUI:CustomGlowStart(object, {color.r, color.g, color.b, 1}, 6)
					end
				else
					ElvUI_EltreumUI:CustomGlowStop(object)
				end
			end
		end
	end

	--mark frame so that the gradient backdrop doesnt overwrite it
	if debuffType and UF.db.colors.debuffHighlight[debuffType] then
		if not wasFiltered then
			object.EltruismDebuffExists = true
			if E.db.ElvUI_EltreumUI.unitframes.gradientmode.enablebackdrop then
				local color = UF.db.colors.debuffHighlight[debuffType]
				object.EltruismDebuffr = color.r
				object.EltruismDebuffg = color.g
				object.EltruismDebuffb = color.b
				object.EltruismDebuffa = color.a
			end
		else
			object.EltruismDebuffExists = false
		end
	else
		object.EltruismDebuffExists = false
	end
end
ElvUI_EltreumUI:SecureHook(UF, "PostUpdate_AuraHighlight", "UFGlow")
