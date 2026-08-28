---@class Sessions
---@field items Session[]
---@field factory SessionFactory
local Sessions = {}

---@param f SessionFactory
---@return Sessions
function Sessions:new(f)
    self.__index = self
    return setmetatable({
        items = {},
        factory = f,
    }, self)
end

---@param id integer
---@return integer, Session| nil
function Sessions:_get_with_index(id)
    for i, s in ipairs(self.items) do
        if s.id == id then
            return i, s
        end
    end
    return -1, nil
end

---@param name string
---@return Session | nil
function Sessions:_is_already_used(name)
    for _, s in ipairs(self.items) do
        if s.name == name then
            return s
        end
    end
    return nil
end

---@param id integer
---@return Session | nil
function Sessions:get(id)
    local _, s = self:_get_with_index(id)
    return s
end

---@return integer
function Sessions:_new_id()
    local session = self.items[#self.items]
    if not session then
        return 0
    else
        return session.id + 1
    end
end

---@class SessionInfo
---@field id integer
---@field name string
---@field cwd string

---@return SessionInfo[]
function Sessions:list()
    local result = {}
    for i, s in ipairs(self.items) do
        result[i] = { id = s.id, name = s.name, cwd = s.cwd }
    end
    return result
end

---@param name string|nil
---@return Session
function Sessions:generate(name)
    local id = self:_new_id()
    local n = name or string.format("%d", id)

    local s = self:_is_already_used(n)
    if s then return s end

    local session = self.factory:start(
        id,
        n,
        vim.uv.cwd() or vim.uv.os_homedir(),
        function(session_id)
            self:remove(session_id)
        end)
    self.items[#self.items + 1] = session
    return session
end

---@param id integer
function Sessions:remove(id)
    local n, s = self:_get_with_index(id);
    if not s then return end

    self.factory:stop(s)
    table.remove(self.items, n)
end

return Sessions
