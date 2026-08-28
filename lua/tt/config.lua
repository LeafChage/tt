---@class TTConfig
---@field shell string
local TTConfig = {}

---@type TTConfig
local default_config = { shell = vim.o.shell }

---@param opt table | nil
function TTConfig.new(opt)
    return vim.tbl_deep_extend("force", default_config, opt or {})
end

return TTConfig
