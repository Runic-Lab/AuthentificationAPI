module("System", package.seeall)
do
  local _class_0
  local _base_0 = {
    load = function(self, application, path)
      self:load_controllers(path)
      return self:load_routers(application, path)
    end,
    load_controllers = function(self, path)
      for element in lfs.dir(path) do
        local _continue_0 = false
        repeat
          if element == "." or element == ".." then
            _continue_0 = true
            break
          end
          local full_path = tostring(path) .. "/" .. tostring(element)
          local attributes = lfs.attributes(full_path)
          if not (attributes and attributes.mode == "directory") then
            _continue_0 = true
            break
          end
          local controller_path = tostring(full_path) .. "/controller"
          local controller_attributes = lfs.attributes(controller_path)
          if controller_attributes and controller_attributes.mode == "directory" then
            self:load_module_controller(controller_path, element)
          end
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
    end,
    load_module_controller = function(self, controller_path, module_name)
      local main_controller_file = tostring(module_name) .. "_controller.lua"
      local controller_file_path = tostring(controller_path) .. "/" .. tostring(main_controller_file)
      if lfs.attributes(controller_file_path) then
        local controller_path_sanitized = controller_file_path:gsub("[/\\]", "."):gsub("%.lua$", "")
        local success, controller_module = pcall(require, controller_path_sanitized)
        if not (success) then
          return error("Failed to load controller for module " .. tostring(module_name) .. ": " .. tostring(controller_module))
        end
      end
    end,
    load_routers = function(self, application, path)
      for element in lfs.dir(path) do
        local _continue_0 = false
        repeat
          if element == "." or element == ".." then
            _continue_0 = true
            break
          end
          local full_path = tostring(path) .. "/" .. tostring(element)
          local attributes = lfs.attributes(full_path)
          if not (attributes and attributes.mode == "directory") then
            _continue_0 = true
            break
          end
          local router_path = tostring(full_path) .. "/router.lua"
          if not (lfs.attributes(router_path)) then
            error("Router not found for module: " .. tostring(element))
          end
          local router_path_sanitized = router_path:gsub("[/\\]", "."):gsub("%.lua$", "")
          local success, router = pcall(require, router_path_sanitized)
          if success and type(router) == "function" then
            router(application)
          else
            error("Failed to load router for module: " .. tostring(element))
          end
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "ModuleLoader"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.instance = nil
  self.get_instance = function(self)
    if not self.__class.instance then
      self.__class.instance = ModuleLoader()
    end
    return self.__class.instance
  end
  ModuleLoader = _class_0
  return _class_0
end
