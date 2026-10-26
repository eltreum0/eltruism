--LibEltreumGlow is a fork of LibCustomGlow

--[[
This library contains work of:
Hendrick "nevcairiel" Leppkes - https://www.wowace.com/projects/libbuttonglow-1-0
Benjamin Staneck - https://github.com/Stanzilla/LibCustomGlow
Dooez - https://github.com/Dooez/LibCustomGlow
]]

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
local hooksecurefunc = _G.hooksecurefunc

local SyncGlowDefaults
local glowDefaultsUnset = true

local sqrt = _G.sqrt
local floor = _G.floor
local min = _G.min
local sin = _G.math.sin
local mathmax = _G.math.max
local abs = _G.math.abs
local HALF_SQRT2 = sqrt(2) * 0.5

local CreateColor = _G.CreateColor
local AnimateTexCoords = (TextureUtil and TextureUtil.AnimateTexCoords) or _G.AnimateTexCoords

local function GetColorRGBA(c)
	if type(c) == "table" then
		local r = c[1] or c.r
		if r then
			return r, c[2] or c.g or 1, c[3] or c.b or 1, c[4] or c.a or 1
		elseif c.GetRGBA then
			return c:GetRGBA()
		end
	end
	return 1, 1, 1, 1
end

local function GetColorAlpha(c)
	if not c then return 1 end
	if type(c) == "table" then
		local a = c[4] or c.a
		if a then return a end
		if c.GetRGBA then
			local _, _, _, rgbaA = c:GetRGBA()
			return rgbaA or 1
		end
	end
	return 1
end

local function noZero(num)
	return (not num or num == 0) and 0.001 or num
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
	IsActive = function(self, object)
		return self.activeObjects[object] ~= nil
	end,
	ReleaseAll = function(self)
		for object in pairs(self.activeObjects) do
			self:Release(object)
		end
	end,
}
GlowMaskPool:Init(GlowParent)
lib.GlowMaskPool = GlowMaskPool

local function IsPoolObjectActive(pool, obj)
	if not pool or not obj then return false end
	if pool.IsActive then
		return pool:IsActive(obj)
	elseif pool.HasActiveObject then
		return pool:HasActiveObject(obj)
	elseif pool.activeObjects then
		return pool.activeObjects[obj] ~= nil
	end
	return false
end

local GlowTexPool, GlowFramePool, ButtonGlowPool, ProcGlowPool
local existingLCG

local function IsLegPoolObject(obj)
	if not obj then return false end
	return IsPoolObjectActive(GlowFramePool, obj)
		or IsPoolObjectActive(ButtonGlowPool, obj)
		or IsPoolObjectActive(ProcGlowPool, obj)
		or IsPoolObjectActive(GlowTexPool, obj)
end

local function ReleaseToExternalPool(obj)
	if not obj or not existingLCG then return false end
	local p = existingLCG.GlowFramePool
	if p and p ~= GlowFramePool and IsPoolObjectActive(p, obj) then p:Release(obj) return true end
	p = existingLCG.ButtonGlowPool
	if p and p ~= ButtonGlowPool and IsPoolObjectActive(p, obj) then p:Release(obj) return true end
	p = existingLCG.ProcGlowPool
	if p and p ~= ProcGlowPool and IsPoolObjectActive(p, obj) then p:Release(obj) return true end
	p = existingLCG.GlowTexPool
	if p and p ~= GlowTexPool and IsPoolObjectActive(p, obj) then p:Release(obj) return true end
	return false
end

local function ProtectPoolRelease(pool)
	if not pool or pool._eltruismProtected then return end
	pool._eltruismProtected = true
	local origRelease = pool.Release
	pool.Release = function(self, obj)
		if not obj then return false end
		if IsPoolObjectActive(self, obj) then
			return origRelease(self, obj)
		elseif self ~= GlowFramePool and self ~= ButtonGlowPool and self ~= ProcGlowPool and self ~= GlowTexPool and IsLegPoolObject(obj) then
			return false
		elseif ReleaseToExternalPool(obj) then
			return true
		else
			if obj.Hide then obj:Hide() end
			if obj.ClearAllPoints then obj:ClearAllPoints() end
			if obj.SetScript then
				obj:SetScript("OnUpdate", nil)
				obj:SetScript("OnHide", nil)
			end
			local parent = obj.GetParent and obj:GetParent()
			if parent then
				if obj.name and parent[obj.name] == obj then
					parent[obj.name] = nil
				end
				if obj.key and parent[obj.key] == obj then
					parent[obj.key] = nil
				end
				if parent._ButtonGlow == obj then
					parent._ButtonGlow = nil
				end
			end
			return false
		end
	end
end

local function ProtectLCG(lcg)
	if not lcg then return end
	existingLCG = lcg
	if lcg.GlowFramePool then ProtectPoolRelease(lcg.GlowFramePool) end
	if lcg.GlowTexPool then ProtectPoolRelease(lcg.GlowTexPool) end
	if lcg.ButtonGlowPool then ProtectPoolRelease(lcg.ButtonGlowPool) end
	if lcg.ProcGlowPool then ProtectPoolRelease(lcg.ProcGlowPool) end
end
lib.ProtectLCG = ProtectLCG
lib.ProtectPoolRelease = ProtectPoolRelease

existingLCG = (_G.LibStub and _G.LibStub("LibCustomGlow-1.0", true)) or (_G.ElvUI and _G.ElvUI[1] and _G.ElvUI[1].Libs and _G.ElvUI[1].Libs.CustomGlow)
if existingLCG then
	ProtectLCG(existingLCG)
end
if hooksecurefunc and _G.LibStub and _G.LibStub.NewLibrary then
	hooksecurefunc(_G.LibStub, "NewLibrary", function(_, major)
		if major == "LibCustomGlow-1.0" then
			local lcg = _G.LibStub("LibCustomGlow-1.0", true)
			if lcg then
				ProtectLCG(lcg)
			end
		end
	end)
end

local TexPoolResetter = function(_, tex)
	if tex.GetNumMaskTextures then
		local maskNum = tex:GetNumMaskTextures()
		for i = maskNum, 1, -1 do
			local mask = tex:GetMaskTexture(i)
			if mask then
				tex:RemoveMaskTexture(mask)
			end
		end
		tex._hasMask = nil
	end
	tex:Hide()
	tex:ClearAllPoints()
	tex:SetSize(0, 0)
	SetTextureRotation(tex, 0, 0.5, 0.5)
	tex:SetVertexColor(1, 1, 1, 1)
	tex:SetAlpha(1)
	if tex.SetDesaturated then
		tex:SetDesaturated(false)
	end
	tex:SetBlendMode("BLEND")
end
GlowTexPool = CreateTexturePool(GlowParent, "ARTWORK", 7, nil, TexPoolResetter)
lib.GlowTexPool = GlowTexPool
ProtectPoolRelease(GlowTexPool)

local function SafeReleaseTexture(pool, tex)
	if not tex then return end
	if IsPoolObjectActive(pool, tex) then
		pool:Release(tex)
	elseif not ReleaseToExternalPool(tex) then
		tex:Hide()
		tex:ClearAllPoints()
	end
end

local function SafeReleaseFrame(pool, frame)
	if not frame then return end
	if IsPoolObjectActive(pool, frame) then
		pool:Release(frame)
	elseif not ReleaseToExternalPool(frame) then
		frame:Hide()
		frame:ClearAllPoints()
		frame:SetScript("OnUpdate", nil)
		frame:SetScript("OnHide", nil)
		local parent = frame.GetParent and frame:GetParent()
		if parent then
			if frame.name and parent[frame.name] == frame then
				parent[frame.name] = nil
			end
			if frame.key and parent[frame.key] == frame then
				parent[frame.key] = nil
			end
			if parent._ButtonGlow == frame then
				parent._ButtonGlow = nil
			end
		end
	end
end

local function SafeReleaseMask(pool, mask)
	if not mask then return end
	if IsPoolObjectActive(pool, mask) then
		pool:Release(mask)
	else
		mask:Hide()
		mask:ClearAllPoints()
	end
end

local FramePoolResetter = function(_, frame)
	frame:SetScript("OnUpdate", nil)
	frame:SetScript("OnHide", nil)
	local parent = frame:GetParent()
	if parent and frame.name and parent[frame.name] then
		parent[frame.name] = nil
	end
	local textures = frame.textures
	if textures then
		for i = 1, #textures do
			SafeReleaseTexture(GlowTexPool, textures[i])
			textures[i] = nil
		end
	else
		frame.textures = {}
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
	if frame.inf then
		local tail = frame.inf.tail
		local flash = frame.inf.flash
		local add = frame.inf.add
		local addVisible = frame.inf.addVisible
		local p = frame.inf.p
		local offsets = frame.inf.offsets
		local flashOptions = frame.inf.flashOptions
		local startBlingOptions = frame.inf.startBlingOptions
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
		if p then frame.inf.p = p end
		if offsets then frame.inf.offsets = offsets end
		if flashOptions then wipe(flashOptions); frame.inf.flashOptions = flashOptions end
		if startBlingOptions then wipe(startBlingOptions); frame.inf.startBlingOptions = startBlingOptions end
	else
		frame.inf = {}
	end
	if frame.info then wipe(frame.info) else frame.info = {} end
	if type(frame.timer) == "table" then
		wipe(frame.timer)
		frame._acTimer = frame.timer
	end
	frame.timer = nil
	frame.name = nil
	frame:SetAlpha(1)
	frame:Hide()
	frame:ClearAllPoints()
end
GlowFramePool = CreateFramePool("Frame", GlowParent, nil, FramePoolResetter)
lib.GlowFramePool = GlowFramePool
ProtectPoolRelease(GlowFramePool)

local function GlowFrame_OnHide(self)
	if self.inf and self.inf.finish then
		SafeReleaseFrame(GlowFramePool, self)
	end
end

local function addFrameAndTex(r, color, name, key, N, xOffset, yOffset, texture, texCoord, desaturated, frameLevel)
	local fullName = (key and key ~= "") and (name .. key) or name
	frameLevel = frameLevel or 8
	xOffset = xOffset or 0
	yOffset = yOffset or 0
	local update = true

	local f = r[fullName]
	local isValidPoolFrame = f and IsPoolObjectActive(GlowFramePool, f)

	if not f or not isValidPoolFrame then
		if f then
			SafeReleaseFrame(GlowFramePool, f)
		end
		f = GlowFramePool:Acquire()
		f:SetParent(r)
		f.name = fullName
		r[fullName] = f
		update = false
	end
	if f.SetClipsChildren then
		f:SetClipsChildren(false)
	end
	f:SetFrameLevel(r:GetFrameLevel() + frameLevel)
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", r, "TOPLEFT", -xOffset + 0.05, yOffset + 0.05)
	f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", xOffset, -yOffset + 0.05)
	f.xOffset = xOffset
	f.yOffset = yOffset

	local rWidth, rHeight = r:GetSize()
	local absX = abs(xOffset)
	local absY = abs(yOffset)
	local width = (rWidth and rWidth > 0) and (rWidth + 2 * absX) or 40
	local height = (rHeight and rHeight > 0) and (rHeight + 2 * absY) or 40
	f:SetSize(width, height)

	f:SetScript("OnHide", GlowFrame_OnHide)
	f:SetAlpha(1)
	f:Show()

	local textures = f.textures
	if not textures then
		textures = {}
		f.textures = textures
	end

	local rCol, gCol, bCol, aCol = GetColorRGBA(color)
	local tc1, tc2, tc3, tc4 = texCoord[1], texCoord[2], texCoord[3], texCoord[4]
	local isClassicAutoCast = not isRetail and name == "_AutoCastGlow"

	for i = 1, N do
		local tex = textures[i]
		if not tex then
			tex = GlowTexPool:Acquire()
			tex:SetTexture(texture)
			tex:SetTexCoord(tc1, tc2, tc3, tc4)
			tex:SetDesaturated(desaturated)
			tex:SetParent(f)
			tex:SetDrawLayer("ARTWORK", 7)
			if isClassicAutoCast then
				tex:SetBlendMode("ADD")
			end
			textures[i] = tex
		end
		SetTextureRotation(tex, 0, 0.5, 0.5)
		tex:SetVertexColor(rCol, gCol, bCol, aCol)
		tex:Show()
	end
	for i = #textures, N + 1, -1 do
		SafeReleaseTexture(GlowTexPool, textures[i])
		textures[i] = nil
	end
	return update, f, width, height
