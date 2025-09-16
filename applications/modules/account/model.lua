module("Modules.Account", package.seeall)
local BaseModel = require("lapis.db.model").Model
local Account
do
  local _class_0
  local _parent_0 = BaseModel
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Account",
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
  local self = _class_0
  self.primary_key = "id"
  self.get_all = function(self, page, size)
    return Account:select("ORDER BY id LIMIT " .. tostring((page - 1) * size) .. ", " .. tostring(size))
  end
  self.update_online = function(self, id, online)
    local account = Account:find(id)
    if not (account) then
      return 1, false
    end
    account:update({
      online = online
    })
    return 2, account.online == online
  end
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Account = _class_0
end
Model = Account
