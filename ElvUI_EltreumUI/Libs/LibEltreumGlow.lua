--[[
This library contains work of Hendrick "nevcairiel" Leppkes
https://www.wowace.com/projects/libbuttonglow-1-0
]]
--LibEltreumGlow is a fork of LibCustomGlow, MIT license 2022 Benjamin Staneck, contains work by Dooez (https://github.com/Dooez/LibCustomGlow)

-- luacheck: globals _G LibStub WOW_PROJECT_ID WOW_PROJECT_MAINLINE UIParent CreateVector2D CreateFrame CreateTexturePool CreateFramePool TextureUtil issecretvalue Masque issecurevariable CreateColor
local _G = _G
local MAJOR_VERSION = "LibEltreumGlow"
local MINOR_VERSION = 1
if not LibStub then _G.error(MAJOR_VERSION .. " requires LibStub.") end

local lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end
local Masque = LibStub("Masque", true)

local isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
local issecretvalue = _G.issecretvalue
local textureList = {
	empty = [[Interface\AdventureMap\BrokenIsles\AM_29]],
	white = [[Interface\BUTTONS\WHITE8X8]],
	shine = [[Interface\ItemSocketingFrame\UI-ItemSockets]],
}

local shineCoords = { 0.3984375, 0.4453125, 0.40234375, 0.44921875 }
if isRetail then
	textureList.shine = [[Interface\Artifacts\Artifacts]]
	shineCoords = { 0.8115234375, 0.9169921875, 0.8798828125, 0.9853515625 }
end

function lib.RegisterTextures(texture, id)
	textureList[id] = texture
end

lib.glowList = {}
lib.startList = {}
lib.stopList = {}

local pairs = _G.pairs
local type = _G.type
local tremove = _G.tremove
local tinsert = _G.tinsert
local wipe = _G.wipe or _G.table.wipe
local setmetatable = _G.setmetatable

local sqrt = _G.sqrt
local floor = _G.floor
local min = _G.min
local sin = _G.math.sin
local mathmax = _G.math.max

local CreateColor = _G.CreateColor
local AnimateTexCoords = (TextureUtil and TextureUtil.AnimateTexCoords) or _G.AnimateTexCoords

local function GetColorRGBA(c)
	if type(c) == "table" then
		if c.GetRGBA then
			return c:GetRGBA()
		end
		return c[1] or c.r or 1, c[2] or c.g or 1, c[3] or c.b or 1, c[4] or c.a or 1
	end
	return 1, 1, 1, 1
end

local function GetColorAlpha(c)
	if not c then return 1 end
	if type(c) == "table" and c.GetRGBA then
		local _, _, _, a = c:GetRGBA()
		return a or 1
	elseif type(c) == "table" then
		return c[4] or c.a or 1
	end
	return 1
end

local function noZero(num)
	if not num or num == 0 then
		return 0.001
	else
		return num
	end
end

local rotationCenter = CreateVector2D and CreateVector2D(0.5, 0.5)

local function SetTextureRotation(tex, radians, cx, cy)
	if not tex or not tex.SetRotation then return end
	if cx and cy and rotationCenter then
		rotationCenter:SetXY(cx, cy)
		tex:SetRotation(radians, rotationCenter)
	elseif cx and cy then
		tex:SetRotation(radians, cx, cy)
	else
		tex:SetRotation(radians)
	end
end

local GlowParent = UIParent

local GlowMaskPool = {
	createFunc = function(self)
		return self.parent:CreateMaskTexture()
	end,
	resetFunc = function(_, mask)
		mask:Hide()
		mask:ClearAllPoints()
	end,
	AddObject = function(self, object)
		local dummy = true
		self.activeObjects[object] = dummy
		self.activeObjectCount = self.activeObjectCount + 1
	end,
	ReclaimObject = function(self, object)
		tinsert(self.inactiveObjects, object)
		self.activeObjects[object] = nil
		self.activeObjectCount = self.activeObjectCount - 1
	end,
	Release = function(self, object)
		local active = self.activeObjects[object] ~= nil
		if active then
			self:resetFunc(object)
			self:ReclaimObject(object)
		end
		return active
	end,
	Acquire = function(self)
		local object = tremove(self.inactiveObjects)
		local new = object == nil
		if new then
			object = self:createFunc()
			self:resetFunc(object, new)
		end
		self:AddObject(object)
		return object, new
	end,
	Init = function(self, parent)
		self.activeObjects = {}
		self.inactiveObjects = {}
		self.activeObjectCount = 0
		self.parent = parent
	end,
	GetNumActive = function(self)
		return self.activeObjectCount
	end,
	EnumerateActive = function(self)
		return pairs(self.activeObjects)
	end,
	ReleaseAll = function(self)
		for object in pairs(self.activeObjects) do
			self:Release(object)
		end
	end,
}
GlowMaskPool:Init(GlowParent)
lib.GlowMaskPool = GlowMaskPool

local TexPoolResetter = function(_, tex)
	if tex.GetNumMaskTextures then
		local maskNum = tex:GetNumMaskTextures()
		for i = maskNum, 1, -1 do
			local mask = tex:GetMaskTexture(i)
			if mask then
				tex:RemoveMaskTexture(mask)
			end
		end
	end
	tex:Hide()
	tex:ClearAllPoints()
	if tex.SetRotation then
		tex:SetRotation(0)
	end
	tex:SetVertexColor(1, 1, 1, 1)
	tex:SetAlpha(1)
	if tex.SetDesaturated then
		tex:SetDesaturated(false)
	end
	tex:SetBlendMode("BLEND")
end
local GlowTexPool = CreateTexturePool(GlowParent, "ARTWORK", 7, nil, TexPoolResetter)
lib.GlowTexPool = GlowTexPool

local function IsPoolObjectActive(pool, obj)
	if not pool or not obj then return false end
	if pool.HasActiveObject then
		return pool:HasActiveObject(obj)
	elseif pool.activeObjects then
		return pool.activeObjects[obj] ~= nil
	end
	return false
end

local function SafeReleaseTexture(pool, tex)
	if not tex then return end
	if IsPoolObjectActive(pool, tex) then
		pool:Release(tex)
	else
		tex:Hide()
	end
end

local function SafeReleaseFrame(pool, frame)
	if not frame then return end
	if IsPoolObjectActive(pool, frame) then
		pool:Release(frame)
	else
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetScript("OnUpdate", nil)
		frame:SetScript("OnHide", nil)
	end
end

local function SafeReleaseMask(pool, mask)
	if not mask then return end
	if IsPoolObjectActive(pool, mask) then
		pool:Release(mask)
	else
		mask:Hide()
	end
end

local FramePoolResetter = function(_, frame)
	frame:SetScript("OnUpdate", nil)
	frame:SetScript("OnHide", nil)
	local parent = frame:GetParent()
	if parent and frame.name and parent[frame.name] then
		parent[frame.name] = nil
	end
	if frame.textures then
		for _, texture in pairs(frame.textures) do
			SafeReleaseTexture(GlowTexPool, texture)
		end
	end
	if frame.bg then
		SafeReleaseTexture(GlowTexPool, frame.bg)
		frame.bg = nil
	end
	if frame.masks then
		for _, mask in pairs(frame.masks) do
			SafeReleaseMask(GlowMaskPool, mask)
		end
		frame.masks = nil
	end
	if frame.SetClipsChildren then
		frame:SetClipsChildren(false)
	end
	-- reuse the existing tables instead of allocating new ones on every release
	if frame.textures then wipe(frame.textures) else frame.textures = {} end
	if frame.inf then
		local tail = frame.inf.tail
		local flash = frame.inf.flash
		local add = frame.inf.add
		local addVisible = frame.inf.addVisible
		wipe(frame.inf)
		if tail then
			if tail.list then wipe(tail.list) end
			wipe(tail)
			tail.list = tail.list or {}
			frame.inf.tail = tail
		end
		if flash then
			if flash.list then wipe(flash.list) end
			wipe(flash)
			flash.list = flash.list or {}
			frame.inf.flash = flash
		end
		if add then wipe(add); frame.inf.add = add end
		if addVisible then wipe(addVisible); frame.inf.addVisible = addVisible end
	else
		frame.inf = {}
	end
	if frame.info then wipe(frame.info) else frame.info = {} end
	if type(frame.timer) == "table" then
		wipe(frame.timer)
	else
		frame.timer = nil
	end
	frame.name = nil
	frame:SetAlpha(1)
	frame:Hide()
	frame:ClearAllPoints()
end
local GlowFramePool = CreateFramePool("Frame", GlowParent, nil, FramePoolResetter)
lib.GlowFramePool = GlowFramePool

local function GlowFrame_OnHide(self)
	if self.inf and self.inf.finish then
		SafeReleaseFrame(GlowFramePool, self)
	end
end

local function addFrameAndTex(r, color, name, key, N, xOffset, yOffset, texture, texCoord, desaturated, frameLevel)
	key = key or ""
	frameLevel = frameLevel or 8
	xOffset = xOffset or 0
	yOffset = yOffset or 0
	local update = true

	local existing = r[name .. key]
	local isValidPoolFrame = existing and IsPoolObjectActive(GlowFramePool, existing)

	if not existing or not isValidPoolFrame then
		if existing then
			existing:Hide()
		end
		r[name .. key] = GlowFramePool:Acquire()
		r[name .. key]:SetParent(r)
		r[name .. key].name = name .. key
		update = false
	end
	local f = r[name .. key]
	f:SetFrameLevel(r:GetFrameLevel() + frameLevel)
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", r, "TOPLEFT", -xOffset + 0.05, yOffset + 0.05)
	f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", xOffset, -yOffset + 0.05)
	f:SetScript("OnHide", GlowFrame_OnHide)
	f:Show()

	if not f.textures then
		f.textures = {}
	end

	local rCol, gCol, bCol, aCol = GetColorRGBA(color)

	for i = 1, N do
		if not f.textures[i] then
			f.textures[i] = GlowTexPool:Acquire()
			f.textures[i]:SetTexture(texture)
			f.textures[i]:SetTexCoord(texCoord[1], texCoord[2], texCoord[3], texCoord[4])
			f.textures[i]:SetDesaturated(desaturated)
			f.textures[i]:SetParent(f)
			f.textures[i]:SetDrawLayer("ARTWORK", 7)
			if not isRetail and name == "_AutoCastGlow" then
				f.textures[i]:SetBlendMode("ADD")
			end
		end
		f.textures[i]:SetVertexColor(rCol, gCol, bCol, aCol)
		f.textures[i]:Show()
	end
	while #f.textures > N do
		SafeReleaseTexture(GlowTexPool, f.textures[#f.textures])
		tremove(f.textures)
	end
	return update
end

local function RGBToHSV(r, g, b)
	local minVal = min(r, g, b)
	local maxVal = mathmax(r, g, b)
	local delta = maxVal - minVal
	local v = maxVal
	local h, s
	if maxVal ~= 0 then
		s = delta / maxVal
	else
		return 0, 0, 0
	end
	if delta == 0 then
		h = 0
	elseif r == maxVal then
		h = (g - b) / delta
	elseif g == maxVal then
		h = 2 + (b - r) / delta
	else
		h = 4 + (r - g) / delta
	end
	h = h * 60
	if h < 0 then h = h + 360 end
	return h, s, v
end

local function HSVToRGB(h, s, v)
	if s == 0 then return v, v, v end
	h = h / 60
	local i = floor(h)
	local f = h - i
	local p = v * (1 - s)
	if i == 0 then
		return v, v * (1 - s * (1 - f)), p
	elseif i == 1 then
		return v * (1 - s * f), v, p
	elseif i == 2 then
		return p, v, v * (1 - s * (1 - f))
	elseif i == 3 then
		return p, v * (1 - s * f), v
	elseif i == 4 then
		return v * (1 - s * (1 - f)), p, v
	else
		return v, p, v * (1 - s * f)
	end
end

local colorPool = {}
for i = 1, 64 do
	colorPool[i] = { 1, 1, 1, 1, r = 1, g = 1, b = 1, a = 1, h = 0, s = 0, v = 1, _cr = 1, _cg = 1, _cb = 1 }
end
local colorPoolIndex = 0

local function GetColorHSV(c, r, g, b)
	if type(c) == "table" and c.h and c._cr == r and c._cg == g and c._cb == b then
		return c.h, c.s, c.v
	end
	local h, s, v = RGBToHSV(r, g, b)
	if type(c) == "table" then
		c.h, c.s, c.v = h, s, v
		c._cr, c._cg, c._cb = r, g, b
	end
	return h, s, v
end

-- HSV transition, for a much prettier color transition in many cases
-- see http://www.wowinterface.com/forums/showthread.php?t=48236
local function GetHSVTransition(perc, c1, c2)
	local r1, g1, b1, a1 = GetColorRGBA(c1)
	local r2, g2, b2, a2 = GetColorRGBA(c2)

	local h1, s1, v1 = GetColorHSV(c1, r1, g1, b1)
	local h2, s2, v2 = GetColorHSV(c2, r2, g2, b2)

	colorPoolIndex = (colorPoolIndex % 64) + 1
	local col = colorPool[colorPoolIndex]

	if perc <= 0 then
		col[1] = r1; col[2] = g1; col[3] = b1; col[4] = a1
		col.r = r1; col.g = g1; col.b = b1; col.a = a1
		col.h = h1; col.s = s1; col.v = v1
		col._cr = r1; col._cg = g1; col._cb = b1
		return col
	elseif perc >= 1 then
		col[1] = r2; col[2] = g2; col[3] = b2; col[4] = a2
		col.r = r2; col.g = g2; col.b = b2; col.a = a2
		col.h = h2; col.s = s2; col.v = v2
		col._cr = r2; col._cg = g2; col._cb = b2
		return col
	end

	-- find the shortest arc through the color circle, then interpolate
	local diff = h2 - h1
	if diff < -180 then
		diff = diff + 360
	elseif diff > 180 then
		diff = diff - 360
	end

	local h3 = (h1 + perc * diff) % 360
	local s3 = s1 - (s1 - s2) * perc
	local v3 = v1 - (v1 - v2) * perc

	local r, g, b = HSVToRGB(h3, s3, v3)

	--interpolate alpha
	local a = a1 - (a1 - a2) * perc

	col[1] = r
	col[2] = g
	col[3] = b
	col[4] = a
	col.r = r
	col.g = g
	col.b = b
	col.a = a
	col.h = h3
	col.s = s3
	col.v = v3
	col._cr = r
	col._cg = g
	col._cb = b
	return col
end

local gradColor1 = CreateColor and CreateColor(1, 1, 1, 1) or { r = 1, g = 1, b = 1, a = 1 }
local gradColor2 = CreateColor and CreateColor(1, 1, 1, 1) or { r = 1, g = 1, b = 1, a = 1 }

local SetGradA
if gradColor1.SetRGBA then
	SetGradA = function(texture, direction, c1, c2)
		if not texture then return end
		local r1, g1, b1, a1 = GetColorRGBA(c1)
		local r2, g2, b2, a2 = GetColorRGBA(c2)
		gradColor1:SetRGBA(r1, g1, b1, a1)
		gradColor2:SetRGBA(r2, g2, b2, a2)
		texture:SetGradient(direction, gradColor1, gradColor2)
	end
else
	SetGradA = function(texture, direction, c1, c2)
		if not texture then return end
		local r1, g1, b1, a1 = GetColorRGBA(c1)
		local r2, g2, b2, a2 = GetColorRGBA(c2)
		if texture.SetGradient then
			gradColor1.r = r1
			gradColor1.g = g1
			gradColor1.b = b1
			gradColor1.a = a1
			gradColor2.r = r2
			gradColor2.g = g2
			gradColor2.b = b2
			gradColor2.a = a2
			texture:SetGradient(direction, gradColor1, gradColor2)
		elseif texture.SetGradientAlpha then
			texture:SetGradientAlpha(direction, r1, g1, b1, a1, r2, g2, b2, a2)
		end
	end
end

local function DeepCopy(original)
	local copy
	if type(original) == "table" then
		copy = {}
		for k, v in pairs(original) do
			copy[k] = DeepCopy(v)
		end
	else
		copy = original
	end
	return copy
end

--Return copy of options table with added missing elements from default--
local function AcquireOptions(options, default, internal)
	if not internal then
		options = DeepCopy(options) or {}
	else
		options = options or {}
	end
	for k, v in pairs(default) do
		if type(v) == "table" then
			options[k] = AcquireOptions(options[k], v, true)
		else
			if options[k] == nil then
				options[k] = v
			end
		end
	end
	return options
end

local GlowList = {}
lib.GetGlows = function()
	return DeepCopy(GlowList)
end

---- Border Internal Funcitons ----

local STATIC_WHITE = { 1, 1, 1, 1, r = 1, g = 1, b = 1, a = 1, h = 0, s = 0, v = 1, _cr = 1, _cg = 1, _cb = 1 }

local function BorderGradientCorners(inf, elapsed)
	local g = inf.gradient
	local gN = g and #g or 0
	if not g or gN == 0 then
		return STATIC_WHITE, STATIC_WHITE, STATIC_WHITE, STATIC_WHITE
	end
	if gN == 1 then
		return g[1], g[1], g[1], g[1]
	end

	local gProgress = inf.gProgress or 0
	gProgress = (gProgress + elapsed * (inf.gradientFrequency or 0.25)) % 1
	inf.gProgress = gProgress

	local cornerP = inf.cornerP
	if not cornerP then
		local totalSize = (inf.width or 0) + (inf.height or 0)
		cornerP = (totalSize > 0) and ((inf.width or 0) / totalSize / 2) or 0.25
		inf.cornerP = cornerP
	end

	local p1 = (gProgress + 0.001) % 1
	local p2 = (gProgress + cornerP) % 1
	local p3 = (gProgress + 0.5) % 1
	local p4 = (gProgress + 0.5 + cornerP) % 1

	local pos1 = (p1 * gN) % gN
	local i1 = (floor(pos1) % gN) + 1
	local c1 = GetHSVTransition(pos1 % 1, g[i1], g[(i1 % gN) + 1])

	local pos2 = (p2 * gN) % gN
	local i2 = (floor(pos2) % gN) + 1
	local c2 = GetHSVTransition(pos2 % 1, g[i2], g[(i2 % gN) + 1])

	local pos3 = (p3 * gN) % gN
	local i3 = (floor(pos3) % gN) + 1
	local c3 = GetHSVTransition(pos3 % 1, g[i3], g[(i3 % gN) + 1])

	local pos4 = (p4 * gN) % gN
	local i4 = (floor(pos4) % gN) + 1
	local c4 = GetHSVTransition(pos4 % 1, g[i4], g[(i4 % gN) + 1])
	return c1, c2, c3, c4
end

local function BorderSet4LinesCenter(f, update)
	local inf = f.inf
	local tails = inf.tail.list
	if not update then
		for _, v in pairs(tails) do
			v:ClearAllPoints()
		end
		if inf.tail.mirror then
			tails[1]:SetPoint("TOP", f, "TOP")
			tails[2]:SetPoint("RIGHT", f, "RIGHT")
			tails[3]:SetPoint("BOTTOM", f, "BOTTOM")
			tails[4]:SetPoint("LEFT", f, "LEFT")

			tails[5]:Hide()
			tails[6]:Hide()
			tails[7]:Hide()
			tails[8]:Hide()

			tails[1]:SetHeight(inf.th)
			tails[2]:SetWidth(inf.th)
			tails[3]:SetHeight(inf.th)
			tails[4]:SetWidth(inf.th)
		else
			if inf.tail.clockwise then
				tails[1]:SetPoint("TOPRIGHT", f, "TOP")
				tails[2]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
				tails[3]:SetPoint("TOPLEFT", f, "LEFT")
				tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
				tails[5]:SetPoint("BOTTOMLEFT", f, "BOTTOM")
				tails[6]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
				tails[7]:SetPoint("BOTTOMRIGHT", f, "RIGHT")
				tails[8]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
			else
				tails[1]:SetPoint("TOPLEFT", f, "TOP")
				tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
				tails[3]:SetPoint("TOPRIGHT", f, "RIGHT")
				tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
				tails[5]:SetPoint("BOTTOMRIGHT", f, "BOTTOM")
				tails[6]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
				tails[7]:SetPoint("BOTTOMLEFT", f, "LEFT")
				tails[8]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
			end

			tails[5]:Show()
			tails[6]:Show()
			tails[7]:Show()
			tails[8]:Show()

			tails[1]:SetHeight(inf.th)
			tails[2]:SetWidth(inf.th)
			tails[3]:SetWidth(inf.th)
			tails[4]:SetHeight(inf.th)
			tails[5]:SetHeight(inf.th)
			tails[6]:SetWidth(inf.th)
			tails[7]:SetWidth(inf.th)
			tails[8]:SetHeight(inf.th)
		end
	end

	local width, height = f:GetSize()
	if inf.tail.mirror then
		tails[1]:SetWidth(width)
		tails[2]:SetHeight(height - inf.th * 2)
		tails[3]:SetWidth(width)
		tails[4]:SetHeight(height - inf.th * 2)
	else
		tails[1]:SetWidth(width / 2)
		tails[2]:SetHeight(height / 2 - inf.th)
		tails[3]:SetHeight(height / 2)
		tails[4]:SetWidth(width / 2 - inf.th)
		tails[5]:SetWidth(width / 2)
		tails[6]:SetHeight(height / 2 - inf.th)
		tails[7]:SetHeight(height / 2)
		tails[8]:SetWidth(width / 2 - inf.th)
	end
	local totalSize = (width or 0) + (height or 0)
	local cornerP = (totalSize > 0) and (width / totalSize) or 0.5
	if cornerP < 0.001 then cornerP = 0.001 elseif cornerP > 0.999 then cornerP = 0.999 end
	inf.cornerP4 = cornerP
	local cornerP4G = (totalSize > 0) and (height / totalSize) or 0.5
	if cornerP4G < 0.001 then cornerP4G = 0.001 elseif cornerP4G > 0.999 then cornerP4G = 0.999 end
	inf.cornerP4G = cornerP4G
end

local function BorderUpdate4LinesCenter(f, progress)
	local inf = f.inf
	local tails = inf.tail.list
	local oldProgress = inf.tail.old

	if inf.tail.mirror then
		local newW = inf.width * (1 - progress)
		local newH = (inf.height - inf.th * 2) * (1 - progress)
		tails[1]:SetWidth(newW)
		tails[2]:SetHeight(newH)
		tails[3]:SetWidth(newW)
		tails[4]:SetHeight(newH)
	else
		local cornerP = inf.cornerP4 or 0.5
		local updt
		if progress < cornerP then
			if oldProgress > cornerP or oldProgress <= 0 then
				tails[3]:Show()
				tails[4]:Show()
				tails[7]:Show()
				tails[8]:Show()
				updt = true
			else
				local stageProg = 1 - progress / cornerP
				tails[4]:SetWidth(stageProg * (inf.width / 2 - inf.th))
				tails[8]:SetWidth(stageProg * (inf.width / 2 - inf.th))
			end
		else
			if oldProgress >= 0.99 or oldProgress < cornerP then
				tails[3]:Show()
				tails[4]:Hide()
				tails[7]:Show()
				tails[8]:Hide()
				updt = true
			else
				local stageProg = (1 - progress) / (1 - cornerP)
				tails[3]:SetHeight(stageProg * (inf.height / 2))
				tails[7]:SetHeight(stageProg * (inf.height / 2))
			end
		end

		if progress < (1 - cornerP) then
			if oldProgress > (1 - cornerP) or oldProgress <= 0 then
				tails[1]:Show()
				tails[2]:Show()
				tails[5]:Show()
				tails[6]:Show()
				updt = true
			else
				local stageProg = 1 - progress / (1 - cornerP)
				tails[2]:SetHeight(stageProg * (inf.height / 2 - inf.th))
				tails[6]:SetHeight(stageProg * (inf.height / 2 - inf.th))
			end
		else
			if oldProgress >= 0.99 or oldProgress < (1 - cornerP) then
				tails[1]:Show()
				tails[2]:Hide()
				tails[5]:Show()
				tails[6]:Hide()
				updt = true
			else
				local stageProg = (1 - progress) / cornerP
				tails[1]:SetWidth(stageProg * (inf.width / 2))
				tails[5]:SetWidth(stageProg * (inf.width / 2))
			end
		end

		if updt then
			BorderSet4LinesCenter(f, true)
			if progress < cornerP then
				local stageProg = 1 - progress / cornerP
				tails[4]:SetWidth(stageProg * (inf.width / 2 - inf.th))
				tails[8]:SetWidth(stageProg * (inf.width / 2 - inf.th))
			else
				local stageProg = (1 - progress) / (1 - cornerP)
				tails[3]:SetHeight(stageProg * (inf.height / 2))
				tails[7]:SetHeight(stageProg * (inf.height / 2))
			end

			if progress < (1 - cornerP) then
				local stageProg = 1 - progress / (1 - cornerP)
				tails[2]:SetHeight(stageProg * (inf.height / 2 - inf.th))
				tails[6]:SetHeight(stageProg * (inf.height / 2 - inf.th))
			else
				local stageProg = (1 - progress) / cornerP
				tails[1]:SetWidth(stageProg * (inf.width / 2))
				tails[5]:SetWidth(stageProg * (inf.width / 2))
			end
		end
	end
	inf.tail.old = progress
end

local function BorderGradient4LinesCenter(f, progress, elapsed)
	local inf = f.inf
	local tails = inf.tail.list
	local c1, c2, c3, c4 = BorderGradientCorners(inf, elapsed)

	if inf.tail.mirror then
		local c1x1 = GetHSVTransition(progress / 2, c2, c1)
		local c1x2 = GetHSVTransition(progress / 2, c1, c2)
		local c2x1 = GetHSVTransition(progress / 2, c4, c1)
		local c2x2 = GetHSVTransition(progress / 2, c1, c4)
		local c3x1 = GetHSVTransition(progress / 2, c3, c4)
		local c3x2 = GetHSVTransition(progress / 2, c4, c3)
		local c4x1 = GetHSVTransition(progress / 2, c3, c2)
		local c4x2 = GetHSVTransition(progress / 2, c2, c3)

		SetGradA(tails[1], "HORIZONTAL", c1x1, c1x2)
		SetGradA(tails[2], "VERTICAL", c2x1, c2x2)
		SetGradA(tails[3], "HORIZONTAL", c3x1, c3x2)
		SetGradA(tails[4], "VERTICAL", c4x1, c4x2)
	else
		local c12 = GetHSVTransition(0.5, c1, c2)
		local c23 = GetHSVTransition(0.5, c2, c3)
		local c34 = GetHSVTransition(0.5, c3, c4)
		local c41 = GetHSVTransition(0.5, c4, c1)

		local cornerP = inf.cornerP4G or 0.5
		if inf.tail.clockwise then
			if progress < cornerP then
				local c2x = GetHSVTransition(progress, c23, c2)
				local c6x = GetHSVTransition(progress, c41, c4)
				SetGradA(tails[1], "HORIZONTAL", c2, c12)
				SetGradA(tails[2], "VERTICAL", c2x, c2)
				SetGradA(tails[5], "HORIZONTAL", c34, c4)
				SetGradA(tails[6], "VERTICAL", c4, c6x)
			else
				local c1x = GetHSVTransition(progress, c2, c12)
				local c5x = GetHSVTransition(progress, c4, c34)
				SetGradA(tails[1], "HORIZONTAL", c1x, c12)
				SetGradA(tails[5], "HORIZONTAL", c34, c5x)
			end
			if progress < 1 - cornerP then
				local c4x = GetHSVTransition(progress, c34, c3)
				local c8x = GetHSVTransition(progress, c12, c1)
				SetGradA(tails[3], "VERTICAL", c3, c23)
				SetGradA(tails[4], "HORIZONTAL", c3, c4x)
				SetGradA(tails[7], "VERTICAL", c41, c1)
				SetGradA(tails[8], "HORIZONTAL", c8x, c1)
			else
				local c3x = GetHSVTransition(progress, c3, c34)
				local c7x = GetHSVTransition(progress, c1, c41)
				SetGradA(tails[3], "VERTICAL", c3x, c23)
				SetGradA(tails[7], "VERTICAL", c41, c7x)
			end
		else
			if progress < cornerP then
				local c2x = GetHSVTransition(progress, c41, c1)
				local c6x = GetHSVTransition(progress, c23, c3)
				SetGradA(tails[1], "HORIZONTAL", c12, c1)
				SetGradA(tails[2], "VERTICAL", c2x, c1)
				SetGradA(tails[5], "HORIZONTAL", c3, c34)
				SetGradA(tails[6], "VERTICAL", c3, c6x)
			else
				local c1x = GetHSVTransition(progress, c1, c12)
				local c5x = GetHSVTransition(progress, c3, c34)
				SetGradA(tails[1], "HORIZONTAL", c12, c1x)
				SetGradA(tails[5], "HORIZONTAL", c5x, c34)
			end
			if progress < 1 - cornerP then
				local c4x = GetHSVTransition(progress, c34, c4)
				local c8x = GetHSVTransition(progress, c12, c2)
				SetGradA(tails[3], "VERTICAL", c4, c41)
				SetGradA(tails[4], "HORIZONTAL", c4x, c4)
				SetGradA(tails[7], "VERTICAL", c23, c2)
				SetGradA(tails[8], "HORIZONTAL", c2, c8x)
			else
				local c3x = GetHSVTransition(progress, c4, c41)
				local c7x = GetHSVTransition(progress, c2, c23)
				SetGradA(tails[3], "VERTICAL", c3x, c41)
				SetGradA(tails[7], "VERTICAL", c23, c7x)
			end
		end
	end
end

local function BorderSet4LinesCorner(f, update)
	local inf = f.inf
	local tails = inf.tail.list
	if not update then
		for _, v in pairs(tails) do
			v:ClearAllPoints()
		end
		if inf.tail.mirror then
			tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT")
			tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
			tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
			tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
			tails[5]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT")
			tails[6]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
			tails[7]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
			tails[8]:SetPoint("TOPLEFT", f, "TOPLEFT")

			tails[5]:Show()
			tails[6]:Show()
			tails[7]:Show()
			tails[8]:Show()

			tails[1]:SetHeight(inf.th)
			tails[2]:SetWidth(inf.th)
			tails[3]:SetWidth(inf.th)
			tails[4]:SetHeight(inf.th)
			tails[5]:SetHeight(inf.th)
			tails[6]:SetWidth(inf.th)
			tails[7]:SetWidth(inf.th)
			tails[8]:SetHeight(inf.th)
		else
			if inf.tail.clockwise then
				tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT")
				tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
				tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT")
				tails[4]:SetPoint("TOPLEFT", f, "TOPLEFT")
			else
				tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT")
				tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT")
				tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
				tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT")
			end
			tails[5]:Hide()
			tails[6]:Hide()
			tails[7]:Hide()
			tails[8]:Hide()

			tails[1]:SetHeight(inf.th)
			tails[2]:SetWidth(inf.th)
			tails[3]:SetHeight(inf.th)
			tails[4]:SetWidth(inf.th)
		end
	end
	local width, height = f:GetSize()
	if inf.tail.mirror then
		tails[1]:SetWidth(width / 2)
		tails[2]:SetHeight(height / 2 - inf.th)
		tails[3]:SetHeight(height / 2 - inf.th)
		tails[4]:SetWidth(width / 2)
		tails[5]:SetWidth(width / 2)
		tails[6]:SetHeight(height / 2 - inf.th)
		tails[7]:SetHeight(height / 2 - inf.th)
		tails[8]:SetWidth(width / 2)
	else
		tails[1]:SetWidth(width - inf.th)
		tails[2]:SetHeight(height - inf.th)
		tails[3]:SetWidth(width - inf.th)
		tails[4]:SetHeight(height - inf.th)
	end
end

local function BorderUpdate4LinesCorner(f, progress)
	local inf = f.inf
	local tails = inf.tail.list

	if inf.tail.mirror then
		local newW = inf.width / 2 * (1 - progress)
		local newH = (inf.height / 2 - inf.th) * (1 - progress)
		tails[1]:SetWidth(newW)
		tails[2]:SetHeight(newH)
		tails[3]:SetHeight(newH)
		tails[4]:SetWidth(newW)
		tails[5]:SetWidth(newW)
		tails[6]:SetHeight(newH)
		tails[7]:SetHeight(newH)
		tails[8]:SetWidth(newW)
	else
		local newW = (inf.width - inf.th) * (1 - progress)
		local newH = (inf.height - inf.th) * (1 - progress)
		tails[1]:SetWidth(newW)
		tails[2]:SetHeight(newH)
		tails[3]:SetWidth(newW)
		tails[4]:SetHeight(newH)
	end
end

local function BorderGradient4LinesCorner(f, progress, elapsed)
	local inf = f.inf
	local tails = inf.tail.list
	local c1, c2, c3, c4 = BorderGradientCorners(inf, elapsed)

	if inf.tail.mirror then
		local gradProg = 0.5 + progress / 2
		local c1x = GetHSVTransition(gradProg, c2, c1)
		local c2x = GetHSVTransition(gradProg, c4, c1)
		local c3x = GetHSVTransition(gradProg, c1, c4)
		local c4x = GetHSVTransition(gradProg, c3, c4)
		local c5x = GetHSVTransition(gradProg, c4, c3)
		local c6x = GetHSVTransition(gradProg, c2, c3)
		local c7x = GetHSVTransition(gradProg, c3, c2)
		local c8x = GetHSVTransition(gradProg, c1, c2)

		SetGradA(tails[1], "HORIZONTAL", c1x, c1)
		SetGradA(tails[2], "VERTICAL", c2x, c1)
		SetGradA(tails[3], "VERTICAL", c4, c3x)
		SetGradA(tails[4], "HORIZONTAL", c4x, c4)
		SetGradA(tails[5], "HORIZONTAL", c3, c5x)
		SetGradA(tails[6], "VERTICAL", c3, c6x)
		SetGradA(tails[7], "VERTICAL", c7x, c2)
		SetGradA(tails[8], "HORIZONTAL", c2, c8x)
	else
		if inf.tail.clockwise then
			local c1x = GetHSVTransition(progress, c2, c1)
			local c2x = GetHSVTransition(progress, c1, c4)
			local c3x = GetHSVTransition(progress, c4, c3)
			local c4x = GetHSVTransition(progress, c3, c2)

			SetGradA(tails[1], "HORIZONTAL", c1x, c1)
			SetGradA(tails[2], "VERTICAL", c4, c2x)
			SetGradA(tails[3], "HORIZONTAL", c3, c3x)
			SetGradA(tails[4], "VERTICAL", c4x, c2)
		else
			local c1x = GetHSVTransition(progress, c1, c2)
			local c2x = GetHSVTransition(progress, c4, c1)
			local c3x = GetHSVTransition(progress, c3, c4)
			local c4x = GetHSVTransition(progress, c2, c3)

			SetGradA(tails[1], "HORIZONTAL", c2, c1x)
			SetGradA(tails[2], "VERTICAL", c2x, c1)
			SetGradA(tails[3], "HORIZONTAL", c3x, c4)
			SetGradA(tails[4], "VERTICAL", c4x, c2)
		end
	end
end

local function BorderSet2LinesCenter(f, update)
	local inf = f.inf
	local tails = inf.tail.list
	if not update then
		for _, v in pairs(tails) do
			v:ClearAllPoints()
		end
		if inf.tail.mirror then
			if inf.tail.startPoint == "LEFT" or inf.tail.startPoint == "RIGHT" then
				inf.tail.Set1 = f.SetHeight
				inf.tail.Set2 = f.SetWidth
				tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
				tails[2]:SetPoint("TOP", f, "TOP")
				tails[3]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
				tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
				tails[5]:SetPoint("BOTTOM", f, "BOTTOM")
				tails[6]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
			else
				inf.tail.Set1 = f.SetWidth
				inf.tail.Set2 = f.SetHeight
				tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
				tails[2]:SetPoint("LEFT", f, "LEFT")
				tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
				tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
				tails[5]:SetPoint("RIGHT", f, "RIGHT")
				tails[6]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
			end
		else
			if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
				inf.tail.Set1 = f.SetWidth
				inf.tail.Set2 = f.SetHeight
				if inf.tail.clockwise then
					tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOM")
					tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[5]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[6]:SetPoint("TOPRIGHT", f, "TOP")
				else
					tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOM")
					tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[5]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[6]:SetPoint("TOPLEFT", f, "TOP")
				end
			else
				inf.tail.Set1 = f.SetHeight
				inf.tail.Set2 = f.SetWidth
				if inf.tail.clockwise then
					tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[3]:SetPoint("BOTTOMRIGHT", f, "RIGHT")
					tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[5]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[6]:SetPoint("TOPLEFT", f, "LEFT")
				else
					tails[1]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[3]:SetPoint("TOPRIGHT", f, "RIGHT")
					tails[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[5]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[6]:SetPoint("BOTTOMLEFT", f, "LEFT")
				end
			end
		end
		inf.tail.Set2(tails[1], inf.th)
		inf.tail.Set1(tails[2], inf.th)
		inf.tail.Set2(tails[3], inf.th)
		inf.tail.Set2(tails[4], inf.th)
		inf.tail.Set1(tails[5], inf.th)
		inf.tail.Set2(tails[6], inf.th)
	end
	if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
		inf.tail.size1 = f:GetWidth()
		inf.tail.size2 = f:GetHeight()
	else
		inf.tail.size1 = f:GetHeight()
		inf.tail.size2 = f:GetWidth()
	end
	if inf.tail.mirror then
		inf.tail.Set1(tails[1], inf.tail.size1 / 2 - inf.th)
		inf.tail.Set2(tails[2], inf.tail.size2)
		inf.tail.Set1(tails[3], inf.tail.size1 / 2 - inf.th)
		inf.tail.Set1(tails[4], inf.tail.size1 / 2 - inf.th)
		inf.tail.Set2(tails[5], inf.tail.size2)
		inf.tail.Set1(tails[6], inf.tail.size1 / 2 - inf.th)
	else
		inf.tail.Set1(tails[1], inf.tail.size1 / 2 - inf.th)
		inf.tail.Set2(tails[2], inf.tail.size2 - inf.th)
		inf.tail.Set1(tails[3], inf.tail.size1 / 2)
		inf.tail.Set1(tails[4], inf.tail.size1 / 2 - inf.th)
		inf.tail.Set2(tails[5], inf.tail.size2 - inf.th)
		inf.tail.Set1(tails[6], inf.tail.size1 / 2)
	end
	local totalSize = (inf.tail.size1 or 0) + (inf.tail.size2 or 0)
	local cornerP_mirror = (totalSize > 0) and (inf.tail.size1 / totalSize) or 0.5
	if cornerP_mirror < 0.001 then cornerP_mirror = 0.001 elseif cornerP_mirror > 0.999 then cornerP_mirror = 0.999 end
	inf.tail.cornerP_mirror = cornerP_mirror
	local cornerP_nonmirror = (totalSize > 0) and (inf.tail.size1 / 2 / totalSize) or 0.25
	if cornerP_nonmirror < 0.001 then cornerP_nonmirror = 0.001 elseif cornerP_nonmirror > 0.499 then cornerP_nonmirror = 0.499 end
	inf.tail.cornerP = cornerP_nonmirror
end

local function BorderUpdate2LinesCenter(f, progress)
	local inf = f.inf
	local tails = inf.tail.list
	local oldProgress = inf.tail.old

	if inf.tail.mirror then
		local cornerP = inf.tail.cornerP_mirror or 0.5
		if progress < cornerP then
			if oldProgress > cornerP or oldProgress <= 0 then
				for _, v in pairs(tails) do
					v:Show()
				end
				BorderSet2LinesCenter(f, true)
			end
			local stageProg = 1 - progress / cornerP
			inf.tail.Set1(tails[1], stageProg * (inf.tail.size1 / 2 - inf.th))
			inf.tail.Set1(tails[3], stageProg * (inf.tail.size1 / 2 - inf.th))
			inf.tail.Set1(tails[4], stageProg * (inf.tail.size1 / 2 - inf.th))
			inf.tail.Set1(tails[6], stageProg * (inf.tail.size1 / 2 - inf.th))
		else
			if oldProgress >= 0.99 or oldProgress < cornerP then
				tails[1]:Hide()
				tails[2]:Show()
				tails[3]:Hide()
				tails[4]:Hide()
				tails[5]:Show()
				tails[6]:Hide()
				BorderSet2LinesCenter(f, true)
			end
			local stageProg = (1 - progress) / (1 - cornerP)
			inf.tail.Set2(tails[2], stageProg * inf.tail.size2)
			inf.tail.Set2(tails[5], stageProg * inf.tail.size2)
		end
	else
		local cornerP = inf.tail.cornerP or 0.25
		if progress < cornerP then
			if oldProgress > cornerP or oldProgress <= 0 then
				for _, v in pairs(tails) do
					v:Show()
				end
				BorderSet2LinesCenter(f, true)
			end
			local stageProg = 1 - progress / cornerP
			inf.tail.Set1(tails[1], stageProg * (inf.tail.size1 / 2 - inf.th))
			inf.tail.Set1(tails[4], stageProg * (inf.tail.size1 / 2 - inf.th))
		elseif progress < (1 - cornerP) then
			if oldProgress > (1 - cornerP) or oldProgress <= cornerP then
				tails[1]:Hide()
				tails[2]:Show()
				tails[3]:Show()
				tails[4]:Hide()
				tails[5]:Show()
				tails[6]:Show()
				BorderSet2LinesCenter(f, true)
			end
			local stageProg = (1 - cornerP - progress) / (1 - 2 * cornerP)
			inf.tail.Set2(tails[2], stageProg * (inf.tail.size2 - inf.th))
			inf.tail.Set2(tails[5], stageProg * (inf.tail.size2 - inf.th))
		elseif progress < 1 then
			if oldProgress >= 0.99 or oldProgress < (1 - cornerP) then
				tails[1]:Hide()
				tails[2]:Hide()
				tails[3]:Show()
				tails[4]:Hide()
				tails[5]:Hide()
				tails[6]:Show()
				BorderSet2LinesCenter(f, true)
			end
			local stageProg = (1 - progress) / cornerP
			inf.tail.Set1(tails[3], stageProg * (inf.tail.size1 / 2))
			inf.tail.Set1(tails[6], stageProg * (inf.tail.size1 / 2))
		end
	end
	inf.tail.old = progress
end

local function BorderGradient2LinesCenter(f, progress, elapsed)
	local inf = f.inf
	local tails = inf.tail.list
	local c1, c2, c3, c4 = BorderGradientCorners(inf, elapsed)

	if inf.tail.mirror then
		local cornerP = inf.tail.cornerP_mirror or 0.5
		if progress < cornerP then
			local stageProg = progress / cornerP
			if inf.tail.startPoint == "LEFT" or inf.tail.startPoint == "RIGHT" then
				local c23 = GetHSVTransition(0.5, c2, c3)
				local c41 = GetHSVTransition(0.5, c4, c1)
				local c1x = GetHSVTransition(stageProg, c41, c1)
				local c3x = GetHSVTransition(stageProg, c23, c2)
				local c4x = GetHSVTransition(stageProg, c23, c3)
				local c6x = GetHSVTransition(stageProg, c41, c4)
				SetGradA(tails[1], "VERTICAL", c1x, c1)
				SetGradA(tails[2], "HORIZONTAL", c2, c1)
				SetGradA(tails[3], "VERTICAL", c3x, c2)
				SetGradA(tails[4], "VERTICAL", c3, c4x)
				SetGradA(tails[5], "HORIZONTAL", c3, c4)
				SetGradA(tails[6], "VERTICAL", c4, c6x)
			else
				local c12 = GetHSVTransition(0.5, c1, c2)
				local c34 = GetHSVTransition(0.5, c3, c4)
				local c1x = GetHSVTransition(stageProg, c12, c2)
				local c3x = GetHSVTransition(stageProg, c34, c3)
				local c4x = GetHSVTransition(stageProg, c34, c4)
				local c6x = GetHSVTransition(stageProg, c12, c1)
				SetGradA(tails[1], "HORIZONTAL", c2, c1x)
				SetGradA(tails[2], "VERTICAL", c3, c2)
				SetGradA(tails[3], "HORIZONTAL", c3, c3x)
				SetGradA(tails[4], "HORIZONTAL", c4x, c4)
				SetGradA(tails[5], "VERTICAL", c4, c1)
				SetGradA(tails[6], "HORIZONTAL", c6x, c1)
			end
		else
			local stageProg = (progress - cornerP) / (1 - cornerP) / 2
			if inf.tail.startPoint == "LEFT" or inf.tail.startPoint == "RIGHT" then
				local c2x1 = GetHSVTransition(stageProg, c2, c1)
				local c2x2 = GetHSVTransition(stageProg, c1, c2)
				local c5x1 = GetHSVTransition(stageProg, c3, c4)
				local c5x2 = GetHSVTransition(stageProg, c4, c3)
				SetGradA(tails[2], "HORIZONTAL", c2x1, c2x2)
				SetGradA(tails[5], "HORIZONTAL", c5x1, c5x2)
			else
				local c2x1 = GetHSVTransition(stageProg, c3, c2)
				local c2x2 = GetHSVTransition(stageProg, c2, c3)
				local c5x1 = GetHSVTransition(stageProg, c4, c1)
				local c5x2 = GetHSVTransition(stageProg, c1, c4)
				SetGradA(tails[2], "VERTICAL", c2x1, c2x2)
				SetGradA(tails[5], "VERTICAL", c5x1, c5x2)
			end
		end
	else
		local cornerP = inf.tail.cornerP or 0.25
		if inf.tail.clockwise then
			if progress < cornerP then
				local stageProg = progress / cornerP
				if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c1x = GetHSVTransition(stageProg, c12, c1)
					local c4x = GetHSVTransition(stageProg, c34, c3)
					SetGradA(tails[1], "HORIZONTAL", c1x, c1)
					SetGradA(tails[2], "VERTICAL", c4, c1)
					SetGradA(tails[3], "HORIZONTAL", c34, c4)
					SetGradA(tails[4], "HORIZONTAL", c3, c4x)
					SetGradA(tails[5], "VERTICAL", c3, c2)
					SetGradA(tails[6], "HORIZONTAL", c2, c12)
				else
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c1x = GetHSVTransition(stageProg, c23, c2)
					local c4x = GetHSVTransition(stageProg, c41, c4)
					SetGradA(tails[1], "VERTICAL", c1x, c2)
					SetGradA(tails[2], "HORIZONTAL", c2, c1)
					SetGradA(tails[3], "VERTICAL", c41, c1)
					SetGradA(tails[4], "VERTICAL", c4, c4x)
					SetGradA(tails[5], "HORIZONTAL", c3, c4)
					SetGradA(tails[6], "VERTICAL", c3, c23)
				end
			elseif progress < (1 - cornerP) then
				local stageProg = (progress - cornerP) / (1 - cornerP * 2)
				if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c2x = GetHSVTransition(stageProg, c1, c4)
					local c5x = GetHSVTransition(stageProg, c3, c2)
					SetGradA(tails[2], "VERTICAL", c4, c2x)
					SetGradA(tails[3], "HORIZONTAL", c34, c4)
					SetGradA(tails[5], "VERTICAL", c5x, c2)
					SetGradA(tails[6], "HORIZONTAL", c2, c12)
				else
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c2x = GetHSVTransition(stageProg, c2, c1)
					local c5x = GetHSVTransition(stageProg, c4, c3)
					SetGradA(tails[2], "HORIZONTAL", c2x, c1)
					SetGradA(tails[3], "VERTICAL", c41, c1)
					SetGradA(tails[5], "HORIZONTAL", c3, c5x)
					SetGradA(tails[6], "VERTICAL", c3, c23)
				end
			else
				local stageProg = (progress - 1 + cornerP) / cornerP
				if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c3x = GetHSVTransition(stageProg, c4, c34)
					local c6x = GetHSVTransition(stageProg, c2, c12)
					SetGradA(tails[3], "HORIZONTAL", c34, c3x)
					SetGradA(tails[6], "HORIZONTAL", c6x, c12)
				else
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c3x = GetHSVTransition(stageProg, c1, c41)
					local c6x = GetHSVTransition(stageProg, c3, c23)
					SetGradA(tails[3], "VERTICAL", c41, c3x)
					SetGradA(tails[6], "VERTICAL", c6x, c23)
				end
			end
		else
			if progress < cornerP then
				local stageProg = progress / cornerP
				if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c1x = GetHSVTransition(stageProg, c12, c1)
					local c4x = GetHSVTransition(stageProg, c34, c4)
					SetGradA(tails[1], "HORIZONTAL", c2, c1x)
					SetGradA(tails[2], "VERTICAL", c3, c2)
					SetGradA(tails[3], "HORIZONTAL", c3, c34)
					SetGradA(tails[4], "HORIZONTAL", c4x, c4)
					SetGradA(tails[5], "VERTICAL", c4, c1)
					SetGradA(tails[6], "HORIZONTAL", c12, c1)
				else
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c1x = GetHSVTransition(stageProg, c23, c3)
					local c4x = GetHSVTransition(stageProg, c41, c1)
					SetGradA(tails[1], "VERTICAL", c3, c1x)
					SetGradA(tails[2], "HORIZONTAL", c3, c4)
					SetGradA(tails[3], "VERTICAL", c4, c41)
					SetGradA(tails[4], "VERTICAL", c4x, c1)
					SetGradA(tails[5], "HORIZONTAL", c2, c1)
					SetGradA(tails[6], "VERTICAL", c23, c2)
				end
			elseif progress < (1 - cornerP) then
				local stageProg = (progress - cornerP) / (1 - cornerP * 2)
				if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c2x = GetHSVTransition(stageProg, c2, c3)
					local c5x = GetHSVTransition(stageProg, c4, c1)
					SetGradA(tails[2], "VERTICAL", c3, c2x)
					SetGradA(tails[3], "HORIZONTAL", c3, c34)
					SetGradA(tails[5], "VERTICAL", c5x, c1)
					SetGradA(tails[6], "HORIZONTAL", c12, c1)
				else
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c2x = GetHSVTransition(stageProg, c3, c4)
					local c5x = GetHSVTransition(stageProg, c1, c2)
					SetGradA(tails[2], "HORIZONTAL", c2x, c4)
					SetGradA(tails[3], "VERTICAL", c4, c41)
					SetGradA(tails[5], "HORIZONTAL", c2, c5x)
					SetGradA(tails[6], "VERTICAL", c23, c2)
				end
			else
				local stageProg = (progress - 1 + cornerP) / cornerP
				if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c3x = GetHSVTransition(stageProg, c3, c34)
					local c6x = GetHSVTransition(stageProg, c1, c12)
					SetGradA(tails[3], "HORIZONTAL", c3x, c34)
					SetGradA(tails[6], "HORIZONTAL", c12, c6x)
				else
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c3x = GetHSVTransition(stageProg, c4, c41)
					local c6x = GetHSVTransition(stageProg, c2, c23)
					SetGradA(tails[3], "VERTICAL", c3x, c41)
					SetGradA(tails[6], "VERTICAL", c23, c6x)
				end
			end
		end
	end
end

local function BorderSet2LinesCorner(f, update)
	local inf = f.inf
	local tails = inf.tail.list
	if not update then
		for _, v in pairs(tails) do
			v:ClearAllPoints()
		end
		if inf.tail.mirror then
			if inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT" then
				tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT")
				tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
				tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT")
				tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
			else
				tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT")
				tails[2]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
				tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
				tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
			end
			tails[1]:SetHeight(inf.th)
			tails[2]:SetWidth(inf.th)
			tails[3]:SetWidth(inf.th)
			tails[4]:SetHeight(inf.th)
		else
			if inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT" then
				if inf.tail.clockwise then
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
					tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[4]:SetPoint("TOPLEFT", f, "TOPLEFT")
				else
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
					tails[3]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[4]:SetPoint("TOPLEFT", f, "TOPLEFT")
				end
			else
				if inf.tail.clockwise then
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT")
					tails[3]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT")
				else
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT")
					tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT")
				end
			end
			inf.tail.Set2(tails[1], inf.th)
			inf.tail.Set1(tails[2], inf.th)
			inf.tail.Set2(tails[3], inf.th)
			inf.tail.Set1(tails[4], inf.th)
		end
	end

	if inf.tail.mirror then
		tails[1]:SetWidth(f:GetWidth())
		tails[2]:SetHeight(f:GetHeight() - inf.th)
		tails[3]:SetHeight(f:GetHeight())
		tails[4]:SetWidth(f:GetWidth() - inf.th)
	else
		if inf.tail.clockwise and (inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT") or not inf.tail.clockwise and (inf.tail.startPoint == "BOTTOMLEFT" or inf.tail.startPoint == "TOPRIGHT") then
			inf.tail.size1 = f:GetWidth()
			inf.tail.size2 = f:GetHeight()
		else
			inf.tail.size1 = f:GetHeight()
			inf.tail.size2 = f:GetWidth()
		end
		inf.tail.Set1(tails[1], inf.tail.size1 - 2 * inf.th)
		inf.tail.Set2(tails[2], inf.tail.size2)
		inf.tail.Set1(tails[3], inf.tail.size1 - 2 * inf.th)
		inf.tail.Set2(tails[4], inf.tail.size2)
	end
	local totalSize = (inf.tail.size1 or 0) + (inf.tail.size2 or 0)
	local cornerP = (totalSize > 0) and (inf.tail.size1 / totalSize) or 0.5
	if cornerP < 0.001 then cornerP = 0.001 elseif cornerP > 0.999 then cornerP = 0.999 end
	inf.tail.cornerP = cornerP
end

local function BorderUpdate2LinesCorner(f, progress)
	local inf = f.inf
	local tails = inf.tail.list
	local oldProgress = inf.tail.old
	if inf.tail.mirror then
		tails[1]:SetWidth((1 - progress) * inf.width)
		tails[2]:SetHeight((1 - progress) * (inf.height - inf.th))
		tails[3]:SetHeight((1 - progress) * inf.height)
		tails[4]:SetWidth((1 - progress) * (inf.width - inf.th))
	else
		local cornerP = inf.tail.cornerP or 0.5
		if progress < cornerP then
			if oldProgress > cornerP or oldProgress <= 0 then
				for _, v in pairs(tails) do
					v:Show()
				end
				BorderSet2LinesCorner(f, true)
			end
			local stageProg = 1 - progress / cornerP
			inf.tail.Set1(tails[1], stageProg * (inf.tail.size1 - 2 * inf.th))
			inf.tail.Set1(tails[3], stageProg * (inf.tail.size1 - 2 * inf.th))
		else
			if oldProgress >= 0.99 or oldProgress < cornerP then
				tails[1]:Hide()
				tails[2]:Show()
				tails[3]:Hide()
				tails[4]:Show()
				BorderSet2LinesCorner(f, true)
			end
			local stageProg = (1 - progress) / (1 - cornerP)
			inf.tail.Set2(tails[2], stageProg * inf.tail.size2)
			inf.tail.Set2(tails[4], stageProg * inf.tail.size2)
		end
	end
	inf.tail.old = progress
end

local function BorderGradient2LinesCorner(f, progress, elapsed)
	local inf = f.inf
	local tails = inf.tail.list
	local c1, c2, c3, c4 = BorderGradientCorners(inf, elapsed)

	if inf.tail.mirror then
		if inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT" then
			local c1x = GetHSVTransition(progress, c2, c1)
			local c2x = GetHSVTransition(progress, c4, c1)
			local c3x = GetHSVTransition(progress, c2, c3)
			local c4x = GetHSVTransition(progress, c4, c3)

			SetGradA(tails[1], "HORIZONTAL", c1x, c1)
			SetGradA(tails[2], "VERTICAL", c2x, c1)
			SetGradA(tails[3], "VERTICAL", c3, c3x)
			SetGradA(tails[4], "HORIZONTAL", c3, c4x)
		else
			local c1x = GetHSVTransition(progress, c1, c2)
			local c2x = GetHSVTransition(progress, c3, c2)
			local c3x = GetHSVTransition(progress, c1, c4)
			local c4x = GetHSVTransition(progress, c3, c4)

			SetGradA(tails[1], "HORIZONTAL", c2, c1x)
			SetGradA(tails[2], "VERTICAL", c2x, c2)
			SetGradA(tails[3], "VERTICAL", c4, c3x)
			SetGradA(tails[4], "HORIZONTAL", c4x, c4)
		end
	else
		local cornerP = inf.tail.cornerP or 0.5
		if inf.tail.clockwise then
			if progress < cornerP then
				local stageProg = progress / cornerP
				if inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT" then
					local c1x = GetHSVTransition(stageProg, c2, c1)
					local c3x = GetHSVTransition(stageProg, c4, c3)

					SetGradA(tails[1], "HORIZONTAL", c1x, c1)
					SetGradA(tails[2], "VERTICAL", c4, c1)
					SetGradA(tails[3], "HORIZONTAL", c3, c3x)
					SetGradA(tails[4], "VERTICAL", c3, c2)
				else
					local c1x = GetHSVTransition(stageProg, c1, c4)
					local c3x = GetHSVTransition(stageProg, c3, c2)

					SetGradA(tails[1], "VERTICAL", c4, c1x)
					SetGradA(tails[2], "HORIZONTAL", c3, c4)
					SetGradA(tails[3], "VERTICAL", c3x, c2)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
				end
			else
				local stageProg = (progress - cornerP) / (1 - cornerP)
				if inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT" then
					local c2x = GetHSVTransition(stageProg, c1, c4)
					local c4x = GetHSVTransition(stageProg, c3, c2)

					SetGradA(tails[2], "VERTICAL", c4, c2x)
					SetGradA(tails[4], "VERTICAL", c4x, c2)
				else
					local c2x = GetHSVTransition(stageProg, c4, c3)
					local c4x = GetHSVTransition(stageProg, c2, c1)

					SetGradA(tails[2], "HORIZONTAL", c3, c2x)
					SetGradA(tails[4], "HORIZONTAL", c4x, c1)
				end
			end
		else
			if progress < cornerP then
				local stageProg = progress / cornerP
				if inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT" then
					local c1x = GetHSVTransition(stageProg, c2, c3)
					local c3x = GetHSVTransition(stageProg, c4, c1)

					SetGradA(tails[1], "VERTICAL", c3, c1x)
					SetGradA(tails[2], "HORIZONTAL", c3, c4)
					SetGradA(tails[3], "VERTICAL", c3x, c1)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
				else
					local c1x = GetHSVTransition(stageProg, c1, c2)
					local c3x = GetHSVTransition(stageProg, c3, c4)

					SetGradA(tails[1], "HORIZONTAL", c2, c1x)
					SetGradA(tails[2], "VERTICAL", c3, c2)
					SetGradA(tails[3], "HORIZONTAL", c3x, c4)
					SetGradA(tails[4], "VERTICAL", c4, c1)
				end
			else
				local stageProg = (progress - cornerP) / (1 - cornerP)
				if inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT" then
					local c2x = GetHSVTransition(stageProg, c3, c4)
					local c4x = GetHSVTransition(stageProg, c1, c2)

					SetGradA(tails[2], "HORIZONTAL", c2x, c4)
					SetGradA(tails[4], "HORIZONTAL", c2, c4x)
				else
					local c2x = GetHSVTransition(stageProg, c2, c3)
					local c4x = GetHSVTransition(stageProg, c4, c1)

					SetGradA(tails[2], "VERTICAL", c3, c2x)
					SetGradA(tails[4], "VERTICAL", c4x, c1)
				end
			end
		end
	end
end

local function BorderSet1LineCenter(f, update)
	local inf = f.inf
	local tails = inf.tail.list
	if not update then
		for _, v in pairs(tails) do
			v:ClearAllPoints()
		end
		if inf.tail.mirror then
			if inf.tail.startPoint == "TOP" then
				inf.tail.Set1 = f.SetWidth
				inf.tail.Set2 = f.SetHeight
				tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
				tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
				tails[3]:SetPoint("BOTTOM", f, "BOTTOM")
				tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
				tails[5]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
			elseif inf.tail.startPoint == "BOTTOM" then
				inf.tail.Set1 = f.SetWidth
				inf.tail.Set2 = f.SetHeight
				tails[1]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
				tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
				tails[3]:SetPoint("TOP", f, "TOP")
				tails[4]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
				tails[5]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
			elseif inf.tail.startPoint == "LEFT" then
				inf.tail.Set1 = f.SetHeight
				inf.tail.Set2 = f.SetWidth
				tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
				tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
				tails[3]:SetPoint("RIGHT", f, "RIGHT")
				tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
				tails[5]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
			else
				inf.tail.Set1 = f.SetHeight
				inf.tail.Set2 = f.SetWidth
				tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
				tails[2]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
				tails[3]:SetPoint("LEFT", f, "LEFT")
				tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
				tails[5]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
			end
		else
			if inf.tail.clockwise then
				if inf.tail.startPoint == "TOP" then
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[4]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[5]:SetPoint("TOPRIGHT", f, "TOP")
				elseif inf.tail.startPoint == "BOTTOM" then
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[2]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[3]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[5]:SetPoint("BOTTOMLEFT", f, "BOTTOM")
				elseif inf.tail.startPoint == "LEFT" then
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[5]:SetPoint("TOPLEFT", f, "LEFT")
				else
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[3]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[5]:SetPoint("BOTTOMRIGHT", f, "RIGHT")
				end
			else
				if inf.tail.startPoint == "TOP" then
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[5]:SetPoint("TOPLEFT", f, "TOP")
				elseif inf.tail.startPoint == "BOTTOM" then
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[3]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[5]:SetPoint("BOTTOMRIGHT", f, "BOTTOM")
				elseif inf.tail.startPoint == "LEFT" then
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[3]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[4]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[5]:SetPoint("BOTTOMLEFT", f, "LEFT")
				else
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[2]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[5]:SetPoint("TOPRIGHT", f, "RIGHT")
				end
			end
		end
		inf.tail.Set2(tails[1], inf.th)
		inf.tail.Set1(tails[2], inf.th)
		inf.tail.Set2(tails[3], inf.th)
		inf.tail.Set1(tails[4], inf.th)
		inf.tail.Set2(tails[5], inf.th)
	end
	if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
		inf.tail.size1 = f:GetWidth()
		inf.tail.size2 = f:GetHeight()
	else
		inf.tail.size1 = f:GetHeight()
		inf.tail.size2 = f:GetWidth()
	end

	if inf.tail.mirror then
		inf.tail.Set1(tails[1], inf.tail.size1 / 2 - inf.th)
		inf.tail.Set2(tails[2], inf.tail.size2 - inf.th)
		inf.tail.Set1(tails[3], inf.tail.size1)
		inf.tail.Set2(tails[4], inf.tail.size2 - inf.th)
		inf.tail.Set1(tails[5], inf.tail.size1 / 2 - inf.th)
	else
		inf.tail.Set1(tails[1], inf.tail.size1 / 2 - inf.th)
		inf.tail.Set2(tails[2], inf.tail.size2 - inf.th)
		inf.tail.Set1(tails[3], inf.tail.size1 - inf.th)
		inf.tail.Set2(tails[4], inf.tail.size2 - inf.th)
		inf.tail.Set1(tails[5], inf.tail.size1 / 2)
	end
	local totalSize = (inf.tail.size1 or 0) + (inf.tail.size2 or 0)
	local cornerP_mirror = (totalSize > 0) and (inf.tail.size1 / totalSize / 2) or 0.25
	if cornerP_mirror < 0.001 then cornerP_mirror = 0.001 elseif cornerP_mirror > 0.499 then cornerP_mirror = 0.499 end
	inf.tail.cornerP_mirror = cornerP_mirror
	local cornerP = (totalSize > 0) and (inf.tail.size1 / totalSize / 4) or 0.125
	if cornerP < 0.001 then cornerP = 0.001 elseif cornerP > 0.249 then cornerP = 0.249 end
	inf.tail.cornerP = cornerP
end

local function BorderUpdate1LineCenter(f, progress)
	local inf = f.inf
	local tails = inf.tail.list
	local oldProgress = inf.tail.old

	if inf.tail.mirror then
		local cornerP = inf.tail.cornerP_mirror or 0.25
		if progress < cornerP then
			if oldProgress > cornerP or oldProgress <= 0 then
				for _, v in pairs(tails) do
					v:Show()
				end
				BorderSet1LineCenter(f, true)
			end
			local stageProg = 1 - progress / cornerP
			inf.tail.Set1(tails[1], stageProg * (inf.tail.size1 / 2 - inf.th))
			inf.tail.Set1(tails[5], stageProg * (inf.tail.size1 / 2 - inf.th))
		elseif progress < 1 - cornerP then
			if oldProgress > 1 - cornerP or oldProgress <= cornerP then
				tails[1]:Hide()
				tails[2]:Show()
				tails[3]:Show()
				tails[4]:Show()
				tails[5]:Hide()
				BorderSet1LineCenter(f, true)
			end
			local stageProg = (1 - progress - cornerP) / (1 - cornerP * 2)
			inf.tail.Set2(tails[2], stageProg * (inf.tail.size2 - inf.th))
			inf.tail.Set2(tails[4], stageProg * (inf.tail.size2 - inf.th))
		else
			if oldProgress >= 0.99 or oldProgress <= 1 - cornerP then
				tails[1]:Hide()
				tails[2]:Hide()
				tails[3]:Show()
				tails[4]:Hide()
				tails[5]:Hide()
				BorderSet1LineCenter(f, true)
			end
			local stageProg = (1 - progress) / cornerP
			inf.tail.Set1(tails[3], stageProg * inf.tail.size1)
		end
	else
		local cornerP = inf.tail.cornerP or 0.125
		if progress < cornerP then
			if oldProgress > cornerP or oldProgress <= 0 then
				for _, v in pairs(tails) do
					v:Show()
				end
				BorderSet1LineCenter(f, true)
			end
			local stageProg = 1 - progress / cornerP
			inf.tail.Set1(tails[1], stageProg * (inf.tail.size1 / 2 - inf.th))
		elseif progress < 0.5 - cornerP then
			if oldProgress > 0.5 - cornerP or oldProgress <= cornerP then
				tails[1]:Hide()
				tails[2]:Show()
				tails[3]:Show()
				tails[4]:Show()
				tails[5]:Show()
				BorderSet1LineCenter(f, true)
			end
			local stageProg = (0.5 - cornerP - progress) / (0.5 - cornerP * 2)
			inf.tail.Set2(tails[2], stageProg * (inf.tail.size2 - inf.th))
		elseif progress < 0.5 + cornerP then
			if oldProgress > 0.5 + cornerP or oldProgress <= 0.5 - cornerP then
				tails[1]:Hide()
				tails[2]:Hide()
				tails[3]:Show()
				tails[4]:Show()
				tails[5]:Show()
				BorderSet1LineCenter(f, true)
			end
			local stageProg = (0.5 + cornerP - progress) / cornerP / 2
			inf.tail.Set1(tails[3], stageProg * (inf.tail.size1 - inf.th))
		elseif progress < 1 - cornerP then
			if oldProgress > 1 - cornerP or oldProgress <= 0.5 + cornerP then
				tails[1]:Hide()
				tails[2]:Hide()
				tails[3]:Hide()
				tails[4]:Show()
				tails[5]:Show()
				BorderSet1LineCenter(f, true)
			end
			local stageProg = (1 - cornerP - progress) / (0.5 - cornerP * 2)
			inf.tail.Set2(tails[4], stageProg * (inf.tail.size2 - inf.th))
		else
			if oldProgress >= 0.99 or oldProgress <= (1 - cornerP) then
				tails[1]:Hide()
				tails[2]:Hide()
				tails[3]:Hide()
				tails[4]:Hide()
				tails[5]:Show()
				BorderSet1LineCenter(f, true)
			end
			local stageProg = (1 - progress) / cornerP
			inf.tail.Set1(tails[5], stageProg * (inf.tail.size1 / 2))
		end
	end
	inf.tail.old = progress
end

local function BorderGradient1LineCenter(f, progress, elapsed)
	local inf = f.inf
	local tails = inf.tail.list
	local c1, c2, c3, c4 = BorderGradientCorners(inf, elapsed)

	if inf.tail.mirror then
		local cornerP = inf.tail.cornerP_mirror or 0.25
		if progress < cornerP then
			local stageProg = progress / cornerP
			if inf.tail.startPoint == "TOP" then
				local c12 = GetHSVTransition(0.5, c1, c2)
				local c1x = GetHSVTransition(stageProg, c12, c1)
				local c5x = GetHSVTransition(stageProg, c12, c2)

				SetGradA(tails[1], "HORIZONTAL", c1x, c1)
				SetGradA(tails[2], "VERTICAL", c4, c1)
				SetGradA(tails[3], "HORIZONTAL", c3, c4)
				SetGradA(tails[4], "VERTICAL", c3, c2)
				SetGradA(tails[5], "HORIZONTAL", c2, c5x)
			elseif inf.tail.startPoint == "BOTTOM" then
				local c34 = GetHSVTransition(0.5, c3, c4)
				local c1x = GetHSVTransition(stageProg, c34, c4)
				local c5x = GetHSVTransition(stageProg, c34, c3)

				SetGradA(tails[1], "HORIZONTAL", c1x, c4)
				SetGradA(tails[2], "VERTICAL", c4, c1)
				SetGradA(tails[3], "HORIZONTAL", c2, c1)
				SetGradA(tails[4], "VERTICAL", c3, c2)
				SetGradA(tails[5], "HORIZONTAL", c3, c5x)
			elseif inf.tail.startPoint == "LEFT" then
				local c23 = GetHSVTransition(0.5, c2, c3)
				local c1x = GetHSVTransition(stageProg, c23, c2)
				local c5x = GetHSVTransition(stageProg, c23, c3)

				SetGradA(tails[1], "VERTICAL", c1x, c2)
				SetGradA(tails[2], "HORIZONTAL", c2, c1)
				SetGradA(tails[3], "VERTICAL", c4, c1)
				SetGradA(tails[4], "HORIZONTAL", c3, c4)
				SetGradA(tails[5], "VERTICAL", c3, c5x)
			else
				local c41 = GetHSVTransition(0.5, c4, c1)
				local c1x = GetHSVTransition(stageProg, c41, c1)
				local c5x = GetHSVTransition(stageProg, c41, c4)

				SetGradA(tails[1], "VERTICAL", c1x, c1)
				SetGradA(tails[2], "HORIZONTAL", c2, c1)
				SetGradA(tails[3], "VERTICAL", c3, c2)
				SetGradA(tails[4], "HORIZONTAL", c3, c4)
				SetGradA(tails[5], "VERTICAL", c4, c5x)
			end
		elseif progress < (1 - cornerP) then
			local stageProg = (progress - cornerP) / (1 - cornerP * 2)
			if inf.tail.startPoint == "TOP" then
				local c2x = GetHSVTransition(stageProg, c1, c4)
				local c4x = GetHSVTransition(stageProg, c2, c3)

				SetGradA(tails[2], "VERTICAL", c4, c2x)
				SetGradA(tails[3], "HORIZONTAL", c3, c4)
				SetGradA(tails[4], "VERTICAL", c3, c4x)
			elseif inf.tail.startPoint == "BOTTOM" then
				local c2x = GetHSVTransition(stageProg, c4, c1)
				local c4x = GetHSVTransition(stageProg, c3, c2)

				SetGradA(tails[2], "VERTICAL", c2x, c1)
				SetGradA(tails[3], "HORIZONTAL", c2, c1)
				SetGradA(tails[4], "VERTICAL", c4x, c2)
			elseif inf.tail.startPoint == "LEFT" then
				local c2x = GetHSVTransition(stageProg, c2, c1)
				local c4x = GetHSVTransition(stageProg, c3, c4)

				SetGradA(tails[2], "HORIZONTAL", c2x, c1)
				SetGradA(tails[3], "VERTICAL", c4, c1)
				SetGradA(tails[4], "HORIZONTAL", c4x, c4)
			else
				local c2x = GetHSVTransition(stageProg, c1, c2)
				local c4x = GetHSVTransition(stageProg, c4, c3)

				SetGradA(tails[2], "HORIZONTAL", c2, c2x)
				SetGradA(tails[3], "VERTICAL", c3, c2)
				SetGradA(tails[4], "HORIZONTAL", c3, c4x)
			end
		else
			local stageProg = (progress - 1 + 0.5) / cornerP
			if inf.tail.startPoint == "TOP" then
				local c34 = GetHSVTransition(0.5, c3, c4)
				local c3x1 = GetHSVTransition(stageProg, c3, c34)
				local c3x2 = GetHSVTransition(stageProg, c4, c34)

				SetGradA(tails[3], "HORIZONTAL", c3x1, c3x2)
			elseif inf.tail.startPoint == "BOTTOM" then
				local c12 = GetHSVTransition(0.5, c1, c2)
				local c3x1 = GetHSVTransition(stageProg, c2, c12)
				local c3x2 = GetHSVTransition(stageProg, c1, c12)

				SetGradA(tails[3], "HORIZONTAL", c3x1, c3x2)
			elseif inf.tail.startPoint == "LEFT" then
				local c41 = GetHSVTransition(0.5, c4, c1)
				local c3x1 = GetHSVTransition(stageProg, c4, c41)
				local c3x2 = GetHSVTransition(stageProg, c1, c41)

				SetGradA(tails[3], "VERTICAL", c3x1, c3x2)
			else
				local c23 = GetHSVTransition(0.5, c2, c3)
				local c3x1 = GetHSVTransition(stageProg, c3, c23)
				local c3x2 = GetHSVTransition(stageProg, c2, c23)

				SetGradA(tails[3], "VERTICAL", c3x1, c3x2)
			end
		end
	else
		local cornerP = inf.tail.cornerP or 0.125
		if inf.tail.clockwise then
			if progress < cornerP then
				local stageProg = progress / cornerP
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c1x = GetHSVTransition(stageProg, c12, c1)
					SetGradA(tails[1], "HORIZONTAL", c1x, c1)
					SetGradA(tails[2], "VERTICAL", c4, c1)
					SetGradA(tails[3], "HORIZONTAL", c3, c4)
					SetGradA(tails[4], "VERTICAL", c3, c2)
					SetGradA(tails[5], "HORIZONTAL", c2, c12)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c1x = GetHSVTransition(stageProg, c34, c3)
					SetGradA(tails[1], "HORIZONTAL", c3, c1x)
					SetGradA(tails[2], "VERTICAL", c3, c2)
					SetGradA(tails[3], "HORIZONTAL", c2, c1)
					SetGradA(tails[4], "VERTICAL", c4, c1)
					SetGradA(tails[5], "HORIZONTAL", c34, c4)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c1x = GetHSVTransition(stageProg, c23, c2)
					SetGradA(tails[1], "VERTICAL", c1x, c2)
					SetGradA(tails[2], "HORIZONTAL", c2, c1)
					SetGradA(tails[3], "VERTICAL", c4, c1)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
					SetGradA(tails[5], "VERTICAL", c3, c23)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c1x = GetHSVTransition(stageProg, c41, c4)
					SetGradA(tails[1], "VERTICAL", c4, c1x)
					SetGradA(tails[2], "HORIZONTAL", c3, c4)
					SetGradA(tails[3], "VERTICAL", c3, c2)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
					SetGradA(tails[5], "VERTICAL", c41, c1)
				end
			elseif progress < 0.5 - cornerP then
				local stageProg = (progress - cornerP) / (0.5 - cornerP * 2)
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c2x = GetHSVTransition(stageProg, c1, c4)
					SetGradA(tails[2], "VERTICAL", c4, c2x)
					SetGradA(tails[3], "HORIZONTAL", c3, c4)
					SetGradA(tails[4], "VERTICAL", c3, c2)
					SetGradA(tails[5], "HORIZONTAL", c2, c12)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c2x = GetHSVTransition(stageProg, c3, c2)
					SetGradA(tails[2], "VERTICAL", c2x, c2)
					SetGradA(tails[3], "HORIZONTAL", c2, c1)
					SetGradA(tails[4], "VERTICAL", c4, c1)
					SetGradA(tails[5], "HORIZONTAL", c34, c4)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c2x = GetHSVTransition(stageProg, c2, c1)
					SetGradA(tails[2], "HORIZONTAL", c2x, c1)
					SetGradA(tails[3], "VERTICAL", c4, c1)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
					SetGradA(tails[5], "VERTICAL", c3, c23)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c2x = GetHSVTransition(stageProg, c4, c3)
					SetGradA(tails[2], "HORIZONTAL", c3, c2x)
					SetGradA(tails[3], "VERTICAL", c3, c2)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
					SetGradA(tails[5], "VERTICAL", c41, c1)
				end
			elseif progress < 0.5 + cornerP then
				local stageProg = (progress - 0.5 + cornerP) / cornerP / 2
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c3x = GetHSVTransition(stageProg, c4, c3)
					SetGradA(tails[3], "HORIZONTAL", c3, c3x)
					SetGradA(tails[4], "VERTICAL", c3, c2)
					SetGradA(tails[5], "HORIZONTAL", c2, c12)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c3x = GetHSVTransition(stageProg, c2, c1)
					SetGradA(tails[3], "HORIZONTAL", c3x, c1)
					SetGradA(tails[4], "VERTICAL", c4, c1)
					SetGradA(tails[5], "HORIZONTAL", c34, c4)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c3x = GetHSVTransition(stageProg, c1, c4)
					SetGradA(tails[3], "VERTICAL", c4, c3x)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
					SetGradA(tails[5], "VERTICAL", c3, c23)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c3x = GetHSVTransition(stageProg, c3, c2)
					SetGradA(tails[3], "VERTICAL", c3x, c2)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
					SetGradA(tails[5], "VERTICAL", c41, c1)
				end
			elseif progress < 1 - cornerP then
				local stageProg = (progress - 0.5 - cornerP) / (0.5 - cornerP * 2)
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c4x = GetHSVTransition(stageProg, c3, c2)
					SetGradA(tails[4], "VERTICAL", c4x, c2)
					SetGradA(tails[5], "HORIZONTAL", c2, c12)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c4x = GetHSVTransition(stageProg, c1, c4)
					SetGradA(tails[4], "VERTICAL", c4, c4x)
					SetGradA(tails[5], "HORIZONTAL", c34, c4)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c4x = GetHSVTransition(stageProg, c4, c3)
					SetGradA(tails[4], "HORIZONTAL", c3, c4x)
					SetGradA(tails[5], "VERTICAL", c3, c23)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c4x = GetHSVTransition(stageProg, c2, c1)
					SetGradA(tails[4], "HORIZONTAL", c4x, c1)
					SetGradA(tails[5], "VERTICAL", c41, c1)
				end
			else
				local stageProg = (progress - 1 + cornerP) / cornerP
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c5x = GetHSVTransition(stageProg, c2, c12)
					SetGradA(tails[5], "HORIZONTAL", c5x, c12)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c5x = GetHSVTransition(stageProg, c4, c34)
					SetGradA(tails[5], "HORIZONTAL", c34, c5x)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c5x = GetHSVTransition(stageProg, c3, c23)
					SetGradA(tails[5], "VERTICAL", c5x, c23)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c5x = GetHSVTransition(stageProg, c1, c41)
					SetGradA(tails[5], "VERTICAL", c41, c5x)
				end
			end
		else
			if progress < cornerP then
				local stageProg = progress / cornerP
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c1x = GetHSVTransition(stageProg, c2, c12)
					SetGradA(tails[1], "HORIZONTAL", c2, c1x)
					SetGradA(tails[2], "VERTICAL", c3, c2)
					SetGradA(tails[3], "HORIZONTAL", c3, c4)
					SetGradA(tails[4], "VERTICAL", c4, c1)
					SetGradA(tails[5], "HORIZONTAL", c12, c1)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c1x = GetHSVTransition(stageProg, c34, c4)
					SetGradA(tails[1], "HORIZONTAL", c1x, c4)
					SetGradA(tails[2], "VERTICAL", c4, c1)
					SetGradA(tails[3], "HORIZONTAL", c2, c1)
					SetGradA(tails[4], "VERTICAL", c3, c2)
					SetGradA(tails[5], "HORIZONTAL", c3, c34)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c1x = GetHSVTransition(stageProg, c3, c23)
					SetGradA(tails[1], "VERTICAL", c3, c1x)
					SetGradA(tails[2], "HORIZONTAL", c3, c4)
					SetGradA(tails[3], "VERTICAL", c4, c1)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
					SetGradA(tails[5], "VERTICAL", c23, c2)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c1x = GetHSVTransition(stageProg, c41, c1)
					SetGradA(tails[1], "VERTICAL", c1x, c1)
					SetGradA(tails[2], "HORIZONTAL", c2, c1)
					SetGradA(tails[3], "VERTICAL", c3, c2)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
					SetGradA(tails[5], "VERTICAL", c4, c41)
				end
			elseif progress < 0.5 - cornerP then
				local stageProg = (progress - cornerP) / (0.5 - cornerP * 2)
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c2x = GetHSVTransition(stageProg, c2, c3)
					SetGradA(tails[2], "VERTICAL", c3, c2x)
					SetGradA(tails[3], "HORIZONTAL", c3, c4)
					SetGradA(tails[4], "VERTICAL", c4, c1)
					SetGradA(tails[5], "HORIZONTAL", c12, c1)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c2x = GetHSVTransition(stageProg, c4, c1)
					SetGradA(tails[2], "VERTICAL", c2x, c1)
					SetGradA(tails[3], "HORIZONTAL", c2, c1)
					SetGradA(tails[4], "VERTICAL", c3, c2)
					SetGradA(tails[5], "HORIZONTAL", c3, c34)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c2x = GetHSVTransition(stageProg, c3, c4)
					SetGradA(tails[2], "HORIZONTAL", c2x, c4)
					SetGradA(tails[3], "VERTICAL", c4, c1)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
					SetGradA(tails[5], "VERTICAL", c23, c2)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c2x = GetHSVTransition(stageProg, c1, c2)
					SetGradA(tails[2], "HORIZONTAL", c2, c2x)
					SetGradA(tails[3], "VERTICAL", c3, c2)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
					SetGradA(tails[5], "VERTICAL", c4, c41)
				end
			elseif progress < 0.5 + cornerP then
				local stageProg = (progress - 0.5 + cornerP) / cornerP / 2
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c3x = GetHSVTransition(stageProg, c3, c4)
					SetGradA(tails[3], "HORIZONTAL", c3x, c4)
					SetGradA(tails[4], "VERTICAL", c4, c1)
					SetGradA(tails[5], "HORIZONTAL", c12, c1)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c3x = GetHSVTransition(stageProg, c1, c2)
					SetGradA(tails[3], "HORIZONTAL", c2, c3x)
					SetGradA(tails[4], "VERTICAL", c3, c2)
					SetGradA(tails[5], "HORIZONTAL", c3, c34)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c3x = GetHSVTransition(stageProg, c4, c1)
					SetGradA(tails[3], "VERTICAL", c3x, c1)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
					SetGradA(tails[5], "VERTICAL", c23, c2)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c3x = GetHSVTransition(stageProg, c2, c3)
					SetGradA(tails[3], "VERTICAL", c3, c3x)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
					SetGradA(tails[5], "VERTICAL", c4, c41)
				end
			elseif progress < 1 - cornerP then
				local stageProg = (progress - 0.5 - cornerP) / (0.5 - cornerP * 2)
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c4x = GetHSVTransition(stageProg, c4, c1)
					SetGradA(tails[4], "VERTICAL", c4x, c1)
					SetGradA(tails[5], "HORIZONTAL", c12, c1)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c4x = GetHSVTransition(stageProg, c2, c3)
					SetGradA(tails[4], "VERTICAL", c3, c4x)
					SetGradA(tails[5], "HORIZONTAL", c3, c34)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c4x = GetHSVTransition(stageProg, c1, c2)
					SetGradA(tails[4], "HORIZONTAL", c2, c4x)
					SetGradA(tails[5], "VERTICAL", c23, c2)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c4x = GetHSVTransition(stageProg, c3, c4)
					SetGradA(tails[4], "HORIZONTAL", c4x, c4)
					SetGradA(tails[5], "VERTICAL", c4, c41)
				end
			else
				local stageProg = (progress - 1 + cornerP) / cornerP
				if inf.tail.startPoint == "TOP" then
					local c12 = GetHSVTransition(0.5, c1, c2)
					local c5x = GetHSVTransition(stageProg, c1, c12)
					SetGradA(tails[5], "HORIZONTAL", c12, c5x)
				elseif inf.tail.startPoint == "BOTTOM" then
					local c34 = GetHSVTransition(0.5, c3, c4)
					local c5x = GetHSVTransition(stageProg, c3, c34)
					SetGradA(tails[5], "HORIZONTAL", c5x, c34)
				elseif inf.tail.startPoint == "LEFT" then
					local c23 = GetHSVTransition(0.5, c2, c3)
					local c5x = GetHSVTransition(stageProg, c2, c23)
					SetGradA(tails[5], "VERTICAL", c23, c5x)
				else
					local c41 = GetHSVTransition(0.5, c4, c1)
					local c5x = GetHSVTransition(stageProg, c4, c41)
					SetGradA(tails[5], "VERTICAL", c5x, c41)
				end
			end
		end
	end
end

local function BorderSet1LineCorner(f, update)
	local inf = f.inf
	local tails = inf.tail.list
	if not update then
		for _, v in pairs(tails) do
			v:ClearAllPoints()
		end
		if inf.tail.mirror then
			if inf.tail.startPoint == "TOPLEFT" then
				tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
				tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
				tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
				tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
			elseif inf.tail.startPoint == "TOPRIGHT" then
				tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
				tails[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
				tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
				tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT")
			elseif inf.tail.startPoint == "BOTTOMRIGHT" then
				tails[1]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
				tails[2]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
				tails[3]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
				tails[4]:SetPoint("TOPLEFT", f, "TOPLEFT")
			else
				tails[1]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
				tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
				tails[3]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
				tails[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT")
			end
			tails[1]:SetHeight(inf.th)
			tails[2]:SetWidth(inf.th)
			tails[3]:SetWidth(inf.th)
			tails[4]:SetHeight(inf.th)
		else
			if inf.tail.clockwise then
				if inf.tail.startPoint == "TOPRIGHT" then
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[3]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT")
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT")
				elseif inf.tail.startPoint == "TOPLEFT" then
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, inf.th)
					tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[4]:SetPoint("TOPLEFT", f, "TOPLEFT")
				else
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", inf.th, 0)
					tails[2]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -inf.th)
					tails[3]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -inf.th, 0)
					tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
				end
			else
				if inf.tail.startPoint == "TOPRIGHT" then
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT")
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					inf.tail.Set1 = f.SetWidth
					inf.tail.Set2 = f.SetHeight
					tails[1]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[2]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[3]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[4]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT")
				elseif inf.tail.startPoint == "TOPLEFT" then
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -inf.th, 0)
					tails[3]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[4]:SetPoint("TOPLEFT", f, "TOPLEFT")
				else
					inf.tail.Set1 = f.SetHeight
					inf.tail.Set2 = f.SetWidth
					tails[1]:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -inf.th)
					tails[2]:SetPoint("TOPLEFT", f, "TOPLEFT", inf.th, 0)
					tails[3]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, inf.th)
					tails[4]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT")
				end
			end
			inf.tail.Set2(tails[1], inf.th)
			inf.tail.Set1(tails[2], inf.th)
			inf.tail.Set2(tails[3], inf.th)
			inf.tail.Set1(tails[4], inf.th)
		end
	end

	if inf.tail.mirror then
		tails[1]:SetWidth(f:GetWidth() - inf.th)
		tails[2]:SetHeight(f:GetHeight() - inf.th)
		tails[3]:SetHeight(f:GetHeight() - 2 * inf.th)
		tails[4]:SetWidth(f:GetWidth())
	else
		if inf.tail.clockwise and (inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT") or not inf.tail.clockwise and (inf.tail.startPoint == "TOPRIGHT" or inf.tail.startPoint == "BOTTOMLEFT") then
			inf.tail.size1 = f:GetWidth()
			inf.tail.size2 = f:GetHeight()
		else
			inf.tail.size1 = f:GetHeight()
			inf.tail.size2 = f:GetWidth()
		end
		inf.tail.Set1(tails[1], inf.tail.size1 - 2 * inf.th)
		inf.tail.Set2(tails[2], inf.tail.size2 - inf.th)
		inf.tail.Set1(tails[3], inf.tail.size1 - inf.th)
		inf.tail.Set2(tails[4], inf.tail.size2)
	end
	local totalSize = (inf.width or 0) + (inf.height or 0)
	local cornerP_mirror = (totalSize > 0) and (inf.width / totalSize) or 0.5
	if cornerP_mirror < 0.001 then cornerP_mirror = 0.001 elseif cornerP_mirror > 0.999 then cornerP_mirror = 0.999 end
	inf.tail.cornerP_mirror = cornerP_mirror
	local totalSize2 = (inf.tail.size1 or 0) + (inf.tail.size2 or 0)
	local cornerP = (totalSize2 > 0) and (inf.tail.size1 / totalSize2 / 2) or 0.25
	if cornerP < 0.001 then cornerP = 0.001 elseif cornerP > 0.499 then cornerP = 0.499 end
	inf.tail.cornerP = cornerP
end

local function BorderUpdate1LineCorner(f, progress)
	local inf = f.inf
	local tails = inf.tail.list
	local oldProgress = inf.tail.old

	if inf.tail.mirror then
		local cornerP = inf.tail.cornerP_mirror or 0.5
		local updt
		if progress < cornerP then
			if oldProgress > cornerP or oldProgress <= 0 then
				tails[1]:Show()
				tails[2]:Show()
				updt = true
			else
				local stageProg = 1 - progress / cornerP
				tails[1]:SetWidth(stageProg * (inf.width - inf.th))
			end
		else
			if oldProgress >= 0.99 or oldProgress < cornerP then
				tails[1]:Hide()
				tails[2]:Show()
				updt = true
			else
				local stageProg = (1 - progress) / (1 - cornerP)
				tails[2]:SetHeight(stageProg * (inf.height - inf.th))
			end
		end

		if progress < (1 - cornerP) then
			if oldProgress > (1 - cornerP) or oldProgress <= 0 then
				tails[3]:Show()
				tails[4]:Show()
				updt = true
			else
				local stageProg = 1 - progress / (1 - cornerP)
				tails[3]:SetHeight(stageProg * (inf.height - 2 * inf.th))
			end
		else
			if oldProgress >= 0.99 or oldProgress < (1 - cornerP) then
				tails[3]:Hide()
				tails[4]:Show()
				updt = true
			else
				local stageProg = (1 - progress) / cornerP
				tails[4]:SetWidth(stageProg * inf.width)
			end
		end

		if updt then
			BorderSet1LineCorner(f, true)
			if progress < cornerP then
				local stageProg = 1 - progress / cornerP
				tails[1]:SetWidth(stageProg * (inf.width - inf.th))
			else
				local stageProg = (1 - progress) / (1 - cornerP)
				tails[2]:SetHeight(stageProg * (inf.height - inf.th))
			end
			if progress < (1 - cornerP) then
				local stageProg = 1 - progress / (1 - cornerP)
				tails[3]:SetHeight(stageProg * (inf.height - 2 * inf.th))
			else
				local stageProg = (1 - progress) / cornerP
				tails[4]:SetWidth(stageProg * inf.width)
			end
		end
	else
		local cornerP = inf.tail.cornerP or 0.25
		if progress < cornerP then
			if oldProgress > cornerP or oldProgress <= 0 then
				for _, v in pairs(tails) do
					v:Show()
				end
				BorderSet1LineCorner(f, true)
			end
			local stageProg = 1 - progress / cornerP
			inf.tail.Set1(tails[1], stageProg * (inf.tail.size1 - 2 * inf.th))
		elseif progress < 0.5 then
			if oldProgress > 0.5 or oldProgress <= cornerP then
				tails[1]:Hide()
				tails[2]:Show()
				tails[3]:Show()
				tails[4]:Show()
				BorderSet1LineCorner(f, true)
			end
			local stageProg = (0.5 - progress) / (0.5 - cornerP)
			inf.tail.Set2(tails[2], stageProg * (inf.tail.size2 - inf.th))
		elseif progress < (0.5 + cornerP) then
			if oldProgress > (0.5 + cornerP) or oldProgress <= 0.5 then
				tails[1]:Hide()
				tails[2]:Hide()
				tails[3]:Show()
				tails[4]:Show()
				BorderSet1LineCorner(f, true)
			end
			local stageProg = (0.5 + cornerP - progress) / cornerP
			inf.tail.Set1(tails[3], stageProg * (inf.tail.size1 - inf.th))
		else
			if oldProgress >= 0.99 or oldProgress <= (1 - cornerP) then
				tails[1]:Hide()
				tails[2]:Hide()
				tails[3]:Hide()
				tails[4]:Show()
				BorderSet1LineCorner(f, true)
			end
			local stageProg = (1 - progress) / (0.5 - cornerP)
			inf.tail.Set2(tails[4], stageProg * inf.tail.size2)
		end
	end
	inf.tail.old = progress
end

local function BorderGradient1LineCorner(f, progress, elapsed)
	local inf = f.inf
	local tails = inf.tail.list
	local c1, c2, c3, c4 = BorderGradientCorners(inf, elapsed)

	if inf.tail.mirror then
		local cornerP = inf.tail.cornerP_mirror or 0.5
		if progress < cornerP then
			local stageProg = progress / cornerP
			if inf.tail.startPoint == "TOPLEFT" then
				local c1x = GetHSVTransition(stageProg, c2, c1)
				SetGradA(tails[1], "HORIZONTAL", c1x, c1)
				SetGradA(tails[2], "VERTICAL", c4, c1)
			elseif inf.tail.startPoint == "TOPRIGHT" then
				local c1x = GetHSVTransition(stageProg, c1, c2)
				SetGradA(tails[1], "HORIZONTAL", c2, c1x)
				SetGradA(tails[2], "VERTICAL", c3, c2)
			elseif inf.tail.startPoint == "BOTTOMRIGHT" then
				local c1x = GetHSVTransition(stageProg, c4, c3)
				SetGradA(tails[1], "HORIZONTAL", c3, c1x)
				SetGradA(tails[2], "VERTICAL", c3, c2)
			else
				local c1x = GetHSVTransition(stageProg, c3, c4)
				SetGradA(tails[1], "HORIZONTAL", c1x, c4)
				SetGradA(tails[2], "VERTICAL", c4, c1)
			end
		else
			local stageProg = (progress - cornerP) / (1 - cornerP)
			if inf.tail.startPoint == "TOPLEFT" then
				local c2x = GetHSVTransition(stageProg, c1, c4)
				SetGradA(tails[2], "VERTICAL", c4, c2x)
			elseif inf.tail.startPoint == "TOPRIGHT" then
				local c2x = GetHSVTransition(stageProg, c2, c3)
				SetGradA(tails[2], "VERTICAL", c3, c2x)
			elseif inf.tail.startPoint == "BOTTOMRIGHT" then
				local c2x = GetHSVTransition(stageProg, c3, c2)
				SetGradA(tails[2], "VERTICAL", c2x, c2)
			else
				local c2x = GetHSVTransition(stageProg, c4, c1)
				SetGradA(tails[2], "VERTICAL", c2x, c1)
			end
		end
		if progress < (1 - cornerP) then
			local stageProg = progress / (1 - cornerP)
			if inf.tail.startPoint == "TOPLEFT" then
				local c3x = GetHSVTransition(stageProg, c2, c3)
				SetGradA(tails[3], "VERTICAL", c3, c3x)
				SetGradA(tails[4], "HORIZONTAL", c3, c4)
			elseif inf.tail.startPoint == "TOPRIGHT" then
				local c3x = GetHSVTransition(stageProg, c1, c4)
				SetGradA(tails[3], "VERTICAL", c4, c3x)
				SetGradA(tails[4], "HORIZONTAL", c3, c4)
			elseif inf.tail.startPoint == "BOTTOMRIGHT" then
				local c3x = GetHSVTransition(stageProg, c4, c1)
				SetGradA(tails[3], "VERTICAL", c3x, c1)
				SetGradA(tails[4], "HORIZONTAL", c2, c1)
			else
				local c3x = GetHSVTransition(stageProg, c3, c2)
				SetGradA(tails[3], "VERTICAL", c3x, c2)
				SetGradA(tails[4], "HORIZONTAL", c2, c1)
			end
		else
			local stageProg = (progress + cornerP - 1) / cornerP
			if inf.tail.startPoint == "TOPLEFT" then
				local c4x = GetHSVTransition(stageProg, c3, c4)
				SetGradA(tails[4], "HORIZONTAL", c4x, c4)
			elseif inf.tail.startPoint == "TOPRIGHT" then
				local c4x = GetHSVTransition(stageProg, c4, c3)
				SetGradA(tails[4], "HORIZONTAL", c3, c4x)
			elseif inf.tail.startPoint == "BOTTOMRIGHT" then
				local c4x = GetHSVTransition(stageProg, c1, c2)
				SetGradA(tails[4], "HORIZONTAL", c2, c4x)
			else
				local c4x = GetHSVTransition(stageProg, c2, c1)
				SetGradA(tails[4], "HORIZONTAL", c4x, c1)
			end
		end
	else
		local cornerP = inf.tail.cornerP or 0.25
		if inf.tail.clockwise then
			if progress < cornerP then
				local stageProg = progress / cornerP
				if inf.tail.startPoint == "TOPRIGHT" then
					local c1x = GetHSVTransition(stageProg, c1, c4)
					SetGradA(tails[1], "VERTICAL", c4, c1x)
					SetGradA(tails[2], "HORIZONTAL", c3, c4)
					SetGradA(tails[3], "VERTICAL", c3, c2)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					local c1x = GetHSVTransition(stageProg, c3, c2)
					SetGradA(tails[1], "VERTICAL", c1x, c2)
					SetGradA(tails[2], "HORIZONTAL", c2, c1)
					SetGradA(tails[3], "VERTICAL", c4, c1)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
				elseif inf.tail.startPoint == "TOPLEFT" then
					local c1x = GetHSVTransition(stageProg, c2, c1)
					SetGradA(tails[1], "HORIZONTAL", c1x, c1)
					SetGradA(tails[2], "VERTICAL", c4, c1)
					SetGradA(tails[3], "HORIZONTAL", c3, c4)
					SetGradA(tails[4], "VERTICAL", c3, c2)
				else
					local c1x = GetHSVTransition(stageProg, c4, c3)
					SetGradA(tails[1], "HORIZONTAL", c3, c1x)
					SetGradA(tails[2], "VERTICAL", c3, c2)
					SetGradA(tails[3], "HORIZONTAL", c2, c1)
					SetGradA(tails[4], "VERTICAL", c4, c1)
				end
			elseif progress < 0.5 then
				local stageProg = (progress - cornerP) / (0.5 - cornerP)
				if inf.tail.startPoint == "TOPRIGHT" then
					local c2x = GetHSVTransition(stageProg, c4, c3)
					SetGradA(tails[2], "HORIZONTAL", c3, c2x)
					SetGradA(tails[3], "VERTICAL", c3, c2)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					local c2x = GetHSVTransition(stageProg, c2, c1)
					SetGradA(tails[2], "HORIZONTAL", c2x, c1)
					SetGradA(tails[3], "VERTICAL", c4, c1)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
				elseif inf.tail.startPoint == "TOPLEFT" then
					local c2x = GetHSVTransition(stageProg, c1, c4)
					SetGradA(tails[2], "VERTICAL", c4, c2x)
					SetGradA(tails[3], "HORIZONTAL", c3, c4)
					SetGradA(tails[4], "VERTICAL", c3, c2)
				else
					local c2x = GetHSVTransition(stageProg, c3, c2)
					SetGradA(tails[2], "VERTICAL", c2x, c2)
					SetGradA(tails[3], "HORIZONTAL", c2, c1)
					SetGradA(tails[4], "VERTICAL", c4, c1)
				end
			elseif progress < 0.5 + cornerP then
				local stageProg = (progress - 0.5) / cornerP
				if inf.tail.startPoint == "TOPRIGHT" then
					local c3x = GetHSVTransition(stageProg, c3, c2)
					SetGradA(tails[3], "VERTICAL", c3x, c2)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					local c3x = GetHSVTransition(stageProg, c1, c4)
					SetGradA(tails[3], "VERTICAL", c4, c3x)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
				elseif inf.tail.startPoint == "TOPLEFT" then
					local c3x = GetHSVTransition(stageProg, c4, c3)
					SetGradA(tails[3], "HORIZONTAL", c3, c3x)
					SetGradA(tails[4], "VERTICAL", c3, c2)
				else
					local c3x = GetHSVTransition(stageProg, c2, c1)
					SetGradA(tails[3], "HORIZONTAL", c3x, c1)
					SetGradA(tails[4], "VERTICAL", c4, c1)
				end
			else
				local stageProg = (progress - 0.5 - cornerP) / (0.5 - cornerP)
				if inf.tail.startPoint == "TOPRIGHT" then
					local c4x = GetHSVTransition(stageProg, c2, c3)
					SetGradA(tails[4], "HORIZONTAL", c4x, c1)
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					local c4x = GetHSVTransition(stageProg, c4, c3)
					SetGradA(tails[4], "HORIZONTAL", c3, c4x)
				elseif inf.tail.startPoint == "TOPLEFT" then
					local c4x = GetHSVTransition(stageProg, c3, c2)
					SetGradA(tails[4], "VERTICAL", c4x, c2)
				else
					local c4x = GetHSVTransition(stageProg, c1, c4)
					SetGradA(tails[4], "VERTICAL", c4, c4x)
				end
			end
		else
			if progress < cornerP then
				local stageProg = progress / cornerP
				if inf.tail.startPoint == "TOPRIGHT" then
					local c1x = GetHSVTransition(stageProg, c1, c2)
					SetGradA(tails[1], "HORIZONTAL", c2, c1x)
					SetGradA(tails[2], "VERTICAL", c3, c2)
					SetGradA(tails[3], "HORIZONTAL", c3, c4)
					SetGradA(tails[4], "VERTICAL", c4, c1)
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					local c1x = GetHSVTransition(stageProg, c3, c4)
					SetGradA(tails[1], "HORIZONTAL", c1x, c4)
					SetGradA(tails[2], "VERTICAL", c4, c1)
					SetGradA(tails[3], "HORIZONTAL", c2, c1)
					SetGradA(tails[4], "VERTICAL", c3, c2)
				elseif inf.tail.startPoint == "TOPLEFT" then
					local c1x = GetHSVTransition(stageProg, c2, c3)
					SetGradA(tails[1], "VERTICAL", c3, c1x)
					SetGradA(tails[2], "HORIZONTAL", c3, c4)
					SetGradA(tails[3], "VERTICAL", c4, c1)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
				else
					local c1x = GetHSVTransition(stageProg, c4, c1)
					SetGradA(tails[1], "VERTICAL", c1x, c1)
					SetGradA(tails[2], "HORIZONTAL", c2, c1)
					SetGradA(tails[3], "VERTICAL", c3, c2)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
				end
			elseif progress < 0.5 then
				local stageProg = (progress - cornerP) / (0.5 - cornerP)
				if inf.tail.startPoint == "TOPRIGHT" then
					local c2x = GetHSVTransition(stageProg, c2, c3)
					SetGradA(tails[2], "VERTICAL", c3, c2x)
					SetGradA(tails[3], "HORIZONTAL", c3, c4)
					SetGradA(tails[4], "VERTICAL", c4, c1)
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					local c2x = GetHSVTransition(stageProg, c4, c1)
					SetGradA(tails[2], "VERTICAL", c2x, c1)
					SetGradA(tails[3], "HORIZONTAL", c2, c1)
					SetGradA(tails[4], "VERTICAL", c3, c2)
				elseif inf.tail.startPoint == "TOPLEFT" then
					local c2x = GetHSVTransition(stageProg, c3, c4)
					SetGradA(tails[2], "HORIZONTAL", c2x, c4)
					SetGradA(tails[3], "VERTICAL", c4, c1)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
				else
					local c2x = GetHSVTransition(stageProg, c1, c2)
					SetGradA(tails[2], "HORIZONTAL", c2, c2x)
					SetGradA(tails[3], "VERTICAL", c3, c2)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
				end
			elseif progress < 0.5 + cornerP then
				local stageProg = (progress - 0.5) / cornerP
				if inf.tail.startPoint == "TOPRIGHT" then
					local c3x = GetHSVTransition(stageProg, c3, c4)
					SetGradA(tails[3], "HORIZONTAL", c3x, c4)
					SetGradA(tails[4], "VERTICAL", c4, c1)
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					local c3x = GetHSVTransition(stageProg, c1, c2)
					SetGradA(tails[3], "HORIZONTAL", c2, c3x)
					SetGradA(tails[4], "VERTICAL", c3, c2)
				elseif inf.tail.startPoint == "TOPLEFT" then
					local c3x = GetHSVTransition(stageProg, c4, c1)
					SetGradA(tails[3], "VERTICAL", c3x, c1)
					SetGradA(tails[4], "HORIZONTAL", c2, c1)
				else
					local c3x = GetHSVTransition(stageProg, c2, c3)
					SetGradA(tails[3], "VERTICAL", c3, c3x)
					SetGradA(tails[4], "HORIZONTAL", c3, c4)
				end
			else
				local stageProg = (progress - 0.5 - cornerP) / (0.5 - cornerP)
				if inf.tail.startPoint == "TOPRIGHT" then
					local c4x = GetHSVTransition(stageProg, c4, c1)
					SetGradA(tails[4], "VERTICAL", c4x, c1)
				elseif inf.tail.startPoint == "BOTTOMLEFT" then
					local c4x = GetHSVTransition(stageProg, c2, c3)
					SetGradA(tails[4], "VERTICAL", c3, c4x)
				elseif inf.tail.startPoint == "TOPLEFT" then
					local c4x = GetHSVTransition(stageProg, c1, c2)
					SetGradA(tails[4], "HORIZONTAL", c2, c4x)
				else
					local c4x = GetHSVTransition(stageProg, c3, c4)
					SetGradA(tails[4], "HORIZONTAL", c4x, c4)
				end
			end
		end
	end
end

local borderF = {
	TOPLEFT = {
		[1] = {
			Set = BorderSet1LineCorner,
			Update = BorderUpdate1LineCorner,
			Gradient = BorderGradient1LineCorner,
			tailN = 4,
		},
		[2] = {
			Set = BorderSet2LinesCorner,
			Update = BorderUpdate2LinesCorner,
			Gradient = BorderGradient2LinesCorner,
			tailN = 4,
		},
		[4] = {
			Set = BorderSet4LinesCorner,
			Update = BorderUpdate4LinesCorner,
			Gradient = BorderGradient4LinesCorner,
			tailN = 8,
		},
	},
	TOP = {
		[1] = {
			Set = BorderSet1LineCenter,
			Update = BorderUpdate1LineCenter,
			Gradient = BorderGradient1LineCenter,
			tailN = 5,
		},
		[2] = {
			Set = BorderSet2LinesCenter,
			Update = BorderUpdate2LinesCenter,
			Gradient = BorderGradient2LinesCenter,
			tailN = 6,
		},
		[4] = {
			Set = BorderSet4LinesCenter,
			Update = BorderUpdate4LinesCenter,
			Gradient = BorderGradient4LinesCenter,
			tailN = 8,
		},
	},
}
borderF["TOPRIGHT"] = borderF["TOPLEFT"]
borderF["BOTTOMRIGHT"] = borderF["TOPLEFT"]
borderF["BOTTOMLEFT"] = borderF["TOPLEFT"]
borderF["LEFT"] = borderF["TOP"]
borderF["BOTTOM"] = borderF["TOP"]
borderF["RIGHT"] = borderF["TOP"]

local function BorderReverse(startPoint, N)
	if N == 2 then
		if startPoint == "TOP" or startPoint == "BOTTOM" then
			return "LEFT"
		elseif startPoint == "LEFT" or startPoint == "RIGHT" then
			return "TOP"
		elseif startPoint == "TOPLEFT" or startPoint == "BOTTOMRIGHT" then
			return "TOPRIGHT"
		elseif startPoint == "BOTTOMLEFT" or startPoint == "TOPRIGHT" then
			return "TOPLEFT"
		end
	elseif N == 1 then
		if startPoint == "TOP" then
			return "BOTTOM"
		elseif startPoint == "TOPRIGHT" then
			return "BOTTOMLEFT"
		elseif startPoint == "RIGHT" then
			return "LEFT"
		elseif startPoint == "BOTTOMRIGHT" then
			return "TOPLEFT"
		elseif startPoint == "BOTTOM" then
			return "TOP"
		elseif startPoint == "BOTTOMLEFT" then
			return "TOPRIGHT"
		elseif startPoint == "LEFT" then
			return "RIGHT"
		elseif startPoint == "TOPLEFT" then
			return "BOTTOMRIGHT"
		end
	else
		if startPoint == "TOP" or startPoint == "BOTTOM" or startPoint == "LEFT" or startPoint == "RIGHT" then
			return "TOPLEFT"
		elseif startPoint == "TOPLEFT" or startPoint == "BOTTOMRIGHT" or startPoint == "BOTTOMLEFT" or startPoint == "TOPRIGHT" then
			return "TOP"
		end
	end
end

---- Flash Internal Functions ----
local function FlashSetSplit(f, secondStage)
	local inf = f.inf
	for _, tex in pairs(inf.flash.list) do
		tex:ClearAllPoints()
	end

	if inf.flash.startPoint == "LEFT" or inf.flash.startPoint == "RIGHT" then
		inf.flash.Set1 = f.SetWidth
		inf.flash.size1 = f:GetWidth()
		inf.flash.list[1]:SetHeight(f:GetHeight())
		inf.flash.list[2]:SetHeight(f:GetHeight())
		if secondStage then
			inf.flash.list[1]:SetPoint("LEFT", f, "LEFT")
			inf.flash.list[2]:SetPoint("RIGHT", f, "RIGHT")
		else
			inf.flash.list[1]:SetPoint("RIGHT", f, "CENTER")
			inf.flash.list[2]:SetPoint("LEFT", f, "CENTER")
		end
	elseif inf.flash.startPoint == "TOP" or inf.flash.startPoint == "BOTTOM" then
		inf.flash.Set1 = f.SetHeight
		inf.flash.size1 = f:GetHeight()
		inf.flash.list[1]:SetWidth(f:GetWidth())
		inf.flash.list[2]:SetWidth(f:GetWidth())
		if secondStage then
			inf.flash.list[1]:SetPoint("BOTTOM", f, "CENTER")
			inf.flash.list[2]:SetPoint("TOP", f, "CENTER")
		else
			inf.flash.list[1]:SetPoint("TOP", f, "TOP")
			inf.flash.list[2]:SetPoint("BOTTOM", f, "BOTTOM")
		end
	elseif inf.flash.startPoint == "TOPLEFT" or inf.flash.startPoint == "BOTTOMRIGHT" then
		inf.flash.Set1 = f.SetHeight
		inf.flash.size1 = (f:GetHeight() + f:GetWidth()) / 2 * sqrt(2)
		inf.flash.list[1]:SetWidth((f:GetHeight() + f:GetWidth()) / 2 * sqrt(2))
		inf.flash.list[2]:SetWidth((f:GetHeight() + f:GetWidth()) / 2 * sqrt(2))
		if secondStage then
			inf.flash.list[1]:SetPoint("BOTTOM", f, "CENTER")
			inf.flash.list[2]:SetPoint("TOP", f, "CENTER")
			SetTextureRotation(inf.flash.list[1], 0.785, 0.5, 0)
			SetTextureRotation(inf.flash.list[2], 0.785, 0.5, 1)
		else
			inf.flash.list[1]:SetPoint("TOP", f, "TOPLEFT")
			inf.flash.list[2]:SetPoint("BOTTOM", f, "BOTTOMRIGHT")
			SetTextureRotation(inf.flash.list[1], 0.785, 0.5, 1)
			SetTextureRotation(inf.flash.list[2], 0.785, 0.5, 0)
		end
	else
		inf.flash.Set1 = f.SetHeight
		inf.flash.size1 = (f:GetHeight() + f:GetWidth()) / 2 * sqrt(2)
		inf.flash.list[1]:SetWidth((f:GetHeight() + f:GetWidth()) / 2 * sqrt(2))
		inf.flash.list[2]:SetWidth((f:GetHeight() + f:GetWidth()) / 2 * sqrt(2))
		if secondStage then
			inf.flash.list[1]:SetPoint("BOTTOM", f, "CENTER")
			inf.flash.list[2]:SetPoint("TOP", f, "CENTER")
			SetTextureRotation(inf.flash.list[1], -0.785, 0.5, 0)
			SetTextureRotation(inf.flash.list[2], -0.785, 0.5, 1)
		else
			inf.flash.list[1]:SetPoint("TOP", f, "TOPRIGHT")
			inf.flash.list[2]:SetPoint("BOTTOM", f, "BOTTOMLEFT")
			SetTextureRotation(inf.flash.list[1], -0.785, 0.5, 1)
			SetTextureRotation(inf.flash.list[2], -0.785, 0.5, 0)
		end
	end
end

local function FlashUpdateSplit(f, progress)
	local inf = f.inf
	local oldProgress = inf.flash.old
	if progress < 0.5 then
		if oldProgress <= 0 or oldProgress > 0.5 then
			FlashSetSplit(f, false)
		end
		inf.flash.Set1(inf.flash.list[1], inf.flash.size1 * progress)
		inf.flash.Set1(inf.flash.list[2], inf.flash.size1 * progress)
	else
		if oldProgress < 0.5 or oldProgress >= 0.99 then
			FlashSetSplit(f, true)
		end
		local stageProg = 1 - progress
		inf.flash.Set1(inf.flash.list[1], inf.flash.size1 * stageProg)
		inf.flash.Set1(inf.flash.list[2], inf.flash.size1 * stageProg)
	end
	inf.flash.old = progress
end

local function FlashSetShutter(f)
	local inf = f.inf
	for _, tex in pairs(inf.flash.list) do
		tex:ClearAllPoints()
	end

	inf.flash.list[2]:SetPoint("CENTER", f, "CENTER")
	if inf.flash.startPoint == "LEFT" then
		inf.flash.Set1 = f.SetHeight
		inf.flash.size1 = f:GetHeight()
		inf.flash.list[1]:SetPoint("LEFT", f, "LEFT")
		inf.flash.list[3]:SetPoint("RIGHT", f, "RIGHT")
		inf.flash.list[1]:SetWidth(f:GetWidth() / 3)
		inf.flash.list[2]:SetWidth(f:GetWidth() / 3)
		inf.flash.list[3]:SetWidth(f:GetWidth() / 3)
	elseif inf.flash.startPoint == "RIGHT" then
		inf.flash.Set1 = f.SetHeight
		inf.flash.size1 = f:GetHeight()
		inf.flash.list[1]:SetPoint("RIGHT", f, "RIGHT")
		inf.flash.list[3]:SetPoint("LEFT", f, "LEFT")
		inf.flash.list[1]:SetWidth(f:GetWidth() / 3)
		inf.flash.list[2]:SetWidth(f:GetWidth() / 3)
		inf.flash.list[3]:SetWidth(f:GetWidth() / 3)
	elseif inf.flash.startPoint == "TOP" then
		inf.flash.Set1 = f.SetWidth
		inf.flash.size1 = f:GetWidth()
		inf.flash.list[1]:SetPoint("TOP", f, "TOP")
		inf.flash.list[3]:SetPoint("BOTTOM", f, "BOTTOM")
		inf.flash.list[1]:SetHeight(f:GetHeight() / 3)
		inf.flash.list[2]:SetHeight(f:GetHeight() / 3)
		inf.flash.list[3]:SetHeight(f:GetHeight() / 3)
	elseif inf.flash.startPoint == "BOTTOM" then
		inf.flash.Set1 = f.SetWidth
		inf.flash.size1 = f:GetWidth()
		inf.flash.list[1]:SetPoint("BOTTOM", f, "BOTTOM")
		inf.flash.list[3]:SetPoint("TOP", f, "TOP")
		inf.flash.list[1]:SetHeight(f:GetHeight() / 3)
		inf.flash.list[2]:SetHeight(f:GetHeight() / 3)
		inf.flash.list[3]:SetHeight(f:GetHeight() / 3)
	elseif inf.flash.startPoint == "TOPLEFT" then
		inf.flash.Set1 = f.SetWidth
		inf.flash.size1 = (f:GetWidth() + f:GetHeight()) * sqrt(2) / 2
		inf.flash.list[1]:SetPoint("TOP", f, "TOPLEFT")
		inf.flash.list[3]:SetPoint("BOTTOM", f, "BOTTOMRIGHT")
		inf.flash.list[1]:SetHeight(inf.flash.size1 / 3)
		inf.flash.list[2]:SetHeight(inf.flash.size1 / 3 + 0.1)
		inf.flash.list[3]:SetHeight(inf.flash.size1 / 3)
		SetTextureRotation(inf.flash.list[1], 0.785, 0.5, 1)
		SetTextureRotation(inf.flash.list[2], 0.785, 0.5, 0.5)
		SetTextureRotation(inf.flash.list[3], 0.785, 0.5, 0)
	elseif inf.flash.startPoint == "TOPRIGHT" then
		inf.flash.Set1 = f.SetWidth
		inf.flash.size1 = (f:GetWidth() + f:GetHeight()) * sqrt(2) / 2
		inf.flash.list[1]:SetPoint("TOP", f, "TOPRIGHT")
		inf.flash.list[3]:SetPoint("BOTTOM", f, "BOTTOMLEFT")
		inf.flash.list[1]:SetHeight(inf.flash.size1 / 3)
		inf.flash.list[2]:SetHeight(inf.flash.size1 / 3 + 0.1)
		inf.flash.list[3]:SetHeight(inf.flash.size1 / 3)
		SetTextureRotation(inf.flash.list[1], -0.785, 0.5, 1)
		SetTextureRotation(inf.flash.list[2], -0.785, 0.5, 0.5)
		SetTextureRotation(inf.flash.list[3], -0.785, 0.5, 0)
	elseif inf.flash.startPoint == "BOTTOMRIGHT" then
		inf.flash.Set1 = f.SetWidth
		inf.flash.size1 = (f:GetWidth() + f:GetHeight()) * sqrt(2) / 2
		inf.flash.list[1]:SetPoint("BOTTOM", f, "BOTTOMRIGHT")
		inf.flash.list[3]:SetPoint("TOP", f, "TOPLEFT")
		inf.flash.list[1]:SetHeight(inf.flash.size1 / 3)
		inf.flash.list[2]:SetHeight(inf.flash.size1 / 3 + 0.1)
		inf.flash.list[3]:SetHeight(inf.flash.size1 / 3)
		SetTextureRotation(inf.flash.list[1], 0.785, 0.5, 0)
		SetTextureRotation(inf.flash.list[2], 0.785, 0.5, 0.5)
		SetTextureRotation(inf.flash.list[3], 0.785, 0.5, 1)
	else
		inf.flash.Set1 = f.SetWidth
		inf.flash.size1 = (f:GetWidth() + f:GetHeight()) * sqrt(2) / 2
		inf.flash.list[1]:SetPoint("BOTTOM", f, "BOTTOMLEFT")
		inf.flash.list[3]:SetPoint("TOP", f, "TOPRIGHT")
		inf.flash.list[1]:SetHeight(inf.flash.size1 / 3)
		inf.flash.list[2]:SetHeight(inf.flash.size1 / 3 + 0.1)
		inf.flash.list[3]:SetHeight(inf.flash.size1 / 3)
		SetTextureRotation(inf.flash.list[1], -0.785, 0.5, 0)
		SetTextureRotation(inf.flash.list[2], -0.785, 0.5, 0.5)
		SetTextureRotation(inf.flash.list[3], -0.785, 0.5, 1)
	end
end

local function FlashUpdateShutter(f, progress)
	local inf = f.inf
	local oldProgress = inf.flash.old
	if progress < 0.167 then
		if oldProgress <= 0 or oldProgress > 0.167 then
			inf.flash.list[1]:Show()
			inf.flash.list[2]:Hide()
			inf.flash.list[3]:Hide()
		end
		inf.flash.Set1(inf.flash.list[1], inf.flash.size1 * progress * 6)
	elseif progress < 0.333 then
		if oldProgress < 0.167 or oldProgress >= 0.333 then
			inf.flash.list[1]:Show()
			inf.flash.list[2]:Show()
			inf.flash.list[3]:Hide()
			inf.flash.Set1(inf.flash.list[1], inf.flash.size1)
		end
		inf.flash.Set1(inf.flash.list[2], inf.flash.size1 * (progress - 0.167) * 6)
	elseif progress < 0.5 then
		if oldProgress < 0.333 or oldProgress >= 0.5 then
			inf.flash.list[1]:Show()
			inf.flash.list[2]:Show()
			inf.flash.list[3]:Show()
			inf.flash.Set1(inf.flash.list[1], inf.flash.size1)
			inf.flash.Set1(inf.flash.list[2], inf.flash.size1)
		end
		inf.flash.Set1(inf.flash.list[3], inf.flash.size1 * (progress - 0.333) * 6)
	elseif progress < 0.667 then
		if oldProgress < 0.5 or oldProgress >= 0.667 then
			inf.flash.list[1]:Show()
			inf.flash.list[2]:Show()
			inf.flash.list[3]:Show()
			inf.flash.Set1(inf.flash.list[2], inf.flash.size1)
			inf.flash.Set1(inf.flash.list[3], inf.flash.size1)
		end
		inf.flash.Set1(inf.flash.list[1], inf.flash.size1 * (1 - (progress - 0.5) * 6))
	elseif progress < 0.833 then
		if oldProgress < 0.667 or oldProgress >= 0.833 then
			inf.flash.list[1]:Hide()
			inf.flash.list[2]:Show()
			inf.flash.list[3]:Show()
			inf.flash.Set1(inf.flash.list[3], inf.flash.size1)
		end
		inf.flash.Set1(inf.flash.list[2], inf.flash.size1 * (1 - (progress - 0.667) * 6))
	else
		if oldProgress < 0.833 or oldProgress >= 0.99 then
			inf.flash.list[1]:Hide()
			inf.flash.list[2]:Hide()
			inf.flash.list[3]:Show()
		end
		inf.flash.Set1(inf.flash.list[3], inf.flash.size1 * (1 - progress) * 6)
	end
	inf.flash.old = progress
end

local function FlashSetSlide(_) end

local function FlashUpdateSlide(_, _) end

local function FlashSetSquare(_) end

local function FlashUpdateSquare(_, _) end

local flashF = {
	split = {
		Update = FlashUpdateSplit,
		Set = FlashSetSplit,
		flashN = 2,
	},
	shutter = {
		Update = FlashUpdateShutter,
		Set = FlashSetShutter,
		flashN = 3,
	},
	square = {
		Update = FlashUpdateSquare,
		Set = FlashSetSquare,
		flashN = 4,
	},
	slide = {
		Update = FlashUpdateSlide,
		Set = FlashSetSlide,
		flashN = 0,
	},
}

---- Bling ----
local function BlingUpdate(self, elapsed)
	local inf = self.inf
	if not inf then
		SafeReleaseFrame(GlowFramePool, self)
		return
	end
	local progress = self.timer + (inf.reverse and -1 or 1) * elapsed / (inf.duration or 0.65)
	local old, new

	if inf.sine then
		new = sin(1.5708 * progress)
		old = sin(1.5708 * self.timer)
	else
		new = progress
		old = self.timer
	end

	local width, height = self:GetSize()
	if not width or not height or width <= 0 or height <= 0 then
		return
	end

	if self.inf.width ~= width or self.inf.height ~= height then
		if inf.noTails then
			inf.FlashSet(self, new > 0.5)
		else
			inf.FlashSet(self, new > 0.33)
			inf.BorderSet(self)
		end
		self.inf.width = width
		self.inf.height = height
	end

	if inf.noTails then
		if new < 0.5 then
			if old >= 0.5 and inf.midCallback then
				inf.midCallback()
			end
			inf.FlashUpdate(self, new)
		else
			if old <= 0.5 and inf.midCallback then
				inf.midCallback()
			end
			inf.FlashUpdate(self, new)
		end
	else
		if new < 0.33 and old >= 0.33 then
			if inf.midCallback then
				inf.midCallback()
			end
			for _, v in pairs(inf.tail.list) do
				v:Hide()
			end
		end
		if new < 0.66 then
			if old >= 0.66 then
				for _, v in pairs(self.inf.flash.list) do
					v:Show()
				end
				inf.BorderSet(self)
			end
			inf.FlashUpdate(self, new / 0.66)
		elseif old < 0.66 or old >= 0.99 then
			for _, v in pairs(self.inf.flash.list) do
				v:Hide()
			end
		end
		if new > 0.33 then
			if old <= 0.33 then
				if inf.midCallback then
					inf.midCallback()
				end
			end
			if old <= 0.33 or self.timer >= 1 then
				for _, v in pairs(inf.tail.list) do
					v:Show()
				end
				inf.BorderSet(self)
			end
			if new > 0.66 then
				inf.BorderUpdate(self, (new - 0.66) / 0.34)
				if inf.gradient then
					inf.BorderGradient(self, (new - 0.66) / 0.34, elapsed)
				end
			elseif inf.gradient then
				inf.BorderGradient(self, 0, elapsed)
			end
		end
	end
	if progress > 1 or progress < 0 or not self:IsVisible() then
		if inf.endCallback then
			inf.endCallback()
		end
		if self.SetClipsChildren then
			self:SetClipsChildren(false)
		end
		SafeReleaseFrame(GlowFramePool, self)
		return
	end
	self.timer = progress
end

local blingTemplates = {
	default = {
		flash = "split",
		startPoint = "TOPLEFT",
		color = { 0.95, 0.95, 0.95, 0.85 },
		gradient = { { 1, 0.75, 0.75, 1 }, { 0.75, 1, 0.75, 1 }, { 0.75, 0.75, 1, 1 } },
		gradientFrequency = 0.7,
		noTails = false,
		sine = true,
		tails = {
			th = 2,
			N = 1,
			color = { 0.95, 0.95, 0.95, 0.85 },
			startPoint = "BOTTOMLEFT",
			clockwise = true,
			mirror = true,
		},
		reverse = false,
		duration = 0.65,
		xOffset = 0,
		yOffset = 0,
		frameLevel = 8,
	},
}

function lib.Bling(r, options)
	if not r then return end
	local template = options and options.template and blingTemplates[options.template] or blingTemplates.default
	options = AcquireOptions(options, template)

	local BorderSet = borderF[options.tails.startPoint][options.tails.N].Set
	local BorderUpdate = borderF[options.tails.startPoint][options.tails.N].Update
	local BorderGradient = borderF[options.tails.startPoint][options.tails.N].Gradient
	local tailN = options.noTails and 0 or borderF[options.tails.startPoint][options.tails.N].tailN

	local FlashSet = flashF[options.flash].Set
	local FlashUpdate = flashF[options.flash].Update
	local flashN = flashF[options.flash].flashN

	addFrameAndTex(r,options.color,"_Bling",options.key,tailN + flashN,options.xOffset,options.yOffset,textureList.white,{0,1,0,1},nil,options.frameLevel)
	local f = r["_Bling" .. (options.key or "")]

	f.timer = options.reverse and 1 or 0.001

	local inf = f.inf
	if not inf then
		inf = {}
		f.inf = inf
	end
	inf.reverse = options.reverse
	inf.th = options.tails.th
	inf.duration = options.duration
	inf.noTails = options.noTails
	inf.sine = options.sine
	inf.midCallback = options.midCallback
	inf.endCallback = options.endCallback
	inf.gradient = options.gradient
	inf.gradientFrequency = options.gradientFrequency
	inf.width = f:GetWidth()
	inf.height = f:GetHeight()
	inf.BorderSet = BorderSet
	inf.BorderUpdate = BorderUpdate
	inf.BorderGradient = BorderGradient
	inf.FlashUpdate = FlashUpdate
	inf.FlashSet = FlashSet

	local flash = inf.flash
	if not flash then
		flash = { list = {} }
		inf.flash = flash
	end
	flash.startPoint = options.startPoint
	flash.old = options.reverse and 1 or 0
	local flashList = flash.list or {}
	flash.list = flashList
	for i = 1, flashN do
		flashList[i] = f.textures[i]
	end
	for i = flashN + 1, #flashList do
		flashList[i] = nil
	end

	local tail = inf.tail
	if not tail then
		tail = { list = {} }
		inf.tail = tail
	end
	tail.startPoint = options.tails.startPoint
	tail.mirror = options.tails.mirror
	tail.old = options.reverse and 1 or 0
	tail.clockwise = options.tails.clockwise
	local tailList = tail.list or {}
	tail.list = tailList
	for i = 1, tailN do
		tailList[i] = f.textures[i + flashN]
	end
	for i = tailN + 1, #tailList do
		tailList[i] = nil
	end
	if options.tails.color then
		local rCol, gCol, bCol, aCol = GetColorRGBA(options.tails.color)
		for _, v in pairs(tailList) do
			v:SetVertexColor(rCol, gCol, bCol, aCol)
		end
	end

	FlashSet(f, options.reverse)
	BlingUpdate(f, 0.001)

	if f.SetClipsChildren then
		f:SetClipsChildren(true)
	end
	f:SetScript("OnUpdate", BlingUpdate)
end

function lib.Bling_Stop(r, key)
	key = key or ""
	local f = r and r["_Bling" .. key]
	if not f then return end
	if f.SetClipsChildren then
		f:SetClipsChildren(false)
	end
	SafeReleaseFrame(GlowFramePool, f)
end
lib.stopList["Bling"] = lib.Bling_Stop

local BlingParamters = {
	name = "Bling",
	desc = "Creates Bling over target region",
	default = blingTemplates.default,
	start = lib.Bling,
	stop = lib.Bling_Stop,
	type = "group",
	args = {
		flash = {
			name = "Flash",
			desc = "Type of flash",
			type = "select",
			values = {
				["split"] = "split",
				["shutter"] = "shutter",
				["square"] = "square",
				["slide"] = "slide",
			},
		},
		startPoint = {
			name = "Start point",
			desc = "Starting point of flash",
			type = "select",
			values = {
				["TOPLEFT"] = "TOPLEFT",
				["TOP"] = "TOP",
				["TOPRIGHT"] = "TOPRIGHT",
				["RIGHT"] = "RIGHT",
				["BOTTOMRIGHT"] = "BOTTOMRIGHT",
				["BOTTOM"] = "BOTTOM",
				["BOTTOMLEFT"] = "BOTTOMLEFT",
				["LEFT"] = "LEFT",
			},
		},
		color = {
			name = "Color",
			desc = "Color of flash",
			type = "color",
		},
		gradient = {
			name = "Gradient",
			desc = "Gradient of tail lines",
			type = "gradient",
		},
		gradientFrequency = {
			name = "Gradient frequency",
			desc = "Frequency of gradient rotation",
			type = "range",
			softMin = -2,
			softMax = 2,
			step = 0.05,
		},
		noTails = {
			name = "Disable tail lines",
			desc = "Bling will not show lines, only flash",
			type = "toggle",
		},
		sine = {
			name = "Sine",
			desc = "Use sinusoidal progress instead of linear",
			type = "toggle",
		},
		tails = {
			name = "Tail parameters",
			desc = "Parameters of tail lines if enabled",
			type = "group",
			args = {
				th = {
					name = "Tail thickness",
					desc = "Thickness of tails",
					type = "range",
					min = 1,
					softMax = 5,
					step = 1,
				},
				N = {
					name = "Tail N",
					desc = "Number of tail lines",
					type = "select",
					values = {
						["1"] = 1,
						["2"] = 2,
						["4"] = 4,
					},
				},
				color = {
					name = "Tail color",
					desc = "Color of tail lines",
					type = "color",
				},
				startPoint = {
					name = "Tail start point",
					desc = "Starting point of tail lines",
					type = "select",
					values = {
						["TOPLEFT"] = "TOPLEFT",
						["TOP"] = "TOP",
						["TOPRIGHT"] = "TOPRIGHT",
						["RIGHT"] = "RIGHT",
						["BOTTOMRIGHT"] = "BOTTOMRIGHT",
						["BOTTOM"] = "BOTTOM",
						["BOTTOMLEFT"] = "BOTTOMLEFT",
						["LEFT"] = "LEFT",
					},
				},
				clockwise = {
					name = "Clockwise",
					desc = "Direction of tail progress if not mirrored",
					type = "toggle",
				},
				mirror = {
					name = "Mirror",
					desc = "Mirror tail line progress",
					type = "toggle",
				},
			},
		},
		reverse = {
			name = "Reverse",
			desc = "Reverses Bling progress",
			type = "toggle",
		},
		duration = {
			name = "Duration",
			desc = "Bling duration in seconds",
			type = "range",
			min = 0.05,
			softMax = 1,
			step = 0.05,
		},
		xOffset = {
			name = "X offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		yOffset = {
			name = "Y offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		frameLevel = {
			name = "Frame level",
			type = "range",
			softMin = 1,
			softMax = 20,
			min = 0,
			max = 10000,
			step = 1,
		},
	},
}
GlowList["Bling"] = BlingParamters

---- New Glow ----
local function BorderPulseUpdate(self, elapsed)
	if not self.inf then
		SafeReleaseFrame(GlowFramePool, self)
		return
	end

	local progress = (self.timer or 0) + elapsed * (self.inf.frequency or 2) * (self.inf.sign or 1)

	if self.inf.finish and (self.inf.forceStop or progress > 1 or progress < 0 or not self:IsVisible()) then
		SafeReleaseFrame(GlowFramePool, self)
		return
	end

	if self.inf.annoy then
		local annoyProg = (self.inf.annoyProg or 0) + elapsed * (self.inf.annoyFrequency or 0.5)
		if annoyProg > 1 then
			lib.Bling(self, self.inf.flashOptions)
			annoyProg = annoyProg % 1
		end
		self.inf.annoyProg = annoyProg
	end

	local width, height = self:GetSize()
	if not width or not height or width <= 0 or height <= 0 then
		return
	end

	if self.inf.width ~= width or self.inf.height ~= height then
		self.inf.BorderSet(self, true)
		self.inf.width = width
		self.inf.height = height
		self.inf.cornerP = nil
	end
	if progress < 0 or progress > 1 then
		self.inf.tail.old = progress
		self.inf.sign = -self.inf.sign
		progress = 1 - progress % 1

		if self.inf.tail.mirror then
			self.inf.tail.startPoint = BorderReverse(self.inf.tail.startPoint, self.inf.N)
			if self.inf.N == 4 then
				self.inf.BorderSet = borderF[self.inf.tail.startPoint][self.inf.N].Set
				self.inf.BorderUpdate = borderF[self.inf.tail.startPoint][self.inf.N].Update
				self.inf.BorderGradient = borderF[self.inf.tail.startPoint][self.inf.N].Gradient
			end
		else
			self.inf.tail.clockwise = not self.inf.tail.clockwise
		end
		self.inf.BorderSet(self)
	end

	local newProg = self.inf.sine and sin(1.5708 * progress) or progress
	self.inf.BorderUpdate(self, newProg)
	if self.inf.gradient then
		self.inf.BorderGradient(self, newProg, elapsed)
	end
	self.timer = progress
end

local borderPulseTemplates = {
	default = {
		N = 1,
		startPoint = "BOTTOMLEFT",
		th = 2,
		color = { 0.95, 0.95, 0.95, 0.85 },
		gradient = { { 1, 0.75, 0.75, 1 }, { 0.75, 1, 0.75, 1 }, { 0.75, 0.75, 1, 1 } },
		gradientFrequency = 0.7,
		sine = true,
		clockwise = true,
		mirror = true,
		startBling = true,
		repeatBling = true,
		annoy = false,
		annoyFrequency = 0.5,
		blingOptions = blingTemplates.default,
		forceStop = false,
		frequency = 2,
		xOffset = 0,
		yOffset = 0,
		frameLevel = 8,
	},
}
borderPulseTemplates.default.blingOptions.reverse = true
borderPulseTemplates.default.blingOptions.noTails = true
borderPulseTemplates.default.blingOptions.sine = false
borderPulseTemplates.default.blingOptions.duration = 0.5

function lib.BorderPulse_Start(r, options)
	if not r then
		return
	end
	local template = options and options.template and borderPulseTemplates[options.template]
		or borderPulseTemplates.default
	options = AcquireOptions(options, template)

	local BorderSet = borderF[options.startPoint][options.N].Set
	local BorderUpdate = borderF[options.startPoint][options.N].Update
	local BorderGradient = borderF[options.startPoint][options.N].Gradient
	local tailN = borderF[options.startPoint][options.N].tailN

	local update = addFrameAndTex(r,options.color,"_BorderPulse",options.key,tailN,options.xOffset,options.yOffset,textureList.white,{0,1,0,1},nil,options.frameLevel)
	local f = r["_BorderPulse" .. (options.key or "")]

	f.timer = f.timer or 0.001

	local inf = f.inf
	if not inf then
		inf = {}
		f.inf = inf
	end
	inf.N = options.N
	inf.th = options.th
	inf.frequency = options.frequency
	inf.sine = options.sine
	inf.forceStop = options.forceStop
	inf.gradient = options.gradient
	inf.gradientFrequency = options.gradientFrequency
	inf.annoy = options.annoy
	inf.annoyFrequency = options.annoyFrequency
	inf.BorderSet = BorderSet
	inf.BorderUpdate = BorderUpdate
	inf.BorderGradient = BorderGradient
	inf.width = f:GetWidth()
	inf.height = f:GetHeight()
	inf.gProgress = inf.gProgress or 0
	inf.sign = inf.sign or 1

	local tail = inf.tail
	if not tail then
		tail = {}
		inf.tail = tail
	end
	tail.clockwise = options.clockwise
	tail.list = f.textures
	tail.startPoint = options.startPoint
	tail.mirror = options.mirror
	tail.old = tail.old or 0

	if f.inf.sign == -1 then
		if f.inf.tail.mirror then
			f.inf.tail.startPoint = BorderReverse(f.inf.tail.startPoint, f.inf.N)
			if f.inf.N == 4 then
				f.inf.BorderSet = borderF[f.inf.tail.startPoint][f.inf.N].Set
				f.inf.BorderUpdate = borderF[f.inf.tail.startPoint][f.inf.N].Update
				f.inf.BorderGradient = borderF[f.inf.tail.startPoint][f.inf.N].Gradient
			end
		else
			f.inf.tail.clockwise = not f.inf.tail.clockwise
		end
	end

	if options.repeatBling or options.annoy then
		local flashOptions = AcquireOptions(options.blingOptions, blingTemplates.default)
		if not flashOptions.noTails then
			flashOptions.noTails = true
			flashOptions.duration = flashOptions.duration * 0.66
		end
		f.inf.flashOptions = flashOptions
	end

	f.inf.BorderSet(f)
	BorderPulseUpdate(f, 0.001)

	f:SetScript("OnUpdate", BorderPulseUpdate)

	if options.startBling then
		if not update then
			f:Hide()
		end
		if not update then
			options.blingOptions.gradient = options.gradient
			options.blingOptions.midCallback = function()
				if f.name and f.name == "_BorderPulse" .. (options.key or "") then
					f:Show()
				end
			end
			options.blingOptions.endCallback = function()
				if f.name and f.name == "_BorderPulse" .. (options.key or "") then
					f:Show()
					f:SetScript("OnUpdate", BorderPulseUpdate)
				end
			end
			lib.Bling(r, options.blingOptions)
		elseif options.repeatBling then
			lib.Bling(r, f.inf.flashOptions)
		end
	end
end

function lib.BorderPulse_Stop(r, key, force)
	key = key or ""
	local f = r and r["_BorderPulse" .. key]
	if not f then
		return
	end
	if r["_Bling" .. key] and lib.Bling_Stop then
		lib.Bling_Stop(r, key)
	end
	if force or not r:IsVisible() or not f:IsVisible() or not f.inf or f:GetScript("OnUpdate") ~= BorderPulseUpdate then
		SafeReleaseFrame(GlowFramePool, f)
	else
		f.inf.finish = true
	end
end

local BorderPulseParamters = {
	name = "Border Pulse",
	desc = "Creates Border Pulse glow over target region",
	default = borderPulseTemplates.default,
	start = lib.BorderPulse_Start,
	stop = lib.BorderPulse_Stop,
	type = "group",
	args = {
		N = {
			name = "Tail N",
			desc = "Number of tail lines",
			type = "select",
			values = {
				["1"] = 1,
				["2"] = 2,
				["4"] = 4,
			},
		},
		startPoint = {
			name = "Start point",
			desc = "Starting point of flash",
			type = "select",
			values = {
				["TOPLEFT"] = "TOPLEFT",
				["TOP"] = "TOP",
				["TOPRIGHT"] = "TOPRIGHT",
				["RIGHT"] = "RIGHT",
				["BOTTOMRIGHT"] = "BOTTOMRIGHT",
				["BOTTOM"] = "BOTTOM",
				["BOTTOMLEFT"] = "BOTTOMLEFT",
				["LEFT"] = "LEFT",
			},
		},
		th = {
			name = "Tail thickness",
			desc = "Thickness of tails",
			type = "range",
			min = 1,
			softMax = 5,
			step = 1,
		},
		color = {
			name = "Color",
			desc = "Color of flash",
			type = "color",
		},
		gradient = {
			name = "Gradient",
			desc = "Gradient of tail lines",
			type = "gradient",
		},
		gradientFrequency = {
			name = "Gradient frequency",
			desc = "Frequency of gradient rotation",
			type = "range",
			softMin = -2,
			softMax = 2,
			step = 0.05,
		},
		sine = {
			name = "Sine",
			desc = "Use sinusoidal progress instead of linear",
			type = "toggle",
		},
		clockwise = {
			name = "Clockwise",
			desc = "Direction of pulses",
			type = "toggle",
		},
		mirror = {
			name = "Mirror",
			desc = "Mirror tail line progress",
			type = "toggle",
		},
		startBling = {
			name = "Start Bling",
			desc = "Show Bling on first application of glow",
			type = "toggle",
		},
		repeatBling = {
			name = "Repeat Bling",
			desc = "Show Bling on reapplication of glow",
			type = "toggle",
		},
		annoy = {
			name = "Annoy",
			desc = "Repeat Bling periodically while glow is active",
			type = "toggle",
		},
		annoyFrequency = {
			name = "Annoy frequency",
			desc = "Frequency of annoy Bling if eenabled",
			type = "range",
			min = 0.05,
			softMin = 0.25,
			softMax = 2,
			step = 0.05,
		},
		blingOptions = BlingParamters,
		forceStop = {
			name = "Force stop",
			desc = "Stops glow immediately without waiting for period end",
			type = "toggle",
		},
		frequency = {
			name = "Glow frequency",
			desc = "Frequency of glow pulses",
			type = "range",
			softMin = -2,
			softMax = 2,
			step = 0.05,
		},
		xOffset = {
			name = "X offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		yOffset = {
			name = "Y offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		frameLevel = {
			name = "Frame level",
			type = "range",
			softMin = 1,
			softMax = 20,
			min = 0,
			max = 10000,
			step = 1,
		},
	},
}

GlowList["Border Pulse Glow"] = BorderPulseParamters

---- Pixel Glow ----
local pixelTemplates = {
	default = {
		N = 2,
		th = 2,
		color = { 0.95, 0.95, 0.95, 0.85 },
		gradient = { { 1, 0.75, 0.75, 1 }, { 0.75, 1, 0.75, 1 }, { 0.75, 0.75, 1, 1 } },
		gradientFrequency = 0.75,
		startBling = true,
		repeatBling = true,
		annoy = false,
		annoyFrequency = 0.5,
		blingOptions = blingTemplates.default,
		forceStop = false,
		fadeDuration = 0.45,
		frequency = -0.55,
		xOffset = 0,
		yOffset = 0,
		frameLevel = 8,
	},
}

local function PixelUpdateInfo(f)
	local width, height = f:GetSize()
	local sizeChanged = width ~= f.inf.width or height ~= f.inf.height
	local paramChanged = f.inf.th ~= f.inf.lastTh or f.inf.defaultLength ~= f.inf.lastDefaultLength or f.inf.N ~= f.inf.lastN
	if sizeChanged or paramChanged then
		if (width + height) <= 0 then
			return false
		end
		f.inf.length = min(f.inf.defaultLength, width - 2, height - 2)
		if f.inf.length <= 0 then f.inf.length = 1 end
		local perimeter = 2 * (width + height)
		local p = f.inf.p or {}
		p[1] = (width - f.inf.length) / perimeter
		p[2] = width / perimeter
		p[3] = (width + height - f.inf.length) / perimeter
		p[4] = (width + height) / perimeter
		p[5] = (2 * width + height - f.inf.length) / perimeter
		p[6] = (2 * width + height) / perimeter
		p[7] = (perimeter - f.inf.length) / perimeter
		p[8] = 1
		f.inf.p = p
		f.inf.perimeter = perimeter
		f.inf.diffLength = f.inf.length - f.inf.th
		f.inf.invStep = perimeter / f.inf.length
		if f.inf.gradient then
			f.inf.gradientStep = f.inf.length / perimeter
		end

		f.inf.add[1]:ClearAllPoints()
		f.inf.add[1]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -f.inf.th)
		f.inf.add[1]:SetWidth(f.inf.th)

		f.inf.add[2]:ClearAllPoints()
		f.inf.add[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", f.inf.th, 0)
		f.inf.add[2]:SetHeight(f.inf.th)

		f.inf.add[3]:ClearAllPoints()
		f.inf.add[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, f.inf.th)
		f.inf.add[3]:SetWidth(f.inf.th)

		f.inf.add[4]:ClearAllPoints()
		f.inf.add[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -f.inf.th, 0)
		f.inf.add[4]:SetHeight(f.inf.th)

		f.inf.width = width
		f.inf.height = height
		f.inf.lastTh = f.inf.th
		f.inf.lastDefaultLength = f.inf.defaultLength
		f.inf.lastN = f.inf.N

		local offsets = f.inf.offsets or {}
		for i = 1, f.inf.N do
			offsets[i] = (i - 1) / f.inf.N
		end
		for i = f.inf.N + 1, #offsets do
			offsets[i] = nil
		end
		f.inf.offsets = offsets

		return true, true
	end
	return true, false
end

local function PixelSetLine(f, texN, progress)
	local tex = f.textures[texN]
	local p = f.inf.p
	local length = f.inf.length
	local th = f.inf.th

	tex:ClearAllPoints()
	if progress < p[1] then
		tex:SetWidth(length)
		tex:SetHeight(th)
	elseif progress < p[2] then
		tex:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
		tex:SetHeight(th)
	elseif progress < p[3] then
		tex:SetWidth(th)
		tex:SetHeight(length)
	elseif progress < p[4] then
		tex:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
		tex:SetWidth(th)
	elseif progress < p[5] then
		tex:SetWidth(length)
		tex:SetHeight(th)
	elseif progress < p[6] then
		tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
		tex:SetHeight(th)
	elseif progress < p[7] then
		tex:SetWidth(th)
		tex:SetHeight(length)
	else
		tex:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
		tex:SetWidth(th)
	end
end

local function PixelUpdateLine(f, texN, addVisible, oldProgress, progress)
	local tex = f.textures[texN]
	local inf = f.inf
	local p = inf.p
	local length = inf.length
	local th = inf.th
	local perimeter = inf.perimeter
	local invStep = inf.invStep
	local diffLength = inf.diffLength
	if progress < p[1] then
		if oldProgress > p[1] then
			tex:ClearAllPoints()
			tex:SetWidth(length)
			tex:SetHeight(th)
		end
		tex:SetPoint("TOPRIGHT", f, "TOPRIGHT", -progress * perimeter, 0)
	elseif progress < p[2] then
		if oldProgress >= p[2] or oldProgress < p[1] then
			tex:ClearAllPoints()
			tex:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
			tex:SetHeight(th)
		end
		addVisible[1] = true
		local cornerLength = (progress - p[1]) * invStep * diffLength
		tex:SetWidth(diffLength - cornerLength + th)
		inf.add[1]:SetHeight(cornerLength)
	elseif progress < p[3] then
		if oldProgress > p[3] or oldProgress < p[2] then
			tex:ClearAllPoints()
			tex:SetWidth(th)
			tex:SetHeight(length)
		end
		tex:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -(progress - p[2]) * perimeter)
	elseif progress < p[4] then
		if oldProgress >= p[4] or oldProgress < p[3] then
			tex:ClearAllPoints()
			tex:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
			tex:SetWidth(th)
		end
		addVisible[2] = true
		local cornerLength = (progress - p[3]) * invStep * diffLength
		tex:SetHeight(diffLength - cornerLength + th)
		inf.add[2]:SetWidth(cornerLength)
	elseif progress < p[5] then
		if oldProgress > p[5] or oldProgress < p[4] then
			tex:ClearAllPoints()
			tex:SetWidth(length)
			tex:SetHeight(th)
		end
		tex:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", (progress - p[4]) * perimeter, 0)
	elseif progress < p[6] then
		if oldProgress >= p[6] or oldProgress < p[5] then
			tex:ClearAllPoints()
			tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
			tex:SetHeight(th)
		end
		addVisible[3] = true
		local cornerLength = (progress - p[5]) * invStep * diffLength
		tex:SetWidth(diffLength - cornerLength + th)
		inf.add[3]:SetHeight(cornerLength)
	elseif progress < p[7] then
		if oldProgress < p[6] or oldProgress > p[7] then
			tex:ClearAllPoints()
			tex:SetWidth(th)
			tex:SetHeight(length)
		end
		tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, (progress - p[6]) * perimeter)
	else
		if oldProgress < p[7] then
			tex:ClearAllPoints()
			tex:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
			tex:SetWidth(th)
		end
		addVisible[4] = true
		local cornerLength = (progress - p[7]) * invStep * diffLength
		tex:SetHeight(diffLength - cornerLength + th)
		inf.add[4]:SetWidth(cornerLength)
	end
