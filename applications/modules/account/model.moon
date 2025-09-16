module "Modules.Account", package.seeall
export Model

BaseModel = require("lapis.db.model").Model

class Account extends BaseModel
    @primary_key: "id"

    @get_all: (page, size) =>
        return Account\select "ORDER BY id LIMIT #{(page - 1) * size}, #{size}"

    @update_online: (id, online) =>
        account = Account\find id

        unless account
            return 1, false

        account\update {
            online: online
        }

        return 2, account.online == online

Model = Account