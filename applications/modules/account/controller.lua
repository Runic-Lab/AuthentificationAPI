module("Modules.Account", package.seeall)
local req_time = os.clock()
Controller = { }
Controller.get_all = function(app)
  local page, size = System.Pagination.get_page_and_size(app.params)
  local results = Modules.Account.Model:get_all(page, size)
  local total_pages = math.ceil(Modules.Account.Model:count() / size)
  return System.Response.send(200, req_time, results, total_pages)
end
Controller.update = function(app)
  local id = app.params.id
  local online = app.params.online
  if not (id) then
    return System.Response.send(400, req_time, "Please, set an id")
  end
  id = tonumber(id)
  if not (type(id) == "number") then
    return System.Response.send(400, req_time, "Please, set an number")
  end
  if not (online) then
    return System.Response.send(400, req_time, "Please, online")
  end
  online = tonumber(online)
  if not (type(online) == "number") then
    return System.Response.send(400, req_time, "Please, set an number")
  end
  local code, success = Modules.Account.Model:update_online(id, online)
  if code == 1 and success == false then
    return System.Response.send(400, req_time, "Account id invalid")
  end
  if code == 2 and success == false then
    return System.Response.send(400, req_time, "Internal error")
  end
  return System.Response.send(200, req_time, "Success")
end
