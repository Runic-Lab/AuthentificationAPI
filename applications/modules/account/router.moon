require("applications.modules.account.controller")
require("applications.modules.account.model")

app_respond_to = require("lapis.application").respond_to
json_params = require("lapis.application").json_params

return (self) ->
    @\match "accounts", "/accounts", app_respond_to {
        GET: Modules.Account.Controller.get_all
    }

    @\match "account_update", "/account/:id", app_respond_to {
        PUT: json_params Modules.Account.Controller.update
    }