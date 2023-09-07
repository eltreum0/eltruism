local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local hooksecurefunc = _G.hooksecurefunc
local tostring = _G.tostring

--modify the position of the information panel
local allowedunits = {
	['ElvUF_Player'] = true,
	['ElvUF_Target'] = true,
	['ElvUF_TargetTarget'] = true,
	['ElvUF_Focus'] = true,
	['ElvUF_FocusTarget'] = true,
	['ElvUF_Pet'] = true,
	['ElvUF_TargetTargetTarget'] = true,
}
local function Configure_InfoPanel(_, frame)
	local db = frame.db
	local isShown = frame.USE_INFO_PANEL

	frame.InfoPanel:SetShown(isShown)

	if isShown then
		frame.InfoPanel:ClearAllPoints()

		local allowed = (E.db.ElvUI_EltreumUI.unitframes.infopanelontopallframes or allowedunits[tostring(frame:GetName())]) and true or false

		--print(E.private["general"]["pixelPerfect"],E.db["unitframe"]["thinBorders"])
		if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.infopanelontop and allowed then
			local portrait = (db.portrait.style == '3D' and frame.Portrait3D) or frame.Portrait2D
			portrait.db = db.portrait
			frame.InfoPanel:ClearAllPoints()
			frame.InfoPanelOnTop = true
			if E.db.unitframe.thinBorders then
				if frame.USE_PORTRAIT and portrait.db.style ~= '3D' then
					if frame.ORIENTATION == 'LEFT' then
						--[[frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
						frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, -(UF.SPACING*3))
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, db.infoPanel.height)
						frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)]]
						if not frame.USE_PORTRAIT_OVERLAY then
							frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
							frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, -(UF.SPACING*3))
							frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height - (UF.BORDER/2))
							frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, db.infoPanel.height - (UF.BORDER/2))
							frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)
						else
							frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
							frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
							frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height - (UF.BORDER/2))
							frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height - (UF.BORDER/2))
							frame.InfoPanel:SetSize(db.width,db.infoPanel.height)
						end
					elseif frame.ORIENTATION == 'RIGHT' then
						if not frame.USE_PORTRAIT_OVERLAY then
							frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING - portrait.db.width, UF.BORDER + UF.SPACING)
							frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
							frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING - portrait.db.width, db.infoPanel.height)
							frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
							frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)
						else
							frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
							frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
							frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
							frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
							frame.InfoPanel:SetSize(db.width,db.infoPanel.height)
						end
					end
				else
					frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
					--frame.InfoPanel:Point('BOTTOMLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
					frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
					frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
					frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					--[[if db.orientation == 'LEFT' then
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					else
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					end]]
					frame.InfoPanel:SetSize(db.width,db.infoPanel.height)
				end
			else
				if frame.USE_PORTRAIT and portrait.db.style ~= '3D' then
					if frame.ORIENTATION == 'LEFT' then
						--[[frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
						frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, -(UF.SPACING*3))
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER+portrait.db.width, db.infoPanel.height)
						frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)]]
						if not frame.USE_PORTRAIT_OVERLAY then
							frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
							frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', (UF.BORDER*1.5)+portrait.db.width, -(UF.SPACING*3))
							frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height - (UF.BORDER/2))
							frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', (UF.BORDER*1.5)+portrait.db.width, db.infoPanel.height - (UF.BORDER/2))
							frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)
						else
							frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
							frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', (UF.BORDER*1.5), -(UF.SPACING*3))
							frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height - (UF.BORDER/2))
							frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', (UF.BORDER*1.5), db.infoPanel.height - (UF.BORDER/2))
							frame.InfoPanel:SetSize(db.width,db.infoPanel.height)
						end
					elseif frame.ORIENTATION == 'RIGHT' then
						if not frame.USE_PORTRAIT_OVERLAY then
							frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
							frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER*1.3, -(UF.SPACING*3))
							frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
							frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER*1.3, db.infoPanel.height)
							frame.InfoPanel:SetSize(db.width,db.infoPanel.height)
						else
							frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING - portrait.db.width, UF.BORDER + UF.SPACING)
							frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER*1.3, -(UF.SPACING*3))
							frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING - portrait.db.width, db.infoPanel.height)
							frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER*1.3, db.infoPanel.height)
							frame.InfoPanel:SetSize(db.width-portrait.db.width,db.infoPanel.height)
						end
					end
				else
					frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
					--frame.InfoPanel:Point('BOTTOMLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
					frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', UF.BORDER, -(UF.SPACING*3))
					frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
					frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					--[[if db.orientation == 'LEFT' then
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					else
						frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -UF.BORDER - UF.SPACING, db.infoPanel.height)
						frame.InfoPanel:Point('TOPLEFT', frame.Health.backdrop, 'TOPLEFT', UF.BORDER, db.infoPanel.height)
					end]]
					frame.InfoPanel:SetSize(db.width,db.infoPanel.height)
				end
			end
		else --this is the original
			if frame.ORIENTATION == 'RIGHT' and frame.unitframeType ~= 'arena' then
				frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -UF.BORDER - UF.SPACING, UF.BORDER + UF.SPACING)
				if frame.USE_POWERBAR and not frame.USE_INSET_POWERBAR and not frame.POWERBAR_DETACHED then
					frame.InfoPanel:Point('TOPLEFT', frame.Power.backdrop, 'BOTTOMLEFT', UF.BORDER, -(UF.SPACING*3))
				else
					frame.InfoPanel:Point('TOPLEFT', frame.Health.backdrop, 'BOTTOMLEFT', UF.BORDER, -(UF.SPACING*3))
				end
			else
				frame.InfoPanel:Point('BOTTOMLEFT', frame, 'BOTTOMLEFT', UF.BORDER + UF.SPACING, UF.BORDER + UF.SPACING)
				if frame.USE_POWERBAR and not frame.USE_INSET_POWERBAR and not frame.POWERBAR_DETACHED then
					frame.InfoPanel:Point('TOPRIGHT', frame.Power.backdrop, 'BOTTOMRIGHT', -UF.BORDER, -(UF.SPACING*3))
				else
					frame.InfoPanel:Point('TOPRIGHT', frame.Health.backdrop, 'BOTTOMRIGHT', -UF.BORDER, -(UF.SPACING*3))
				end
			end
		end

		if db.infoPanel.transparent then
			frame.InfoPanel.backdrop:SetTemplate('Transparent', nil, nil, nil, true)
		else
			frame.InfoPanel.backdrop:SetTemplate(nil, true, nil, nil, true)
		end
	else
		frame.InfoPanel:Hide()
	end
