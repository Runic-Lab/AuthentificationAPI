lapis = require "lapis"
lfs = require "lfs"

require "system.module_loader"
require "system.pagination"
require "system.response"

module_loader = System.ModuleLoader\get_instance!

class Application extends lapis.Application
    handle_404: =>
      return { status: 404, json: { error: "Error 404: The specified path is invalid" } }
    handle_500: (err, trace) =>
      return { status: 500, json: { error: "Error 500: Internal server error", detail: err, trace: trace } }

SetupApplicationInstance = ->
    application = Application!

    module_loader\load application, "applications/modules"
    return application

SetupApplicationInstance!