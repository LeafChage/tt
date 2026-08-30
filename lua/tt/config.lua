---@class KeyMap
---@field open string
---@field close string

---@class KeyMaps
---@field n KeyMap
---@field i KeyMap


---@alias Layout "current" | "float"| "vertical" | "horizontal"

---@see https://github.com/neovim/neovim/blob/82ea5a8aac40331579113b961b6cef88865ad5a9/runtime/lua/vim/_meta/api_keysets.gen.lua#L479
---@alias Border any[]|"none"|"single"|"double"|"rounded"|"solid"|"shadow"

---@class TTConfigFloatLayout
---@field width number
---@field height number
---@field border Border

---@class TTConfig
---@field shell string
---@field keys KeyMaps
---@field layout Layout
---@field float TTConfigFloatLayout
local TTConfig = {}

---@type TTConfig
TTConfig.default = {
    shell = vim.o.shell,
    layout = "current",
    keys = {
        n = {
            open = "<cr>",
            close = "<c-d>",
        },
        i = {
            open = "<cr>",
            close = "<c-d>",
        }
    },
    float = {
        width = 0.8,
        height = 0.8,
        border = "rounded",
    }
}

---@param opt table | nil
function TTConfig.new(opt)
    return vim.tbl_deep_extend("force", TTConfig.default, opt or {})
end

return TTConfig
