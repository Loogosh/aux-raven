-- Raven 1.14.2 compatibility for Classic aux v1.2.3
-- AH protocol matches Turtle 1.18: page size 50, no GetAll dump, durations 2/8/24h.

select(2, ...) 'aux'

local TOKEN_NAME = 'WoW Token'
local PAGE_SIZE = 50

function M.ensure_auction_ui()
	if AuctionCategories then
		return true
	end
	if AuctionFrame_LoadUI then
		pcall(AuctionFrame_LoadUI)
	end
	return AuctionCategories ~= nil
end

function M.is_token_category(category)
	local name = category and category.name
	return name and strfind(name, TOKEN_NAME, 1, true) ~= nil
end

-- 1.18/Raven server has no GetAll auction dump; Classic client may still report canQueryAll.
function M.supports_get_all()
	return false
end

function M.auction_page_size()
	return PAGE_SIZE
end

-- Classic: GetNumAuctionItems(type) → batchCount, totalCount
-- Raven API docs: total, numOwned, offset, pageSize
-- Mis-reading Raven as Classic stopped paging after the first full page.
function M.auction_list_counts(kind)
	kind = kind or 'list'
	local a, b, c, d = GetNumAuctionItems(kind)
	a = tonumber(a) or 0
	b = tonumber(b)
	c = tonumber(c)
	d = tonumber(d)
	if d then
		local total, offset, pageSize = a, c or 0, d
		if pageSize <= 0 then
			pageSize = PAGE_SIZE
		end
		local batch = min(pageSize, max(0, total - offset))
		if batch <= 0 and pageSize > 0 then
			batch = pageSize
		end
		return batch, total
	end
	return a, b or a
end
