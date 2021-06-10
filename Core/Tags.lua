local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local ElvUF = E.oUF
local utf8sub = string.utf8sub

-- Name custom abbreviation by Azilroka
ElvUF.Tags.Events['name:eltruism:abbreviate'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:eltruism:abbreviate'] = function(unit)
	local name = UnitName(unit)
	-- local name = 'Ецхо оф а Пандарен Монк' --cyrillic name test
	if name and string.len(name) > 16 then
        name = name:gsub('(%S+) ', function(t) return t:utf8sub(1,1)..'. ' end)
	end
	return name
end
E:AddTagInfo('name:eltruism:abbreviate', ElvUI_EltreumUI.Name, "Abbreviates the unit name once it goes over 16 characters, made by Azilroka")

-- Class Icons
local classIcons = {
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
ElvUF.Tags.Events['eltruism:class:all'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['eltruism:class:all'] = function(unit)
	local icon
	local _ , classes = UnitClass(unit)
	icon = classIcons[classes]
	return icon
end
E:AddTagInfo('eltruism:class:all', ElvUI_EltreumUI.Name, "Shows Class Icons by Blizzard on all targets")

--ty repooc!
ElvUF.Tags.Events['eltruism:class:player'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['eltruism:class:player'] = function(unit)
    if not UnitIsPlayer(unit) then return end
    local icon
    local _ , classes = UnitClass(unit)
    icon = classIcons[classes]
    return icon
end
E:AddTagInfo('eltruism:class:player', ElvUI_EltreumUI.Name, "Shows Class Icons by Blizzard only on Player targets")
