---@class Session
---@field id integer
---@field name string
---@field buf integer
---@field job integer
---@field cwd string
local Session = {}

---@param id integer
---@param name string
---@param buf integer
---@param job integer
---@param cwd string
---@return Session
function Session.new(id, name, buf, job, cwd)
    return { id = id, name = name, buf = buf, job = job, cwd = cwd }
end

return Session
