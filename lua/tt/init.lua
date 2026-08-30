local TTConfig = require("tt.config")
local Sessions = require("tt.sessions")
local SessionFactory = require("tt.session_factory")
local Window = require("tt.window")

local M = {}

---@type Sessions
M.sessions = Sessions:new(SessionFactory:new(TTConfig.new(nil)))

---@type TTConfig
M.config = TTConfig.default

--- @param opts table
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
    Window.open(M.config.layout, M.config.float, session.buf)
end

--- @param name string|nil
function M.create(name)
    local session = M.sessions:generate(name)
    Window.open(M.config.layout, M.config.float, session.buf)
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
