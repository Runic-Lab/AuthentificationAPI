import config from require "lapis.config"

config "development", ->
  server "nginx"
  code_cache "off"
  num_workers "1"
  port "8081"

  mysql ->
    backend "resty_mysql"
    host "127.0.0.1"
    user "naxxramas_user"
    password "naxxramas_passwd"
    database "335_production_authentification"