end
hooksecurefunc(UF, 'Configure_InfoPanel', Configure_InfoPanel)

function ElvUI_EltreumUI:SkinPortrait(frame)
	local db = frame.db
	local portrait = (db.portrait.style == '3D' and frame.Portrait3D) or frame.Portrait2D
	portrait.db = db.portrait
	frame.Portrait = portrait

	if frame.USE_PORTRAIT and portrait.db.style ~= '3D' then
		if E.db.ElvUI_EltreumUI.unitframes.UFmodifications and E.db.ElvUI_EltreumUI.unitframes.infopanelontop and allowedunits[tostring(frame:GetName())] and not frame.USE_PORTRAIT_OVERLAY then
			if frame.ORIENTATION == 'LEFT' then
				if portrait.db.style == '2D' then
					portrait:ClearAllPoints()
					if E.db.unitframe.thinBorders then
						portrait:SetPoint("BOTTOMLEFT", portrait.backdrop, "BOTTOMLEFT", 0, 1-(UF.BORDER/2))
						portrait:SetPoint("BOTTOMRIGHT", portrait.backdrop, "BOTTOMRIGHT", 0, 1-(UF.BORDER/2))
						portrait:SetPoint("TOPRIGHT", portrait.backdrop, "TOPRIGHT", 0, db.infoPanel.height-1)
						portrait:SetPoint("TOPLEFT", portrait.backdrop, "TOPLEFT", 0, db.infoPanel.height-1)
					else
						portrait:SetPoint("BOTTOMLEFT", portrait.backdrop, "BOTTOMLEFT", -1, -(1/2))
						portrait:SetPoint("BOTTOMRIGHT", portrait.backdrop, "BOTTOMRIGHT", 0, -(1/2))
						portrait:SetPoint("TOPRIGHT", portrait.backdrop, "TOPRIGHT", 0, db.infoPanel.height+(UF.BORDER/1.5)-1)
						portrait:SetPoint("TOPLEFT", portrait.backdrop, "TOPLEFT", -1, db.infoPanel.height+(UF.BORDER/1.5)-1)
					end
				elseif portrait.db.style == 'Class' then
					portrait:ClearAllPoints()
					if E.db.unitframe.thinBorders then
						portrait:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", 0, db.infoPanel.height-(UF.BORDER/2))
						portrait:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0+portrait.db.width, db.infoPanel.height-(UF.BORDER/2))
						portrait:SetPoint("TOPRIGHT", frame, "TOPLEFT", 0, db.infoPanel.height-1)
						portrait:SetPoint("TOPLEFT", frame, "TOPLEFT", 0+portrait.db.width, db.infoPanel.height-1)
					else
						portrait:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", UF.BORDER, db.infoPanel.height+(UF.BORDER/4)+1)
						portrait:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", UF.BORDER+portrait.db.width, db.infoPanel.height+(UF.BORDER/4)+1)
						portrait:SetPoint("TOPRIGHT", frame, "TOPLEFT", UF.BORDER, db.infoPanel.height+(UF.BORDER/2))
						portrait:SetPoint("TOPLEFT", frame, "TOPLEFT", UF.BORDER+portrait.db.width, db.infoPanel.height+(UF.BORDER/2))
					end
					portrait.backdrop:ClearAllPoints()
					portrait.backdrop:SetAllPoints(portrait)
				end
			elseif frame.ORIENTATION == 'RIGHT' then
				if portrait.db.style == '2D' then
					portrait:ClearAllPoints()
					if E.db.unitframe.thinBorders then
						portrait:SetPoint("BOTTOMLEFT", portrait.backdrop, "BOTTOMLEFT", 0, 1-(UF.BORDER/2))
						portrait:SetPoint("BOTTOMRIGHT", portrait.backdrop, "BOTTOMRIGHT", 0, 1-(UF.BORDER/2))
						portrait:SetPoint("TOPRIGHT", portrait.backdrop, "TOPRIGHT", 0, db.infoPanel.height+(UF.BORDER/2))
						portrait:SetPoint("TOPLEFT", portrait.backdrop, "TOPLEFT", 0, db.infoPanel.height+(UF.BORDER/2))
					else
						portrait:SetPoint("BOTTOMLEFT", portrait.backdrop, "BOTTOMLEFT", 0, -(1/2))
						portrait:SetPoint("BOTTOMRIGHT", portrait.backdrop, "BOTTOMRIGHT", 0, -(1/2))
						portrait:SetPoint("TOPRIGHT", portrait.backdrop, "TOPRIGHT", 0, db.infoPanel.height+(UF.BORDER*1.2)-0.5)
						portrait:SetPoint("TOPLEFT", portrait.backdrop, "TOPLEFT", 0, db.infoPanel.height+(UF.BORDER*1.2)-0.5)
					end
				elseif portrait.db.style == 'Class' then
					portrait:ClearAllPoints()
					if E.db.unitframe.thinBorders then
						portrait:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, db.infoPanel.height)--+(UF.BORDER/2))
						portrait:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0-portrait.db.width, db.infoPanel.height)--+(UF.BORDER/2))
						portrait:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0-portrait.db.width, db.infoPanel.height+(UF.BORDER/2))
						portrait:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, db.infoPanel.height+(UF.BORDER/2))
					else
						portrait:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -UF.BORDER, db.infoPanel.height+(UF.BORDER/2))
						portrait:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", -UF.BORDER-portrait.db.width, db.infoPanel.height+(UF.BORDER/2))

						portrait:SetPoint("TOPLEFT", frame, "TOPRIGHT", -UF.BORDER-portrait.db.width, db.infoPanel.height+UF.BORDER)
						portrait:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -UF.BORDER, db.infoPanel.height+UF.BORDER)
					end
					portrait.backdrop:ClearAllPoints()
					portrait.backdrop:SetAllPoints(portrait)
				end
			end
		end
	end
end
hooksecurefunc(UF, "Configure_Portrait", ElvUI_EltreumUI.SkinPortrait)