end

local function RGBToHSV(r, g, b)
	local minVal = min(r, g, b)
	local maxVal = mathmax(r, g, b)
	local delta = maxVal - minVal
	local v = maxVal
	if maxVal == 0 then
		return 0, 0, 0
	end
	local s = delta / maxVal
	local h
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

local function GetColorInfo(c)
	if type(c) == "table" then
		local r = c[1] or c.r
		local g = c[2] or c.g or 1
		local b = c[3] or c.b or 1
		local a = c[4] or c.a or 1
		if not r and c.GetRGBA then
			r, g, b, a = c:GetRGBA()
		end
		r = r or 1
		local h = c.h
		if h and c._cr == r and c._cg == g and c._cb == b then
			return r, g, b, a, h, c.s, c.v
		end
		local s, v
		h, s, v = RGBToHSV(r, g, b)
		c.h, c.s, c.v = h, s, v
		c._cr, c._cg, c._cb = r, g, b
		return r, g, b, a, h, s, v
	end
	local h, s, v = RGBToHSV(1, 1, 1)
	return 1, 1, 1, 1, h, s, v
end

local function PrepareGradient(g)
	if type(g) ~= "table" then return end
	for i = 1, #g do
		local c = g[i]
		if type(c) == "table" then
			local r, gr, b, a = GetColorInfo(c)
			c[1], c[2], c[3], c[4] = r, gr, b, a
		end
	end
end

