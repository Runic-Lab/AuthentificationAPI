module "Modules.Account", package.seeall
export Controller

req_time = os.clock!

Controller = {}

Controller.get_all = (app) ->
    page, size = System.Pagination.get_page_and_size app.params
    results = Modules.Account.Model\get_all page, size
    total_pages = math.ceil Modules.Account.Model\count! / size

    return System.Response.send 200, req_time, results, total_pages

Controller.update = (app) ->
    id = app.params.id
    online = app.params.online

    unless id
        return System.Response.send 400, req_time, "Please, set an id"

    id = tonumber(id)
    unless type(id) == "number"
        return System.Response.send 400, req_time, "Please, set an number"

    unless online
        return System.Response.send 400, req_time, "Please, online"

    online = tonumber(online)
    unless type(online) == "number"
        return System.Response.send 400, req_time, "Please, set an number"

    code, success = Modules.Account.Model\update_online id, online

    if code == 1 and success == false
        return System.Response.send 400, req_time, "Account id invalid"

    if code == 2 and success == false
        return System.Response.send 400, req_time, "Internal error"

    return System.Response.send 200, req_time, "Success"
