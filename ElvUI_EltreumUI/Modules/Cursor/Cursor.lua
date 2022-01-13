local _G = _G
local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
--local pairs = _G.pairs
local SetCVar = _G.SetCVar
local UIParent = _G.UIParent
local GetTime = _G.GetTime
local UnitCastingInfo = _G.UnitCastingInfo or _G.CastingInfo
local UnitChannelInfo = _G.UnitChannelInfo or _G.ChannelInfo
local GetSpellCooldown = _G.GetSpellCooldown
local GetCursorPosition = _G.GetCursorPosition
local next, unpack, floor, cos, sin, max, min = _G.next, _G.unpack, _G.floor, _G.cos, _G.sin, _G.max, _G.min
local isRetail = _G.select(4, _G.GetBuildInfo())>=30000
--create frame
local cursorframe = _G.CreateFrame("Frame", "EltruismCursor")

function ElvUI_EltreumUI:CursorInit()
	ElvUI_EltreumUI:CastCursor()
	ElvUI_EltreumUI:CurrentTypeofCursor()
	if E.db.ElvUI_EltreumUI.cursor.cooldown then
		ElvUI_EltreumUI:CooldownInitialize() --starts cursor module with cooldowns
		ElvUI_EltreumUI:CooldownEnable() --starts cursor module with cooldowns
	end
end

local rootFrame = _G.CreateFrame("Frame", "EltruismCursorRoot", UIParent)
local Cast = _G.CreateFrame("Frame", "EltruismCursorCast", rootFrame)
local GCD = _G.CreateFrame("Frame", "EltruismCursorGCD", rootFrame)
local Cursor = _G.CreateFrame("Frame", "EltruismCursorCursor", rootFrame)

--Detect the current cursor for options
function ElvUI_EltreumUI:CurrentTypeofCursor()
	local currentring = E.db.ElvUI_EltreumUI.cursor.ring
	if currentring:match("ring1") then
		currentring = '|cff82B4ffType 1|r'
	elseif currentring:match("ring2") then
		currentring = '|cff82B4ffType 2|r'
	elseif currentring:match("ring3") then
		currentring = '|cff82B4ffType 3|r'
	elseif currentring:match("ring4") then
		currentring = '|cff82B4ffType 4|r'
	elseif currentring:match("ring5") then
		currentring = '|cff82B4ffType 5|r'
	elseif currentring:match("ring6") then
		currentring = '|cff82B4ffType 6|r'
	elseif currentring:match("ring7") then
		currentring = '|cff82B4ffType 7|r'
	elseif currentring:match("ring8") then
		currentring = '|cff82B4ffType 8|r'
	elseif currentring:match("ring9") then
		currentring = '|cff82B4ffType 9|r'
	elseif currentring:match("ring10") then
		currentring = '|cff82B4ffType 10|r'
	end
	return currentring
end

-- Change cursor size based on user input
function ElvUI_EltreumUI:CursorSize(value)
	if value == '-1' then
		SetCVar("cursorSizePreferred", -1)
		E.db.ElvUI_EltreumUI.cursor.size = '-1'
	elseif value == '0' then
		SetCVar("cursorSizePreferred", 0)
		E.db.ElvUI_EltreumUI.cursor.size = '0'
	elseif value == '1' then
		SetCVar("cursorSizePreferred", 1)
		E.db.ElvUI_EltreumUI.cursor.size = '1'
	elseif value == '2' then
		SetCVar("cursorSizePreferred", 2)
		E.db.ElvUI_EltreumUI.cursor.size = '2'
	elseif value == '3' then
		SetCVar("cursorSizePreferred", 3)
		E.db.ElvUI_EltreumUI.cursor.size = '3'
	elseif value == '4' then
		SetCVar("cursorSizePreferred", 4)
		E.db.ElvUI_EltreumUI.cursor.size = '4'
	end
end