local function GetHSVTransition(perc, c1, c2)
	colorPoolIndex = (colorPoolIndex % 64) + 1
	local col = colorPool[colorPoolIndex]

	local r1, g1, b1, a1, h1, s1, v1 = GetColorInfo(c1)
	if perc <= 0 then
		col[1], col[2], col[3], col[4] = r1, g1, b1, a1
		col.r, col.g, col.b, col.a = r1, g1, b1, a1
		col.h, col.s, col.v = h1, s1, v1
		col._cr, col._cg, col._cb = r1, g1, b1
		return col
	end

	local r2, g2, b2, a2, h2, s2, v2 = GetColorInfo(c2)
	if perc >= 1 then
		col[1], col[2], col[3], col[4] = r2, g2, b2, a2
		col.r, col.g, col.b, col.a = r2, g2, b2, a2
		col.h, col.s, col.v = h2, s2, v2
		col._cr, col._cg, col._cb = r2, g2, b2
		return col
	end

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
	local a = a1 - (a1 - a2) * perc

	col[1], col[2], col[3], col[4] = r, g, b, a
	col.r, col.g, col.b, col.a = r, g, b, a
	col.h, col.s, col.v = h3, s3, v3
	col._cr, col._cg, col._cb = r, g, b
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
			gradColor1.r, gradColor1.g, gradColor1.b, gradColor1.a = r1, g1, b1, a1
			gradColor2.r, gradColor2.g, gradColor2.b, gradColor2.a = r2, g2, b2, a2
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
		for i = 1, #tails do
			tails[i]:ClearAllPoints()
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
		for i = 1, #tails do
			tails[i]:ClearAllPoints()
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
		for i = 1, #tails do
			tails[i]:ClearAllPoints()
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
	local width, height = f:GetSize()
	if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
		inf.tail.size1 = width
		inf.tail.size2 = height
	else
		inf.tail.size1 = height
		inf.tail.size2 = width
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
				for i = 1, #tails do
					tails[i]:Show()
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
				for i = 1, #tails do
					tails[i]:Show()
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
		for i = 1, #tails do
			tails[i]:ClearAllPoints()
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

	local width, height = f:GetSize()
	if inf.tail.mirror then
		tails[1]:SetWidth(width)
		tails[2]:SetHeight(height - inf.th)
		tails[3]:SetHeight(height)
		tails[4]:SetWidth(width - inf.th)
	else
		if inf.tail.clockwise and (inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT") or not inf.tail.clockwise and (inf.tail.startPoint == "BOTTOMLEFT" or inf.tail.startPoint == "TOPRIGHT") then
			inf.tail.size1 = width
			inf.tail.size2 = height
		else
			inf.tail.size1 = height
			inf.tail.size2 = width
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
				for i = 1, #tails do
					tails[i]:Show()
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
		for i = 1, #tails do
			tails[i]:ClearAllPoints()
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
	local width, height = f:GetSize()
	if inf.tail.startPoint == "TOP" or inf.tail.startPoint == "BOTTOM" then
		inf.tail.size1 = width
		inf.tail.size2 = height
	else
		inf.tail.size1 = height
		inf.tail.size2 = width
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
				for i = 1, #tails do
					tails[i]:Show()
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
				for i = 1, #tails do
					tails[i]:Show()
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
		for i = 1, #tails do
			tails[i]:ClearAllPoints()
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

	local width, height = f:GetSize()
	if inf.tail.mirror then
		tails[1]:SetWidth(width - inf.th)
		tails[2]:SetHeight(height - inf.th)
		tails[3]:SetHeight(height - 2 * inf.th)
		tails[4]:SetWidth(width)
	else
		if inf.tail.clockwise and (inf.tail.startPoint == "TOPLEFT" or inf.tail.startPoint == "BOTTOMRIGHT") or not inf.tail.clockwise and (inf.tail.startPoint == "TOPRIGHT" or inf.tail.startPoint == "BOTTOMLEFT") then
			inf.tail.size1 = width
			inf.tail.size2 = height
		else
			inf.tail.size1 = height
			inf.tail.size2 = width
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
				for i = 1, #tails do
					tails[i]:Show()
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

local BORDER_REVERSE_MAP = {
	[1] = { TOP = "BOTTOM", BOTTOM = "TOP", LEFT = "RIGHT", RIGHT = "LEFT", TOPLEFT = "BOTTOMRIGHT", BOTTOMRIGHT = "TOPLEFT", TOPRIGHT = "BOTTOMLEFT", BOTTOMLEFT = "TOPRIGHT" },
	[2] = { TOP = "LEFT", BOTTOM = "LEFT", LEFT = "TOP", RIGHT = "TOP", TOPLEFT = "TOPRIGHT", BOTTOMRIGHT = "TOPRIGHT", BOTTOMLEFT = "TOPLEFT", TOPRIGHT = "TOPLEFT" },
	[4] = { TOP = "TOPLEFT", BOTTOM = "TOPLEFT", LEFT = "TOPLEFT", RIGHT = "TOPLEFT", TOPLEFT = "TOP", BOTTOMRIGHT = "TOP", BOTTOMLEFT = "TOP", TOPRIGHT = "TOP" },
}

local function BorderReverse(startPoint, N)
	local map = BORDER_REVERSE_MAP[N] or BORDER_REVERSE_MAP[4]
	return (map and map[startPoint]) or startPoint
end

---- Flash Internal Functions ----
local function FlashSetSplit(f, secondStage)
	local inf = f.inf
	local flash = inf.flash
	local list = flash.list
	local tex1, tex2 = list[1], list[2]
	for i = 1, #list do
		list[i]:ClearAllPoints()
	end

	local width, height = f:GetSize()
	local startPoint = flash.startPoint
	if startPoint == "LEFT" or startPoint == "RIGHT" then
		flash.Set1 = f.SetWidth
		flash.size1 = width
		tex1:SetHeight(height)
		tex2:SetHeight(height)
		if secondStage then
			tex1:SetPoint("LEFT", f, "LEFT")
			tex2:SetPoint("RIGHT", f, "RIGHT")
		else
			tex1:SetPoint("RIGHT", f, "CENTER")
			tex2:SetPoint("LEFT", f, "CENTER")
		end
	elseif startPoint == "TOP" or startPoint == "BOTTOM" then
		flash.Set1 = f.SetHeight
		flash.size1 = height
		tex1:SetWidth(width)
		tex2:SetWidth(width)
		if secondStage then
			tex1:SetPoint("BOTTOM", f, "CENTER")
			tex2:SetPoint("TOP", f, "CENTER")
		else
			tex1:SetPoint("TOP", f, "TOP")
			tex2:SetPoint("BOTTOM", f, "BOTTOM")
		end
	elseif startPoint == "TOPLEFT" or startPoint == "BOTTOMRIGHT" then
		local diagSize = (height + width) * HALF_SQRT2
		flash.Set1 = f.SetHeight
		flash.size1 = diagSize
		tex1:SetWidth(diagSize)
		tex2:SetWidth(diagSize)
		if secondStage then
			tex1:SetPoint("BOTTOM", f, "CENTER")
			tex2:SetPoint("TOP", f, "CENTER")
			SetTextureRotation(tex1, 0.785, 0.5, 0)
			SetTextureRotation(tex2, 0.785, 0.5, 1)
		else
			tex1:SetPoint("TOP", f, "TOPLEFT")
			tex2:SetPoint("BOTTOM", f, "BOTTOMRIGHT")
			SetTextureRotation(tex1, 0.785, 0.5, 1)
			SetTextureRotation(tex2, 0.785, 0.5, 0)
		end
	else
		local diagSize = (height + width) * HALF_SQRT2
		flash.Set1 = f.SetHeight
		flash.size1 = diagSize
		tex1:SetWidth(diagSize)
		tex2:SetWidth(diagSize)
		if secondStage then
			tex1:SetPoint("BOTTOM", f, "CENTER")
			tex2:SetPoint("TOP", f, "CENTER")
			SetTextureRotation(tex1, -0.785, 0.5, 0)
			SetTextureRotation(tex2, -0.785, 0.5, 1)
		else
			tex1:SetPoint("TOP", f, "TOPRIGHT")
			tex2:SetPoint("BOTTOM", f, "BOTTOMLEFT")
			SetTextureRotation(tex1, -0.785, 0.5, 1)
			SetTextureRotation(tex2, -0.785, 0.5, 0)
		end
	end
end

local function FlashUpdateSplit(f, progress)
	local flash = f.inf.flash
	local oldProgress = flash.old
	local list = flash.list
	if progress < 0.5 then
		if oldProgress <= 0 or oldProgress > 0.5 then
			FlashSetSplit(f, false)
		end
		local size = flash.size1 * progress
		flash.Set1(list[1], size)
		flash.Set1(list[2], size)
	else
		if oldProgress < 0.5 or oldProgress >= 0.99 then
			FlashSetSplit(f, true)
		end
		local size = flash.size1 * (1 - progress)
		flash.Set1(list[1], size)
		flash.Set1(list[2], size)
	end
	flash.old = progress
end

local function FlashSetShutter(f)
	local inf = f.inf
	local flash = inf.flash
	local list = flash.list
	local tex1, tex2, tex3 = list[1], list[2], list[3]
	for i = 1, #list do
		list[i]:ClearAllPoints()
	end

	local width, height = f:GetSize()
	local startPoint = flash.startPoint
	tex2:SetPoint("CENTER", f, "CENTER")
	if startPoint == "LEFT" then
		local thirdW = width / 3
		flash.Set1 = f.SetHeight
		flash.size1 = height
		tex1:SetPoint("LEFT", f, "LEFT")
		tex3:SetPoint("RIGHT", f, "RIGHT")
		tex1:SetWidth(thirdW)
		tex2:SetWidth(thirdW)
		tex3:SetWidth(thirdW)
	elseif startPoint == "RIGHT" then
		local thirdW = width / 3
		flash.Set1 = f.SetHeight
		flash.size1 = height
		tex1:SetPoint("RIGHT", f, "RIGHT")
		tex3:SetPoint("LEFT", f, "LEFT")
		tex1:SetWidth(thirdW)
		tex2:SetWidth(thirdW)
		tex3:SetWidth(thirdW)
	elseif startPoint == "TOP" then
		local thirdH = height / 3
		flash.Set1 = f.SetWidth
		flash.size1 = width
		tex1:SetPoint("TOP", f, "TOP")
		tex3:SetPoint("BOTTOM", f, "BOTTOM")
		tex1:SetHeight(thirdH)
		tex2:SetHeight(thirdH)
		tex3:SetHeight(thirdH)
	elseif startPoint == "BOTTOM" then
		local thirdH = height / 3
		flash.Set1 = f.SetWidth
		flash.size1 = width
		tex1:SetPoint("BOTTOM", f, "BOTTOM")
		tex3:SetPoint("TOP", f, "TOP")
		tex1:SetHeight(thirdH)
		tex2:SetHeight(thirdH)
		tex3:SetHeight(thirdH)
	elseif startPoint == "TOPLEFT" then
		local diagSize = (width + height) * HALF_SQRT2
		local thirdDiag = diagSize / 3
		flash.Set1 = f.SetWidth
		flash.size1 = diagSize
		tex1:SetPoint("TOP", f, "TOPLEFT")
		tex3:SetPoint("BOTTOM", f, "BOTTOMRIGHT")
		tex1:SetHeight(thirdDiag)
		tex2:SetHeight(thirdDiag + 0.1)
		tex3:SetHeight(thirdDiag)
		SetTextureRotation(tex1, 0.785, 0.5, 1)
		SetTextureRotation(tex2, 0.785, 0.5, 0.5)
		SetTextureRotation(tex3, 0.785, 0.5, 0)
	elseif startPoint == "TOPRIGHT" then
		local diagSize = (width + height) * HALF_SQRT2
		local thirdDiag = diagSize / 3
		flash.Set1 = f.SetWidth
		flash.size1 = diagSize
		tex1:SetPoint("TOP", f, "TOPRIGHT")
		tex3:SetPoint("BOTTOM", f, "BOTTOMLEFT")
		tex1:SetHeight(thirdDiag)
		tex2:SetHeight(thirdDiag + 0.1)
		tex3:SetHeight(thirdDiag)
		SetTextureRotation(tex1, -0.785, 0.5, 1)
		SetTextureRotation(tex2, -0.785, 0.5, 0.5)
		SetTextureRotation(tex3, -0.785, 0.5, 0)
	elseif startPoint == "BOTTOMRIGHT" then
		local diagSize = (width + height) * HALF_SQRT2
		local thirdDiag = diagSize / 3
		flash.Set1 = f.SetWidth
		flash.size1 = diagSize
		tex1:SetPoint("BOTTOM", f, "BOTTOMRIGHT")
		tex3:SetPoint("TOP", f, "TOPLEFT")
		tex1:SetHeight(thirdDiag)
		tex2:SetHeight(thirdDiag + 0.1)
		tex3:SetHeight(thirdDiag)
		SetTextureRotation(tex1, 0.785, 0.5, 0)
		SetTextureRotation(tex2, 0.785, 0.5, 0.5)
		SetTextureRotation(tex3, 0.785, 0.5, 1)
	else
		local diagSize = (width + height) * HALF_SQRT2
		local thirdDiag = diagSize / 3
		flash.Set1 = f.SetWidth
		flash.size1 = diagSize
		tex1:SetPoint("BOTTOM", f, "BOTTOMLEFT")
		tex3:SetPoint("TOP", f, "TOPRIGHT")
		tex1:SetHeight(thirdDiag)
		tex2:SetHeight(thirdDiag + 0.1)
		tex3:SetHeight(thirdDiag)
		SetTextureRotation(tex1, -0.785, 0.5, 0)
		SetTextureRotation(tex2, -0.785, 0.5, 0.5)
		SetTextureRotation(tex3, -0.785, 0.5, 1)
	end
end

local function FlashUpdateShutter(f, progress)
	local flash = f.inf.flash
	local oldProgress = flash.old
	local list = flash.list
	local tex1, tex2, tex3 = list[1], list[2], list[3]
	local Set1 = flash.Set1
	local size1 = flash.size1
	if progress < 0.167 then
		if oldProgress <= 0 or oldProgress > 0.167 then
			tex1:Show()
			tex2:Hide()
			tex3:Hide()
		end
		Set1(tex1, size1 * progress * 6)
	elseif progress < 0.333 then
		if oldProgress < 0.167 or oldProgress >= 0.333 then
			tex1:Show()
			tex2:Show()
			tex3:Hide()
			Set1(tex1, size1)
		end
		Set1(tex2, size1 * (progress - 0.167) * 6)
	elseif progress < 0.5 then
		if oldProgress < 0.333 or oldProgress >= 0.5 then
			tex1:Show()
			tex2:Show()
			tex3:Show()
			Set1(tex1, size1)
			Set1(tex2, size1)
		end
		Set1(tex3, size1 * (progress - 0.333) * 6)
	elseif progress < 0.667 then
		if oldProgress < 0.5 or oldProgress >= 0.667 then
			tex1:Show()
			tex2:Show()
			tex3:Show()
			Set1(tex2, size1)
			Set1(tex3, size1)
		end
		Set1(tex1, size1 * (1 - (progress - 0.5) * 6))
	elseif progress < 0.833 then
		if oldProgress < 0.667 or oldProgress >= 0.833 then
			tex1:Hide()
			tex2:Show()
			tex3:Show()
			Set1(tex3, size1)
		end
		Set1(tex2, size1 * (1 - (progress - 0.667) * 6))
	else
		if oldProgress < 0.833 or oldProgress >= 0.99 then
			tex1:Hide()
			tex2:Hide()
			tex3:Show()
		end
		Set1(tex3, size1 * (1 - progress) * 6)
	end
	flash.old = progress
end

local function FlashSetSlide(f, secondStage)
	local inf = f.inf
	local flash = inf.flash
	local tex = flash.list[1]
	tex:ClearAllPoints()
	tex:Show()

	local width, height = f:GetSize()
	local startPoint = flash.startPoint
	if startPoint == "LEFT" then
		flash.Set1 = f.SetWidth
		flash.size1 = width
		tex:SetHeight(height)
		if secondStage then
			tex:SetPoint("RIGHT", f, "RIGHT")
		else
			tex:SetPoint("LEFT", f, "LEFT")
		end
	elseif startPoint == "RIGHT" then
		flash.Set1 = f.SetWidth
		flash.size1 = width
		tex:SetHeight(height)
		if secondStage then
			tex:SetPoint("LEFT", f, "LEFT")
		else
			tex:SetPoint("RIGHT", f, "RIGHT")
		end
	elseif startPoint == "TOP" then
		flash.Set1 = f.SetHeight
		flash.size1 = height
		tex:SetWidth(width)
		if secondStage then
			tex:SetPoint("BOTTOM", f, "BOTTOM")
		else
			tex:SetPoint("TOP", f, "TOP")
		end
	elseif startPoint == "BOTTOM" then
		flash.Set1 = f.SetHeight
		flash.size1 = height
		tex:SetWidth(width)
		if secondStage then
			tex:SetPoint("TOP", f, "TOP")
		else
			tex:SetPoint("BOTTOM", f, "BOTTOM")
		end
	elseif startPoint == "TOPLEFT" then
		local diagSize = (height + width) * HALF_SQRT2
		flash.Set1 = f.SetHeight
		flash.size1 = diagSize
		tex:SetWidth(diagSize)
		if secondStage then
			tex:SetPoint("BOTTOM", f, "BOTTOMRIGHT")
			SetTextureRotation(tex, 0.785, 0.5, 0)
		else
			tex:SetPoint("TOP", f, "TOPLEFT")
			SetTextureRotation(tex, 0.785, 0.5, 1)
		end
	elseif startPoint == "BOTTOMRIGHT" then
		local diagSize = (height + width) * HALF_SQRT2
		flash.Set1 = f.SetHeight
		flash.size1 = diagSize
		tex:SetWidth(diagSize)
		if secondStage then
			tex:SetPoint("TOP", f, "TOPLEFT")
			SetTextureRotation(tex, 0.785, 0.5, 1)
		else
			tex:SetPoint("BOTTOM", f, "BOTTOMRIGHT")
			SetTextureRotation(tex, 0.785, 0.5, 0)
		end
	elseif startPoint == "TOPRIGHT" then
		local diagSize = (height + width) * HALF_SQRT2
		flash.Set1 = f.SetHeight
		flash.size1 = diagSize
		tex:SetWidth(diagSize)
		if secondStage then
			tex:SetPoint("BOTTOM", f, "BOTTOMLEFT")
			SetTextureRotation(tex, -0.785, 0.5, 0)
		else
			tex:SetPoint("TOP", f, "TOPRIGHT")
			SetTextureRotation(tex, -0.785, 0.5, 1)
		end
	else
		local diagSize = (height + width) * HALF_SQRT2
		flash.Set1 = f.SetHeight
		flash.size1 = diagSize
		tex:SetWidth(diagSize)
		if secondStage then
			tex:SetPoint("TOP", f, "TOPRIGHT")
			SetTextureRotation(tex, -0.785, 0.5, 1)
		else
			tex:SetPoint("BOTTOM", f, "BOTTOMLEFT")
			SetTextureRotation(tex, -0.785, 0.5, 0)
		end
	end
end

local function FlashUpdateSlide(f, progress)
	local flash = f.inf.flash
	local oldProgress = flash.old
	if progress < 0.5 then
		if oldProgress <= 0 or oldProgress > 0.5 then
			FlashSetSlide(f, false)
		end
		flash.Set1(flash.list[1], flash.size1 * progress * 2)
	else
		if oldProgress < 0.5 or oldProgress >= 0.99 then
			FlashSetSlide(f, true)
		end
		flash.Set1(flash.list[1], flash.size1 * (1 - progress) * 2)
	end
	flash.old = progress
end

local function FlashSetSquare(f, secondStage)
	local inf = f.inf
	local flash = inf.flash
	local list = flash.list
	local tex1, tex2, tex3, tex4 = list[1], list[2], list[3], list[4]
	for i = 1, #list do
		list[i]:ClearAllPoints()
	end

	local width, height = f:GetSize()
	flash.sizeW = width
	flash.sizeH = height

	if secondStage then
		tex1:Show()
		tex2:Show()
		tex3:Show()
		tex4:Show()
		tex1:SetPoint("TOP", f, "TOP")
		tex2:SetPoint("RIGHT", f, "RIGHT")
		tex3:SetPoint("BOTTOM", f, "BOTTOM")
		tex4:SetPoint("LEFT", f, "LEFT")
		tex1:SetWidth(width)
		tex3:SetWidth(width)
	else
		local startPoint = flash.startPoint or "CENTER"
		tex1:Show()
		tex2:Hide()
		tex3:Hide()
		tex4:Hide()
		tex1:SetPoint(startPoint, f, startPoint)
	end
end

local function FlashUpdateSquare(f, progress)
	local flash = f.inf.flash
	local oldProgress = flash.old
	local list = flash.list
	if progress < 0.5 then
		if oldProgress <= 0 or oldProgress > 0.5 then
			FlashSetSquare(f, false)
		end
		local stageProg = progress * 2
		local w = flash.sizeW * stageProg
		local h = flash.sizeH * stageProg
		list[1]:SetSize(w > 0.001 and w or 0.001, h > 0.001 and h or 0.001)
	else
		if oldProgress < 0.5 or oldProgress >= 0.99 then
			FlashSetSquare(f, true)
		end
		local stageProg = (1 - progress) * 2
		local width, height = flash.sizeW, flash.sizeH
		local wallW = width * 0.5 * stageProg
		local wallH = height * 0.5 * stageProg
		local innerH = height - 2 * wallH
		if wallW < 0.001 then wallW = 0.001 end
		if wallH < 0.001 then wallH = 0.001 end
		if innerH < 0.001 then innerH = 0.001 end
		list[1]:SetHeight(wallH)
		list[3]:SetHeight(wallH)
		list[2]:SetSize(wallW, innerH)
		list[4]:SetSize(wallW, innerH)
	end
	flash.old = progress
end

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
		flashN = 1,
	},
}

