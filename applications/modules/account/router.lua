require("applications.modules.account.controller")
require("applications.modules.account.model")
local app_respond_to = require("lapis.application").respond_to
local json_params = require("lapis.application").json_params
return function(self)
  self:match("accounts", "/accounts", app_respond_to({
    GET = Modules.Account.Controller.get_all
  }))
  return self:match("account_update", "/account/:id", app_respond_to({
    PUT = json_params(Modules.Account.Controller.update)
  }))
end
