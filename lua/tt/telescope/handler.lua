local tt           = require('tt')
local actions      = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M            = {}

---@param prompt_bufnr integer
function M.create(prompt_bufnr)
    local lines = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, -1, false)
    local name = table.concat(lines, ""):gsub("> ", "")
    actions.close(prompt_bufnr)
    if #name > 0 then
        tt.create(name)
    end
end

---@param prompt_bufnr integer
function M.open(prompt_bufnr)
    local session = action_state.get_selected_entry()
    if session then
        actions.close(prompt_bufnr)
        tt.open(session.id)
    else
        M.create(prompt_bufnr)
    end
end

---@param prompt_bufnr integer
function M.close(prompt_bufnr)
    local session = action_state.get_selected_entry()
    if session then
        actions.close(prompt_bufnr)
        tt.kill(session.id)
    end
end

return M
