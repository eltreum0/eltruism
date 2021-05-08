local ElvUI_EltreumUI, E, L, V, P, G = unpack(select(2, ...))
local ElvUF = E.oUF

-- Name custom abbreviation by Azilroka
ElvUF.Tags.Events['name:azilroka:abbreviate'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:azilroka:abbreviate'] = function(unit)
	local name = UnitName(unit)
	if name and string.len(name) > 16 then
        name = name:gsub('(%S+) ', function(t) return t:sub(1,1)..'. ' end)
	end
	return name
	end

E:AddTagInfo('name:azilroka:abbreviate', ElvUI_EltreumUI.Name, "Abbreviates the unit name once it goes over 16 characters, made by Azilroka")