---- Bling ----
local function BlingUpdate(self, elapsed)
	local inf = self.inf
	if not inf or not self:IsVisible() then
		if inf and inf.endCallback then
			inf.endCallback(inf.callbackTarget, inf.callbackExpectedName)
		end
		if self.SetClipsChildren then
			self:SetClipsChildren(false)
		end
		SafeReleaseFrame(GlowFramePool, self)
		return
	end

	-- Repeating edge phase (the center flash / annoy played once during intro and is not repeated)
	if inf.introDone then
		if not inf.repeatAnim then
			if self.SetClipsChildren then
				self:SetClipsChildren(false)
			end
			SafeReleaseFrame(GlowFramePool, self)
			return
		end

		local width, height = self:GetSize()
		if not width or not height or width <= 0 or height <= 0 then
			return
		end
		if inf.width ~= width or inf.height ~= height then
			inf.BorderSet(self)
			inf.width = width
			inf.height = height
		end

		if inf.annoy then
			local annoyProg = (inf.annoyProg or 0) + elapsed * (inf.annoyFrequency or 0.5)
			if annoyProg > 1 then
				annoyProg = annoyProg % 1
				inf.annoyActive = true
				inf.annoyFlashTimer = 0.001
				if inf.flash then
					inf.flash.old = 0
				end
				local flashList = inf.flash and inf.flash.list
				if flashList then
					for i = 1, #flashList do
						flashList[i]:Show()
					end
				end
			end
			inf.annoyProg = annoyProg

			if inf.annoyActive then
				local flashTimer = (inf.annoyFlashTimer or 0) + elapsed / ((inf.duration or 0.65) * 0.66)
				if flashTimer >= 1 then
					inf.annoyActive = nil
					inf.annoyFlashTimer = nil
					local flashList = inf.flash and inf.flash.list
					if flashList then
						for i = 1, #flashList do
							flashList[i]:Hide()
						end
					end
				else
					inf.annoyFlashTimer = flashTimer
					local flashProg = inf.sine and sin(1.5708 * flashTimer) or flashTimer
					if inf.FlashUpdate then
						inf.FlashUpdate(self, flashProg)
					end
				end
			end
		end

		local direction = inf.reverse and -1 or 1
		local tailTimer = (inf.tailTimer or (inf.reverse and 1 or 0)) + direction * elapsed / (inf.duration or 0.65)
		if inf.reverse then
			if tailTimer <= 0 then
				tailTimer = 1 - ((-tailTimer) % 1)
				if tailTimer <= 0 or tailTimer >= 1 then tailTimer = 0.999 end
				local tailList = inf.tail and inf.tail.list
				if tailList then
					for i = 1, #tailList do
						tailList[i]:Show()
					end
				end
				if inf.tail then
					inf.tail.old = 1
				end
				inf.BorderSet(self)
			end
		else
			if tailTimer >= 1 then
				tailTimer = tailTimer % 1
				if tailTimer <= 0 or tailTimer >= 1 then tailTimer = 0.001 end
				local tailList = inf.tail and inf.tail.list
				if tailList then
					for i = 1, #tailList do
						tailList[i]:Show()
					end
				end
				if inf.tail then
					inf.tail.old = 0
				end
				inf.BorderSet(self)
			end
		end
		inf.tailTimer = tailTimer
		local tailProg = inf.sine and sin(1.5708 * tailTimer) or tailTimer
		inf.BorderUpdate(self, tailProg)
		if inf.gradient then
			inf.BorderGradient(self, tailProg, elapsed)
		end
		return
	end

	local progress = self.timer + (inf.reverse and -1 or 1) * elapsed / (inf.duration or 0.65)

	if progress > 1 or progress < 0 then
		if not inf.repeatAnim or inf.noTails then
			if inf.endCallback then
				inf.endCallback(inf.callbackTarget, inf.callbackExpectedName)
			end
			if self.SetClipsChildren then
				self:SetClipsChildren(false)
			end
			SafeReleaseFrame(GlowFramePool, self)
			return
		else
			inf.introDone = true
			local flashList = inf.flash and inf.flash.list
			if flashList then
				for i = 1, #flashList do
					flashList[i]:Hide()
				end
			end
			local tailList = inf.tail and inf.tail.list
			if tailList then
				for i = 1, #tailList do
					tailList[i]:Show()
				end
			end
			inf.BorderSet(self)
			if inf.tail then
				inf.tail.old = inf.reverse and 1 or 0
			end
			inf.tailTimer = inf.reverse and 1 or 0.001
			local tailProg = inf.sine and sin(1.5708 * inf.tailTimer) or inf.tailTimer
			inf.BorderUpdate(self, tailProg)
			if inf.gradient then
				inf.BorderGradient(self, tailProg, elapsed)
			end
			return
		end
	end

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

	if inf.width ~= width or inf.height ~= height then
		if inf.noTails then
			inf.FlashSet(self, new > 0.5)
		else
			inf.FlashSet(self, new > 0.33)
			inf.BorderSet(self)
		end
		inf.width = width
		inf.height = height
	end

	if inf.noTails then
		if ((new < 0.5 and old >= 0.5) or (new >= 0.5 and old <= 0.5)) and inf.midCallback then
			inf.midCallback(inf.callbackTarget, inf.callbackExpectedName)
		end
		inf.FlashUpdate(self, new)
	else
		local tailList = inf.tail.list
		local flashList = inf.flash.list
		if new < 0.33 and old >= 0.33 then
			if inf.midCallback then
				inf.midCallback(inf.callbackTarget, inf.callbackExpectedName)
			end
			for i = 1, #tailList do
				tailList[i]:Hide()
			end
		end
		if new < 0.66 then
			if old >= 0.66 then
				for i = 1, #flashList do
					flashList[i]:Show()
				end
				inf.BorderSet(self)
			end
			inf.FlashUpdate(self, new / 0.66)
		elseif old < 0.66 or old >= 0.99 then
			for i = 1, #flashList do
				flashList[i]:Hide()
			end
		end
		if new > 0.33 then
			if old <= 0.33 and inf.midCallback then
				inf.midCallback(inf.callbackTarget, inf.callbackExpectedName)
			end
			if old <= 0.33 or self.timer >= 1 then
				for i = 1, #tailList do
					tailList[i]:Show()
				end
				inf.BorderSet(self)
			end
			if new > 0.66 then
				local tailProg = (new - 0.66) / 0.34
				inf.BorderUpdate(self, tailProg)
				if inf.gradient then
					inf.BorderGradient(self, tailProg, elapsed)
				end
			elseif inf.gradient then
				inf.BorderGradient(self, 0, elapsed)
			end
		end
	end
	if not self:IsVisible() then
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
		repeatAnim = true,
		["repeat"] = true,
		annoy = false,
		annoyFrequency = 0.5,
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

local DEFAULT_TEXCOORD = { 0, 1, 0, 1 }

function lib.Bling(r, options)
	if not r then return end
	if glowDefaultsUnset then
		SyncGlowDefaults()
	end
	local template = options and options.template and blingTemplates[options.template] or blingTemplates.default
	local opt = options or template
	local noTails = opt.noTails ~= nil and opt.noTails or template.noTails
	local reverse = opt.reverse ~= nil and opt.reverse or template.reverse
	local sine = opt.sine ~= nil and opt.sine or template.sine
	local repeatAnim = false
	if not noTails then
		repeatAnim = opt.repeatAnim ~= nil and opt.repeatAnim or (opt["repeat"] ~= nil and opt["repeat"] or (template.repeatAnim ~= nil and template.repeatAnim or (template["repeat"] ~= nil and template["repeat"] or true)))
	end
	local annoy = opt.annoy ~= nil and opt.annoy or template.annoy
	local annoyFrequency = opt.annoyFrequency or template.annoyFrequency
	local flashType = opt.flash or template.flash
	local flashEntry = flashF[flashType] or flashF.split

	local FlashSet = flashEntry.Set
	local FlashUpdate = flashEntry.Update
	local flashN = flashEntry.flashN

	local tailStartPoint, tailCount, tailTh, tailColor, tailClockwise, tailMirror
	local BorderSet, BorderUpdate, BorderGradient, tailN, gradient
	if noTails then
		tailN = 0
	else
		local optTails = opt.tails or template.tails
		local defTails = template.tails
		tailStartPoint = optTails.startPoint or defTails.startPoint
		tailCount = optTails.N or defTails.N
		tailTh = optTails.th or defTails.th
		tailColor = optTails.color ~= nil and optTails.color or defTails.color
		tailClockwise = optTails.clockwise ~= nil and optTails.clockwise or defTails.clockwise
		tailMirror = optTails.mirror ~= nil and optTails.mirror or defTails.mirror

		local borderEntry = borderF[tailStartPoint][tailCount]
		BorderSet = borderEntry.Set
		BorderUpdate = borderEntry.Update
		BorderGradient = borderEntry.Gradient
		tailN = borderEntry.tailN

		gradient = opt.gradient ~= nil and opt.gradient or (not options and template.gradient or nil)
		if gradient then
			PrepareGradient(gradient)
		end
	end

	local color = opt.color or template.color
	local key = opt.key
	local xOffset = opt.xOffset or template.xOffset
	local yOffset = opt.yOffset or template.yOffset
	local frameLevel = opt.frameLevel or template.frameLevel

	local _, f, width, height = addFrameAndTex(r, color, "_Bling", key, tailN + flashN, xOffset, yOffset, textureList.white, DEFAULT_TEXCOORD, nil, frameLevel)

	f.timer = reverse and 1 or 0.001

	local inf = f.inf
	if not inf then
		inf = {}
		f.inf = inf
	end
	inf.reverse = reverse
	inf.th = tailTh
	inf.duration = opt.duration or template.duration
	inf.noTails = noTails
	inf.sine = sine
	inf.repeatAnim = repeatAnim
	inf.introDone = nil
	inf.tailTimer = nil
	inf.annoy = annoy
	inf.annoyFrequency = annoyFrequency
	inf.annoyProg = 0
	inf.annoyActive = nil
	inf.annoyFlashTimer = nil
	inf.midCallback = opt.midCallback
	inf.endCallback = opt.endCallback
	inf.callbackTarget = opt.callbackTarget
	inf.callbackExpectedName = opt.callbackExpectedName
	inf.gradient = gradient
	inf.gradientFrequency = opt.gradientFrequency or template.gradientFrequency
	inf.width = width
	inf.height = height
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
	flash.startPoint = opt.startPoint or template.startPoint
	flash.old = reverse and 1 or 0
	local flashList = flash.list or {}
	flash.list = flashList
	local textures = f.textures
	for i = 1, flashN do
		flashList[i] = textures[i]
	end
	for i = flashN + 1, #flashList do
		flashList[i] = nil
	end

	if not noTails then
		local tail = inf.tail
		if not tail then
			tail = { list = {} }
			inf.tail = tail
		end
		tail.startPoint = tailStartPoint
		tail.mirror = tailMirror
		tail.old = reverse and 1 or 0
		tail.clockwise = tailClockwise
		local tailList = tail.list or {}
		tail.list = tailList
		for i = 1, tailN do
			tailList[i] = textures[i + flashN]
			if not reverse then
				tailList[i]:Hide()
			end
		end
		for i = tailN + 1, #tailList do
			tailList[i] = nil
		end
		if tailColor and not gradient and tailN > 0 then
			local rCol, gCol, bCol, aCol = GetColorRGBA(tailColor)
			for i = 1, tailN do
				tailList[i]:SetVertexColor(rCol, gCol, bCol, aCol)
			end
		end
	end

	FlashSet(f, reverse)
	if not noTails and reverse then
		BorderSet(f)
	end
	BlingUpdate(f, 0.001)

	if f.SetClipsChildren then
		f:SetClipsChildren(true)
	end
	f:SetScript("OnUpdate", BlingUpdate)
end

