req_time = os.clock!

Controller = {}

Controller.get_all = (app) ->
	page, size = System.Pagination.get_page_and_size app.params
	results = require("applications.modules.account.model")\get_all page, size
	total_pages = math.ceil require("applications.modules.account.model")\count! / size

	return System.Response.send 200, req_time, results, total_pages

Controller.update = (app) ->
	id = app.params.id
	online = app.params.online

	unless id
		return System.Response.send 400, req_time, "Please, set an id"

	id = tonumber id
	unless type(id) == "number"
		return System.Response.send 400, req_time, "Please, set a number"

	unless online
		return System.Response.send 400, req_time, "Please, set online"

	online = tonumber online
	unless type(online) == "number"
		return System.Response.send 400, req_time, "Please, set a number"

	code, success = require("applications.modules.account.model")\update_online id, online

	if code == 1 and success == false
		return System.Response.send 400, req_time, "Account id invalid"

	if code == 2 and success == false
		return System.Response.send 400, req_time, "Internal error"

	return System.Response.send 200, req_time, "Success"

Controller.create = (app) ->
	username = app.params.username
	password = app.params.password

	unless username
		return System.Response.send 400, req_time, "Please, set a username"

	unless password
		return System.Response.send 400, req_time, "Please, set a password"

	account, msg = require("applications.modules.account.model")\create_account username, password

	unless account
		return System.Response.send 400, req_time, msg

	return System.Response.send 200, req_time, account, msg

return Controller
