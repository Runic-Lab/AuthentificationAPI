module "System", package.seeall
export Response

Response = {}

Response.build_meta = (code, req_time, total_pages) ->
    res_time = os.clock!
    exec_time = (res_time - req_time) * 1000

    data = {
        request_date: os.date "%Y-%m-%d %H:%M:%S", req_time
        response_date: os.date "%Y-%m-%d %H:%M:%S", res_time
        execution_time: exec_time
    }

    if total_pages
        data.total_pages = total_pages

    if code
        data.status_code = code

    return data

Response.send = (code, req_time, results, total_pages) ->
    meta = Response.build_meta code == 200, req_time, total_pages
    msg = nil

    if code == 200
        msg = {
            results: results
            meta: meta
        }
    else
        msg = {
            error: {
                message: results
                status_code: code
            }

            meta: meta
        }

    return { json: msg }