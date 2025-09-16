module "System", package.seeall
export Pagination

Pagination = {}

Pagination.get_page_and_size = (params) ->
    page = tonumber(params.page) or 1
    size = tonumber(params.size) or 10

    return page, size