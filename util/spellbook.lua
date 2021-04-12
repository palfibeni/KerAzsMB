function isSpellOnCooldownByName(spellname)
    return isSpellOnCooldownById(getSpellId(spellname))
end

function isSpellOnCooldownById(spellbookId)
	local start, duration = GetSpellCooldown(spellbookId, "BOOKTYPE_SPELL ")
	return start ~= 0
end

-- Returns the spellbookId of the spell
function getSpellId(spellName)
	local highestRank = -1
	local highestRankId = -1
	for i = 1, 200 do
		local name, rankString = GetSpellName(i, "BOOKTYPE_SPELL")
		if name == spellName then
			local rank = 0
			if string.find(rankString, "Rank %d+") then
				rank = tonumber(string.sub(rankString, 5))
			end
			if rank > highestRank then
				highestRankId = i
				highestRank = rank
			end
		end
	end
	return highestRankId
end

function IsActionReady(actionSlot)
    if IsUsableAction(actionSlot) and GetActionCooldown(actionSlot) == 0 then
        return true
    end
    return false
end
