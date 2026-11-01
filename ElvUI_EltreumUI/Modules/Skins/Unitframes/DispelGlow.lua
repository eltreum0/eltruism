local E = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G
local next = _G.next
local select = _G.select
local Enum = _G.Enum
local CreateFrame = _G.CreateFrame
local hooksecurefunc = _G.hooksecurefunc
local InCombatLockdown = _G.InCombatLockdown

if not E.Modern then
	--glow dispellable debuffs
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
	ElvUI_EltreumUI:SecureHook(UF, "PostUpdate_AuraHighlight", "UFGlow")
else
	--return early
	if not (E.private.unitframe.enable and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.glow and E.db.ElvUI_EltreumUI.glow.enableUFs) then return end

	--in modern aura payloads are secret in combat, so use elvui's custom aura container with blizzard's marching ants instead
	--https://www.townlong-yak.com/framexml/ptr/Blizzard_SharedXML/MarchingAnts.lua
	local dispelContainers = {}
	local combatQueue = {}
	local emptyFilters = {}
	local dispelTextureOptions = {
		style = (Enum and Enum.CustomAuraButtonDispelTypeTextureStyle and Enum.CustomAuraButtonDispelTypeTextureStyle.PreserveAsset) or 1,
		showWhenHarmful = true,
		showWhenHelpful = false,
	}

	--prevent marching ants from stopping animation or keeping scale events registered when hidden
	local function DispelAntsResume(self)
		if (self.animSpeed or 1) > 0 then
			self:Play()
		end
	end

	local function DispelAntsOnHide(self)
		self:UnregisterEvent("UI_SCALE_CHANGED")
		self:UnregisterEvent("DISPLAY_SIZE_CHANGED")
	end

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

		--create marching ants border from xml template in load_libs.xml
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

		--bind the 4 border sides to blizzard's dispel type texture system so c++ colors/shows them by debuff type
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

		--hide the aura button itself while keeping the border shown so only the marching ants are visible
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

	local dispelSlotOptions = {
		initializeFrame = InitializeDispelButton,
	}

	local function UpdateDispelGlowSlot(container, frame, unit)
		if not container or not frame then return end

		unit = unit or frame.__unit or frame.unit
		if frame:IsShown() and unit and not container:IsShown() then
			E:Auras_ToggleActive(container, unit, true)
		end

		--defer slot creation if the container is not shown yet
		if not container:IsShown() then
			container.eltruismNeedsSlot = true
			return
		end
		container.eltruismNeedsSlot = nil

		--resolve candidate filters for dispellable debuffs from elvui
		local filters
		if E.Auras_FilterSlot then
			filters = E:Auras_FilterSlot(container)
			if E.Auras_CleanCandidates then
				E:Auras_CleanCandidates(container, filters)
			end
			filters = container.candidates or filters or emptyFilters
		else
			filters = emptyFilters
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

		--adding aura slots in combat can fail/taint, so queue the frame for PLAYER_REGEN_ENABLED
		if InCombatLockdown() then
			combatQueue[frame] = container
			return
		end

		dispelSlotOptions.candidateFilters = filters
		container:AddAuraSlot("EltruismUFGlowSlot", "HARMFUL|DISPELLABLE", dispelSlotOptions)
		container.known.EltruismUFGlowSlot = true
		if container.UpdateAllAuras then
			container:UpdateAllAuras()
		end
	end

	--sync container active state and pending slots when frames are shown or hidden
	local function OnContainerShow(container)
		if container.eltruismNeedsSlot and container.eltruismFrame then
			UpdateDispelGlowSlot(container, container.eltruismFrame)
		end
	end

	local function OnFrameShow(frame)
		local container = frame.EltruismUFGlowContainer
		local unit = frame.__unit or frame.unit
		if container and unit then
			E:Auras_ToggleActive(container, unit, true)
		end
	end

	local function OnFrameHide(frame)
		local container = frame.EltruismUFGlowContainer
		local unit = frame.__unit or frame.unit
		if container and unit then
			E:Auras_ToggleActive(container, unit, false)
		end
	end

	--create custom aura container on the unitframe for tracking dispellable debuffs
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

		local target = frame.Health.backdrop or frame.Health
		container:ClearAllPoints()
		container:SetAllPoints(target)
		container.eltruismFrame = frame
		container:SetFrameLevel((frame.Health:GetFrameLevel() or 10) + 20)

		hooksecurefunc(container, "Show", OnContainerShow)

		if not frame.EltruismUFGlowHooked then
			hooksecurefunc(frame, "Show", OnFrameShow)
			hooksecurefunc(frame, "Hide", OnFrameHide)
			frame.EltruismUFGlowHooked = true
		end

		frame.EltruismUFGlowContainer = container
		dispelContainers[frame] = container
		return container
	end

	function ElvUI_EltreumUI:UFGlow_Configure(_, frame)
		if not frame or not frame.Health then return end
		if not (E.private.unitframe.enable and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.glow and E.db.ElvUI_EltreumUI.glow.enableUFs) then
			return
		end

		local container = GetDispelGlowContainer(frame)
		container.allowEnable = true
		container.forceShowAuras = true
		container.unitframeType = frame.unitframeType

		local unit = frame.__unit or frame.unit
		if unit and frame:IsShown() then
			E:Auras_ToggleActive(container, unit, true)
		elseif unit then
			E:Auras_GroupUnit(container, unit)
		end

		UpdateDispelGlowSlot(container, frame, unit)
	end

	function ElvUI_EltreumUI:UFGlow_Toggle(_, frame, unit, shown)
		local container = frame and frame.EltruismUFGlowContainer
		if not container then return end
		local targetUnit = unit or frame.__unit or frame.unit
		if targetUnit then
			E:Auras_ToggleActive(container, targetUnit, shown)
		end
	end

	function ElvUI_EltreumUI:UFGlow_UpdateUnit(_, frame, unit)
		local container = frame and frame.EltruismUFGlowContainer
		if not container then return end
		local targetUnit = unit or frame.__unit or frame.unit
		if targetUnit and frame:IsShown() then
			E:Auras_ToggleActive(container, targetUnit, true)
		elseif targetUnit then
			E:Auras_GroupUnit(container, targetUnit)
		end
	end

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

	function ElvUI_EltreumUI:UFGlowModern()
		if not (E.private.unitframe.enable and E.db.ElvUI_EltreumUI and E.db.ElvUI_EltreumUI.glow and E.db.ElvUI_EltreumUI.glow.enableUFs) then
			for frame, container in next, dispelContainers do
				if frame.EltruismUFGlowBorder then
					frame.EltruismUFGlowBorder:Hide()
				end
				if container:IsShown() then
					container:Hide()
				end
			end
			return
		end

		if UF.units then
			for _, frame in next, UF.units do
				if frame and frame.Health then
					ElvUI_EltreumUI:UFGlow_Configure(nil, frame)
				end
			end
		else
			if _G.ElvUF_Player then
				ElvUI_EltreumUI:UFGlow_Configure(nil, _G.ElvUF_Player)
			end
			if _G.ElvUF_Target then
				ElvUI_EltreumUI:UFGlow_Configure(nil, _G.ElvUF_Target)
			end
			if _G.ElvUF_TargetTarget then
				ElvUI_EltreumUI:UFGlow_Configure(nil, _G.ElvUF_TargetTarget)
			end
			if _G.ElvUF_Focus then
				ElvUI_EltreumUI:UFGlow_Configure(nil, _G.ElvUF_Focus)
			end
			if _G.ElvUF_Pet then
				ElvUI_EltreumUI:UFGlow_Configure(nil, _G.ElvUF_Pet)
			end
		end

		if UF.headers then
			for _, header in next, UF.headers do
				if header.GetChildren then
					ConfigureHeaderChildren(header:GetChildren())
				end
			end
		end
	end

	--hooks into elvui unitframe and aura container lifecycle
	ElvUI_EltreumUI:SecureHook(UF, "ConfigureFrame", "UFGlow_Configure")
	ElvUI_EltreumUI:SecureHook(UF, "Auras_ToggleContainer", "UFGlow_Toggle")
	ElvUI_EltreumUI:SecureHook(UF, "Configure_UnitAuras", "UFGlow_UpdateUnit")
	ElvUI_EltreumUI:SecureHook(E, "Auras_DispelUpdated", "UFGlow_DispelUpdated")

	local dispelGlowEvents = CreateFrame("FRAME")
	dispelGlowEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
	dispelGlowEvents:RegisterEvent("PLAYER_REGEN_ENABLED")
	dispelGlowEvents:SetScript("OnEvent", function(_, event)
		if event == "PLAYER_REGEN_ENABLED" then
			--process any frames that were queued during combat
			if next(combatQueue) then
				for frame, container in next, combatQueue do
					combatQueue[frame] = nil
					UpdateDispelGlowSlot(container, frame)
				end
			end
		elseif event == "PLAYER_ENTERING_WORLD" then
			ElvUI_EltreumUI:UFGlowModern()
		end
	end)

	if UF.Initialized then
		ElvUI_EltreumUI:UFGlowModern()
	end
end