end

local function PixelGradientLine(f, texN, progress, c1, c2)
	local tex = f.textures[texN]
	local inf = f.inf
	local p = inf.p
	local invStep = inf.invStep
	if progress < p[1] then
		SetGradA(tex, "HORIZONTAL", c2, c1)
	elseif progress < p[2] then
		local stageProg = (progress - p[1]) * invStep
		local c12 = GetHSVTransition(1 - stageProg, c1, c2)
		SetGradA(tex, "HORIZONTAL", c12, c1)
		SetGradA(inf.add[1], "VERTICAL", c2, c12)
	elseif progress < p[3] then
		SetGradA(tex, "VERTICAL", c2, c1)
	elseif progress < p[4] then
		local stageProg = (progress - p[3]) * invStep
		local c12 = GetHSVTransition(1 - stageProg, c1, c2)
		SetGradA(tex, "VERTICAL", c12, c1)
		SetGradA(inf.add[2], "HORIZONTAL", c12, c2)
	elseif progress < p[5] then
		SetGradA(tex, "HORIZONTAL", c1, c2)
	elseif progress < p[6] then
		local stageProg = (progress - p[5]) * invStep
		local c12 = GetHSVTransition(1 - stageProg, c1, c2)
		SetGradA(tex, "HORIZONTAL", c1, c12)
		SetGradA(inf.add[3], "VERTICAL", c12, c2)
	elseif progress < p[7] then
		SetGradA(tex, "VERTICAL", c1, c2)
	else
		local stageProg = (progress - p[7]) * invStep
		local c12 = GetHSVTransition(1 - stageProg, c1, c2)
		SetGradA(tex, "VERTICAL", c1, c12)
		SetGradA(inf.add[4], "HORIZONTAL", c2, c12)
	end
