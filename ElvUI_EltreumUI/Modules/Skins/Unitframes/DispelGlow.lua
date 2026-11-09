local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local next = _G.next
local select = _G.select
local Enum = _G.Enum
local CreateFrame = _G.CreateFrame
local InCombatLockdown = _G.InCombatLockdown
local UnitCanAssist = _G.UnitCanAssist
local UnitIsUnit = _G.UnitIsUnit
local UnitExists = _G.UnitExists
local issecretvalue = _G.issecretvalue

--glow dispellable debuffs
if not E.Modern then
	function ElvUI_EltreumUI:UFGlow(_, frame, _, _, debuffType, _, wasFiltered)
		if not frame or not frame.GetName then return end
		local db = E.db.ElvUI_EltreumUI
		if not db then return end

		--local canDispel = filtercheck:StyleFilterDispelCheck(object, debuffType)
		local color = not wasFiltered and debuffType and UF.db.colors.debuffHighlight[debuffType]

		if E.private.unitframe.enable and db.glow and db.glow.enableUFs then
			if color then
				--reuse color table per frame to avoid allocations on aura updates
				local glowColor = frame._EltruismDispelColor
				if not glowColor then
					glowColor = { color.r, color.g, color.b, 1 }
					frame._EltruismDispelColor = glowColor
				else
					glowColor[1], glowColor[2], glowColor[3], glowColor[4] = color.r, color.g, color.b, 1
				end
				ElvUI_EltreumUI:CustomGlowStart(frame, glowColor, 6)
			elseif frame._EltruismGlowing then
				ElvUI_EltreumUI:CustomGlowStop(frame)
			end
		end

		--mark frame so that the gradient backdrop doesnt overwrite it
		if color then
			frame.EltruismDebuffExists = true
			if db.unitframes and db.unitframes.gradientmode and db.unitframes.gradientmode.enablebackdrop then
				frame.EltruismDebuffr = color.r
				frame.EltruismDebuffg = color.g
				frame.EltruismDebuffb = color.b
				frame.EltruismDebuffa = color.a
			end
		else
			frame.EltruismDebuffExists = false
		end
	end
	ElvUI_EltreumUI:SecureHook(UF, "PostUpdate_AuraHighlight", "UFGlow") --hook aura highlight updates to apply or remove custom dispel glow
