local TTConfig = require("tt.config")
local Sessions = require("tt.sessions")
local SessionFactory = require("tt.session_factory")

local M = {}

---@type Sessions
M.sessions = Sessions:new(SessionFactory:new(TTConfig.new(nil)))

function M.setup(opts)
    M.config = TTConfig.new(opts)
end

--- @param id integer
function M.open(id)
    local session = M.sessions:get(id)
    if not session then
        vim.notify("this session does not exist", vim.log.levels.ERROR)
        return
    end
    vim.api.nvim_win_set_buf(0, session.buf)
    vim.cmd.startinsert()
end

--- @param name string|nil
function M.create(name)
    local session = M.sessions:generate(name)
    vim.api.nvim_win_set_buf(0, session.buf)
    vim.cmd.startinsert()
end

--- @return SessionInfo[]
function M.list()
    return M.sessions:list()
end

---@param id integer
function M.kill(id)
    local session = M.sessions:get(id)
    if not session then
        vim.notify("this session does not exist", vim.log.levels.ERROR)
        return
    end
    M.sessions:remove(id)
end

return M
