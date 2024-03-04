local E, L = unpack(ElvUI)
local oUF = E.oUF
local NP = E:GetModule('NamePlates')
local elementAdded = false
local _G = _G
local math = _G.math
local string = _G.string
local UnitCanAttack = _G.UnitCanAttack
local UnitIsPlayer = _G.UnitIsPlayer
local UnitGUID = _G.UnitGUID
local UnitClassification = _G.UnitClassification
local hooksecurefunc = _G.hooksecurefunc

--based on blinkii's idea
local bossIDs = {

	-- Algeth'ar Academy
	["194181"] = true,
	["191736"] = true,
	["196482"] = true,
	["190609"] = true,

	-- Brackenhide Hollow
	["186122"] = true,
	["186124"] = true,
	["186125"] = true,
	["186120"] = true,
	["186121"] = true,
	["186116"] = true,

	-- Halls of Infusion
	["189719"] = true,
	["189729"] = true,
	["189722"] = true,
	["189727"] = true,

	-- Neltharus
	["189901"] = true,
	["189478"] = true,
	["181861"] = true,
	["189340"] = true,

	-- Ruby Life Pools
	["188252"] = true,
	["189232"] = true,
	["190485"] = true,
	["190484"] = true,

	-- The Azure Vault
	["186738"] = true,
	["186644"] = true,
	["186739"] = true,
	["199614"] = true,

	-- The Nokhud Offensive
	["186615"] = true,
	["195723"] = true,
	["186338"] = true,
	["186151"] = true,
	["186616"] = true,
	["186339"] = true,

	-- Uldaman: Legacy of Tyr
	["184125"] = true,
	["184124"] = true,
	["184018"] = true,
	["184422"] = true,

	-- Halls of Valor
	["95674"] = true,
	["99868"] = true,
	["94960"] = true,
	["95833"] = true,
	["95675"] = true,
	["95676"] = true,

	-- Court of Stars
	["104218"] = true,
	["104217"] = true,
	["104215"] = true,

	-- Shadowmoon Burial Grounds
	["76407"] = true,
	["75452"] = true,
	["75509"] = true,

	-- Temple of the Jade Serpent
	["56448"] = true,
	["59051"] = true,
	["59726"] = true,
	["56732"] = true,
	["56439"] = true,

	-- Neltharion's Lair
	["91007"] = true,
	["91005"] = true,
	["91003"] = true,
	["91004"] = true,

	-- Freehold
	["129431"] = true,
	["129432"] = true,
	["126847"] = true,
	["129440"] = true,
	["129732"] = true,

	-- Underrot
	["131817"] = true,
	["131318"] = true,
	["131383"] = true,
	["133007"] = true,

	-- Vortex Pinnacle
	["43878"] = true,
	["43873"] = true,
	["43875"] = true,

	-- Dawn of the Infinite
	["198933"] = true,
	["198995"] = true,
	["198996"] = true,
	["198997"] = true,
	["198998"] = true,
	["198999"] = true,
	["199000"] = true,
	["201788"] = true,
	["201790"] = true,
	["201792"] = true,
	["209207"] = true,
	["209208"] = true,
	["203679"] = true,
	["203678"] = true,

	--Darkheart Thicket
	["103344"] = true, --oakheart
	["99192"] = true, --shade-of-xavius
	["96512"] = true, --archdruid-glaidalis
	["99200"] = true, --dresaron

	--Black Rook Hold
	["94923"] = true, --lord-kurtalos-ravencrest
	["98542"] = true, --amalgam-of-souls
	["98696"] = true, --illysanna-ravencrest
	["98949"] = true, --smashspite-the-hateful

	-- Waycrest Manor
	["131527"] = true, --lord-waycrest
	["131667"] = true, --soulbound-goliath
	["131863"] = true, --raal-the-gluttonous
	["144324"] = true, --gorak-tul
	["135360"] = true, --sister-briar

	--Atal'Dazar
	["143577"] = true, --rezan
	["129399"] = true, --volkaal
	["129412"] = true, --yazma
	["129614"] = true, --priestess-alunza

	--The Everbloom
	["83846"] = true, --yalnu
	["81522"] = true, --witherbark
	["82682"] = true, --archmage-sol
	["83894"] = true, --dulhu
	["83892"] = true, --life-warden-gola
	["83893"] = true, --earthshaper-telu
	["84550"] = true, --xeritac

	--Throne of the Tides
	["40788"] = true, --mindbender-ghursha
	["40765"] = true, --commander-ulthok
	["40586"] = true, --lady-nazjar
	["44566"] = true, --ozumat
	["40825"] = true, --erunak-stonespeaker

	-- Vault of the Incarnates
	["190245"] = true, --Broodkeeper-Diurna
	["184972"] = true, --Eranog
	["189492"] = true, --Raszageth
	["189813"] = true, --Dathea-Ascended
	["184986"] = true, --Kurog-Grimtotem
	["187967"] = true, --Sennarth
	["190496"] = true, --Terros
	["187771"] = true, --Kadros-Icewrath
	["187768"] = true, --Dathea-Stormlash
	["187772"] = true, --Opalfang
	["187767"] = true, --Embar-Firepath

	-- Aberrus, the Shadowed Crucible
	["200913"] = true, --Thadrion
	["200918"] = true, --Rionthus
	["199659"] = true, --Warlord Kagni
	["201320"] = true, --Rashok
	["202637"] = true, --Zskarn
	["201579"] = true, --Magmorax
	["204223"] = true, --Neltharion
	["205319"] = true, --Scalecommander Sarkareth
	["201261"] = true, --Kazzara, the Hellforged
	["201773"] = true, --Eternal Blaze
	["201774"] = true, --Essence of Shadow
	["201934"] = true, --Shadowflame Amalgamation
	["200912"] = true, --Neldris

	--Amirdrassil, the Dream's Hope
	["209333"] = true, -- Gnarlroot
	["200926"] = true, -- Igira the Cruel
	["208478"] = true, -- Volcoross
	["208363"] = true, -- Council of Dreams
	["208365"] = true, -- Council of Dreams
	["208367"] = true, -- Council of Dreams
	["208445"] = true, -- Larodar, the Keeper of the Flame
	["206172"] = true, -- Nymue, Weaver of the Cycle
	["200927"] = true, -- Smolderon
	["209090"] = true, -- Tindral Sageswift, Seer of the Flame
	["204931"] = true, -- Fyrakk the Blazing

	-- The Primalist Future (storm fury bosses)
	["199502"] = true, --glakis-winters-wrath
	["199667"] = true, --nimbulatus-storms-wrath
	["199664"] = true, --seismodor-earths-wrath

	--dragonflight world bosses
	["193534"] = true, --strunraan
	["193532"] = true, --bazual
	["193535"] = true, --basrikron
	["193533"] = true, --liskanoth
	["203220"] = true, --Vakan
	["199853"] = true, --Gholna
	["209574"] = true, --Aurostor

	--shadowlands world bosses
	["167524"] = true, --valinor
	["182466"] = true, --antros
	["178958"] = true, --morgeth
	["167525"] = true, --mortanis
	["167527"] = true, --oranomonos-the-everbranching
	["167526"] = true, --nurgash-muckformed
	["169035"] = true, --nathanos-blightcaller

	--bfa world bosses
	["154638"] = true, --grand-empress-shekzara
	["160970"] = true, --vuklaz-the-earthbreaker
	["152671"] = true, --wekemara
	["152697"] = true, --ulmath
	["148295"] = true, --ivus-the-decayed
	["144946"] = true, --ivus-the-forest-lord
	["138122"] = true, --dooms-howl
	["137374"] = true, --the-lions-roar
	["132701"] = true, --tzane
	["132253"] = true, --jiarak
	["138794"] = true, --dunegorger-kraulok
	["140252"] = true, --hailstone-construct
	["136385"] = true, --azurethos
	["140163"] = true, --warbringer-yenajz

	--legion world bosses
	["109943"] = true, --ana-mouz
	["121124"] = true, --apocron
	["117239"] = true, --brutallus
	["109331"] = true, --calamir
	["110378"] = true, --drugon-the-frostblood
	["99929"] = true, --flotsam
	["108879"] = true, --humongris
	["108829"] = true, --levantus
	["117303"] = true, --malificus
	["110321"] = true, --nazak-the-fiend
	["107544"] = true, --nithogg
	["108678"] = true, --sharthos
	["117470"] = true, --sivash
	["106981"] = true, --captain-hring
	["106984"] = true, --soultrapper-mevra
	["106982"] = true, --reaver-jdorn
	["112350"] = true, --withered-jim

	--wod world bosses
	["81252"] = true, --drov-the-ruiner
	["81535"] = true, --tarlna-the-ageless
	["83746"] = true, --rukhmar
	["94015"] = true, --supreme-lord-kazzak

	--mop world bosses
	["60491"] = true, --sha-of-anger
	["62346"] = true, --galleon
	["69099"] = true, --nalak
	["69161"] = true, --oondasta
	["72057"] = true, --ordos
	["71952"] = true, --chi-ji
	["71954"] = true, --niuzao
	["71953"] = true, --xuen
	["71955"] = true, --yulon

	--cataclysm world bosses
	["50063"] = true, --akmahat
	["50056"] = true, --garr
	["50089"] = true, --julak-doom
	["50009"] = true, --mobus
	["40728"] = true, --whale-shark
	["50061"] = true, --xariona

	--tbc world bosses
	["18728"] = true, --doom-lord-kazzak
	["17711"] = true, --doomwalker

	--classic world bosses
	["6109"] = true, --azuregos
	["15205"] = true, --baron-kazum
	["15305"] = true, --lord-skwol
	["15204"] = true, --high-marshal-whirlaxis
	["15203"] = true, --prince-skaldrenox
	["14890"] = true, --taerar
	["14887"] = true, --ysondre
	["15491"] = true, --eranikus-tyrant-of-the-dream
	["12397"] = true, --lord-kazzak
	["15571"] = true, --maws
	["15818"] = true, --lieutenant-general-nokhor
	["7846"] = true, --teremus-the-devourer
	["15625"] = true, --twilight-corrupter
	["18338"] = true, --highlord-kruul
	["14889"] = true, --emeriss
	["14888"] = true, --lethon

	--wow anniversary
	["121820"] = true, --azuregos
	["121913"] = true, --emeriss
	["121821"] = true, --lethon
	["121911"] = true, --taerar
	["121912"] = true, --ysondre
	["121818"] = true, --lord-kazzak
	["167749"] = true, --doomwalker

	--darkmoon
	["58336"] = true, --darkmoon-rabbit
	["71992"] = true, --moonfang
	["15467"] = true, --omen

	--World Events

	--Love is in the Air
	["36296"] = true, --Apothecary Hummel <Crown Chemical Co.>
	["36565"] = true, --Apothecary Baxter <Crown Chemical Co.>
	["36272"] = true, --Apothecary Frye <Crown Chemical Co.>

	--SOD bosses

	--blackfathom
	["202699"] = true, --baron-aquanis
	["201722"] = true, --ghamoo-ra
	["204068"] = true, --lady-sarevess
	["204921"] = true, --gelihast
	["207356"] = true, --lorgus-jett
	["209678"] = true, --twilight-lord-kelris
	["213334"] = true, --akumai

	---gnomeregan
	["7361"] = true, --grubbis
	["7079"] = true, --viscous-fallout
	["6235"] = true, --electrocutioner-6000
	["6229"] = true, --crowd-pummeler-9-60
	["6228"] = true, --dark-iron-ambassador
	["7800"] = true, --mekgineer-thermaplugg

	--sod event bosses
	["212804"] = true, --centrius
	["212707"] = true, --larodar
	["212803"] = true, --ceredwyn
	["212801"] = true, --jubei
	["212730"] = true, --tojara
	["212802"] = true, --moogul-the-sly
	["218690"] = true, --khadamu
}

