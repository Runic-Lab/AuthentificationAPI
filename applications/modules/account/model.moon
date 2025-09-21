module "Modules.Account", package.seeall
export Model

BaseModel = require("lapis.db.model").Model

class Account extends BaseModel
    @primary_key: "id"

    @create_account: (id, username, password) =>
        exists = Account\find { username: username }
        if exists
            return nil, "The username #{username} already exists."

        account = Account\create {
            username: username
            password: password
            online: false
        }

        return {
            id: account.id
            username: account.username
            online: account.online
        }, "Account successfully created"

        return account, "Account successfully created"

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