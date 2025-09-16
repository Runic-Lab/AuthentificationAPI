local lapis = require("lapis")
local lfs = require("lfs")
require("system.module_loader")
require("system.pagination")
require("system.response")
local module_loader = System.ModuleLoader:get_instance()
local Application
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    handle_404 = function(self)
      return {
        status = 404,
        json = {
          error = "Error 404: The specified path is invalid"
        }
      }
    end,
    handle_500 = function(self, err, trace)
      return {
        status = 500,
        json = {
          error = "Error 500: Internal server error",
          detail = err,
          trace = trace
        }
      }
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Application",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Application = _class_0
end
local SetupApplicationInstance
SetupApplicationInstance = function()
  local application = Application()
  module_loader:load(application, "applications/modules")
  return application
end
return SetupApplicationInstance()