local textureDB = {
	["TYPE1"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star.tga",
	["TYPE2"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star2.tga",
	["TYPE3"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star3.tga",
	["TYPE4"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star4.tga",
	["TYPE5"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star5.tga",
	["TYPE6"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star6.tga",
	["TYPE7"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\star7.tga",
	["TYPE8"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\dragon.tga",
	["TYPE9"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\dragon2.tga",
	["TYPE10"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\treasure.tga",
	["TYPE11"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull.tga",
	["TYPE12"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull2.tga",
	["TYPE13"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull3.tga",
	["TYPE14"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull4.tga",
	["TYPE15"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull5.tga",
	["TYPE16"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull6.tga",
	["TYPE17"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull7.tga",
	["TYPE18"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull8.tga",
	["TYPE19"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull9.tga",
	["TYPE20"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\reaper.tga",
	["TYPE21"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\reaper2.tga",
	["TYPE22"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\skull10.tga",
}

local textureDB64 = {
	["TYPE1"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star.tga",
	["TYPE2"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star2.tga",
	["TYPE3"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star3.tga",
	["TYPE4"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star4.tga",
	["TYPE5"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star5.tga",
	["TYPE6"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star6.tga",
	["TYPE7"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\star7.tga",
	["TYPE8"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\dragon.tga",
	["TYPE9"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\dragon2.tga",
	["TYPE10"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\treasure.tga",
	["TYPE11"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull.tga",
	["TYPE12"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull2.tga",
	["TYPE13"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull3.tga",
	["TYPE14"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull4.tga",
	["TYPE15"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull5.tga",
	["TYPE16"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull6.tga",
	["TYPE17"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull7.tga",
	["TYPE18"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull8.tga",
	["TYPE19"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull9.tga",
	["TYPE20"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\reaper.tga",
	["TYPE21"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\reaper2.tga",
	["TYPE22"] = "Interface\\AddOns\\ElvUI_EltreumUI\\Media\\Textures\\Nameplates\\64\\skull10.tga",
}

function ElvUI_EltreumUI:GetBossIconTextureAndID(textureType,isbossID,bossID,resolution)
	if textureType then
		if resolution then
			return textureDB64[textureType]
		else
			return textureDB[textureType]
		end
	elseif isbossID then
		if bossIDs[bossID] then
			return true
		else
			return false
		end
	end
end

local function Update(self)
	local element = self.EltruismClassificationIndicator

	if element.PreUpdate then
		element:PreUpdate()
	end

	local classification = self.classification
	local frameType = self.frameType
	if frameType then
	--if frameType and frameType == 'ENEMY_NPC' then
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
	else
		element:Hide()
	end

	if E.db.ElvUI_EltreumUI.dev then
		ElvUI_EltreumUI:Print("npcID: "..self.npcID..","..classification..","..frameType)
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
			element:SetTexture([[Interface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\tinylogo]])
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
	if db and db.enable and (nameplate.frameType == 'FRIENDLY_NPC' or nameplate.frameType == 'ENEMY_NPC') then
	--if db and (nameplate.frameType == 'ENEMY_NPC') then
		if not nameplate:IsElementEnabled('EltruismClassificationIndicator') then
			nameplate:EnableElement('EltruismClassificationIndicator')
		end
		if nameplate.EltruismClassificationIndicator and nameplate:IsElementEnabled('ClassificationIndicator') then
			nameplate.EltruismClassificationIndicator:Show()
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
		if nameplate.EltruismClassificationIndicator then
			nameplate.EltruismClassificationIndicator:Hide()
		end
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

--Difficulty Icon for npcs
E:AddTag('eltruism:classification', 'UNIT_NAME_UPDATE', function(unit)
	local red,green,blue
	local icon
	local classification = UnitClassification(unit) -- "worldboss", "rareelite", "elite", "rare", "normal", "trivial", or "minus"
	if UnitGUID(unit) and string.match(UnitGUID(unit), "Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)") then
		local unitID = (string.match(UnitGUID(unit), "Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)"))
		--print(classification,unitID,UnitGUID(unit))
		--make sure its not a player as to not overwrite class colors
		if not UnitIsPlayer(unit) and UnitCanAttack("player", unit) then
			if classification == 'worldboss' or bossIDs[unitID] then
				red = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.bossR*255)
				blue = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.bossB*255)
				green = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.bossG*255)
				if E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss == "CUSTOM" then
					icon = "|T"..[[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customboss..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				else
					icon = "|T"..textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontypeboss]..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				end
			elseif classification == 'elite' then
				red = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.eliteR*255)
				blue = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.eliteB*255)
				green = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.eliteG*255)
				if E.db.ElvUI_EltreumUI.nameplates.classification.icontypeelite == "CUSTOM" then
					icon = "|T"..[[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customelite..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				else
					icon = "|T"..textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontypeelite]..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				end
			elseif classification == 'rareelite' then
				red = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteR*255)
				blue = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteB*255)
				green = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareeliteG*255)
				if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite == "CUSTOM" then
					icon = "|T"..[[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrareelite..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				else
					icon = "|T"..textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontyperareelite]..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				end
			elseif classification == 'rare' then
				red = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareR*255)
				blue = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareB*255)
				green = math.floor(E.db.ElvUI_EltreumUI.nameplates.classification.rareG*255)
				if E.db.ElvUI_EltreumUI.nameplates.classification.icontyperare == "CUSTOM" then
					icon = "|T"..[[Interface\AddOns\]]..E.db.ElvUI_EltreumUI.nameplates.classification.customrare..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				else
					icon = "|T"..textureDB[E.db.ElvUI_EltreumUI.nameplates.classification.icontyperare]..":0:0:0:2:32:32:0:32:0:32:" .. red .. ":" .. green .. ":" .. blue .. "|t"
					return icon
				end
			end
		end
	end
end)
E:AddTagInfo('eltruism:classification', ElvUI_EltreumUI.Name.." "..L["Miscellaneous"], L["Shows an Icon for the classification of the unit"])