end

local function PixelUpdate(self, elapsed)
	local oldProgress = self.timer
	local inf = self.inf
	self.timer = self.timer + elapsed * inf.frequency
	self.timer = self.timer % 1

	if inf.finish then
		inf.fading = inf.fading or 0
		if inf.forceStop or inf.fading > (inf.fadeDuration or 0.3) or not self:IsVisible() then
			SafeReleaseFrame(GlowFramePool, self)
			return
		else
			self:SetAlpha(1 - inf.fading / (inf.fadeDuration or 0.3))
			inf.fading = inf.fading + elapsed
		end
	else
		if inf.annoy then
			local annoyProg = (inf.annoyProg or 0) + elapsed * inf.annoyFrequency
			if annoyProg > 1 then
				lib.Bling(self, inf.flashOptions)
				annoyProg = annoyProg % 1
			end
			inf.annoyProg = annoyProg
		end
	end

	local nonZero, change = PixelUpdateInfo(self)
	if not nonZero then
		return
	end

	local addVisible = inf.addVisible
	local prev1, prev2, prev3, prev4 = addVisible[1], addVisible[2], addVisible[3], addVisible[4]
	addVisible[1], addVisible[2], addVisible[3], addVisible[4] = nil, nil, nil, nil
	local g = inf.gradient
	local N = inf.N
	local timer = self.timer

	local offsets = inf.offsets

	if g then
		local gN = #g
		local gradientPhase = ((inf.gradientPhase or 0) + inf.gradientFrequency * elapsed) % 1
		inf.gradientPhase = gradientPhase
		local gradientStep = inf.gradientStep
		for i = 1, N do
			local offset = offsets[i]
			local old = (oldProgress + offset) % 1
			local new = (timer + offset) % 1
			if change then
				PixelSetLine(self, i, new)
			end
			PixelUpdateLine(self, i, addVisible, old, new)
			local p1 = (new + gradientPhase + 0.001) % 1
			local p2 = (p1 + gradientStep) % 1
			local pos1, pos2 = (p1 * gN) % gN, (p2 * gN) % gN
			local i1 = (floor(pos1) % gN) + 1
			local i2 = (floor(pos2) % gN) + 1
			local c1 = GetHSVTransition(pos1 % 1, g[i1], g[(i1 % gN) + 1])
			local c2 = GetHSVTransition(pos2 % 1, g[i2], g[(i2 % gN) + 1])
			PixelGradientLine(self, i, new, c1, c2)
		end
	else
		for i = 1, N do
			local offset = offsets[i]
			local old = (oldProgress + offset) % 1
			local new = (timer + offset) % 1
			if change then
				PixelSetLine(self, i, new)
			end
			PixelUpdateLine(self, i, addVisible, old, new)
		end
	end
	if addVisible[1] ~= prev1 then inf.add[1]:SetShown(addVisible[1]) end
	if addVisible[2] ~= prev2 then inf.add[2]:SetShown(addVisible[2]) end
	if addVisible[3] ~= prev3 then inf.add[3]:SetShown(addVisible[3]) end
	if addVisible[4] ~= prev4 then inf.add[4]:SetShown(addVisible[4]) end
