local Session        = require("tt.session")

---@class SessionFactory
---@field config TTConfig
---@field start fun(self: SessionFactory, id: integer, name: string, cwd: string, on_exit: fun(session_id: integer)|nil): Session
---@field stop fun(self: SessionFactory, s: Session)
local SessionFactory = {}

---@param config TTConfig
---@return SessionFactory
function SessionFactory:new(config)
    self.__index = self
    return setmetatable({
        config = config,
    }, self)
end

---@param s Session
---@return boolean
function SessionFactory:_alive(s)
    return s.job ~= nil and vim.fn.jobwait({ s.job }, 0)[1] == -1
end

---@param id integer
---@param name string
---@param cwd string
---@param on_exit fun(session_id: integer) | nil
---@return Session
function SessionFactory:start(id, name, cwd, on_exit)
    local buf = vim.api.nvim_create_buf(false, true)

    local job = vim.api.nvim_buf_call(buf, function()
        vim.notify("create bu, and jobstart", vim.log.levels.DEBUG)
        return vim.fn.jobstart(self.config.shell, {
            term = true,
            cwd = cwd,
            on_exit = function()
                vim.schedule(function()
                    if on_exit then on_exit(id) end
                end)
            end,
        })
    end)

    local s = Session.new(id, name, buf, job, cwd)
    vim.bo[buf].bufhidden = "hide"

    return s
end

---@param s Session
function SessionFactory:stop(s)
    if s.job then
        vim.fn.jobstop(s.job)
    end

    if vim.api.nvim_buf_is_valid(s.buf) then
        vim.api.nvim_buf_delete(s.buf, { force = true })
    end
end

return SessionFactory;
