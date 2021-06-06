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
