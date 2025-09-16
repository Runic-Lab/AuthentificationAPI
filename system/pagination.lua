module("System", package.seeall)
Pagination = { }
Pagination.get_page_and_size = function(params)
  local page = tonumber(params.page) or 1
  local size = tonumber(params.size) or 10
  return page, size
end
