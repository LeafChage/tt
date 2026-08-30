local M = {}

--- @param buf integer
--- @return integer
local function open_current(buf)
    vim.api.nvim_win_set_buf(0, buf)
    return 0
end

--- @param buf integer
--- @return integer win
local function open_vertically(buf)
    -- win = -1 → split relative to the whole tabpage (like botright)
    -- win = 0  → split relative to the current window (like rightbelow)
    return vim.api.nvim_open_win(buf, true, { split = "right", win = 0 })
end

--- @param buf integer
--- @return integer win
local function open_horizontally(buf)
    return vim.api.nvim_open_win(buf, true, { split = "below", win = 0 })
end

--- @param config TTConfigFloatLayout
--- @param buf integer
--- @return integer win
local function open_float(config, buf)
    local width  = math.floor(vim.o.columns * config.width)
    local height = math.floor(vim.o.lines * config.height)
    local win    = vim.api.nvim_open_win(buf, true, {
        relative  = "editor",
        width     = width,
        height    = height,
        row       = math.floor((vim.o.lines - height) / 2 - 1),
        col       = math.floor((vim.o.columns - width) / 2),
        style     = "minimal",
        border    = config.border,
        title     = " tt ",
        title_pos = "center",
    })
    return win
end

---@param layout Layout
---@param config TTConfigFloatLayout
---@param buf integer
function M.open(layout, config, buf)
    if layout == "current" then
        open_current(buf)
    elseif layout == "vertical" then
        open_vertically(buf)
    elseif layout == "horizontal" then
        open_horizontally(buf)
    elseif layout == "float" then
        open_float(config, buf)
    end
    vim.schedule(function()
        if vim.api.nvim_get_current_buf() == buf then
            vim.cmd.startinsert()
        end
    end)
end

return M
