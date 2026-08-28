local tt            = require('tt')
local actions       = require("telescope.actions")
local finders       = require("telescope.finders")
local pickers       = require("telescope.pickers")
local conf          = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local action_state  = require("telescope.actions.state")
local previewers    = require("telescope.previewers")

return require("telescope").register_extension({
    exports = {
        tt = function(opts)
            local displayer = entry_display.create({
                separator = " ",
                items = {
                    { width = 40 },
                    { remaining = true },
                },
            })
            local make_display = function(entry)
                return displayer({
                    entry.name,
                    vim.fn.fnamemodify(entry.cwd, ":~")
                })
            end
            pickers.new(opts, {
                prompt_title = "tt",
                sorter = conf.generic_sorter(opts),
                finder = finders.new_table({
                    results = tt.list(),
                    entry_maker = function(session)
                        return {
                            display = make_display,                      --- require
                            value   = session,                           --- require
                            ordinal = session.id .. " " .. session.name, --- require

                            id      = session.id,
                            name    = session.name,
                            cwd     = session.cwd,
                        }
                    end,
                }),
                attach_mappings = function(_, map)
                    map("i", "<Enter>", function(prompt_bufnr)
                        local session = action_state.get_selected_entry()
                        if session then
                            actions.close(prompt_bufnr)
                            tt.open(session.id)
                            return
                        end

                        local lines = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, -1, false)
                        local name = table.concat(lines, ""):gsub("> ", "")
                        actions.close(prompt_bufnr)
                        if #name > 0 then
                            tt.create(name)
                        end
                    end, { desc = "open terminal" })

                    map("i", "<C-d>", function(prompt_bufnr)
                        local session = action_state.get_selected_entry()
                        if session then
                            actions.close(prompt_bufnr)
                            tt.kill(session.id)
                            return
                        end
                    end, { desc = "remove terminal" })
                    return true
                end,
            }):find()
        end
    },
})