end

function lib.PixelGlow_Start(r, colorOrOptions, N, frequency, length, th, xOffset, yOffset, border, key, frameLevel)
	if not r then return end

	local options
	if (colorOrOptions ~= nil and (type(colorOrOptions) ~= "table" or colorOrOptions[1] ~= nil or colorOrOptions.GetRGBA)) or N ~= nil or frequency ~= nil or length ~= nil or th ~= nil or xOffset ~= nil or yOffset ~= nil or border ~= nil or key ~= nil or frameLevel ~= nil then
		local d = pixelTemplates.default
		options = {
			color = colorOrOptions or d.color,
			N = N or d.N,
			frequency = frequency or d.frequency,
			length = length,
			th = th or d.th,
			xOffset = xOffset or d.xOffset,
			yOffset = yOffset or d.yOffset,
			border = (border ~= nil) and border or d.border,
			key = key or d.key,
			frameLevel = frameLevel or d.frameLevel,
			fadeDuration = d.fadeDuration,
			forceStop = d.forceStop,
			gradient = d.gradient,
			gradientFrequency = d.gradientFrequency,
			annoy = d.annoy,
			annoyFrequency = d.annoyFrequency,
			startBling = d.startBling,
			repeatBling = d.repeatBling,
			blingOptions = d.blingOptions,
		}
	else
		options = colorOrOptions
		local template = options and options.template and pixelTemplates[options.template] or pixelTemplates.default
		options = AcquireOptions(options, template)
	end

	local update = addFrameAndTex(r,options.color,"_PixelGlow",options.key or "" ,options.N + 4,options.xOffset,options.yOffset,textureList.white,{0,1,0,1},nil,options.frameLevel)
	local f = r["_PixelGlow" .. (options.key or "")]

	local width, height = f:GetSize()

	options.length = options.length or min(floor((width + height) / options.N * 1.25))
	local optLength = min(options.length, width - 2, height - 2)

	f.timer = f.timer or 0.001
	local inf = f.inf
	if not inf then
		inf = {}
		f.inf = inf
	end
	inf.th = options.th
	inf.defaultLength = options.length
	inf.length = optLength
	inf.N = options.N
	inf.frequency = -options.frequency
	inf.annoy = options.annoy
	inf.annoyFrequency = options.annoyFrequency
	inf.gradient = options.gradient
	inf.gradientFrequency = options.gradientFrequency
	inf.gradientStep = optLength / (width + height)
	inf.forceStop = options.forceStop
	inf.fadeDuration = options.fadeDuration
	inf.finish = nil
	inf.fading = nil

	local add = inf.add
	if not add then
		add = {}
		inf.add = add
	end
	add[1] = f.textures[options.N + 1]
	add[2] = f.textures[options.N + 2]
	add[3] = f.textures[options.N + 3]
	add[4] = f.textures[options.N + 4]

	local addVisible = inf.addVisible
	if not addVisible then
		addVisible = {}
		inf.addVisible = addVisible
	else
		wipe(addVisible)
	end
	PixelUpdateInfo(f)
	for i = 1, options.N do
		local new = (f.timer + (i - 1) / options.N) % 1
		PixelSetLine(f, i, new)
		local old = (new + 0.5) % 1
		PixelUpdateLine(f, i, f.inf.addVisible, old, new)
	end

	for i = 1, 4 do
		f.inf.add[i]:SetShown(f.inf.addVisible[i])
	end

	if options.border then
		if not f.bg then
			f.bg = GlowTexPool:Acquire()
			f.bg:SetTexture(textureList.white)
			f.bg:SetParent(f)
			f.bg:SetAllPoints(f)
			f.bg:SetDrawLayer("BACKGROUND", -7)
		end
		local rCol, gCol, bCol, aCol = GetColorRGBA(options.color)
		f.bg:SetVertexColor(rCol, gCol, bCol, aCol * 0.3)
		f.bg:Show()
	else
		if f.bg then
			SafeReleaseTexture(GlowTexPool, f.bg)
			f.bg = nil
		end
	end

	if options.repeatBling or options.annoy then
		local flashOptions = AcquireOptions(options.blingOptions, blingTemplates.default)
		if not flashOptions.noTails then
			flashOptions.noTails = true
			flashOptions.duration = flashOptions.duration * 0.66
		end
		f.inf.flashOptions = flashOptions
	end

	PixelUpdate(f, 0.001)

	f:SetScript("OnUpdate", PixelUpdate)
	if options.startBling then
		if not update then
			f:Hide()
		end
		if not update then
			options.blingOptions.gradient = options.gradient
			options.blingOptions.midCallback = function() if f.name and f.name == "_PixelGlow"..(options.key or "") then f:Show() end end
			options.blingOptions.endCallback = function() if f.name and f.name == "_PixelGlow"..(options.key or "") then f:Show() f:SetScript("OnUpdate", PixelUpdate) end end
			lib.Bling(r, options.blingOptions)
		elseif options.repeatBling then
			lib.Bling(r, f.inf.flashOptions)
		end
	end
