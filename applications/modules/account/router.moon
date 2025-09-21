Controller = require "applications.modules.account.controller"

app_respond_to = require("lapis.application").respond_to
json_params = require("lapis.application").json_params

return (self) ->
	@\match "accounts", "/accounts", app_respond_to {
		GET: Controller.get_all
	}

	@\match "account_update", "/account/:id", app_respond_to {
		PUT: json_params Controller.update
	}

	@\match "account_create", "/account", app_respond_to {
		POST: json_params Controller.create
	}