function lib.Bling_Stop(r, key)
	if not r then return end
	local fullKey = (key and key ~= "") and ("_Bling" .. key) or "_Bling"
	local f = r[fullKey]
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
		repeatAnim = {
			name = "Repeat",
			desc = "Repeat Bling animation continuously",
			type = "toggle",
		},
		annoy = {
			name = "Annoy",
			desc = "Repeat Bling periodically while glow is active",
			type = "toggle",
		},
		annoyFrequency = {
			name = "Annoy frequency",
			desc = "Frequency of annoy Bling if enabled",
			type = "range",
			min = 0.05,
			softMin = 0.25,
			softMax = 2,
			step = 0.05,
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

---- Border Pulse Glow ----
local function BorderPulseUpdate(self, elapsed)
	local inf = self.inf
	if not inf then
		SafeReleaseFrame(GlowFramePool, self)
		return
	end

	local progress = (self.timer or 0) + elapsed * (inf.frequency or 2) * (inf.sign or 1)

	if inf.finish and (inf.forceStop or progress > 1 or progress < 0 or not self:IsVisible()) then
		SafeReleaseFrame(GlowFramePool, self)
		return
	end

	if inf.annoy then
		local annoyProg = (inf.annoyProg or 0) + elapsed * (inf.annoyFrequency or 0.5)
		if annoyProg > 1 then
			lib.Bling(self, inf.flashOptions)
			annoyProg = annoyProg % 1
		end
		inf.annoyProg = annoyProg
	end

	local width, height = self:GetSize()
	if not width or not height or width <= 0 or height <= 0 then
		return
	end

	if inf.width ~= width or inf.height ~= height then
		inf.BorderSet(self, true)
		inf.width = width
		inf.height = height
		inf.cornerP = nil
	end
	if progress < 0 or progress > 1 then
		local tail = inf.tail
		tail.old = progress
		inf.sign = -inf.sign
		progress = 1 - progress % 1

		if tail.mirror then
			tail.startPoint = BorderReverse(tail.startPoint, inf.N)
			if inf.N == 4 then
				local entry = borderF[tail.startPoint][inf.N]
				inf.BorderSet = entry.Set
				inf.BorderUpdate = entry.Update
				inf.BorderGradient = entry.Gradient
			end
		else
			tail.clockwise = not tail.clockwise
		end
		inf.BorderSet(self)
	end

	local newProg = inf.sine and sin(1.5708 * progress) or progress
	inf.BorderUpdate(self, newProg)
	if inf.gradient then
		inf.BorderGradient(self, newProg, elapsed)
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
		blingOptions = {
			flash = "split",
			startPoint = "TOPLEFT",
			color = { 0.95, 0.95, 0.95, 0.85 },
			gradient = { { 1, 0.75, 0.75, 1 }, { 0.75, 1, 0.75, 1 }, { 0.75, 0.75, 1, 1 } },
			gradientFrequency = 0.7,
			noTails = true,
			sine = false,
			tails = blingTemplates.default.tails,
			reverse = true,
			duration = 0.5,
			xOffset = 0,
			yOffset = 0,
			frameLevel = 8,
		},
		forceStop = false,
		frequency = 2,
		xOffset = 0,
		yOffset = 0,
		frameLevel = 8,
	},
}

local function CopyBlingOptionsInto(dest, src, def)
	local s = src or def
	dest.flash = s.flash or def.flash
	dest.startPoint = s.startPoint or def.startPoint
	dest.color = s.color or def.color
	if s.gradient ~= nil then
		dest.gradient = s.gradient
	elseif not src then
		dest.gradient = def.gradient
	else
		dest.gradient = nil
	end
	dest.gradientFrequency = s.gradientFrequency or def.gradientFrequency
	if s.noTails == nil then dest.noTails = def.noTails else dest.noTails = s.noTails end
	if s.sine == nil then dest.sine = def.sine else dest.sine = s.sine end
	dest.repeatAnim = false
	dest["repeat"] = false
	dest.tails = s.tails or def.tails
	dest.reverse = s.reverse ~= nil and s.reverse or def.reverse
	dest.duration = s.duration or def.duration
	dest.xOffset = s.xOffset or def.xOffset
	dest.yOffset = s.yOffset or def.yOffset
	dest.frameLevel = s.frameLevel or def.frameLevel
	dest.key = s.key
	dest.midCallback = nil
	dest.endCallback = nil
	dest.callbackTarget = nil
	dest.callbackExpectedName = nil
	return dest
end

local function BorderPulseBlingMid(target, expectedName)
	if target and target.name and target.name == expectedName then
		target:Show()
	end
end

local function BorderPulseBlingEnd(target, expectedName)
	if target and target.name and target.name == expectedName then
		target:Show()
		target:SetScript("OnUpdate", BorderPulseUpdate)
		BorderPulseUpdate(target, 0.001)
	end
end

function lib.BorderPulse_Start(r, options)
	if not r then
		return
	end
	if glowDefaultsUnset then
		SyncGlowDefaults()
	end
	local template = options and options.template and borderPulseTemplates[options.template] or borderPulseTemplates.default
	local opt = options or template

	local startPoint = opt.startPoint or template.startPoint
	local N = opt.N or template.N
	local borderEntry = borderF[startPoint][N]
	local BorderSet = borderEntry.Set
	local BorderUpdate = borderEntry.Update
	local BorderGradient = borderEntry.Gradient
	local tailN = borderEntry.tailN

	local color = opt.color or template.color
	local key = opt.key
	local xOffset = opt.xOffset or template.xOffset
	local yOffset = opt.yOffset or template.yOffset
	local frameLevel = opt.frameLevel or template.frameLevel
	local gradient = opt.gradient ~= nil and opt.gradient or (not options and template.gradient or nil)
	if gradient then
		PrepareGradient(gradient)
	end

	local update, f, width, height = addFrameAndTex(r, color, "_BorderPulse", key, tailN, xOffset, yOffset, textureList.white, DEFAULT_TEXCOORD, nil, frameLevel)

	if type(f.timer) ~= "number" then
		f.timer = 0.001
	end

	local inf = f.inf
	if not inf then
		inf = {}
		f.inf = inf
	end

	local repeatBling = opt.repeatBling ~= nil and opt.repeatBling or template.repeatBling
	local annoy = opt.annoy ~= nil and opt.annoy or template.annoy
	local startBling = opt.startBling ~= nil and opt.startBling or template.startBling

	inf.N = N
	inf.th = opt.th or template.th
	inf.frequency = opt.frequency or template.frequency
	inf.sine = opt.sine ~= nil and opt.sine or template.sine
	inf.forceStop = opt.forceStop ~= nil and opt.forceStop or template.forceStop
	inf.finish = nil
	inf.gradient = gradient
	inf.gradientFrequency = opt.gradientFrequency or template.gradientFrequency
	inf.annoy = annoy
	inf.annoyFrequency = opt.annoyFrequency or template.annoyFrequency
	inf.BorderSet = BorderSet
	inf.BorderUpdate = BorderUpdate
	inf.BorderGradient = BorderGradient
	inf.width = width
	inf.height = height
	inf.gProgress = inf.gProgress or 0
	inf.sign = inf.sign or 1
	inf.cornerP = nil

	local tail = inf.tail
	if not tail then
		tail = {}
		inf.tail = tail
	end
	tail.clockwise = opt.clockwise ~= nil and opt.clockwise or template.clockwise
	tail.list = f.textures
	tail.startPoint = startPoint
	tail.mirror = opt.mirror ~= nil and opt.mirror or template.mirror
	tail.old = 0

	if inf.sign == -1 then
		if tail.mirror then
			tail.startPoint = BorderReverse(tail.startPoint, inf.N)
			if inf.N == 4 then
				local revEntry = borderF[tail.startPoint][inf.N]
				inf.BorderSet = revEntry.Set
				inf.BorderUpdate = revEntry.Update
				inf.BorderGradient = revEntry.Gradient
			end
		else
			tail.clockwise = not tail.clockwise
		end
	end

	local blingOptSrc = opt.blingOptions or template.blingOptions
	if repeatBling or annoy then
		local flashOptions = CopyBlingOptionsInto(inf.flashOptions or {}, blingOptSrc, blingTemplates.default)
		if not opt.blingOptions then
			flashOptions.color = color
			flashOptions.gradient = gradient
		end
		if not flashOptions.noTails then
			flashOptions.noTails = true
			flashOptions.duration = flashOptions.duration * 0.66
		end
		inf.flashOptions = flashOptions
	end

	inf.BorderSet(f)

	f:SetScript("OnUpdate", BorderPulseUpdate)
	BorderPulseUpdate(f, 0.001)

	if startBling then
		if not update then
			f:Hide()
			local startOpts = CopyBlingOptionsInto(inf.startBlingOptions or {}, blingOptSrc, borderPulseTemplates.default.blingOptions)
			inf.startBlingOptions = startOpts
			if not opt.blingOptions then
				startOpts.color = color
			end
			startOpts.gradient = gradient
			startOpts.callbackTarget = f
			startOpts.callbackExpectedName = f.name
			startOpts.midCallback = BorderPulseBlingMid
			startOpts.endCallback = BorderPulseBlingEnd
			lib.Bling(r, startOpts)
		elseif repeatBling then
			lib.Bling(r, inf.flashOptions)
		end
	end
end

function lib.BorderPulse_Stop(r, key, force)
	if not r then return end
	local hasKey = key and key ~= ""
	local f = r[hasKey and ("_BorderPulse" .. key) or "_BorderPulse"]
	if not f then
		return
	end
	if r[hasKey and ("_Bling" .. key) or "_Bling"] then
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
		N = 4,
		th = 3,
		color = { 0.95, 0.95, 0.95, 0.85 },
		gradient = { { 1, 0.75, 0.75, 1 }, { 0.75, 1, 0.75, 1 }, { 0.75, 0.75, 1, 1 } },
		gradientFrequency = 0.7,
		length = 15,
		startBling = true,
		repeatBling = false,
		annoy = false,
		annoyFrequency = 0.5,
		blingOptions = borderPulseTemplates.default.blingOptions,
		forceStop = false,
		fadeDuration = 0.45,
		frequency = -1,
		xOffset = 3,
		yOffset = 3,
		frameLevel = 8,
	},
}

local function PixelUpdateInfo(f)
	local inf = f.inf
	local width, height = f:GetSize()
	if not width or not height or width <= 0 or height <= 0 then
		local parent = f:GetParent()
		if parent and parent.GetSize then
			local pW, pH = parent:GetSize()
			if pW and pH and pW > 0 and pH > 0 then
				local absX = (f.xOffset and (f.xOffset < 0 and -f.xOffset or f.xOffset)) or 0
				local absY = (f.yOffset and (f.yOffset < 0 and -f.yOffset or f.yOffset)) or 0
				width = pW + 2 * absX
				height = pH + 2 * absY
				f:SetSize(width, height)
			end
		end
	end
	if width ~= inf.width or height ~= inf.height or inf.dirty then
		if not width or not height or (width + height) <= 0 then
			return false
		end
		local th = inf.th
		local N = inf.N
		local defaultLength = inf.optLengthArg or floor((width + height) / N * 1.25)
		inf.defaultLength = defaultLength
		local length = min(defaultLength, width - 2, height - 2)
		if length <= 0 then length = 1 end
		inf.length = length
		local perimeter = 2 * (width + height)
		local p = inf.p or {}
		p[1] = (width - length) / perimeter
		p[2] = width / perimeter
		p[3] = (width + height - length) / perimeter
		p[4] = (width + height) / perimeter
		p[5] = (2 * width + height - length) / perimeter
		p[6] = (2 * width + height) / perimeter
		p[7] = (perimeter - length) / perimeter
		p[8] = 1
		inf.p = p
		inf.perimeter = perimeter
		local diffLength = length - th
		if diffLength < 0 then diffLength = 0 end
		inf.diffLength = diffLength
		inf.invStep = perimeter / (length > 0 and length or 1)
		if inf.gradient then
			inf.gradientStep = (perimeter > 0) and (length / perimeter) or 0
		end

		local add = inf.add
		add[1]:ClearAllPoints()
		add[1]:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -th)
		add[1]:SetSize(th, 0.001)

		add[2]:ClearAllPoints()
		add[2]:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", th, 0)
		add[2]:SetSize(0.001, th)

		add[3]:ClearAllPoints()
		add[3]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, th)
		add[3]:SetSize(th, 0.001)

		add[4]:ClearAllPoints()
		add[4]:SetPoint("TOPRIGHT", f, "TOPRIGHT", -th, 0)
		add[4]:SetSize(0.001, th)

		inf.width = width
		inf.height = height
		inf.dirty = nil

		local offsets = inf.offsets or {}
		for i = 1, N do
			offsets[i] = (i - 1) / N
		end
		for i = N + 1, #offsets do
			offsets[i] = nil
		end
		inf.offsets = offsets

		return true, true
	end
	return true, false