end

function lib.PixelGlow_Stop(r, key, force)
	key = key or ""
	if not r or not r["_PixelGlow" .. key] then
		return
	end
	local f = r["_PixelGlow" .. key]
	if r["_Bling" .. key] and lib.Bling_Stop then
		lib.Bling_Stop(r, key)
	end
	if force or not r:IsVisible() or not f:IsVisible() or not f.inf or f:GetScript("OnUpdate") ~= PixelUpdate then
		SafeReleaseFrame(GlowFramePool, f)
	elseif f.inf then
		f.inf.finish = true
	else
		SafeReleaseFrame(GlowFramePool, f)
	end
end
tinsert(lib.glowList, "Pixel Glow")
lib.startList["Pixel Glow"] = lib.PixelGlow_Start
lib.stopList["Pixel Glow"] = lib.PixelGlow_Stop

local PixelGlowParamters = {
	name = "Pixel Glow",
	desc = "Creates Pixel glow over target region",
	default = pixelTemplates.default,
	start = lib.PixelGlow_Start,
	stop = lib.PixelGlow_Stop,
	type = "group",
	args = {
		N = {
			name = "Number of lines",
			desc = "Number of lines",
			type = "range",
			min = 1,
			softMax = 14,
			step = 1,
		},
		th = {
			name = "Line thickness",
			desc = "Thickness of lines",
			type = "range",
			min = 1,
			softMax = 5,
			step = 1,
		},
		color = {
			name = "Color",
			desc = "Color of lines",
			type = "color",
		},
		gradient = {
			name = "Gradient",
			desc = "Gradient of lines",
			type = "gradient",
		},
		gradientFrequency = {
			name = "Gradient frequency",
			desc = "Frequency of gradient rotation",
			type = "range",
			softMin = -2,
			softMax = 2,
			step = 0.05,
		},
		startBling = {
			name = "Start Bling",
			desc = "Show Bling on first application of glow",
			type = "toggle",
		},
		repeatBling = {
			name = "Repeat Bling",
			desc = "Show Bling on reapplication of glow",
			type = "toggle",
		},
		annoy = {
			name = "Annoy",
			desc = "Repeat Bling periodically while glow is active",
			type = "toggle",
		},
		annoyFrequency = {
			name = "Annoy frequency",
			desc = "Frequency of annoy Bling if eenabled",
			type = "range",
			min = 0.05,
			softMin = 0.25,
			softMax = 2,
			step = 0.05,
		},
		blingOptions = BlingParamters,
		forceStop = {
			name = "Force stop",
			desc = "Stops glow immediately without waiting for fade",
			type = "toggle",
		},
		fadeDuration = {
			name = "Fade duration",
			desc = "Duration of fade animation if not forced stop",
			type = "range",
			min = 0,
			softMin = 0.05,
			softMax = 1,
			step = 0.05,
		},
		frequency = {
			name = "Glow frequency",
			type = "range",
			softMin = -2,
			softMax = 2,
			step = 0.05,
		},
		xOffset = {
			name = "X offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		yOffset = {
			name = "Y offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		frameLevel = {
			name = "Frame level",
			type = "range",
			softMin = 1,
			softMax = 20,
			min = 0,
			max = 10000,
			step = 1,
		},
	},
}
GlowList["Pixel Glow"] = PixelGlowParamters

