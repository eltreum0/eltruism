local E = unpack(ElvUI)
local _G = _G
local UnitCastingInfo = _G.UnitCastingInfo or _G.CastingInfo
local UnitChannelInfo = _G.UnitChannelInfo or _G.ChannelInfo
local CreateFrame = _G.CreateFrame
local UIParent = _G.UIParent
local SetCVar = _G.C_CVar and _G.C_CVar.SetCVar or _G.SetCVar
local next = _G.next
local min = _G.min
local floor = _G.floor
local unpack = _G.unpack
local max = _G.max
local sin = _G.sin
local cos = _G.cos
local GetCursorPosition = _G.GetCursorPosition
local InCombatLockdown = _G.InCombatLockdown
local GetTime = _G.GetTime
local GetSpellCooldown = _G.C_Spell and _G.C_Spell.GetSpellCooldown or _G.GetSpellCooldown
local colorcast
local colorgcd
local colorcursor
local currentring
local Defaults
local QUAD_POINTS
local QUAD_COORD_FULL
local QUAD_COORD_FUNC

function ElvUI_EltreumUI:CursorInit()
	if E.db.ElvUI_EltreumUI.cursors.cursor.enable then
		ElvUI_EltreumUI:CastCursor()
		if E.db.ElvUI_EltreumUI.cursors.cursor.cooldown then
			ElvUI_EltreumUI:CooldownEnable() --starts cursor module with cooldowns
		end
	end
end

local cursorframe = CreateFrame("Frame", "EltruismCursorSetup")
local rootFrame = CreateFrame("Frame", "EltruismCursorRoot", UIParent)
local Cast = CreateFrame("Frame", "EltruismCursorCast", rootFrame)
local GCD = CreateFrame("Frame", "EltruismCursorGCD", rootFrame)
local Cursor = CreateFrame("Frame", "EltruismCursorCursor", rootFrame)

--Detect the current cursor for options
function ElvUI_EltreumUI:CurrentTypeofCursor()
	currentring = E.db.ElvUI_EltreumUI.cursors.cursor.ring
	if currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring1.tga' then
		currentring = '|cff82B4ffType 1|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring2.tga' then
		currentring = '|cff82B4ffType 2|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring3.tga' then
		currentring = '|cff82B4ffType 3|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring4.tga' then
		currentring = '|cff82B4ffType 4|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring5.tga' then
		currentring = '|cff82B4ffType 5|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring6.tga' then
		currentring = '|cff82B4ffType 6|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring7.tga' then
		currentring = '|cff82B4ffType 7|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring8.tga' then
		currentring = '|cff82B4ffType 8|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring9.tga' then
		currentring = '|cff82B4ffType 9|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring10.tga' then
		currentring = '|cff82B4ffType 10|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring11.tga' then
		currentring = '|cff82B4ffType 11|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring12.tga' then
		currentring = '|cff82B4ffType 12|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring13.tga' then
		currentring = '|cff82B4ffType 13|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring14.tga' then
		currentring = '|cff82B4ffType 14|r'
	elseif currentring == 'Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Cursor\\ring15.tga' then
		currentring = '|cff82B4ffType 15|r'
	end
	return currentring
end

-- Change cursor size based on user input
function ElvUI_EltreumUI:CursorSize(value)
	if value == '-1' then
		SetCVar("cursorSizePreferred", -1)
		E.db.ElvUI_EltreumUI.cursors.cursor.size = '-1'
	elseif value == '0' then
		SetCVar("cursorSizePreferred", 0)
		E.db.ElvUI_EltreumUI.cursors.cursor.size = '0'
	elseif value == '1' then
		SetCVar("cursorSizePreferred", 1)
		E.db.ElvUI_EltreumUI.cursors.cursor.size = '1'
	elseif value == '2' then
		SetCVar("cursorSizePreferred", 2)
		E.db.ElvUI_EltreumUI.cursors.cursor.size = '2'
	elseif value == '3' then
		SetCVar("cursorSizePreferred", 3)
		E.db.ElvUI_EltreumUI.cursors.cursor.size = '3'
	elseif value == '4' then
		SetCVar("cursorSizePreferred", 4)
		E.db.ElvUI_EltreumUI.cursors.cursor.size = '4'
	end
end