end

local function PixelSetLine(f, texN, progress)
	local tex = f.textures[texN]
	local inf = f.inf
	local p = inf.p
	local length = inf.length
	local th = inf.th
	local perimeter = inf.perimeter
	local invStep = inf.invStep
	local diffLength = inf.diffLength or 0

	tex:ClearAllPoints()
	if progress < p[1] then
		tex:SetPoint("TOPRIGHT", f, "TOPRIGHT", -progress * perimeter, 0)
		tex:SetSize(length, th)
	elseif progress < p[2] then
		local stageProg = (progress - p[1]) * invStep
		if stageProg < 0 then stageProg = 0 elseif stageProg > 1 then stageProg = 1 end
		local cornerLength = stageProg * diffLength
		tex:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
		tex:SetSize(mathmax(diffLength - cornerLength + th, th), th)
	elseif progress < p[3] then
		tex:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -(progress - p[2]) * perimeter)
		tex:SetSize(th, length)
	elseif progress < p[4] then
		local stageProg = (progress - p[3]) * invStep
		if stageProg < 0 then stageProg = 0 elseif stageProg > 1 then stageProg = 1 end
		local cornerLength = stageProg * diffLength
		tex:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
		tex:SetSize(th, mathmax(diffLength - cornerLength + th, th))
	elseif progress < p[5] then
		tex:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", (progress - p[4]) * perimeter, 0)
		tex:SetSize(length, th)
	elseif progress < p[6] then
		local stageProg = (progress - p[5]) * invStep
		if stageProg < 0 then stageProg = 0 elseif stageProg > 1 then stageProg = 1 end
		local cornerLength = stageProg * diffLength
		tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
		tex:SetSize(mathmax(diffLength - cornerLength + th, th), th)
	elseif progress < p[7] then
		tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, (progress - p[6]) * perimeter)
		tex:SetSize(th, length)
	else
		local stageProg = (progress - p[7]) * invStep
		if stageProg < 0 then stageProg = 0 elseif stageProg > 1 then stageProg = 1 end
		local cornerLength = stageProg * diffLength
		tex:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
		tex:SetSize(th, mathmax(diffLength - cornerLength + th, th))
	end
end

local function PixelUpdateLine(f, texN, addVisible, oldProgress, progress, c1, c2)
	local tex = f.textures[texN]
	local inf = f.inf
	local p = inf.p
	local length = inf.length
	local th = inf.th
	local perimeter = inf.perimeter
	local invStep = inf.invStep
	local diffLength = inf.diffLength or 0
	if progress < p[1] then
		if oldProgress > p[1] then
			tex:ClearAllPoints()
			tex:SetSize(length, th)
		end
		tex:SetPoint("TOPRIGHT", f, "TOPRIGHT", -progress * perimeter, 0)
		if c1 then
			SetGradA(tex, "HORIZONTAL", c2, c1)
		end
	elseif progress < p[2] then
		if oldProgress >= p[2] or oldProgress < p[1] then
			tex:ClearAllPoints()
			tex:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
			tex:SetHeight(th)
		end
		addVisible[1] = true
		local stageProg = (progress - p[1]) * invStep
		if stageProg < 0 then stageProg = 0 elseif stageProg > 1 then stageProg = 1 end
		local cornerLength = stageProg * diffLength
		local add1 = inf.add[1]
		tex:SetWidth(mathmax(diffLength - cornerLength + th, th))
		add1:SetSize(th, cornerLength > 0.001 and cornerLength or 0.001)
		if c1 then
			local c12 = GetHSVTransition(1 - stageProg, c1, c2)
			SetGradA(tex, "HORIZONTAL", c12, c1)
			SetGradA(add1, "VERTICAL", c2, c12)
		end
	elseif progress < p[3] then
		if oldProgress > p[3] or oldProgress < p[2] then
			tex:ClearAllPoints()
			tex:SetSize(th, length)
		end
		tex:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -(progress - p[2]) * perimeter)
		if c1 then
			SetGradA(tex, "VERTICAL", c2, c1)
		end
	elseif progress < p[4] then
		if oldProgress >= p[4] or oldProgress < p[3] then
			tex:ClearAllPoints()
			tex:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
			tex:SetWidth(th)
		end
		addVisible[2] = true
		local stageProg = (progress - p[3]) * invStep
		if stageProg < 0 then stageProg = 0 elseif stageProg > 1 then stageProg = 1 end
		local cornerLength = stageProg * diffLength
		local add2 = inf.add[2]
		tex:SetHeight(mathmax(diffLength - cornerLength + th, th))
		add2:SetSize(cornerLength > 0.001 and cornerLength or 0.001, th)
		if c1 then
			local c12 = GetHSVTransition(1 - stageProg, c1, c2)
			SetGradA(tex, "VERTICAL", c12, c1)
			SetGradA(add2, "HORIZONTAL", c12, c2)
		end
	elseif progress < p[5] then
		if oldProgress > p[5] or oldProgress < p[4] then
			tex:ClearAllPoints()
			tex:SetSize(length, th)
		end
		tex:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", (progress - p[4]) * perimeter, 0)
		if c1 then
			SetGradA(tex, "HORIZONTAL", c1, c2)
		end
	elseif progress < p[6] then
		if oldProgress >= p[6] or oldProgress < p[5] then
			tex:ClearAllPoints()
			tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
			tex:SetHeight(th)
		end
		addVisible[3] = true
		local stageProg = (progress - p[5]) * invStep
		if stageProg < 0 then stageProg = 0 elseif stageProg > 1 then stageProg = 1 end
		local cornerLength = stageProg * diffLength
		local add3 = inf.add[3]
		tex:SetWidth(mathmax(diffLength - cornerLength + th, th))
		add3:SetSize(th, cornerLength > 0.001 and cornerLength or 0.001)
		if c1 then
			local c12 = GetHSVTransition(1 - stageProg, c1, c2)
			SetGradA(tex, "HORIZONTAL", c1, c12)
			SetGradA(add3, "VERTICAL", c12, c2)
		end
	elseif progress < p[7] then
		if oldProgress < p[6] or oldProgress > p[7] then
			tex:ClearAllPoints()
			tex:SetSize(th, length)
		end
		tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, (progress - p[6]) * perimeter)
		if c1 then
			SetGradA(tex, "VERTICAL", c1, c2)
		end
	else
		if oldProgress < p[7] or oldProgress >= 1 then
			tex:ClearAllPoints()
			tex:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
			tex:SetWidth(th)
		end
		addVisible[4] = true
		local stageProg = (progress - p[7]) * invStep
		if stageProg < 0 then stageProg = 0 elseif stageProg > 1 then stageProg = 1 end
		local cornerLength = stageProg * diffLength
		local add4 = inf.add[4]
		tex:SetHeight(mathmax(diffLength - cornerLength + th, th))
		add4:SetSize(cornerLength > 0.001 and cornerLength or 0.001, th)
		if c1 then
			local c12 = GetHSVTransition(1 - stageProg, c1, c2)
			SetGradA(tex, "VERTICAL", c1, c12)
			SetGradA(add4, "HORIZONTAL", c2, c12)
		end
	end
end

local function PixelUpdate(self, elapsed)
	local oldProgress = self.timer
	local inf = self.inf
	local timer = (oldProgress + elapsed * inf.frequency) % 1
	self.timer = timer

	if inf.finish then
		local fading = inf.fading or 0
		local fadeDuration = inf.fadeDuration or 0.3
		if inf.forceStop or fading > fadeDuration or not self:IsVisible() then
			SafeReleaseFrame(GlowFramePool, self)
			return
		else
			self:SetAlpha(1 - fading / fadeDuration)
			inf.fading = fading + elapsed
		end
	elseif inf.annoy then
		local annoyProg = (inf.annoyProg or 0) + elapsed * inf.annoyFrequency
		if annoyProg > 1 then
			lib.Bling(self, inf.flashOptions)
			annoyProg = annoyProg % 1
		end
		inf.annoyProg = annoyProg
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
				old = (new + 0.5) % 1
			end
			local p1 = (new + gradientPhase + 0.001) % 1
			local p2 = (p1 + gradientStep) % 1
			local pos1, pos2 = (p1 * gN) % gN, (p2 * gN) % gN
			local i1 = (floor(pos1) % gN) + 1
			local i2 = (floor(pos2) % gN) + 1
			local c1 = GetHSVTransition(pos1 % 1, g[i1], g[(i1 % gN) + 1])
			local c2 = GetHSVTransition(pos2 % 1, g[i2], g[(i2 % gN) + 1])
			PixelUpdateLine(self, i, addVisible, old, new, c1, c2)
		end
	else
		for i = 1, N do
			local offset = offsets[i]
			local old = (oldProgress + offset) % 1
			local new = (timer + offset) % 1
			if change then
				PixelSetLine(self, i, new)
				old = (new + 0.5) % 1
			end
			PixelUpdateLine(self, i, addVisible, old, new)
		end
	end
	local add = inf.add
	if addVisible[1] ~= prev1 then add[1]:SetShown(addVisible[1]) end
	if addVisible[2] ~= prev2 then add[2]:SetShown(addVisible[2]) end
	if addVisible[3] ~= prev3 then add[3]:SetShown(addVisible[3]) end
	if addVisible[4] ~= prev4 then add[4]:SetShown(addVisible[4]) end
end

local function PixelGlowBlingMid(target, expectedName)
	if target and target.name and target.name == expectedName then
		target:Show()
		if target.inf then
			target.inf.dirty = true
		end
		PixelUpdate(target, 0.001)
	end
end

local function PixelGlowBlingEnd(target, expectedName)
	if target and target.name and target.name == expectedName then
		target:Show()
		target:SetScript("OnUpdate", PixelUpdate)
		if target.inf then
			target.inf.dirty = true
		end
		PixelUpdate(target, 0.001)
	end
end

