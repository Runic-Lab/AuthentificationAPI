module("System", package.seeall)
Response = { }
Response.build_meta = function(code, req_time, total_pages)
  local res_time = os.clock()
  local exec_time = (res_time - req_time) * 1000
  local data = {
    request_date = os.date("%Y-%m-%d %H:%M:%S", req_time),
    response_date = os.date("%Y-%m-%d %H:%M:%S", res_time),
    execution_time = exec_time
  }
  if total_pages then
    data.total_pages = total_pages
  end
  if code then
    data.status_code = code
  end
  return data
end
Response.send = function(code, req_time, results, total_pages)
  local meta = Response.build_meta(code == 200, req_time, total_pages)
  local msg = nil
  if code == 200 then
    msg = {
      results = results,
      meta = meta
    }
  else
    msg = {
      error = {
        message = results,
        status_code = code
      },
      meta = meta
    }
  end
  return {
    json = msg
  }
end