local K_STEPS = { 1, 0.5, 0.3333333333333333, 0.25 }
local function acUpdate(self, elapsed)
	local info = self.info
	local width, height = self:GetSize()
	if width ~= info.width or height ~= info.height then
		if width * height == 0 then
			return
		end
		info.width = width
		info.height = height
		info.perimeter = 2 * (width + height)
		info.bottomlim = height * 2 + width
		info.rightlim = height + width
		info.space = info.perimeter / info.N
	end

	local timer, textures = self.timer, self.textures
	local N, space, perimeter = info.N, info.space, info.perimeter
	local bottomlim, rightlim, infoHeight = info.bottomlim, info.rightlim, info.height
	local step = elapsed * info.frequency
	local texIndex = 0
	for k = 1, 4 do
		local t = (timer[k] + step * K_STEPS[k]) % 1
		timer[k] = t
		local offset = perimeter * t
		for i = 1, N do
			texIndex = texIndex + 1
			local position = (space * i + offset) % perimeter
			if position > bottomlim then
				textures[texIndex]:SetPoint("CENTER", self, "BOTTOMRIGHT", -position + bottomlim, 0)
			elseif position > rightlim then
				textures[texIndex]:SetPoint("CENTER", self, "TOPRIGHT", 0, -position + rightlim)
			elseif position > infoHeight then
				textures[texIndex]:SetPoint("CENTER", self, "TOPLEFT", position - infoHeight, 0)
			else
				textures[texIndex]:SetPoint("CENTER", self, "BOTTOMLEFT", 0, position)
			end
		end
	end