function lib.PixelGlow_Start(r, colorOrOptions, N, frequency, length, th, xOffset, yOffset, border, key, frameLevel)
	if not r then return end

	if glowDefaultsUnset then
		SyncGlowDefaults()
	end

	local d = pixelTemplates.default
	local isOpts = type(colorOrOptions) == "table" and not colorOrOptions[1] and not colorOrOptions.r and not colorOrOptions.GetRGBA
	local template = isOpts and colorOrOptions.template and pixelTemplates[colorOrOptions.template] or d
	local opt = isOpts and colorOrOptions or template

	local optColor = (isOpts and opt.color) or colorOrOptions or template.color
	local optN = (isOpts and opt.N) or N or template.N
	local optFreq = (isOpts and opt.frequency) or frequency or template.frequency
	local optLengthArg = (isOpts and opt.length) or length or template.length
	local optTh = (isOpts and opt.th) or th or template.th
	local optXOff = (isOpts and opt.xOffset) or xOffset or template.xOffset
	local optYOff = (isOpts and opt.yOffset) or yOffset or template.yOffset
	local optBorder = isOpts and (opt.border ~= nil and opt.border or template.border) or (border ~= nil and border or template.border)
	local optKey = (isOpts and opt.key) or key or template.key
	local optFrameLevel = (isOpts and opt.frameLevel) or frameLevel or template.frameLevel
	local optFadeDur = opt.fadeDuration or template.fadeDuration
	local optForceStop = opt.forceStop ~= nil and opt.forceStop or template.forceStop or false
	local optGrad = opt.gradient ~= nil and opt.gradient or template.gradient
	local optGradFreq = opt.gradientFrequency or template.gradientFrequency
	local optAnnoy = opt.annoy ~= nil and opt.annoy or template.annoy
	local optAnnoyFreq = opt.annoyFrequency or template.annoyFrequency
	local optStartBling = opt.startBling ~= nil and opt.startBling or template.startBling
	local optRepeatBling = opt.repeatBling ~= nil and opt.repeatBling or template.repeatBling
	local optBlingOpts = opt.blingOptions or template.blingOptions

	if optGrad then
		PrepareGradient(optGrad)
	end

	local update, f, width, height = addFrameAndTex(r, optColor, "_PixelGlow", optKey or "", optN + 4, optXOff, optYOff, textureList.white, DEFAULT_TEXCOORD, nil, optFrameLevel)

	local defaultLength = optLengthArg or floor((width + height) / optN * 1.25)
	local optLength = min(defaultLength, width - 2, height - 2)
	if optLength <= 0 then optLength = 1 end

	if type(f.timer) ~= "number" then
		f.timer = 0.001
	end
	local inf = f.inf
	if not inf then
		inf = {}
		f.inf = inf
	end
	if inf.th ~= optTh or inf.defaultLength ~= defaultLength or inf.N ~= optN then
		inf.dirty = true
	end
	inf.th = optTh
	inf.optLengthArg = optLengthArg
	inf.defaultLength = defaultLength
	inf.length = optLength
	inf.N = optN
	inf.frequency = -optFreq
	inf.annoy = optAnnoy
	inf.annoyFrequency = optAnnoyFreq
	inf.gradient = optGrad
	inf.gradientFrequency = optGradFreq
	inf.gradientStep = ((width + height) > 0) and (optLength / (width + height)) or 0
	inf.forceStop = optForceStop
	inf.fadeDuration = optFadeDur
	inf.finish = nil
	inf.fading = nil

	local add = inf.add
	if not add then
		add = {}
		inf.add = add
	end
	local textures = f.textures
	add[1] = textures[optN + 1]
	add[2] = textures[optN + 2]
	add[3] = textures[optN + 3]
	add[4] = textures[optN + 4]

	local addVisible = inf.addVisible
	if not addVisible then
		addVisible = {}
		inf.addVisible = addVisible
	else
		addVisible[1], addVisible[2], addVisible[3], addVisible[4] = nil, nil, nil, nil
	end
	add[1]:Hide()
	add[2]:Hide()
	add[3]:Hide()
	add[4]:Hide()

	if optBorder then
		if not f.bg then
			f.bg = GlowTexPool:Acquire()
			f.bg:SetTexture(textureList.white)
			f.bg:SetParent(f)
			f.bg:SetAllPoints(f)
			f.bg:SetDrawLayer("BACKGROUND", -7)
		end
		local rCol, gCol, bCol, aCol = GetColorRGBA(optColor)
		f.bg:SetVertexColor(rCol, gCol, bCol, aCol * 0.3)
		f.bg:Show()
	else
		if f.bg then
			SafeReleaseTexture(GlowTexPool, f.bg)
			f.bg = nil
		end
	end

	if optRepeatBling or optAnnoy then
		local flashOptions = CopyBlingOptionsInto(inf.flashOptions or {}, optBlingOpts, blingTemplates.default)
		if not isOpts or not colorOrOptions.blingOptions then
			flashOptions.color = optColor
			flashOptions.gradient = optGrad
		end
		if not flashOptions.noTails then
			flashOptions.noTails = true
			flashOptions.duration = flashOptions.duration * 0.66
		end
		inf.flashOptions = flashOptions
	end

	inf.dirty = true
	f:SetScript("OnUpdate", PixelUpdate)
	PixelUpdate(f, 0.001)
	if optStartBling then
		if not update then
			f:Hide()
			local startOpts = CopyBlingOptionsInto(inf.startBlingOptions or {}, optBlingOpts, borderPulseTemplates.default.blingOptions)
			inf.startBlingOptions = startOpts
			if not isOpts or not colorOrOptions.blingOptions then
				startOpts.color = optColor
			end
			startOpts.gradient = optGrad
			startOpts.callbackTarget = f
			startOpts.callbackExpectedName = f.name
			startOpts.midCallback = PixelGlowBlingMid
			startOpts.endCallback = PixelGlowBlingEnd
			lib.Bling(r, startOpts)
		elseif optRepeatBling then
			lib.Bling(r, inf.flashOptions)
		end
	end
end

function lib.PixelGlow_Stop(r, key, force)
	if not r then return end
	local hasKey = key and key ~= ""
	local f = r[hasKey and ("_PixelGlow" .. key) or "_PixelGlow"]
	if not f then
		return
	end
	if r[hasKey and ("_Bling" .. key) or "_Bling"] then
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

---- AutoCast Glow ----
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
	if not r then return end
	if glowDefaultsUnset then
		SyncGlowDefaults()
	end

	local d = autoCastTemplates.default
	local optColor, optN, optFreq, optScale, optXOff, optYOff, optKey, optFrameLevel
	local isOpts = type(colorOrOptions) == "table" and colorOrOptions[1] == nil and not colorOrOptions.GetRGBA
	if isOpts then
		local tmpl = colorOrOptions.template and autoCastTemplates[colorOrOptions.template] or d
		optColor = colorOrOptions.color or tmpl.color
		optN = colorOrOptions.N or tmpl.N
		optFreq = colorOrOptions.frequency or tmpl.frequency
		optScale = colorOrOptions.scale or tmpl.scale
		optXOff = colorOrOptions.xOffset or tmpl.xOffset
		optYOff = colorOrOptions.yOffset or tmpl.yOffset
		optKey = colorOrOptions.key or ""
		optFrameLevel = colorOrOptions.frameLevel or tmpl.frameLevel
	else
		optColor = colorOrOptions or d.color
		optN = N or d.N
		optFreq = frequency or d.frequency
		optScale = scale or d.scale
		optXOff = xOffset or d.xOffset
		optYOff = yOffset or d.yOffset
		optKey = key or ""
		optFrameLevel = frameLevel or d.frameLevel
	end

	local update, f = addFrameAndTex(r, optColor, "_AutoCastGlow", optKey, optN * 4, optXOff, optYOff, textureList.shine, shineCoords, true, optFrameLevel)
	local info = f.info
	if not info then
		info = {}
		f.info = info
	end
	if not update or info.scale ~= optScale or info.N ~= optN then
		local textures = f.textures
		for k = 1, 4 do
			local size = AUTOCAST_SIZES[k] * optScale
			local baseIdx = optN * (k - 1)
			for i = 1, optN do
				textures[i + baseIdx]:SetSize(size, size)
			end
		end
		info.scale = optScale
	end
	local timer = f.timer
	if type(timer) ~= "table" then
		timer = f._acTimer or { 0, 0, 0, 0 }
		f._acTimer = timer
		f.timer = timer
	end
	timer[1], timer[2], timer[3], timer[4] = 0, 0, 0, 0
	info.N = optN
	info.frequency = optFreq
	info.width = nil
	info.height = nil
	f:SetScript("OnUpdate", acUpdate)
	acUpdate(f, 0)
end

function lib.AutoCastGlow_Stop(r, key)
	if not r then
		return
	end
	local fullKey = (key and key ~= "") and ("_AutoCastGlow" .. key) or "_AutoCastGlow"
	local f = r[fullKey]
	if not f then
		return false
	else
		SafeReleaseFrame(GlowFramePool, f)
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
	if frame.outerGlow then
		frame.outerGlow:SetScale(1)
	end
	frame.cooldown = nil
	frame._cdTimer = nil
	frame:Hide()
	frame:ClearAllPoints()
end
ButtonGlowPool = CreateFramePool("Frame", GlowParent, nil, ButtonGlowResetter)
lib.ButtonGlowPool = ButtonGlowPool
ProtectPoolRelease(ButtonGlowPool)

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
	local effAlpha = not frame.color and 1.0 or alpha
	frame.spark:SetSize(frameWidth, frameHeight)
	frame.spark:SetAlpha(not frame.color and 1.0 or 0.3 * alpha)
	frame.innerGlow:SetSize(frameWidth / 2, frameHeight / 2)
	frame.innerGlow:SetAlpha(effAlpha)
	frame.innerGlowOver:SetAlpha(effAlpha)
	frame.outerGlow:SetSize(frameWidth * 2, frameHeight * 2)
	frame.outerGlow:SetAlpha(effAlpha)
	frame.outerGlowOver:SetAlpha(effAlpha)
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
	local cooldown = self.cooldown
	if not cooldown then
		if self._legAlpha ~= 1.0 then
			self._legAlpha = 1.0
			self:SetAlpha(1.0)
		end
		return
	end
	local cdTimer = (self._cdTimer or 0.1) + elapsed
	if cdTimer < 0.1 and self._legAlpha ~= nil then
		self._cdTimer = cdTimer
		return
	end
	self._cdTimer = 0
	local duration = cooldown:IsShown() and cooldown:GetCooldownDuration()
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

	f._animAlpha = alpha
	f:SetScript("OnHide", bgHide)
end

local function updateAlphaAnim(f, alpha)
	if f._animAlpha == alpha then return end
	f._animAlpha = alpha
	local inAppear, inFade = f.animIn.appear, f.animIn.fade
	local outAppear, outFade = f.animOut.appear, f.animOut.fade
	for i = 1, #inAppear do
		inAppear[i]:SetToAlpha(alpha)
	end
	for i = 1, #inFade do
		inFade[i]:SetFromAlpha(alpha)
	end
	for i = 1, #outAppear do
		outAppear[i]:SetToAlpha(alpha)
	end
	for i = 1, #outFade do
		outFade[i]:SetFromAlpha(alpha)
	end
end

---- Blizzard's Button Glow ----
local ButtonGlowTextureList = { "spark", "innerGlow", "innerGlowOver", "outerGlow", "outerGlowOver", "ants" }

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
	if not r then return end
	if glowDefaultsUnset then
		SyncGlowDefaults()
	end

	local color, optFreq, optFrameLevel
	local isOpts = type(colorOrOptions) == "table" and colorOrOptions[1] == nil and not colorOrOptions.GetRGBA
	if isOpts then
		local tmpl = colorOrOptions.template and buttonGlowTemplates[colorOrOptions.template] or buttonGlowTemplates.default
		color = (colorOrOptions.color ~= nil) and colorOrOptions.color or tmpl.color
		optFreq = colorOrOptions.frequency or tmpl.frequency
		optFrameLevel = colorOrOptions.frameLevel or tmpl.frameLevel
	else
		color = colorOrOptions
		optFreq = frequency or 0.25
		optFrameLevel = frameLevel or 8
	end

	local throttle = (optFreq and optFreq > 0) and (0.25 / optFreq * 0.01) or 0.01

	local existing = r._ButtonGlow
	local isValidPoolFrame = existing and IsPoolObjectActive(ButtonGlowPool, existing)
	local f, new

	local desat = color and 1 or nil
	local cR, cG, cB, cA = 1, 1, 1, 1
	if color then
		cR, cG, cB, cA = GetColorRGBA(color)
	end

	local width, height = r:GetSize()
	width = (width and width > 0) and width or 40
	height = (height and height > 0) and height or 40
	local glowW, glowH = width * 1.4, height * 1.4

	if isValidPoolFrame then
		f = existing
		f.ants:SetSize(glowW * 0.85, glowH * 0.85)
		AnimIn_OnFinished(f.animIn)
		if f.animOut:IsPlaying() then
			f.animOut:Stop()
			f.animIn:Play()
		end
		local prevColorAlpha = noZero(GetColorAlpha(f.color))
		for i = 1, 6 do
			local tex = f[ButtonGlowTextureList[i]]
			tex:SetDesaturated(desat)
			tex:SetVertexColor(cR, cG, cB)
			tex:SetAlpha(min(tex:GetAlpha() / prevColorAlpha * cA, 1))
		end
		updateAlphaAnim(f, cA)
	else
		if existing then
			SafeReleaseFrame(ButtonGlowPool, existing)
		end
		f, new = ButtonGlowPool:Acquire()
		if new then
			configureButtonGlow(f, cA)
		else
			updateAlphaAnim(f, cA)
		end
		r._ButtonGlow = f
		f:SetParent(r)
		for i = 1, 6 do
			local tex = f[ButtonGlowTextureList[i]]
			tex:SetDesaturated(desat)
			tex:SetVertexColor(cR, cG, cB)
		end
		f._legAlpha = nil
		f._cdTimer = nil
		f:SetScript("OnUpdate", bgUpdate)
		f.animIn:Play()
		if Masque and Masque.UpdateSpellAlert then
			Masque:UpdateSpellAlert(r, f)
		end
	end

	f.color = color or false
	f.cooldown = r.cooldown
	f:SetFrameLevel(r:GetFrameLevel() + optFrameLevel)
	f:SetSize(glowW, glowH)
	f:SetPoint("TOPLEFT", r, "TOPLEFT", -width * 0.2, height * 0.2)
	f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", width * 0.2, -height * 0.2)
	f.throttle = throttle