else
	--return early
	if not (E.private.unitframe.enable and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.glow and E.db.ElvUI_EltreumUI.glow.enableUFs) then return end

	--in modern aura payloads are secret in combat, so use elvui's custom aura container with blizzard's marching ants instead
	--https://www.townlong-yak.com/framexml/ptr/Blizzard_SharedXML/MarchingAnts.lua
	local dispelContainers = {}
	local combatQueue = {}
	local dispelTextureOptions = {
		style = (Enum and Enum.CustomAuraButtonDispelTypeTextureStyle and Enum.CustomAuraButtonDispelTypeTextureStyle.PreserveAsset) or 1,
		showWhenHarmful = true,
		showWhenHelpful = false,
	}
	local dashOffset = 2
	local dashThickness = 3
	local defaultDashLen = 16
	local dashAnimDuration = 0.75

	--prevent marching ants from stopping animation or keeping scale events registered when hidden
	local function DispelAntsResume(self)
		if (self.animSpeed or 1) > 0 then
			self:Play()
		end
	end

	--unregister scale and display events when marching ants border is hidden
	local function DispelAntsOnHide(self)
		self:UnregisterEvent("UI_SCALE_CHANGED")
		self:UnregisterEvent("DISPLAY_SIZE_CHANGED")
	end

	--calculate and update pixel glow dash positions and offsets based on unitframe size

	local function LayoutDashes(border)
		if not border or InCombatLockdown() then return end
		local frame = border.eltruismFrame
		local target = border.eltruismTarget
		if not frame or not target then return end

		--fallback to elvui unitframe dimensions if target width or height is secret or zero
		local w = target.GetWidth and target:GetWidth()
		if not w or (issecretvalue and issecretvalue(w)) or w <= 0 then
			w = (frame.UNIT_WIDTH and frame.UNIT_WIDTH > 0 and frame.UNIT_WIDTH) or (frame.db and frame.db.width) or 220
		end
		local h = target.GetHeight and target:GetHeight()
		if not h or (issecretvalue and issecretvalue(h)) or h <= 0 then
			h = (frame.UNIT_HEIGHT and frame.UNIT_HEIGHT > 0 and frame.UNIT_HEIGHT) or (frame.db and frame.db.height) or 45
		end

		--skip dash layout update if dimensions have not changed
		if border._lastW == w and border._lastH == h then return end
		border._lastW = w
		border._lastH = h

		local stepTop = (w + (dashOffset * 2)) / 3
		local stepRight = (h + (dashOffset * 2)) / 2
		local hDashLen = (stepTop < defaultDashLen and stepTop) or defaultDashLen
		local vDashLen = (stepRight < defaultDashLen and stepRight) or defaultDashLen

		local texs = border.dashTextures
		local anims = border.dashAnims

		--top edge dashes moving left to right
		for i = 1, 4 do
			local tex = texs[i]
			tex:SetSize(hDashLen, dashThickness)
			tex:ClearAllPoints()
			tex:SetPoint("TOPLEFT", border, "TOPLEFT", (i - 2) * stepTop, 0)
			anims[i]:SetOffset(stepTop, 0)
		end

		--right edge dashes moving top to bottom
		for i = 5, 7 do
			local tex = texs[i]
			tex:SetSize(dashThickness, vDashLen)
			tex:ClearAllPoints()
			tex:SetPoint("TOPRIGHT", border, "TOPRIGHT", 0, (6 - i) * stepRight)
			anims[i]:SetOffset(0, -stepRight)
		end

		--bottom edge dashes moving right to left
		for i = 8, 11 do
			local tex = texs[i]
			tex:SetSize(hDashLen, dashThickness)
			tex:ClearAllPoints()
			tex:SetPoint("BOTTOMRIGHT", border, "BOTTOMRIGHT", (9 - i) * stepTop, 0)
			anims[i]:SetOffset(-stepTop, 0)
		end

		--left edge dashes moving bottom to top
		for i = 12, 14 do
			local tex = texs[i]
			tex:SetSize(dashThickness, vDashLen)
			tex:ClearAllPoints()
			tex:SetPoint("BOTTOMLEFT", border, "BOTTOMLEFT", 0, (i - 13) * stepRight)
			anims[i]:SetOffset(0, stepRight)
		end
	end

	--configure the invisible dispel slot button and attach the marching ants or pixel glow border
	local function SetupDispelGlowButton(frame, auraButton)
		if not frame or not auraButton or auraButton.EltruismUFGlowBorder then return end

		--flag button so eltruism aura shadows and aura borders skip this invisible dispel slot button
		auraButton.eltruismShadowChecked = true
		auraButton.isAuraBar = true
		if auraButton.shadow then
			auraButton.shadow:Hide()
		end
		if auraButton.EltruismAuraBorder then
			auraButton.EltruismAuraBorder:Hide()
		end

		--disable mouse interaction and clipping on the slot button
		auraButton:EnableMouse(false)
		if auraButton.SetMouseClickEnabled then
			auraButton:SetMouseClickEnabled(false)
		end
		if auraButton.SetMouseMotionEnabled then
			auraButton:SetMouseMotionEnabled(false)
		end
		if auraButton.SetClipsChildren then
			auraButton:SetClipsChildren(false)
		end
		if auraButton.backdrop then
			auraButton.backdrop:Hide()
		end

		if E.Forever then
			--recreate pixel glow marching ants in forever since blizzard marching ants atlas is missing
			local border = CreateFrame("Frame", nil, auraButton)
			border:EnableMouse(false)
			if border.SetMouseClickEnabled then
				border:SetMouseClickEnabled(false)
			end
			if border.SetMouseMotionEnabled then
				border:SetMouseMotionEnabled(false)
			end
			if border.SetClipsChildren then
				border:SetClipsChildren(true)
			end

			--anchor pixel glow border around health backdrop or health bar
			local target = (frame.Health and (frame.Health.backdrop or frame.Health)) or frame
			border.eltruismFrame = frame
			border.eltruismTarget = target
			border.UpdateDashes = LayoutDashes

			border:ClearAllPoints()
			border:SetPoint("TOPLEFT", target, "TOPLEFT", -dashOffset, dashOffset)
			border:SetPoint("BOTTOMRIGHT", target, "BOTTOMRIGHT", dashOffset, -dashOffset)

			--create repeating animation group for the pixel glow dashes
			local animGroup = border:CreateAnimationGroup()
			animGroup:SetLooping("REPEAT")
			border.AnimGroup = animGroup

			local texs = {}
			local anims = {}
			border.dashTextures = texs
			border.dashAnims = anims

			for i = 1, 14 do
				local dash = border:CreateTexture(nil, "OVERLAY")
				dash:SetTexture(E.media.blankTex)
				local anim = animGroup:CreateAnimation("Translation")
				anim:SetTarget(dash)
				anim:SetDuration(dashAnimDuration)
				texs[i] = dash
				anims[i] = anim
			end

			LayoutDashes(border)

			--bind animation group playback to the aura slot visibility
			if auraButton.AddAuraShownAnimation then
				auraButton:AddAuraShownAnimation(animGroup)
			end

			if auraButton.AddDispelTypeTexture then
				if auraButton.ClearDispelTypeTextures then
					auraButton:ClearDispelTypeTextures()
				end
				for i = 1, 14 do
					auraButton:AddDispelTypeTexture(texs[i], dispelTextureOptions)
				end
			end

			local borderParent = frame.RaisedElementParent or frame
			local castLevel = borderParent and (borderParent.CastBarLevel or (borderParent.GetFrameLevel and borderParent:GetFrameLevel())) or 10
			border:SetFrameStrata("HIGH")
			border:SetFrameLevel(castLevel + 12)
			border:SetAlpha(1)

			auraButton.EltruismUFGlowBorder = border
			frame.EltruismUFGlowBorder = border

			border:Show()
			auraButton:Hide()
			return
		end

		--create marching ants border from xml template in load_libs.xml (Retail)
		local border = CreateFrame("Frame", nil, auraButton, "Eltruism_DispelBorderTemplate")

		border:SetClipsChildren(false)
		border:EnableMouse(false)
		if border.SetMouseClickEnabled then
			border:SetMouseClickEnabled(false)
		end
		if border.SetMouseMotionEnabled then
			border:SetMouseMotionEnabled(false)
		end

		border.CheckResumePlaying = DispelAntsResume
		border.OnHide = DispelAntsOnHide
		if border.SetupAssets then
			border:SetupAssets()
		end

		--replace default animation group with our repeat template and bind its visibility to the aura slot
		if border.MarchingAnim and border.MarchingAnim.Stop then
			border.MarchingAnim:Stop()
		end
		local marchingAnim = border:CreateAnimationGroup(nil, "Eltruism_DispelMarchingAnimTemplate")
		border.MarchingAnim = marchingAnim

		if auraButton.AddAuraShownAnimation then
			auraButton:AddAuraShownAnimation(marchingAnim)
		end

		--bind the 14 dash textures to blizzard's dispel type texture system so colors/shows them by debuff type
		if auraButton.AddDispelTypeTexture then
			if auraButton.ClearDispelTypeTextures then
				auraButton:ClearDispelTypeTextures()
			end
			if border.Top then
				auraButton:AddDispelTypeTexture(border.Top, dispelTextureOptions)
			end
			if border.Bottom then
				auraButton:AddDispelTypeTexture(border.Bottom, dispelTextureOptions)
			end
			if border.Left then
				auraButton:AddDispelTypeTexture(border.Left, dispelTextureOptions)
			end
			if border.Right then
				auraButton:AddDispelTypeTexture(border.Right, dispelTextureOptions)
			end
		end

		--anchor and configure the marching ants border with fixed thickness, offsets and speed
		local target = frame.Health.backdrop or frame.Health
		if border.AnchorAroundTarget and target then
			border:AnchorAroundTarget(target, 1, 1)
		end
		if border.SetLineThickness then
			border:SetLineThickness(7, 7)
		end

		--raise above castbar and other raised unitframe elements
		local borderParent = frame.RaisedElementParent or frame
		local castLevel = borderParent and (borderParent.CastBarLevel or (borderParent.GetFrameLevel and borderParent:GetFrameLevel())) or 10
		border:SetFrameStrata("HIGH")
		border:SetFrameLevel(castLevel + 12)
		border:SetAlpha(1)
		if border.SetSpeed then
			border:SetSpeed(3)
		end

		auraButton.EltruismUFGlowBorder = border
		frame.EltruismUFGlowBorder = border

		--hide the aura button itself while keeping the border shown so only the marching ants/pixel glow is visible
		border:Show()
		auraButton:Hide()
	end

	--reusable callback and options table for AddAuraSlot to avoid per-frame table/closure allocations
	local function InitializeDispelButton(auraButton)
		local container = auraButton and auraButton:GetParent()
		local frame = container and container.eltruismFrame
		if frame then
			frame.EltruismUFGlowButton = auraButton
			container.EltruismUFGlowButton = auraButton
			SetupDispelGlowButton(frame, auraButton)
		end
	end

	--register or update the dispellable debuff aura slot and candidate filters out of combat
	local dispelSlotOptions = {
		initializeFrame = InitializeDispelButton,
	}
	local function UpdateDispelGlowSlot(container, frame)
		if not container or not frame then return end

		--adding or updating aura slots in combat can fail/taint, so queue the frame for PLAYER_REGEN_ENABLED
		if InCombatLockdown() then
			combatQueue[frame] = container
			return
		end

		--resolve candidate filters for dispellable debuffs from elvui
		local filters
		if E.Auras_FilterSlot then
			filters = E:Auras_FilterSlot(container)
			if E.Auras_CleanCandidates then
				E:Auras_CleanCandidates(container, filters)
			end
			filters = container.candidates or filters
		end
		if filters and not next(filters) then
			filters = nil
		end

		--update existing slot filters when dispellable types change (e.g. talent change)
		if container.known and container.known.EltruismUFGlowSlot then
			if container.SetAuraSlotCandidateFilters then
				container:SetAuraSlotCandidateFilters("EltruismUFGlowSlot", filters)
			end
			if container.UpdateAllAuras then
				container:UpdateAllAuras()
			end
			return
		end

		dispelSlotOptions.candidateFilters = filters
		container:AddAuraSlot("EltruismUFGlowSlot", "HARMFUL|DISPELLABLE", dispelSlotOptions)
		container.known.EltruismUFGlowSlot = true
		if container.UpdateAllAuras then
			container:UpdateAllAuras()
		end
	end

	--toggle the dispel glow aura container based on unit existence and assist state
	local function RefreshFrameGlow(frame, unit)
		if not frame or not frame.Health then return end
		local container = frame.EltruismUFGlowContainer
		if not container then return end

		unit = unit or frame.__unit or frame.unit
		local frameShown = frame:IsShown()
		if issecretvalue and issecretvalue(frameShown) then
			frameShown = true
		end

		--verify unit exists and can be assisted while guarding against secret values
		local canAssist = false
		if frameShown and unit and not (issecretvalue and issecretvalue(unit)) then
			local unitExists = UnitExists(unit)
			if not (issecretvalue and issecretvalue(unitExists)) and unitExists then
				if unit == "player" then
					canAssist = true
				else
					local assist = UnitCanAssist("player", unit)
					if not (issecretvalue and issecretvalue(assist)) and assist then
						canAssist = true
					else
						local isPlayer = UnitIsUnit("player", unit)
						if not (issecretvalue and issecretvalue(isPlayer)) and isPlayer then
							canAssist = true
						end
					end
				end
			end
		end

		if canAssist then
			container.canReach = true
			container.canAssist = true
			E:Auras_ToggleActive(container, unit, true)
		else
			container.canReach = false
			container.canAssist = false
			E:Auras_ToggleActive(container, unit, false)
		end
	end

	--create or retrieve the custom aura container on the unitframe for tracking dispellable debuffs
	local function GetDispelGlowContainer(frame)
		local container = frame.EltruismUFGlowContainer
		if container then
			return container
		end

		container = E:Auras_Create(frame, "EltruismUFGlow")
		container:EnableMouse(false)
		if container.SetMouseClickEnabled then
			container:SetMouseClickEnabled(false)
		end
		if container.SetMouseMotionEnabled then
			container:SetMouseMotionEnabled(false)
		end
		if container.SetClipsChildren then
			container:SetClipsChildren(false)
		end
		container.candidates = container.candidates or {}

		--anchor container to health backdrop and raise above health bar
		local target = frame.Health.backdrop or frame.Health
		container:ClearAllPoints()
		container:SetAllPoints(target)
		container.eltruismFrame = frame
		container:SetFrameLevel((frame.Health:GetFrameLevel() or 10) + 20)
		container.allowEnable = true
		container.isHighlight = true
		container.unitframeType = frame.unitframeType
		if container.events then
			container.events.isHighlight = true
		end

		frame.EltruismUFGlowContainer = container
		dispelContainers[frame] = container
		return container
	end

	--configure dispel glow container and border when an elvui unitframe is updated
	function ElvUI_EltreumUI:UFGlow_Configure(_, frame)
		if not frame or not frame.Health then return end
		if not (E.private.unitframe.enable and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.glow and E.db.ElvUI_EltreumUI.glow.enableUFs) then
			return
		end

		local container = GetDispelGlowContainer(frame)
		container.allowEnable = true
		container.unitframeType = frame.unitframeType

		--recalculate forever pixel glow dash offsets when unitframe is resized or reconfigured
		if frame.EltruismUFGlowBorder and frame.EltruismUFGlowBorder.UpdateDashes then
			frame.EltruismUFGlowBorder:UpdateDashes()
		end

		local unit = frame.__unit or frame.unit

		UpdateDispelGlowSlot(container, frame)
		RefreshFrameGlow(frame, unit)
	end

	--toggle dispel glow container active state when elvui toggles unitframe auras
	function ElvUI_EltreumUI:UFGlow_Toggle(_, frame, unit, shown)
		if not frame or not frame.Health then return end
		local targetUnit = unit or frame.__unit or frame.unit
		if shown == false then
			local container = frame.EltruismUFGlowContainer
			if container then
				container.canReach = false
				container.canAssist = false
				E:Auras_ToggleActive(container, targetUnit, false)
			end
		else
			RefreshFrameGlow(frame, targetUnit)
		end
	end

	--toggle dispel glow container active state when elvui toggles unitframe auras
	function ElvUI_EltreumUI:UFGlow_UpdateUnit(_, frame, unit)
		RefreshFrameGlow(frame, unit)
	end

	--update dispel slot candidate filters across all containers when dispellable types change
	function ElvUI_EltreumUI:UFGlow_DispelUpdated()
		if not (E.private.unitframe.enable and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.glow and E.db.ElvUI_EltreumUI.glow.enableUFs) then
			return
		end
		for frame, container in next, dispelContainers do
			if container.known and container.known.EltruismUFGlowSlot then
				UpdateDispelGlowSlot(container, frame)
			end
		end
	end

	--recursive vararg helper to avoid creating temporary tables when iterating group headers
	local function ConfigureHeaderChildren(...)
		for i = 1, select("#", ...) do
			local child = select(i, ...)
			if child then
				if child.Health then
					ElvUI_EltreumUI:UFGlow_Configure(nil, child)
				elseif child.GetChildren then
					ConfigureHeaderChildren(child:GetChildren())
				end
			end
		end
	end

	--initialize or hide modern dispel glow across all individual and group unitframes
	function ElvUI_EltreumUI:UFGlowModern()
		if not (E.private.unitframe.enable and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.glow and E.db.ElvUI_EltreumUI.glow.enableUFs) then
			for _, container in next, dispelContainers do
				if container:IsShown() then
					container:Hide()
				end
			end
			return
		end

		--configure individual unitframes registered in elvui
		if UF.units then
			for _, frame in next, UF.units do
				if frame and frame.Health then
					ElvUI_EltreumUI:UFGlow_Configure(nil, frame)
				end
			end
		end

		--configure group header unitframes (party, raid, boss, arena)
		if UF.headers then
			for _, header in next, UF.headers do
				if header.GetChildren then
					ConfigureHeaderChildren(header:GetChildren())
				end
			end
		end
	end

	--hooks into elvui unitframe and aura container lifecycle
	ElvUI_EltreumUI:SecureHook(UF, "ConfigureFrame", "UFGlow_Configure") --hook unitframe configuration to setup or update the dispel glow container and border
	ElvUI_EltreumUI:SecureHook(UF, "Auras_ToggleContainer", "UFGlow_Toggle")--hook aura container toggling to sync the dispel glow active state
	ElvUI_EltreumUI:SecureHook(UF, "Configure_UnitAuras", "UFGlow_UpdateUnit")--hook unit aura configuration to refresh the dispel glow for the frame unit
	ElvUI_EltreumUI:SecureHook(E, "Auras_DispelUpdated", "UFGlow_DispelUpdated")--hook dispel list updates to refresh candidate filters when dispellable types change

	--event frame to handle combat lockdown queue and target/focus unit changes in forever
	local dispelGlowEvents = CreateFrame("FRAME")
	dispelGlowEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
	dispelGlowEvents:RegisterEvent("PLAYER_REGEN_ENABLED")
	if E.Forever then
		dispelGlowEvents:RegisterEvent("PLAYER_TARGET_CHANGED")
		dispelGlowEvents:RegisterUnitEvent("UNIT_TARGET", "target", "focus")
		dispelGlowEvents:RegisterEvent("PLAYER_FOCUS_CHANGED")
	end
	dispelGlowEvents:SetScript("OnEvent", function(_, event, arg1)
		if event == "PLAYER_REGEN_ENABLED" then
			--process any frames that were queued during combat
			if next(combatQueue) then
				for frame, container in next, combatQueue do
					combatQueue[frame] = nil
					UpdateDispelGlowSlot(container, frame)
					RefreshFrameGlow(frame)
				end
			end
		elseif event == "PLAYER_ENTERING_WORLD" then
			ElvUI_EltreumUI:UFGlowModern()
		--forever only events
		elseif event == "PLAYER_TARGET_CHANGED" then --refresh target and target of target frames when player target changes
			if _G.ElvUF_Target then
				RefreshFrameGlow(_G.ElvUF_Target, "target")
			end
			if _G.ElvUF_TargetTarget then
				RefreshFrameGlow(_G.ElvUF_TargetTarget, "targettarget")
			end
			if _G.ElvUF_TargetTargetTarget then
				RefreshFrameGlow(_G.ElvUF_TargetTargetTarget, "targettargettarget")
			end
		elseif event == "UNIT_TARGET" then --refresh target of target or focus target frames when their unit target changes
			if arg1 == "target" then
				if _G.ElvUF_TargetTarget then
					RefreshFrameGlow(_G.ElvUF_TargetTarget, "targettarget")
				end
				if _G.ElvUF_TargetTargetTarget then
					RefreshFrameGlow(_G.ElvUF_TargetTargetTarget, "targettargettarget")
				end
			elseif arg1 == "focus" then
				if _G.ElvUF_FocusTarget then
					RefreshFrameGlow(_G.ElvUF_FocusTarget, "focustarget")
				end
			end
		elseif event == "PLAYER_FOCUS_CHANGED" then --refresh focus and focus target frames when player focus changes
			if _G.ElvUF_Focus then
				RefreshFrameGlow(_G.ElvUF_Focus, "focus")
			end
			if _G.ElvUF_FocusTarget then
				RefreshFrameGlow(_G.ElvUF_FocusTarget, "focustarget")
			end
		end
	end)

	--initialize immediately if elvui unitframes are already loaded
	if UF.Initialized then
		ElvUI_EltreumUI:UFGlowModern()
	end
end
