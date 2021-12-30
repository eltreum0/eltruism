local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local ElvUF = E.oUF
local _G = _G
local UnitName = _G.UnitName
local UnitClass = _G.UnitClass
local UnitIsPlayer = _G.UnitIsPlayer
local string = _G.string
local utf8sub = string.utf8sub

-- Name custom abbreviation by Azilroka
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("name:eltruism:abbreviate", "UNIT_NAME_UPDATE", function(unit)
		local name = UnitName(unit)
		-- local name = 'Ецхо оф а Пандарен Монк' --cyrillic name test
		if name and string.len(name) > 16 then
			name = name:gsub('(%S+) ', function(t) return t:utf8sub(1,1)..'. ' end)
		end
		return name
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['name:eltruism:abbreviate'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['name:eltruism:abbreviate'] = function(unit)
		local name = UnitName(unit)
			-- local name = 'Ецхо оф а Пандарен Монк' --cyrillic name test
			if name and string.len(name) > 16 then
				name = name:gsub('(%S+) ', function(t) return t:utf8sub(1,1)..'. ' end)
			end
			return name
	end
end
E:AddTagInfo('name:eltruism:abbreviate', ElvUI_EltreumUI.Name, L["Abbreviates the unit name once it goes over 16 characters, made by Azilroka"])

-- Alternate Class Icons by Releaf
local classIcons = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorReleaf.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinReleaf.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterReleaf.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueReleaf.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestReleaf.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightReleaf.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanReleaf.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageReleaf.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockReleaf.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkReleaf.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidReleaf.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterReleaf.tga:0:0:0:0|t",
}

--show class icons on all targets
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:class:all", "UNIT_NAME_UPDATE", function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIcons[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:class:all'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:class:all'] = function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIcons[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:class:all', ElvUI_EltreumUI.Name, L["Shows Class Icons recolored by Releaf on all targets"])

--show class icons only on players, ty repooc!
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:class:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIcons[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:class:player'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:class:player'] = function(unit)
	if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIcons[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:class:player', ElvUI_EltreumUI.Name, L["Shows Class Icons recolored by Releaf on Player targets"])

-- Class Icons
local classIconsBlizzard = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter.tga:0:0:0:0|t",
}

--alternate class icons on all targets
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:blizz:all", "UNIT_NAME_UPDATE", function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsBlizzard[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:blizz:all'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:blizz:all'] = function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsBlizzard[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:blizz:all', ElvUI_EltreumUI.Name, L["Shows Class Icons by Blizzard on all targets"])

--alternate class icons on players
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:blizz:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsBlizzard[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:blizz:player'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:blizz:player'] = function(unit)
		if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsBlizzard[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:blizz:player', ElvUI_EltreumUI.Name, L["Shows Class Icons by Blizzard only on Player targets"])

-- Alternate Class Icons by Releaf with borders
local classIconsReleafborder = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorIconReleaf.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinIconReleaf.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterIconReleaf.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueIconReleaf.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestIconReleaf.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightIconReleaf.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanIconReleaf.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageIconReleaf.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockIconReleaf.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkIconReleaf.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidIconReleaf.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterIconReleaf.tga:0:0:0:0|t",
}

--alternate class icons on all targets
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:ReleafBorder:all", "UNIT_NAME_UPDATE", function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsReleafborder[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:ReleafBorder:all'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:ReleafBorder:all'] = function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsReleafborder[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:ReleafBorder:all', ElvUI_EltreumUI.Name, L["Shows Class Icons with borders recolored by Releaf on all targets"])

--alternate class icons on players
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:ReleafBorder:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsReleafborder[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:ReleafBorder:player'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:ReleafBorder:player'] = function(unit)
		if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsReleafborder[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:ReleafBorder:player', ElvUI_EltreumUI.Name, L["Shows Class Icons with borders recolored by Releaf on Player targets"])

-- Class Icons by Blizz with borders
local classIconsOutline = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarriorShadow.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PaladinShadow.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\HunterShadow.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\RogueShadow.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\PriestShadow.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnightShadow.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\ShamanShadow.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MageShadow.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\WarlockShadow.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\MonkShadow.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DruidShadow.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunterShadow.tga:0:0:0:0|t",
}

--class icons with outlines on all targets
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:IconOutline:all", "UNIT_NAME_UPDATE", function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsOutline[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:IconOutline:all'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:IconOutline:all'] = function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsOutline[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:IconOutline:all', ElvUI_EltreumUI.Name, "Shows Class Icons with Outlines all targets")

--class icons with otlines on players
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:IconOutline:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsOutline[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:IconOutline:player'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:IconOutline:player'] = function(unit)
	if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsOutline[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:IconOutline:player', ElvUI_EltreumUI.Name, "Shows Class Icons with Outlines on Player targets")

-- Class Icons by Releaf with borders
local classIconsOutlineReleaf = {
	['WARRIOR'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warrior1.tga:0:0:0:0|t",
	['PALADIN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Paladin1.tga:0:0:0:0|t",
	['HUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Hunter1.tga:0:0:0:0|t",
	['ROGUE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Rogue1.tga:0:0:0:0|t",
	['PRIEST'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Priest1.tga:0:0:0:0|t",
	['DEATHKNIGHT'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DeathKnight1.tga:0:0:0:0|t",
	['SHAMAN'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Shaman1.tga:0:0:0:0|t",
	['MAGE'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Mage1.tga:0:0:0:0|t",
	['WARLOCK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Warlock1.tga:0:0:0:0|t",
	['MONK'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Monk1.tga:0:0:0:0|t",
	['DRUID'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\Druid1.tga:0:0:0:0|t",
	['DEMONHUNTER'] = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Classes\\DemonHunter1.tga:0:0:0:0|t",
}

--class icons with outlines on all targets
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:ReleafIconOutline:all", "UNIT_NAME_UPDATE", function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsOutlineReleaf[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:ReleafIconOutline:all'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:ReleafIconOutline:all'] = function(unit)
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsOutlineReleaf[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:ReleafIconOutline:all', ElvUI_EltreumUI.Name, "Shows Class Icons with Outlines by Releaf all targets")

--class icons with otlines on players
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("eltruism:ReleafIconOutline:player", "UNIT_NAME_UPDATE", function(unit)
		if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsOutlineReleaf[classes]
		return icon
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['eltruism:ReleafIconOutline:player'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['eltruism:ReleafIconOutline:player'] = function(unit)
	if not UnitIsPlayer(unit) then return end
		local icon
		local _ , classes = UnitClass(unit)
		icon = classIconsOutlineReleaf[classes]
		return icon
	end
end
E:AddTagInfo('eltruism:ReleafIconOutline:player', ElvUI_EltreumUI.Name, "Shows Class Icons with Outlines by Releaf on Player targets")

-- Releaf Logo
if ElvUI_EltreumUI.Retail or ElvUI_EltreumUI.TBC then
	E:AddTag("releaf", "UNIT_NAME_UPDATE", function(unit)
		local color = E:ClassColor(E.myclass, true)
		local red = math.floor(color.r*255)
		local blue = math.floor(color.b*255)
		local green = math.floor(color.g*255)
		local releaf = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\releaftag.tga:0:0:0:3:128:128:0:128:0:128:" .. red .. ":" .. green .. ":" .. blue .. "|t"
		--local releaf = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Releaf-Orange.tga:0:0:0:0|t"
		return releaf
	end)
elseif ElvUI_EltreumUI.Classic then
	ElvUF.Tags.Events['releaf'] = 'UNIT_NAME_UPDATE'
	ElvUF.Tags.Methods['releaf'] = function(unit)
		local color = E:ClassColor(E.myclass, true)
		local red = math.floor(color.r*255)
		local blue = math.floor(color.b*255)
		local green = math.floor(color.g*255)
		local releaf = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\releaftag.tga:0:0:0:3:128:128:0:128:0:128:" .. red .. ":" .. green .. ":" .. blue .. "|t"
		--local releaf = "|TInterface\\Addons\\ElvUI_EltreumUI\\Media\\Textures\\Releaf-Orange.tga:0:0:0:0|t"
		return releaf
	end
end
E:AddTagInfo('releaf', ElvUI_EltreumUI.Name, "Shows Releaf's Icon")