end

function lib.ButtonGlow_Stop(r, force)
	if r and r._ButtonGlow then
		local bg = r._ButtonGlow
		if force then
			if bg.animIn:IsPlaying() then
				bg.animIn:Stop()
			end
			if bg.animOut:IsPlaying() then
				bg.animOut:Stop()
			end
			SafeReleaseFrame(ButtonGlowPool, bg)
		elseif not bg.animOut:IsPlaying() then
			if bg.animIn:IsPlaying() then
				bg.animIn:Stop()
				SafeReleaseFrame(ButtonGlowPool, bg)
			elseif r:IsVisible() then
				bg.animOut:Play()
			else
				SafeReleaseFrame(ButtonGlowPool, bg)
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

---- Blizzard's Proc Glow ----
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

ProcGlowPool = CreateFramePool("Frame", GlowParent, nil, ProcGlowResetter)
lib.ProcGlowPool = ProcGlowPool
ProtectPoolRelease(ProcGlowPool)

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

local function SetupProcGlow(f, glowKey, color, duration, startAnim)
	f.key = glowKey -- for resetter
	local desat = color and 1 or nil
	local cR, cG, cB, cA = 1, 1, 1, 1
	if color then
		cR, cG, cB, cA = GetColorRGBA(color)
	end
	f.ProcStart:SetDesaturated(desat)
	f.ProcStart:SetVertexColor(cR, cG, cB, cA)
	f.ProcLoop:SetDesaturated(desat)
	f.ProcLoop:SetVertexColor(cR, cG, cB, cA)
	if f.ProcLoopAnim.flipbookRepeat then
		f.ProcLoopAnim.flipbookRepeat:SetDuration(duration or 1)
	end
	f.startAnim = startAnim
end

local syncColor = { 1, 1, 1, 1 }
local syncGradient = {
	{ 1, 1, 1, 1, h = 0, s = 0, v = 1 },
	{ 1, 1, 1, 1, h = 0, s = 0, v = 1 },
	{ 1, 1, 1, 1, h = 0, s = 0, v = 1 },
}

local ProcGlowDefaults = {
	frameLevel = 8,
	color = nil,
	startAnim = true,
	xOffset = 0,
	yOffset = 0,
	duration = 1,
	key = "",
}

SyncGlowDefaults = function(force)
	if not force and not glowDefaultsUnset then
		return
	end
	local E = _G.ElvUI and _G.ElvUI[1]
	if not E or not E.db or not E.db.ElvUI_EltreumUI or not E.db.ElvUI_EltreumUI.glow then
		return
	end
	local db = E.db.ElvUI_EltreumUI.glow
	local c
	if db.colorclass then
		c = (_G.CUSTOM_CLASS_COLORS and _G.CUSTOM_CLASS_COLORS[E.myclass]) or (_G.RAID_CLASS_COLORS and _G.RAID_CLASS_COLORS[E.myclass]) or E.myClassColor
	else
		c = db.glowcustomcolor
	end
	if c then
		syncColor[1], syncColor[2], syncColor[3], syncColor[4] = c.r or 1, c.g or 1, c.b or 1, 1
	end

	local grad
	if db.gradient then
		if db.gradientmode == "class" then
			local r = c and c.r or 1
			local g = c and c.g or 1
			local b = c and c.b or 1
			syncGradient[1][1], syncGradient[1][2], syncGradient[1][3], syncGradient[1][4] = E:Clamp(r - 0.2, 0, 1), E:Clamp(g - 0.2, 0, 1), E:Clamp(b - 0.2, 0, 1), 1
			syncGradient[1].h = nil
			syncGradient[2][1], syncGradient[2][2], syncGradient[2][3], syncGradient[2][4] = r, g, b, 1
			syncGradient[2].h = nil
			syncGradient[3][1], syncGradient[3][2], syncGradient[3][3], syncGradient[3][4] = E:Clamp(r + 0.2, 0, 1), E:Clamp(g + 0.2, 0, 1), E:Clamp(b + 0.2, 0, 1), 1
			syncGradient[3].h = nil
			grad = syncGradient
		else
			local c1 = db.gradientcolor1
			local c2 = db.gradientcolor2
			local c3 = db.gradientcolor3
			syncGradient[1][1], syncGradient[1][2], syncGradient[1][3], syncGradient[1][4] = c1 and c1.r or 1, c1 and c1.g or 0.75, c1 and c1.b or 0.75, c1 and c1.a or 1
			syncGradient[1].h = nil
			syncGradient[2][1], syncGradient[2][2], syncGradient[2][3], syncGradient[2][4] = c2 and c2.r or 0.75, c2 and c2.g or 1, c2 and c2.b or 0.75, c2 and c2.a or 1
			syncGradient[2].h = nil
			syncGradient[3][1], syncGradient[3][2], syncGradient[3][3], syncGradient[3][4] = c3 and c3.r or 0.75, c3 and c3.g or 0.75, c3 and c3.b or 1, c3 and c3.a or 1
			syncGradient[3].h = nil
			grad = syncGradient
		end
	else
		grad = nil
	end

	-- Sync Pixel Glow
	local pDef = pixelTemplates.default
	pDef.N = db.numberpixel or 4
	pDef.th = db.thicknesspixel or 3
	pDef.frequency = -(db.frequencypixel or 1)
	pDef.length = db.lengthpixel or 15
	pDef.xOffset = db.pixelxOffset or 3
	pDef.yOffset = db.pixelyOffset or 3
	pDef.border = db.borderpixel
	pDef.startBling = db.pixelstartBling
	pDef.repeatBling = db.pixelrepeatBling
	pDef.annoy = db.pixelannoy
	pDef.annoyFrequency = db.pixelannoyFrequency or 0.5
	pDef.fadeDuration = db.pixelfadeDuration or 0.45
	pDef.forceStop = db.pixelforceStop or false
	pDef.color = syncColor
	pDef.gradient = grad
	pDef.gradientFrequency = db.gradientfrequency or 0.7

	-- Sync Border Pulse Glow
	local bp = db.borderpulse
	local bpDef = borderPulseTemplates.default
	if bp then
		bpDef.N = bp.number or 1
		bpDef.startPoint = bp.startPoint or "BOTTOMLEFT"
		bpDef.th = bp.thickness or 2
		bpDef.frequency = bp.frequency or 1
		bpDef.sine = bp.sine
		bpDef.clockwise = bp.clockwise
		bpDef.mirror = bp.mirror
		bpDef.startBling = bp.startBling
		bpDef.repeatBling = bp.repeatBling
		bpDef.annoy = bp.annoy
		bpDef.annoyFrequency = bp.annoyFrequency or 0.5
		bpDef.forceStop = bp.forceStop or false
		bpDef.xOffset = bp.xOffset or 0
		bpDef.yOffset = bp.yOffset or 0
		bpDef.frameLevel = bp.frameLevel or 8
	end
	bpDef.color = syncColor
	bpDef.gradient = grad
	bpDef.gradientFrequency = db.gradientfrequency or 0.7

	-- Sync Bling
	local bl = db.bling
	local blDef = blingTemplates.default
	if bl then
		blDef.flash = bl.flash or "split"
		blDef.startPoint = bl.startPoint or "TOPLEFT"
		blDef.duration = bl.duration or 0.65
		blDef.sine = bl.sine
		blDef.reverse = bl.reverse
		blDef.noTails = bl.noTails
		local blRepeat = bl.repeatAnim ~= nil and bl.repeatAnim or (bl["repeat"] ~= nil and bl["repeat"] or true)
		blDef.repeatAnim = blRepeat
		blDef["repeat"] = blRepeat
		blDef.annoy = bl.annoy
		blDef.annoyFrequency = bl.annoyFrequency or 0.5
		blDef.xOffset = bl.xOffset or 0
		blDef.yOffset = bl.yOffset or 0
		blDef.frameLevel = bl.frameLevel or 8
		if blDef.tails then
			blDef.tails.th = bl.thickness or 2
			blDef.tails.N = bl.tailN or 1
			blDef.tails.startPoint = bl.tailStartPoint or "BOTTOMLEFT"
			blDef.tails.clockwise = bl.tailClockwise
			blDef.tails.mirror = bl.tailMirror
			blDef.tails.color = syncColor
		end
	end
	blDef.color = syncColor
	blDef.gradient = grad
	blDef.gradientFrequency = db.gradientfrequency or 0.7

	-- Sync AutoCast Glow
	local acDef = autoCastTemplates.default
	acDef.color = syncColor
	acDef.N = db.numberauto or 4
	acDef.frequency = db.frequencyauto or 0.125
	acDef.scale = db.autoscale or 1
	acDef.xOffset = db.autoxOffset or 0
	acDef.yOffset = db.autoyOffset or 0

	-- Sync Blizzard Button Glow
	local bgDef = buttonGlowTemplates.default
	bgDef.color = syncColor
	bgDef.frequency = db.frequencyblizz or 0.25

	-- Sync Proc Glow
	local pr = db.proc
	if pr then
		ProcGlowDefaults.duration = pr.duration or 1
		ProcGlowDefaults.startAnim = pr.startAnim
		ProcGlowDefaults.xOffset = pr.xOffset or 0
		ProcGlowDefaults.yOffset = pr.yOffset or 0
		ProcGlowDefaults.frameLevel = pr.frameLevel or 8
	end
	ProcGlowDefaults.color = syncColor
	glowDefaultsUnset = false
end

lib.SyncGlowDefaults = function()
	SyncGlowDefaults(true)
end

function lib.ProcGlow_Start(r, options, duration, startAnim, xOffset, yOffset, frameLevel, key)
	if not r then return end
	if glowDefaultsUnset then
		SyncGlowDefaults()
	end

	local d = ProcGlowDefaults
	local optColor, optDur, optStartAnim, optXOff, optYOff, optFrameLevel, optKey
	local isOpts = type(options) == "table" and options[1] == nil and not options.GetRGBA
	if isOpts then
		optColor = options.color ~= nil and options.color or d.color
		optDur = options.duration or d.duration
		optStartAnim = options.startAnim == nil and d.startAnim or options.startAnim
		optXOff = options.xOffset or d.xOffset
		optYOff = options.yOffset or d.yOffset
		optFrameLevel = options.frameLevel or d.frameLevel
		optKey = options.key or d.key
	else
		optColor = options
		optDur = duration or d.duration
		optStartAnim = startAnim == nil and d.startAnim or startAnim
		optXOff = xOffset or d.xOffset
		optYOff = yOffset or d.yOffset
		optFrameLevel = frameLevel or d.frameLevel
		optKey = key or d.key
	end

	local glowKey = (optKey and optKey ~= "") and ("_ProcGlow" .. optKey) or "_ProcGlow"
	local existing = r[glowKey]
	local isValidPoolFrame = existing and IsPoolObjectActive(ProcGlowPool, existing)
	local f, new
	if isValidPoolFrame then
		f = existing
	else
		if existing then
			SafeReleaseFrame(ProcGlowPool, existing)
		end
		f, new = ProcGlowPool:Acquire()
		if new then
			InitProcGlow(f)
		end
		r[glowKey] = f
	end
	f:SetParent(r)
	f:SetFrameLevel(r:GetFrameLevel() + optFrameLevel)

	local width, height = r:GetSize()
	width = (width and width > 0) and width or 40
	height = (height and height > 0) and height or 40
	local xOff = optXOff + width * 0.2
	local yOff = optYOff + height * 0.2
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", r, "TOPLEFT", -xOff, yOff)
	f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", xOff, -yOff)

	SetupProcGlow(f, glowKey, optColor, optDur, optStartAnim)
	if f:IsShown() then
		ProcGlow_OnHide(f)
		ProcGlow_OnShow(f)
	else
		f:Show()
	end
end

function lib.ProcGlow_Stop(r, key)
	if not r then return end
	local glowKey = (key and key ~= "") and ("_ProcGlow" .. key) or "_ProcGlow"
	local f = r[glowKey]
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