end

local AUTOCAST_SIZES = { 7, 6, 5, 4 }

local autoCastTemplates = {
	default = {
		color = { 0.95, 0.95, 0.32, 1 },
		N = 4,
		frequency = 0.125,
		scale = 1,
		xOffset = 0,
		yOffset = 0,
		frameLevel = 8,
	},
}

function lib.AutoCastGlow_Start(r, colorOrOptions, N, frequency, scale, xOffset, yOffset, key, frameLevel)
	if not r then
		return
	end

	local options
	if (colorOrOptions ~= nil and (type(colorOrOptions) ~= "table" or colorOrOptions[1] ~= nil or colorOrOptions.GetRGBA)) or N ~= nil or frequency ~= nil or scale ~= nil or xOffset ~= nil or yOffset ~= nil or key ~= nil or frameLevel ~= nil then
		options = {
			color = colorOrOptions or autoCastTemplates.default.color,
			N = N or autoCastTemplates.default.N,
			frequency = frequency or autoCastTemplates.default.frequency,
			scale = scale or autoCastTemplates.default.scale,
			xOffset = xOffset or autoCastTemplates.default.xOffset,
			yOffset = yOffset or autoCastTemplates.default.yOffset,
			key = key or "",
			frameLevel = frameLevel or autoCastTemplates.default.frameLevel,
		}
	else
		options = colorOrOptions
		local template = options and options.template and autoCastTemplates[options.template] or autoCastTemplates.default
		options = AcquireOptions(options, template)
		options.key = options.key or ""
	end

	addFrameAndTex(r,options.color,"_AutoCastGlow",options.key,options.N * 4,options.xOffset,options.yOffset,textureList.shine,shineCoords,true, options.frameLevel)
	local f = r["_AutoCastGlow" .. options.key]
	local sparkScale = options.scale
	local sparkN = options.N
	for k = 1, 4 do
		local size = AUTOCAST_SIZES[k] * sparkScale
		for i = 1, sparkN do
			f.textures[i + sparkN * (k - 1)]:SetSize(size, size)
		end
	end
	local timer = f.timer
	if not timer then
		timer = { 0, 0, 0, 0 }
		f.timer = timer
	else
		timer[1], timer[2], timer[3], timer[4] = 0, 0, 0, 0
	end
	if not f.info then
		f.info = {}
	end
	f.info.N = options.N
	f.info.frequency = options.frequency
	f.info.width = nil
	f.info.height = nil
	f:SetScript("OnUpdate", acUpdate)
	acUpdate(f, 0)
end

function lib.AutoCastGlow_Stop(r, key)
	if not r then
		return
	end
	key = key or ""
	if not r["_AutoCastGlow" .. key] then
		return false
	else
		SafeReleaseFrame(GlowFramePool, r["_AutoCastGlow" .. key])
	end
end
tinsert(lib.glowList, "Autocast Shine")
lib.startList["Autocast Shine"] = lib.AutoCastGlow_Start
lib.stopList["Autocast Shine"] = lib.AutoCastGlow_Stop
lib.startList["AutoCast Glow"] = lib.AutoCastGlow_Start
lib.stopList["AutoCast Glow"] = lib.AutoCastGlow_Stop

local AutoCastParamters = {
	name = "AutoCast Glow",
	desc = "Creates AutoCast glow over target region",
	default = autoCastTemplates.default,
	start = lib.AutoCastGlow_Start,
	stop = lib.AutoCastGlow_Stop,
	type = "group",
	args = {
		N = {
			name = "Number of sparks",
			type = "range",
			min = 1,
			softMax = 15,
			step = 1,
		},
		scale = {
			name = "Spark scale",
			type = "range",
			min = 0,
			softMin = 0.25,
			softMax = 4,
			step = 0.05,
		},
		color = {
			name = "Color",
			type = "color",
		},
		frequency = {
			name = "Glow frequency",
			type = "range",
			min = 0.05,
			softMin = 0.05,
			softMax = 2,
			step = 0.05,
		},
		xOffset = {
			name = "X offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		yOffset = {
			name = "Y offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		frameLevel = {
			name = "Frame level",
			desc = "Glow frame level",
			type = "range",
			softMin = 1,
			softMax = 20,
			min = 0,
			max = 10000,
			step = 1,
		},
	},
}
GlowList["AutoCast Glow"] = AutoCastParamters

---- Action Button Glow ----
local function ButtonGlowResetter(_, frame)
	frame:SetScript("OnUpdate", nil)
	local parent = frame:GetParent()
	if parent and parent._ButtonGlow then
		parent._ButtonGlow = nil
	end
	frame.cooldown = nil
	frame:Hide()
	frame:ClearAllPoints()
end
local ButtonGlowPool = CreateFramePool("Frame", GlowParent, nil, ButtonGlowResetter)
lib.ButtonGlowPool = ButtonGlowPool

local function CreateScaleAnim(group, target, order, duration, x, y, delay)
	local scale = group:CreateAnimation("Scale")
	scale:SetChildKey(target)
	scale:SetOrder(order)
	scale:SetDuration(duration)
	scale:SetScale(x, y)

	if delay then
		scale:SetStartDelay(delay)
	end
end

