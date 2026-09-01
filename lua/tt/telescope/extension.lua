local tt             = require('tt')
local entry_maker    = require('tt.telescope.entry').entry_maker
local handler        = require('tt.telescope.handler')
local previewers     = require("telescope.previewers")
local pickers        = require("telescope.pickers")
local conf           = require("telescope.config").values
local finders        = require("telescope.finders")

---@param self any
---@param entry CustomEntry
local define_preview = function(self, entry, _)
    local buf = entry.buf
    if not buf or not vim.api.nvim_buf_is_valid(buf) then return end
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
    vim.api.nvim_win_call(self.state.winid, function() vim.cmd("normal! G") end)
end

local M              = {
    tt = function(opts)
        pickers.new(opts, {
            prompt_title = "tt",
            previewer = previewers.new_buffer_previewer({
                title = "tt session",
                get_buffer_by_name = function(_, entry)
                    return tostring(entry.id)
                end,
                define_preview = define_preview,
            }),
            sorter = conf.generic_sorter(opts),
            finder = finders.new_table({
                results = tt.list(),
                entry_maker = entry_maker,
            }),
            attach_mappings = function(_, map)
                map("i", tt.config.keys.i.open, handler.open, { desc = "open terminal" })
                map("n", tt.config.keys.n.open, handler.open, { desc = "open terminal" })
                map("i", tt.config.keys.i.close, handler.close, { desc = "close terminal" })
                map("n", tt.config.keys.n.close, handler.close, { desc = "close terminal" })
                return true
            end
        }):find()
    end
}

return M