--This module is a direct fork of CastCursor by michaelsp and as such is available under GNU GPL v3 like the original
function ElvUI_EltreumUI:CastCursor()
	if E.db.ElvUI_EltreumUI.cursors.cursor.enable then

		if E.db.ElvUI_EltreumUI.cursors.cursor.fixlag == 0 then
			--SetCVar("gxCursor", 0)
			SetCVar("HardwareCursor", 0)
		end
		if E.db.ElvUI_EltreumUI.cursors.cursorcast.classcolor then
			colorcast = E:ClassColor(E.myclass, true)
		end
		if not E.db.ElvUI_EltreumUI.cursors.cursorcast.classcolor then
			colorcast = {
				r = E.db.ElvUI_EltreumUI.cursors.cursorcast.r,
				g = E.db.ElvUI_EltreumUI.cursors.cursorcast.g,
				b = E.db.ElvUI_EltreumUI.cursors.cursorcast.b,
				a = E.db.ElvUI_EltreumUI.cursors.cursorcast.a
			}
		end
		if E.db.ElvUI_EltreumUI.cursors.cursorgcd.classcolor then
			colorgcd = E:ClassColor(E.myclass, true)
		end
		if not E.db.ElvUI_EltreumUI.cursors.cursorgcd.classcolor then
			colorgcd = {
				r = E.db.ElvUI_EltreumUI.cursors.cursorgcd.r,
				g = E.db.ElvUI_EltreumUI.cursors.cursorgcd.g,
				b = E.db.ElvUI_EltreumUI.cursors.cursorgcd.b,
				a = E.db.ElvUI_EltreumUI.cursors.cursorgcd.a,
			}
		end
		if E.db.ElvUI_EltreumUI.cursors.cursorcursor.classcolor then
			colorcursor = E:ClassColor(E.myclass, true)
		end
		if not E.db.ElvUI_EltreumUI.cursors.cursorcursor.classcolor then
			colorcursor = {
				r = E.db.ElvUI_EltreumUI.cursors.cursorcursor.r,
				g = E.db.ElvUI_EltreumUI.cursors.cursorcursor.g,
				b = E.db.ElvUI_EltreumUI.cursors.cursorcursor.b,
				a = E.db.ElvUI_EltreumUI.cursors.cursorcursor.a
			}
		end

		Defaults = {
			cast = {
				radius = E.db.ElvUI_EltreumUI.cursors.cursorcast.radius,
				sublayer = 1,
				thickness = E.db.ElvUI_EltreumUI.cursors.cursorcast.thickness,
				color = { colorcast.r, colorcast.g, colorcast.b, colorcast.a },
				texture = E.db.ElvUI_EltreumUI.cursors.cursor.ring,
			},
			gcd = {
				radius = E.db.ElvUI_EltreumUI.cursors.cursorgcd.radius,
				sublayer = 0,
				thickness = E.db.ElvUI_EltreumUI.cursors.cursorgcd.thickness,
				color = { colorgcd.r, colorgcd.g, colorgcd.b, colorgcd.a },
				texture = E.db.ElvUI_EltreumUI.cursors.cursor.ring,
			},
			cursor = {
				radius = E.db.ElvUI_EltreumUI.cursors.cursorcursor.radius,
				sublayer = 0,
				thickness = E.db.ElvUI_EltreumUI.cursors.cursorcursor.thickness,
				combat = E.db.ElvUI_EltreumUI.cursors.cursor.combat,
				color = { colorcursor.r, colorcursor.g, colorcursor.b, colorcursor.a },
				texture = E.db.ElvUI_EltreumUI.cursors.cursor.ring,
			},
		}
		QUAD_POINTS = {
			{ 'TOPLEFT', 'TOP' },
			{ 'TOPRIGHT', 'RIGHT' },
			{ 'BOTTOMRIGHT', 'BOTTOM' },
			{ 'BOTTOMLEFT', 'LEFT' },
		}
		QUAD_COORD_FULL = {
			{ 0,0, 0,1, 1,0, 1,1 },
			{ 0,1, 1,1, 0,0, 1,0 },
			{ 1,1, 1,0, 0,1, 0,0 },
			{ 1,0, 0,0, 1,1, 0,1 },
		}
		QUAD_COORD_FUNC = {
			function(t, r, x1, x2, y1, y2) -- Quadrant1: TOPRIGHT
				t:SetTexCoord(x1,1-y2, x1,1-y1, x2,1-y2, x2,1-y1)
				t:SetSize(x2*r, (1-y1)*r)
			end,
			function(t, r, x1, x2, y1, y2) -- Quadrant2: BOTTOMRIGHT
				t:SetTexCoord(x1,1-y1, x2,1-y1, x1,1-y2, x2,1-y2)
				t:SetSize((1-y1)*r, x2*r)
			end,
			function(t, r, x1, x2, y1, y2) -- Quadrant3: BOTTOMLEFT
				t:SetTexCoord(x2,1-y1, x2,1-y2, x1,1-y1, x1,1-y2)
				t:SetSize(x2*r, (1-y1)*r)
			end,
			function(t, r, x1, x2, y1, y2) -- Quadrant4: TOPLEFT
				t:SetTexCoord(x2,1-y2, x1,1-y2, x2,1-y1, x1,1-y1)
				t:SetSize((1-y1)*r, x2*r)
			end,
		}

		-- Root Frame
		--throttling here makes the frame not sync up, idk if i can make it sync with a throttle
		rootFrame:SetSize(8,8)
		if rootFrame:IsShown() then
			rootFrame:SetScript("OnUpdate", function(self)
				--print("cursor spam "..math.random(1,99))
				local x, y = GetCursorPosition()
				local scaleDivisor = UIParent:GetEffectiveScale()
				self:ClearAllPoints()
				self:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", (x / scaleDivisor) + E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsetx , (y / scaleDivisor) + E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsety )
			end )
		end

		local ringsVisible = {}
		local function RingSetShown(self, visible)
			if visible then
				if not next(ringsVisible) then
					rootFrame:Show()
					rootFrame:SetScript("OnUpdate", function(self)
						--print("cursor spam "..math.random(1,99))
						local x, y = GetCursorPosition()
						local scaleDivisor = UIParent:GetEffectiveScale()
						self:ClearAllPoints()
						self:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", (x / scaleDivisor) + E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsetx , (y / scaleDivisor) + E.db.ElvUI_EltreumUI.cursors.cursor.cooldownoffsety )
					end )
				end
				ringsVisible[self] = true
				self:Show()
			else
				ringsVisible[self] = nil
				if not next(ringsVisible) then
					rootFrame:Hide()
					rootFrame:SetScript("OnUpdate", nil)
				end
				self:Hide()
			end
		end
		-- Shared functions
		local function OnEvent(self,event,...)
			self[event](self,event,...)
		end
		local function Start(self, d, m)
			local textures = self.textures
			local quad = min( floor( 4 * (self.reverse and m - d or d) / m ) + 1, 4)
			for i=1,4 do
				local tex = textures[i]
				if i>quad then
					tex:SetTexCoord(0,0,1,1)
					tex:Hide()
				else
					tex:SetTexCoord(unpack(QUAD_COORD_FULL[i]))
					tex:SetSize(self.radius, self.radius)
					tex:Show()
				end
			end
			self.quad = quad
			self.dur = max(d,0)
			self.max = m
			RingSetShown(self, true)
		end
		local function Update(self, elapsed)
			local dur
			if self.dur == nil then
				self.dur = 0
			end
			dur = self.dur + elapsed
			if dur == nil then
				dur = 0
			end
			if self.max == nil then
				self.max = 0
			end
			if dur >= self.max then
				RingSetShown(self,false)
				return
			end
			self.dur = dur
			local rev = self.reverse
			local maxdur = self.max
			local radius = self.radius
			local angle = 360 * ( rev and maxdur-dur or dur ) / maxdur
			local qangle = angle % 90
			local quad = floor(angle / 90) + 1
			local tex = self.textures[quad]
			local pquad = self.quad
			if quad~=pquad then
				if pquad>0 and pquad<5 then
					local ptex = self.textures[pquad]
					if rev then
						ptex:Hide()
					else
						ptex:SetTexCoord(unpack(QUAD_COORD_FULL[pquad]))
						ptex:SetSize(radius, radius)
					end
				end
				tex:Show()
				self.quad = quad
			end

			if qangle > 0 then
				local f = qangle <= 45 and self.factor or 1
				QUAD_COORD_FUNC[quad]( tex, radius, 0, sin(qangle)*f, cos(qangle)*f, 1 )
			end
		end
		local function Setup(frame)
			local cfg = frame.db
			local radius = cfg.radius
			local r,g,b,a = unpack(cfg.color)
			frame:SetScale(1)
			frame:SetAlpha(a or 1)
			frame:SetFrameStrata( cfg.background and "BACKGROUND" or "TOOLTIP" )
			frame:ClearAllPoints()
			frame:SetPoint('CENTER', rootFrame, 'CENTER', 0, 0)
			frame:SetSize(radius*2, radius*2)
			frame.textures = frame.textures or {}
			local hide = not frame.IsCursor
			for i=1,4 do
				local tex = frame.textures[i] or frame:CreateTexture(nil, "OVERLAY")
				tex:ClearAllPoints()
				tex:SetDrawLayer("OVERLAY", cfg.sublayer or 0)
				tex:SetTexture(cfg.texture)

				--set gradient on casts
				if E.db.ElvUI_EltreumUI.cursors.cursorcast.gradient then
					if frame:GetName() == 'EltruismCursorCast' then --would likely be better to rewrite to use a mask instead of coords since that would also end up with better clipping, but would need a rework
						tex:SetVertexColor(1, 1, 1, a)
						if i == 1 then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
								tex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, false))
							else
								tex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, false, false))
							end
						elseif i == 2 then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
								tex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, false, false))
							else
								tex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, false, false))
							end
						elseif i == 3 then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
								tex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, true, false))
							else
								tex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, true, false))
							end
						elseif i == 4 then
							if E.db.ElvUI_EltreumUI.unitframes.gradientmode.customcolor or E.db.ElvUI_EltreumUI.unitframes.gradientmode.npcustomcolor then
								tex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColorsCustom(E.myclass, true, false))
							else
								tex:SetGradient(E.db.ElvUI_EltreumUI.unitframes.gradientmode.orientation, ElvUI_EltreumUI:GradientColors(E.myclass, true, false))
							end
						end
						--local mask = frame:CreateMaskTexture()
						--mask:SetTexture([[Interface\AddOns\ElvUI_EltreumUI\Media\Textures\square_mask]])
						--mask:SetAllPoints(tex)
						--tex:AddMaskTexture(mask)
					else
						tex:SetVertexColor(r, g, b, a)
					end
				else
					tex:SetVertexColor(r, g, b, a)
				end

				tex:SetTexCoord(unpack(QUAD_COORD_FULL[i]))
				tex:SetSize(radius, radius)
				tex:SetPoint(QUAD_POINTS[i][1], frame, QUAD_POINTS[i][2])
				if hide then tex:Hide() end
				frame.textures[i] = tex
			end
			frame.quad = 0
			frame.radius = radius
			frame.factor = (radius-cfg.thickness)/radius
			frame.reverse = cfg.reverse
			if frame.IsCursor then
				if cfg.combat then
					frame:RegisterEvent('PLAYER_REGEN_ENABLED')
					frame:RegisterEvent('PLAYER_REGEN_DISABLED')
					frame:SetScript("OnEvent", function(self, event) RingSetShown(self,event=='PLAYER_REGEN_DISABLED') end)
					RingSetShown( frame, InCombatLockdown() )
				else
					frame:RegisterEvent('PLAYER_ENTERING_WORLD')
					frame:SetScript("OnEvent", function(self, event) RingSetShown(self,event=='PLAYER_ENTERING_WORLD') end)
					RingSetShown( frame, true )
				end
			else
				frame:SetScript("OnEvent", OnEvent or nil)
				frame:SetScript("OnUpdate", Update)
				RingSetShown( frame, false )
			end
			return frame
		end

		-- Casting/Channeling Ring
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_DELAYED", "player")
		function Cast:UNIT_SPELLCAST_START(_, unit)
			if unit and unit ~= 'player' then
				return
			elseif unit and unit == 'player' then
				local name, _, _, start, finish, _, castID = UnitCastingInfo("player")
				if name then
					self.castID = castID
					Start(self, GetTime() - start * 0.001, (finish - start) * 0.001 )
				else
					RingSetShown( self, false )
				end
			end
		end

		Cast.UNIT_SPELLCAST_DELAYED = Cast.UNIT_SPELLCAST_START
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", "player")
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
		if E.Retail then
			Cast:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_STOP", "player")
		end
		function Cast:UNIT_SPELLCAST_STOP(_, unit, castID)
			if unit and unit ~= 'player' then
				return
			elseif unit and unit == 'player' then
				if castID == self.castID then
					RingSetShown( self, false )
				end
			end
		end

		Cast.UNIT_SPELLCAST_FAILED = Cast.UNIT_SPELLCAST_STOP
		Cast.UNIT_SPELLCAST_INTERRUPTED = Cast.UNIT_SPELLCAST_STOP
		Cast.UNIT_SPELLCAST_CHANNEL_STOP = Cast.UNIT_SPELLCAST_STOP
		Cast.UNIT_SPELLCAST_EMPOWER_STOP = Cast.UNIT_SPELLCAST_STOP
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "player")
		if E.Retail then
			Cast:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_START", "player")
			Cast:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_UPDATE", "player")
		end
		function Cast:UNIT_SPELLCAST_CHANNEL_START(_, unit)
			if unit and unit ~= 'player' then
				return
			elseif unit and unit == 'player' then
				local name, _, _, start, finish, _, _, _ ,_ , numEmpowerStages = UnitChannelInfo("player")
				if name then
					self.castID = nil
					if E.Retail and numEmpowerStages and numEmpowerStages > 0 then
						finish = finish + _G.GetUnitEmpowerHoldAtMaxTime("player")
					end
					Start(self, GetTime() - start * 0.001, (finish - start) * 0.001 )
				else
					RingSetShown( self, false )
				end
			end
		end
		Cast.UNIT_SPELLCAST_CHANNEL_UPDATE = Cast.UNIT_SPELLCAST_CHANNEL_START
		Cast.UNIT_SPELLCAST_EMPOWER_START = Cast.UNIT_SPELLCAST_CHANNEL_START
		Cast.UNIT_SPELLCAST_EMPOWER_UPDATE = Cast.UNIT_SPELLCAST_CHANNEL_START

		-- GCD Ring
		GCD:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
		GCD:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
		function GCD:UNIT_SPELLCAST_START(_, unit, _, spellID)
			if unit and unit ~= 'player' then
				return
			elseif unit and unit == 'player' then
				if E.Retail then
					local cooldowntable = GetSpellCooldown(61304)
					if cooldowntable.duration > 0 and (E.Retail or cooldowntable.duration <= 1.51) then
						Start(self, GetTime() - cooldowntable.startTime, cooldowntable.duration )
					end
				else
					local start, duration = GetSpellCooldown(E.Retail and 61304 or spellID)
					if duration > 0 and (E.Retail or duration <= 1.51) then
						Start(self, GetTime() - start, duration )
					end
				end
			end
		end
		GCD.UNIT_SPELLCAST_SUCCEEDED = GCD.UNIT_SPELLCAST_START
		GCD:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
		GCD:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")
		function GCD:UNIT_SPELLCAST_STOP(_, unit)
			if unit and unit ~= 'player' then
				return
			elseif unit and unit == 'player' then
				RingSetShown( self, false )
			end
		end
		GCD.UNIT_SPELLCAST_INTERRUPTED = GCD.UNIT_SPELLCAST_STOP

		-- Cursor Ring
		Cursor.IsCursor = true
		Cursor:Hide()

		--attempt to hide at the start to prevent onupdate
		rootFrame:Hide()

		-- Run
		--this is kinda of a roundabout way of getting this to working here
		cursorframe:RegisterEvent("PLAYER_STARTED_MOVING")
		cursorframe:RegisterEvent("FIRST_FRAME_RENDERED")
		cursorframe:RegisterEvent("PLAYER_LOGIN")
		cursorframe:SetScript("OnEvent", function()
			if InCombatLockdown() then UIErrorsFrame:AddMessage(ERR_NOT_IN_COMBAT, 1.0, 0.2, 0.2, 1.0) end
			if not InCombatLockdown() then
				--print('cursorframe loaded')
				collectgarbage()
				ResetCPUUsage()
				cursorframe:UnregisterAllEvents()
				cursorframe:SetScript("OnEvent", nil)
				Cursor.db = Defaults.cursor
				Cast.db = Defaults.cast
				GCD.db = Defaults.gcd
				Setup(Cursor)
				Setup(Cast)
				Setup(GCD)
			end
		end)
	end
end