local function CreateAlphaAnim(group, target, order, duration, fromAlpha, toAlpha, delay, appear)
	local alpha = group:CreateAnimation("Alpha")
	alpha:SetChildKey(target)
	alpha:SetOrder(order)
	alpha:SetDuration(duration)
	alpha:SetFromAlpha(fromAlpha)
	alpha:SetToAlpha(toAlpha)
	if delay then
		alpha:SetStartDelay(delay)
	end
	if appear then
		tinsert(group.appear, alpha)
	else
		tinsert(group.fade, alpha)
	end
end

local function AnimIn_OnPlay(group)
	local frame = group:GetParent()
	local frameWidth, frameHeight = frame:GetSize()
	local alpha = GetColorAlpha(frame.color)
	frame.spark:SetSize(frameWidth, frameHeight)
	frame.spark:SetAlpha(not frame.color and 1.0 or 0.3 * alpha)
	frame.innerGlow:SetSize(frameWidth / 2, frameHeight / 2)
	frame.innerGlow:SetAlpha(not frame.color and 1.0 or alpha)
	frame.innerGlowOver:SetAlpha(not frame.color and 1.0 or alpha)
	frame.outerGlow:SetSize(frameWidth * 2, frameHeight * 2)
	frame.outerGlow:SetAlpha(not frame.color and 1.0 or alpha)
	frame.outerGlowOver:SetAlpha(not frame.color and 1.0 or alpha)
	frame.ants:SetSize(frameWidth * 0.85, frameHeight * 0.85)
	frame.ants:SetAlpha(0)
	frame:Show()
end

local function AnimIn_OnFinished(group)
	local frame = group:GetParent()
	local frameWidth, frameHeight = frame:GetSize()
	local alpha = GetColorAlpha(frame.color)
	frame.spark:SetAlpha(0)
	frame.innerGlow:SetAlpha(0)
	frame.innerGlow:SetSize(frameWidth, frameHeight)
	frame.innerGlowOver:SetAlpha(0.0)
	frame.outerGlow:SetSize(frameWidth, frameHeight)
	frame.outerGlowOver:SetAlpha(0.0)
	frame.outerGlowOver:SetSize(frameWidth, frameHeight)
	frame.ants:SetAlpha(not frame.color and 1.0 or alpha)
end

local function AnimIn_OnStop(group)
	local frame = group:GetParent()
	frame.spark:SetAlpha(0)
	frame.innerGlow:SetAlpha(0)
	frame.innerGlowOver:SetAlpha(0.0)
	frame.outerGlowOver:SetAlpha(0.0)
end

local function bgHide(self)
	if self.animOut:IsPlaying() then
		self.animOut:Stop()
		SafeReleaseFrame(ButtonGlowPool, self)
	end
end

local function bgUpdate(self, elapsed)
	AnimateTexCoords(self.ants, 256, 256, 48, 48, 22, elapsed, self.throttle)
	local cooldown = self.cooldown or (self:GetParent() and self:GetParent().cooldown)
	local duration = cooldown and cooldown:IsShown() and cooldown:GetCooldownDuration()
	local targetAlpha
	if (not issecretvalue or not issecretvalue(duration)) and duration and duration > 3000 then
		targetAlpha = 0.5
	else
		targetAlpha = 1.0
	end
	if self._legAlpha ~= targetAlpha then
		self._legAlpha = targetAlpha
		self:SetAlpha(targetAlpha)
	end
end

local function configureButtonGlow(f, alpha)
	f.spark = f:CreateTexture(nil, "BACKGROUND")
	f.spark:SetPoint("CENTER")
	f.spark:SetAlpha(0)
	f.spark:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	f.spark:SetTexCoord(0.00781250, 0.61718750, 0.00390625, 0.26953125)

	-- inner glow
	f.innerGlow = f:CreateTexture(nil, "ARTWORK")
	f.innerGlow:SetPoint("CENTER")
	f.innerGlow:SetAlpha(0)
	f.innerGlow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	f.innerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)

	-- inner glow over
	f.innerGlowOver = f:CreateTexture(nil, "ARTWORK")
	f.innerGlowOver:SetPoint("TOPLEFT", f.innerGlow, "TOPLEFT")
	f.innerGlowOver:SetPoint("BOTTOMRIGHT", f.innerGlow, "BOTTOMRIGHT")
	f.innerGlowOver:SetAlpha(0)
	f.innerGlowOver:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	f.innerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)

	-- outer glow
	f.outerGlow = f:CreateTexture(nil, "ARTWORK")
	f.outerGlow:SetPoint("CENTER")
	f.outerGlow:SetAlpha(0)
	f.outerGlow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	f.outerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)

	-- outer glow over
	f.outerGlowOver = f:CreateTexture(nil, "ARTWORK")
	f.outerGlowOver:SetPoint("TOPLEFT", f.outerGlow, "TOPLEFT")
	f.outerGlowOver:SetPoint("BOTTOMRIGHT", f.outerGlow, "BOTTOMRIGHT")
	f.outerGlowOver:SetAlpha(0)
	f.outerGlowOver:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	f.outerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)

	-- ants
	f.ants = f:CreateTexture(nil, "OVERLAY")
	f.ants:SetPoint("CENTER")
	f.ants:SetAlpha(0)
	f.ants:SetTexture([[Interface\SpellActivationOverlay\IconAlertAnts]])

	f.animIn = f:CreateAnimationGroup()
	f.animIn.appear = {}
	f.animIn.fade = {}
	CreateScaleAnim(f.animIn, "spark", 1, 0.2, 1.5, 1.5)
	CreateAlphaAnim(f.animIn, "spark", 1, 0.2, 0, alpha, nil, true)
	CreateScaleAnim(f.animIn, "innerGlow", 1, 0.3, 2, 2)
	CreateScaleAnim(f.animIn, "innerGlowOver", 1, 0.3, 2, 2)
	CreateAlphaAnim(f.animIn, "innerGlowOver", 1, 0.3, alpha, 0, nil, false)
	CreateScaleAnim(f.animIn, "outerGlow", 1, 0.3, 0.5, 0.5)
	CreateScaleAnim(f.animIn, "outerGlowOver", 1, 0.3, 0.5, 0.5)
	CreateAlphaAnim(f.animIn, "outerGlowOver", 1, 0.3, alpha, 0, nil, false)
	CreateScaleAnim(f.animIn, "spark", 1, 0.2, 2 / 3, 2 / 3, 0.2)
	CreateAlphaAnim(f.animIn, "spark", 1, 0.2, alpha, 0, 0.2, false)
	CreateAlphaAnim(f.animIn, "innerGlow", 1, 0.2, alpha, 0, 0.3, false)
	CreateAlphaAnim(f.animIn, "ants", 1, 0.2, 0, alpha, 0.3, true)
	f.animIn:SetScript("OnPlay", AnimIn_OnPlay)
	f.animIn:SetScript("OnStop", AnimIn_OnStop)
	f.animIn:SetScript("OnFinished", AnimIn_OnFinished)

	f.animOut = f:CreateAnimationGroup()
	f.animOut.appear = {}
	f.animOut.fade = {}
	CreateAlphaAnim(f.animOut, "outerGlowOver", 1, 0.2, 0, alpha, nil, true)
	CreateAlphaAnim(f.animOut, "ants", 1, 0.2, alpha, 0, nil, false)
	CreateAlphaAnim(f.animOut, "outerGlowOver", 2, 0.2, alpha, 0, nil, false)
	CreateAlphaAnim(f.animOut, "outerGlow", 2, 0.2, alpha, 0, nil, false)
	f.animOut:SetScript("OnFinished", function(self)
		SafeReleaseFrame(ButtonGlowPool, self:GetParent())
	end)

	f:SetScript("OnHide", bgHide)
end

local function updateAlphaAnim(f, alpha)
	for _, anim in pairs(f.animIn.appear) do
		anim:SetToAlpha(alpha)
	end
	for _, anim in pairs(f.animIn.fade) do
		anim:SetFromAlpha(alpha)
	end
	for _, anim in pairs(f.animOut.appear) do
		anim:SetToAlpha(alpha)
	end
	for _, anim in pairs(f.animOut.fade) do
		anim:SetFromAlpha(alpha)
	end
end

local ButtonGlowTextures = {
	["spark"] = true,
	["innerGlow"] = true,
	["innerGlowOver"] = true,
	["outerGlow"] = true,
	["outerGlowOver"] = true,
	["ants"] = true,
}

local buttonGlowTemplates = {
	default = {
		color = nil,
		frequency = 0.25,
		xOffset = 0,
		yOffset = 0,
		frameLevel = 8,
	},
}

function lib.ButtonGlow_Start(r, colorOrOptions, frequency, frameLevel)
	if not r then
		return
	end

	local options
	if (colorOrOptions ~= nil and (type(colorOrOptions) ~= "table" or colorOrOptions[1] ~= nil or colorOrOptions.GetRGBA)) or frequency ~= nil or frameLevel ~= nil then
		options = {
			color = colorOrOptions,
			frequency = frequency or 0.25,
			frameLevel = frameLevel or 8,
		}
	else
		options = colorOrOptions
		local template = options and options.template and buttonGlowTemplates[options.template]
			or buttonGlowTemplates.default
		options = AcquireOptions(options, template)
	end

	local throttle
	if options.frequency and options.frequency > 0 then
		throttle = 0.25 / options.frequency * 0.01
	else
		throttle = 0.01
	end

	local color = options.color
	local colorAlpha = GetColorAlpha(color)

	local existing = r._ButtonGlow
	local isValidPoolFrame = existing and IsPoolObjectActive(ButtonGlowPool, existing)

	if existing and isValidPoolFrame then
		local f = r._ButtonGlow
		f.cooldown = r.cooldown
		local width, height = r:GetSize()
		f:SetFrameLevel(r:GetFrameLevel() + options.frameLevel)
		f:SetSize(width * 1.4, height * 1.4)
		f:SetPoint("TOPLEFT", r, "TOPLEFT", -width * 0.2, height * 0.2)
		f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", width * 0.2, -height * 0.2)
		f.ants:SetSize(width * 1.4 * 0.85, height * 1.4 * 0.85)
		AnimIn_OnFinished(f.animIn)
		if f.animOut:IsPlaying() then
			f.animOut:Stop()
			f.animIn:Play()
		end
		if not color then
			for texture in pairs(ButtonGlowTextures) do
				f[texture]:SetDesaturated(nil)
				f[texture]:SetVertexColor(1, 1, 1)
				local alpha = min(f[texture]:GetAlpha() / noZero(GetColorAlpha(f.color)), 1)
				f[texture]:SetAlpha(alpha)
			end
			updateAlphaAnim(f, 1)
			f.color = false
		else
			local cR, cG, cB, cA = GetColorRGBA(color)
			for texture in pairs(ButtonGlowTextures) do
				f[texture]:SetDesaturated(1)
				f[texture]:SetVertexColor(cR, cG, cB)
				local alpha = min(f[texture]:GetAlpha() / noZero(GetColorAlpha(f.color)) * cA, 1)
				f[texture]:SetAlpha(alpha)
			end
			updateAlphaAnim(f, cA)
			f.color = color
		end
		f.throttle = throttle
	else
		if existing then
			existing:Hide()
		end
		local f, new = ButtonGlowPool:Acquire()
		if new then
			configureButtonGlow(f, color and colorAlpha or 1)
		else
			updateAlphaAnim(f, color and colorAlpha or 1)
		end
		r._ButtonGlow = f
		local width, height = r:GetSize()
		f:SetParent(r)
		f.cooldown = r.cooldown
		f:SetFrameLevel(r:GetFrameLevel() + options.frameLevel)
		f:SetSize(width * 1.4, height * 1.4)
		f:SetPoint("TOPLEFT", r, "TOPLEFT", -width * 0.2, height * 0.2)
		f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", width * 0.2, -height * 0.2)
		if not color then
			f.color = false
			for texture in pairs(ButtonGlowTextures) do
				f[texture]:SetDesaturated(nil)
				f[texture]:SetVertexColor(1, 1, 1)
			end
		else
			f.color = color
			local cR, cG, cB = GetColorRGBA(color)
			for texture in pairs(ButtonGlowTextures) do
				f[texture]:SetDesaturated(1)
				f[texture]:SetVertexColor(cR, cG, cB)
			end
		end
		f.throttle = throttle
		f._legAlpha = nil
		f:SetScript("OnUpdate", bgUpdate)

		f.animIn:Play()

		if Masque and Masque.UpdateSpellAlert then
			Masque:UpdateSpellAlert(r, f)
		end
	end
end

function lib.ButtonGlow_Stop(r)
	if r and r._ButtonGlow then
		if not r._ButtonGlow.animOut:IsPlaying() then
			if r._ButtonGlow.animIn:IsPlaying() then
				r._ButtonGlow.animIn:Stop()
				SafeReleaseFrame(ButtonGlowPool, r._ButtonGlow)
			elseif r:IsVisible() then
				r._ButtonGlow.animOut:Play()
			else
				SafeReleaseFrame(ButtonGlowPool, r._ButtonGlow)
			end
		end
	end
end

local ButtonGlowParamters = {
	name = "Blizzard Glow",
	desc = "Creates Blizzard glow over target region",
	default = buttonGlowTemplates.default,
	start = lib.ButtonGlow_Start,
	stop = lib.ButtonGlow_Stop,
	type = "group",
	args = {
		color = {
			name = "Color",
			type = "color",
		},
		frequency = {
			name = "Glow frequency",
			desc = "Frequency of glow",
			type = "range",
			min = 0.05,
			softMin = 0.05,
			softMax = 2,
			step = 0.05,
		},
		xOffset = {
			name = "X offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		yOffset = {
			name = "Y offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		frameLevel = {
			name = "Frame level",
			desc = "Glow frame level",
			type = "range",
			softMin = 1,
			softMax = 20,
			min = 0,
			max = 10000,
			step = 1,
		},
	},
}
GlowList["Action Button Glow"] = ButtonGlowParamters
GlowList["Button Glow"] = ButtonGlowParamters

tinsert(lib.glowList, "Action Button Glow")
lib.startList["Action Button Glow"] = lib.ButtonGlow_Start
lib.stopList["Action Button Glow"] = lib.ButtonGlow_Stop

tinsert(lib.glowList, "Button Glow")
lib.startList["Button Glow"] = lib.ButtonGlow_Start
lib.stopList["Button Glow"] = lib.ButtonGlow_Stop

tinsert(lib.glowList, "AutoCast Glow")

tinsert(lib.glowList, "Border Pulse Glow")
lib.startList["Border Pulse Glow"] = lib.BorderPulse_Start
lib.stopList["Border Pulse Glow"] = lib.BorderPulse_Stop
lib.stopList["Border Pulse"] = lib.BorderPulse_Stop

tinsert(lib.glowList, "Bling")
lib.startList["Bling"] = lib.Bling
lib.stopList["Bling"] = lib.Bling_Stop

---- Proc Glow ----
local function ProcGlowResetter(_, frame)
	frame:Hide()
	frame:ClearAllPoints()
	if frame.ProcStartAnim and frame.ProcStartAnim:IsPlaying() then
		frame.ProcStartAnim:Stop()
	end
	if frame.ProcLoopAnim and frame.ProcLoopAnim:IsPlaying() then
		frame.ProcLoopAnim:Stop()
	end
	local parent = frame:GetParent()
	if frame.key and parent and parent[frame.key] then
		parent[frame.key] = nil
	end
end

local ProcGlowPool = CreateFramePool("Frame", GlowParent, nil, ProcGlowResetter)
lib.ProcGlowPool = ProcGlowPool

local PROC_START_SCALE = (150 / 42) / 1.4

local function ProcGlow_OnHide(self)
	if self.ProcStartAnim:IsPlaying() then
		self.ProcStartAnim:Stop()
	end
	if self.ProcLoopAnim:IsPlaying() then
		self.ProcLoopAnim:Stop()
	end
end

local function ProcGlow_OnShow(self)
	if self.startAnim then
		if not self.ProcStartAnim:IsPlaying() and not self.ProcLoopAnim:IsPlaying() then
			local width, height = self:GetSize()
			self.ProcStart:SetSize(width * PROC_START_SCALE, height * PROC_START_SCALE)
			self.ProcStart:Show()
			self.ProcLoop:Hide()
			self.ProcStartAnim:Play()
		end
	else
		if not self.ProcLoopAnim:IsPlaying() then
			self.ProcStart:Hide()
			self.ProcLoop:Show()
			self.ProcLoopAnim:Play()
		end
	end
end

local function InitProcGlow(f)
	f.ProcStart = f:CreateTexture(nil, "ARTWORK")
	f.ProcStart:SetBlendMode("ADD")
	f.ProcStart:SetAtlas("UI-HUD-ActionBar-Proc-Start-Flipbook")
	f.ProcStart:SetAlpha(1)
	f.ProcStart:SetSize(150, 150)
	f.ProcStart:SetPoint("CENTER")

	f.ProcLoop = f:CreateTexture(nil, "ARTWORK")
	f.ProcLoop:SetAtlas("UI-HUD-ActionBar-Proc-Loop-Flipbook")
	f.ProcLoop:SetAlpha(0)
	f.ProcLoop:SetAllPoints()

	f.ProcLoopAnim = f:CreateAnimationGroup()
	f.ProcLoopAnim:SetLooping("REPEAT")
	f.ProcLoopAnim:SetToFinalAlpha(true)

	local alphaRepeat = f.ProcLoopAnim:CreateAnimation("Alpha")
	alphaRepeat:SetChildKey("ProcLoop")
	alphaRepeat:SetFromAlpha(1)
	alphaRepeat:SetToAlpha(1)
	alphaRepeat:SetDuration(0.001)
	alphaRepeat:SetOrder(0)
	f.ProcLoopAnim.alphaRepeat = alphaRepeat

	local flipbookRepeat = f.ProcLoopAnim:CreateAnimation("FlipBook")
	flipbookRepeat:SetChildKey("ProcLoop")
	flipbookRepeat:SetDuration(1)
	flipbookRepeat:SetOrder(0)
	flipbookRepeat:SetFlipBookRows(6)
	flipbookRepeat:SetFlipBookColumns(5)
	flipbookRepeat:SetFlipBookFrames(30)
	flipbookRepeat:SetFlipBookFrameWidth(0)
	flipbookRepeat:SetFlipBookFrameHeight(0)
	f.ProcLoopAnim.flipbookRepeat = flipbookRepeat

	f.ProcStartAnim = f:CreateAnimationGroup()
	f.ProcStartAnim:SetToFinalAlpha(true)

	local flipbookStartAlphaIn = f.ProcStartAnim:CreateAnimation("Alpha")
	flipbookStartAlphaIn:SetChildKey("ProcStart")
	flipbookStartAlphaIn:SetDuration(0.001)
	flipbookStartAlphaIn:SetOrder(0)
	flipbookStartAlphaIn:SetFromAlpha(1)
	flipbookStartAlphaIn:SetToAlpha(1)

	local flipbookStart = f.ProcStartAnim:CreateAnimation("FlipBook")
	flipbookStart:SetChildKey("ProcStart")
	flipbookStart:SetDuration(0.7)
	flipbookStart:SetOrder(1)
	flipbookStart:SetFlipBookRows(6)
	flipbookStart:SetFlipBookColumns(5)
	flipbookStart:SetFlipBookFrames(30)
	flipbookStart:SetFlipBookFrameWidth(0)
	flipbookStart:SetFlipBookFrameHeight(0)
	f.ProcStartAnim.flipbookStart = flipbookStart

	local flipbookStartAlphaOut = f.ProcStartAnim:CreateAnimation("Alpha")
	flipbookStartAlphaOut:SetChildKey("ProcStart")
	flipbookStartAlphaOut:SetDuration(0.001)
	flipbookStartAlphaOut:SetOrder(2)
	flipbookStartAlphaOut:SetFromAlpha(1)
	flipbookStartAlphaOut:SetToAlpha(0)

	f.ProcStartAnim:SetScript("OnFinished", function(self)
		local p = self:GetParent()
		p.ProcLoopAnim:Play()
		p.ProcLoop:Show()
	end)

	f:SetScript("OnHide", ProcGlow_OnHide)
	f:SetScript("OnShow", ProcGlow_OnShow)
end

local function SetupProcGlow(f, options)
	f.key = "_ProcGlow" .. (options.key or "") -- for resetter
	if not options.color then
		f.ProcStart:SetDesaturated(nil)
		f.ProcStart:SetVertexColor(1, 1, 1, 1)
		f.ProcLoop:SetDesaturated(nil)
		f.ProcLoop:SetVertexColor(1, 1, 1, 1)
	else
		local cR, cG, cB, cA = GetColorRGBA(options.color)
		f.ProcStart:SetDesaturated(1)
		f.ProcStart:SetVertexColor(cR, cG, cB, cA)
		f.ProcLoop:SetDesaturated(1)
		f.ProcLoop:SetVertexColor(cR, cG, cB, cA)
	end
	if f.ProcLoopAnim.flipbookRepeat then
		f.ProcLoopAnim.flipbookRepeat:SetDuration(options.duration or 1)
	end
	f.startAnim = options.startAnim
end

local ProcGlowDefaults = {
	frameLevel = 8,
	color = nil,
	startAnim = true,
	xOffset = 0,
	yOffset = 0,
	duration = 1,
	key = "",
}
local procGlowMeta = { __index = ProcGlowDefaults }

function lib.ProcGlow_Start(r, options, duration, startAnim, xOffset, yOffset, frameLevel, key)
	if not r then
		return
	end

	if (options ~= nil and (type(options) ~= "table" or options[1] ~= nil or options.GetRGBA)) or duration ~= nil or startAnim ~= nil or xOffset ~= nil or yOffset ~= nil or frameLevel ~= nil or key ~= nil then
		options = {
			color = options,
			duration = duration,
			startAnim = (startAnim == nil and true or startAnim),
			xOffset = xOffset,
			yOffset = yOffset,
			frameLevel = frameLevel,
			key = key,
		}
	else
		options = options and DeepCopy(options) or {}
	end
	setmetatable(options, procGlowMeta)

	local glowKey = "_ProcGlow" .. (options.key or "")
	local existing = r[glowKey]
	local isValidPoolFrame = existing and IsPoolObjectActive(ProcGlowPool, existing)
	local f, new
	if existing and isValidPoolFrame then
		f = existing
	else
		if existing then
			existing:Hide()
		end
		f, new = ProcGlowPool:Acquire()
		if new then
			InitProcGlow(f)
		end
		r[glowKey] = f
	end
	f:SetParent(r)
	f:SetFrameLevel(r:GetFrameLevel() + (options.frameLevel or 8))

	local width, height = r:GetSize()
	local xOff = (options.xOffset or 0) + width * 0.2
	local yOff = (options.yOffset or 0) + height * 0.2
	f:SetPoint("TOPLEFT", r, "TOPLEFT", -xOff, yOff)
	f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", xOff, -yOff)

	SetupProcGlow(f, options)
	f:Show()
end

function lib.ProcGlow_Stop(r, key)
	key = key or ""
	local f = r and r["_ProcGlow" .. key]
	if f then
		SafeReleaseFrame(ProcGlowPool, f)
	end
end

local ProcGlowParamters = {
	name = "Proc Glow",
	desc = "Creates Blizzard proc flipbook glow over target region",
	default = ProcGlowDefaults,
	start = lib.ProcGlow_Start,
	stop = lib.ProcGlow_Stop,
	type = "group",
	args = {
		color = {
			name = "Color",
			type = "color",
		},
		duration = {
			name = "Duration",
			desc = "Duration of the loop animation",
			type = "range",
			min = 0.1,
			softMin = 0.5,
			softMax = 3,
			max = 10,
			step = 0.1,
		},
		startAnim = {
			name = "Start Animation",
			desc = "Play the start intro animation",
			type = "toggle",
		},
		xOffset = {
			name = "X offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		yOffset = {
			name = "Y offset",
			type = "range",
			softMin = -5,
			softMax = 5,
			step = 1,
		},
		frameLevel = {
			name = "Frame level",
			desc = "Glow frame level",
			type = "range",
			softMin = 1,
			softMax = 20,
			min = 0,
			max = 10000,
			step = 1,
		},
		key = {
			name = "Key",
			desc = "Key to identify the glow",
			type = "input",
		},
	},
}
GlowList["Proc Glow"] = ProcGlowParamters

tinsert(lib.glowList, "Proc Glow")
lib.startList["Proc Glow"] = lib.ProcGlow_Start
lib.stopList["Proc Glow"] = lib.ProcGlow_Stop
