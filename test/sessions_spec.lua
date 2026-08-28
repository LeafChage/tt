local Sessions = require("tt.sessions")

describe('Sessions', function()
    ---@type SessionFactory
    local factory = {
        config = { shell = "" },
        ---@diagnostic disable-next-line: unused-local
        start = function(self, id, name, cwd)
            return {
                id = id,
                name = name,
            }
        end,
        ---@diagnostic disable-next-line: unused-local
        stop = function(self, session)
        end
    }

    describe('get', function()
        it('empty', function()
            local ss = Sessions:new(factory)
            assert.is_true(ss:get(0) == nil)
        end)

        it('exist', function()
            local ss = Sessions:new(factory)
            local s = ss:generate(nil, nil)
            assert.is_true(ss:get(s.id).id == s.id)
        end)
    end)

    describe('generate', function()
        it('first', function()
            local ss = Sessions:new(factory)
            local s = ss:generate(nil, nil)
            assert.are_equal(s.id, 0)
        end)

        it('exist', function()
            local ss = Sessions:new(factory)
            local _ = ss:generate("first", nil)
            local s = ss:generate(nil, nil)
            assert.are_equal(s.id, 1)
        end)

        it('same name', function()
            local ss = Sessions:new(factory)
            local first = ss:generate("first", nil)
            local next = ss:generate("first", nil)
            assert.are_equal(first.id, next.id)
        end)
    end)

    describe('stop', function()
        it('first', function()
            local ss = Sessions:new(factory)
            local s = ss:generate(nil, nil)
            ss:remove(s.id)
            assert.are_equal(#ss.items, 0)
        end)
    end)
end)
