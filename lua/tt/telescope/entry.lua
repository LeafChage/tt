local entry_display = require("telescope.pickers.entry_display")

local M             = {}

local displayer     = entry_display.create({
    separator = " ",
    items = {
        { width = 40 },
        { remaining = true },
    },
})

---@param entry CustomEntry
local make_display  = function(entry)
    return displayer({
        entry.name,
        vim.fn.fnamemodify(entry.cwd, ":~")
    })
end

---@class CustomEntry
---@field display fun(entry: SessionInfo): any
---@field value Session
---@field ordinal string
---@field id integer
---@field buf integer
---@field name string
---@field cwd string

---@param session SessionInfo
---@return CustomEntry
function M.entry_maker(session)
    return {
        display = make_display,                      --- require
        value   = session,                           --- require
        ordinal = session.id .. " " .. session.name, --- require

        id      = session.id,
        buf     = session.buf,
        name    = session.name,
        cwd     = session.cwd,
    }
end

return M
