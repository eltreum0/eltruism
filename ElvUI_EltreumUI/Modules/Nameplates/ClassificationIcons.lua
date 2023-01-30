local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local oUF = E.oUF
local NP = E:GetModule('NamePlates')
local elementAdded = false

--based on blinkii's idea
local bossIDs = {
    --DF
    --AA
    ["194181"] = true,
    ["191736"] = true,
    ["196482"] = true,
    ["190609"] = true,
    --BH
    ["186122"] = true,
    ["186124"] = true,
    ["186125"] = true,
    ["186120"] = true,
    ["186121"] = true,
    ["186116"] = true,
    --HOF
    ["189719"] = true,
    ["189729"] = true,
    ["189722"] = true,
    ["189727"] = true,
    --NEL
    ["189901"] = true,
    ["189478"] = true,
    ["181861"] = true,
    ["189340"] = true,
    --RLP
    ["188252"] = true,
    ["189232"] = true,
    ["190485"] = true,
	["190484"] = true,
    --TAV
    ["186738"] = true,
    ["186644"] = true,
    ["186739"] = true,
    ["199614"] = true,
    --TNO
    ["186615"] = true,
    ["195723"] = true,
    ["186338"] = true,
    ["186151"] = true,
    ["186616"] = true,
	["186339"] = true,
    --ULD
    ["184125"] = true,
    ["184124"] = true,
    ["184018"] = true,
    ["184422"] = true,
	-- DF S1
	--HOV
	["95674"] = true,
	["99868"] = true,
	["94960"] = true,
	["95833"] = true,
	["95675"] = true,
	["95676"] = true,
	-- COS
	["104218"] = true,
	["104217"] = true,
	["104215"] = true,
	-- SBG
	["76407"] = true,
	["75452"] = true,
	["75509"] = true,
	-- TJS
	["56448"] = true,
	["59051"] = true,
	["59726"] = true,
	["56732"] = true,
	["56439"] = true,
	-- raid VOTI
	["190245"] = true,
	["184972"] = true,
	["189492"] = true,
	["189813"] = true,
	["187771"] = true,
	["181378"] = true,
	["187967"] = true,
	["190496"] = true,
}

local textureDB = {
		["TYPE1"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star.tga",
		["TYPE2"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star2.tga",
		["TYPE3"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star3.tga",
		["TYPE4"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\dragon.tga",
		["TYPE5"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\dragon2.tga",
		["TYPE6"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\treasure.tga"
	}

local function Update(self)
	local element = self.EltruismClassificationIndicator

	if element.PreUpdate then
		element:PreUpdate()
	end

	if E.db.ElvUI_EltreumUI.dev then
		ElvUI_EltreumUI:Print("npcID: ", self.npcID)
	end

	local classification = self.classification

	if classification == 'worldboss' or bossIDs[self.npcID] then
		if E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss == "CUSTOM" then
			element:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customboss)
		else
			element:SetTexture(textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss])
		end
		-- color
		element:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.bossR, E.db.ElvUI_EltreumUI.nameplates.classification.bossG, E.db.ElvUI_EltreumUI.nameplates.classification.bossB, 1)
		element:Show()
	elseif classification == 'elite' then
		if E.db.ElvUI_EltreumUI.nameplates.classification.icontypeelite == "CUSTOM" then
			element:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customelite)
		else
			element:SetTexture(textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontypeelite])
		end
		-- color
		element:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.eliteR, E.db.ElvUI_EltreumUI.nameplates.classification.eliteG, E.db.ElvUI_EltreumUI.nameplates.classification.eliteB, 1)
		element:Show()
	elseif classification == 'rareelite' then
		if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite == "CUSTOM" then
			element:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrareelite)
		else
			element:SetTexture(textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite])
		end
		element:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteR, E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteG, E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteB, 1)
		--element:SetAtlas('nameplates-icon-elite-silver')
		element:Show()
	elseif classification == 'rare' then
		if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperare == "CUSTOM" then
			element:SetTexture([[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrare)
		else
			element:SetTexture(textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontyperare])
		end

		element:SetVertexColor(E.db.ElvUI_EltreumUI.nameplates.classification.rareR, E.db.ElvUI_EltreumUI.nameplates.classification.rareG, E.db.ElvUI_EltreumUI.nameplates.classification.rareB, 1)
		element:Show()
	else
		element:Hide()
	end

	if element.PostUpdate then
		return element:PostUpdate(classification)
	end
end

local function Path(self, ...)
	return (self.EltruismClassificationIndicator.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self)
	local element = self.EltruismClassificationIndicator
	if element then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		if element:IsObjectType('Texture') and not element:GetTexture() then
			element:SetTexture([[Interface\TARGETINGFRAME\Nameplates]])
		end

		self:RegisterEvent('UNIT_CLASSIFICATION_CHANGED', Path)

		return true
	end
end

local function Disable(self)
	local element = self.EltruismClassificationIndicator
	if element then
		element:Hide()

		self:UnregisterEvent('UNIT_CLASSIFICATION_CHANGED', Path)
	end
end

local function Construct_ClassificationIndicator(nameplate)
	return nameplate:CreateTexture(nameplate:GetName() .. 'EltruismClassificationIndicator', 'OVERLAY')
end

local function Update_ClassificationIndicator(_, nameplate)
	local plateDB = NP:PlateDB(nameplate)

	 -- add your settings here
	local db = plateDB.eliteIcon
	 -- if db and db.enable and (nameplate.frameType == 'FRIENDLY_NPC' or nameplate.frameType == 'ENEMY_NPC') then

	 -- only for demo
	if db and (nameplate.frameType == 'FRIENDLY_NPC' or nameplate.frameType == 'ENEMY_NPC') then
		if not nameplate:IsElementEnabled('EltruismClassificationIndicator') then
			nameplate:EnableElement('EltruismClassificationIndicator')
		end
		if nameplate.EltruismClassificationIndicator then
			nameplate.EltruismClassificationIndicator:ClearAllPoints()
			nameplate.EltruismClassificationIndicator:Size(db.size, db.size)
			nameplate.EltruismClassificationIndicator:Point(E.InversePoints[db.position], nameplate, db.position, db.xOffset, db.yOffset)
		end

		if nameplate:IsElementEnabled('ClassificationIndicator') then --hide elvui's icon if eltruism's is enabled
			if nameplate.ClassificationIndicator then
				nameplate.ClassificationIndicator:SetAlpha(0)
			end
		end

	elseif nameplate:IsElementEnabled('EltruismClassificationIndicator') then
		nameplate:DisableElement('EltruismClassificationIndicator')
	end
end

local function StylePlate(_, nameplate)
	nameplate.EltruismClassificationIndicator = Construct_ClassificationIndicator(nameplate.RaisedElement)
end

function ElvUI_EltreumUI:NPClassificatioNIcon()
	if E.db.ElvUI_EltreumUI.nameplates.classification.enable then
		-- hook to create the icon
		hooksecurefunc(NP, "Update_ClassificationIndicator", Update_ClassificationIndicator)
		hooksecurefunc(NP, "StylePlate", StylePlate)

		-- add it to ouf
		if not elementAdded then
			oUF:AddElement('EltruismClassificationIndicator', Path, Enable, Disable)
			elementAdded = true
		end
	end
end