--This module is a direct merge of CastCursor by michaelsp and as such is available under GNU GPL v3 like the original
--all credits of this module go to michaelsp
function ElvUI_EltreumUI:CastCursor()
	if E.db.ElvUI_EltreumUI.cursor.enable then

		if E.db.ElvUI_EltreumUI.cursor.fixlag then
			--SetCVar("gxCursor", 0)
			SetCVar("HardwareCursor", 0) --fix the cursor lag
		end

		local ring = E.db.ElvUI_EltreumUI.cursor.ring
		local castradius = E.db.ElvUI_EltreumUI.cursorcast.radius
		local castthickness = E.db.ElvUI_EltreumUI.cursorcast.thickness
		local gcdradius = E.db.ElvUI_EltreumUI.cursorgcd.radius
		local gcdthickness = E.db.ElvUI_EltreumUI.cursorgcd.thickness
		local cursorradius = E.db.ElvUI_EltreumUI.cursorcursor.radius
		local cursorthickness = E.db.ElvUI_EltreumUI.cursorcursor.thickness
		local cursorcombattoggle = E.db.ElvUI_EltreumUI.cursor.combat
		local colorcast
		local colorgcd
		local colorcursor

		if E.db.ElvUI_EltreumUI.cursorcast.classcolor then
			colorcast = E:ClassColor(E.myclass, true)
		end
		if not E.db.ElvUI_EltreumUI.cursorcast.classcolor then
			colorcast = {
				r = E.db.ElvUI_EltreumUI.cursorcast.r,
				g = E.db.ElvUI_EltreumUI.cursorcast.g,
				b = E.db.ElvUI_EltreumUI.cursorcast.b
			}
		end
		if E.db.ElvUI_EltreumUI.cursorgcd.classcolor then
			colorgcd = E:ClassColor(E.myclass, true)
		end
		if not E.db.ElvUI_EltreumUI.cursorgcd.classcolor then
			colorgcd = {
				r = E.db.ElvUI_EltreumUI.cursorgcd.r,
				g = E.db.ElvUI_EltreumUI.cursorgcd.g,
				b = E.db.ElvUI_EltreumUI.cursorgcd.b
			}
		end
		if E.db.ElvUI_EltreumUI.cursorcursor.classcolor then
			colorcursor = E:ClassColor(E.myclass, true)
		end
		if not E.db.ElvUI_EltreumUI.cursorcursor.classcolor then
			colorcursor = {
				r = E.db.ElvUI_EltreumUI.cursorcursor.r,
				g = E.db.ElvUI_EltreumUI.cursorcursor.g,
				b = E.db.ElvUI_EltreumUI.cursorcursor.b
			}
		end

		local Defaults = {
			cast = {
				radius = castradius,
				sublayer = 1,
				thickness = castthickness,
				color = { colorcast.r, colorcast.g, colorcast.b },
				texture = ring,
			},
			gcd = {
				radius = gcdradius,
				sublayer = 0,
				thickness = gcdthickness,
				color = { colorgcd.r, colorgcd.g, colorgcd.b },
				texture = ring,
			},
			cursor = {
				radius = cursorradius,
				sublayer = 0,
				thickness = cursorthickness,
				combat = cursorcombattoggle,
				color = { colorcursor.r, colorcursor.g, colorcursor.b },
				texture = ring,
			},
		}
		local QUAD_POINTS = {
			{ 'TOPLEFT',	 'TOP'	},
			{ 'TOPRIGHT',	'RIGHT'  },
			{ 'BOTTOMRIGHT', 'BOTTOM' },
			{ 'BOTTOMLEFT',  'LEFT'   },
		}
		local QUAD_COORD_FULL = {
			{ 0,0, 0,1, 1,0, 1,1 },
			{ 0,1, 1,1, 0,0, 1,0 },
			{ 1,1, 1,0, 0,1, 0,0 },
			{ 1,0, 0,0, 1,1, 0,1 },
		}
		local QUAD_COORD_FUNC = {
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
		--[[
			local function CopyDefaults(src, dst)
				if _G.type(dst)~="table" then dst = {} end
				for k,v in pairs(src) do
					if _G.type(v)=="table" then
						dst[k] = CopyDefaults(v,dst[k])
					elseif dst[k]==nil then
						dst[k] = v
					end
				end
				return dst
			end
		]]

		-- Root Frame
		--throttling here makes the frame not sync up, idk if i can make it sync with a throttle
		rootFrame:SetSize(8,8)
		if rootFrame:IsShown() then
			rootFrame:SetScript("OnUpdate", function(self)
				print("cursor spam "..math.random(1,99))
				local x, y = GetCursorPosition()
				local scaleDivisor = UIParent:GetEffectiveScale()
				self:ClearAllPoints()
				self:SetPoint( "CENTER", UIParent, "BOTTOMLEFT", x / scaleDivisor , y / scaleDivisor )
			end )
		else
			rootFrame:SetScript("OnUpdate", nil)
		end

		local ringsVisible = {}
		local function RingSetShown(self, visible)
			if visible then
				if not next(ringsVisible) then
					rootFrame:Show()
				end
				ringsVisible[self] = true
				self:Show()
			else
				ringsVisible[self] = nil
				if not next(ringsVisible) then
					rootFrame:Hide()
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
			local quad = min( floor( 4 * (self.reverse and m-d or d)/m ) + 1, 4)
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
			self.dur  = max(d,0)
			self.max  = m
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
			local rev	= self.reverse
			local maxdur = self.max
			local radius = self.radius
			local angle  = 360 * ( rev and maxdur-dur or dur ) / maxdur
			local qangle = angle % 90
			local quad   = floor(angle/90) + 1
			local tex	= self.textures[quad]
			local pquad  = self.quad
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

			if qangle>0 then
				local f = qangle<=45 and self.factor or 1
				QUAD_COORD_FUNC[quad]( tex, radius, 0, sin(qangle)*f, cos(qangle)*f, 1 )
			end
		end
		local function Setup(frame)
			local cfg	 = frame.db
			local radius  = cfg.radius
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
				tex:SetVertexColor(r, g, b)
				tex:SetTexCoord(unpack(QUAD_COORD_FULL[i]))
				tex:SetSize(radius, radius)
				tex:SetPoint(QUAD_POINTS[i][1], frame, QUAD_POINTS[i][2])
				if hide then tex:Hide() end
				frame.textures[i] = tex
			end
			frame.quad   = 0
			frame.radius = radius
			frame.factor = (radius-cfg.thickness)/radius
			frame.reverse = cfg.reverse
			if frame.IsCursor then
				if cfg.combat then
					frame:RegisterEvent('PLAYER_REGEN_ENABLED')
					frame:RegisterEvent('PLAYER_REGEN_DISABLED')
					frame:SetScript("OnEvent", function(self, event) RingSetShown(self,event=='PLAYER_REGEN_DISABLED') end)
					RingSetShown( frame, _G.InCombatLockdown() )
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
		function Cast:UNIT_SPELLCAST_START(event, unit)
			if unit and unit ~= 'player' then
				return
			elseif unit and unit == 'player' then
				local name, _, _, start, finish, _, castID = UnitCastingInfo("player")
				if name then
					self.castID = castID
					Start(self, GetTime() - start/1000, (finish - start) / 1000 )
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
		function Cast:UNIT_SPELLCAST_STOP(event, unit, castID)
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
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
		Cast:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "player")
		function Cast:UNIT_SPELLCAST_CHANNEL_START(event, unit)
			if unit and unit ~= 'player' then
				return
			elseif unit and unit == 'player' then
				local name, _, _, start, finish = UnitChannelInfo("player")
				if name then
					self.castID = nil
					Start(self, GetTime() - start/1000, (finish - start) / 1000 )
				else
					RingSetShown( self, false )
				end
			end
		end
		Cast.UNIT_SPELLCAST_CHANNEL_UPDATE = Cast.UNIT_SPELLCAST_CHANNEL_START

		-- GCD Ring
		GCD:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
		GCD:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
		function GCD:UNIT_SPELLCAST_START(event, unit, _, spellID)
		--function GCD:UNIT_SPELLCAST_START(event, unit, guid, spellID)
			if unit and unit ~= 'player' then
				return
			elseif unit and unit == 'player' then
				local start, duration = GetSpellCooldown( isRetail and 61304 or spellID )
				if duration>0 and (isRetail or duration<=1.51) then
					Start(self, GetTime() - start, duration )
				end
			end
		end
		GCD.UNIT_SPELLCAST_SUCCEEDED = GCD.UNIT_SPELLCAST_START
		GCD:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
		GCD:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")
		--function GCD:UNIT_SPELLCAST_STOP(event, unit, castID)
		function GCD:UNIT_SPELLCAST_STOP(event, unit)
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
		-- Run
		--this is kinda of a roundabout way of getting this to working here
		cursorframe:RegisterEvent("PLAYER_STARTED_MOVING")
		cursorframe:SetScript("OnEvent", function(self, event, _)
		--cursorframe:SetScript("OnEvent", function(self, event, name)
			--EltreumCursorDB = CopyDefaults(Defaults, EltreumCursorDB)
			local EltreumCursorDB = Defaults
			--print('cursorframe loaded')
			self:UnregisterEvent("PLAYER_STARTED_MOVING")
			self:SetScript("OnEvent", nil)
			self:SetPoint("Center", UIParent, "Center")
			self:Hide()
			self.db = EltreumCursorDB
			Cursor.db = self.db.cursor
			Cast.db = self.db.cast
			GCD.db = self.db.gcd
			self.Start = Start
			self.Update = Update
			self.Setup = Setup
			self.Defaults = Defaults
			self.rings = { cast = Cast, gcd = GCD, cursor = Cursor }
			Setup(Cursor)
			Setup(Cast)
			Setup(GCD)
		end )
	end
end
