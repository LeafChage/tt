## How to use
```lua
--- lazy.nvim
{
    "LeafChage/tt",
    dependencies = {
      {'nvim-telescope/telescope.nvim'},
    },
    config = function()
      require("tt").setup({
        -- --- current | float | vertical | horizontal
        -- layout: "current"
        -- keys = {
        --     n = {
        --         open = "<cr>",
        --         close = "<c-d>",
        --     },
        --     i = {
        --         open = "<cr>",
        --         close = "<c-d>",
        --     }
        -- },
        -- float = {
        --     width = 0.8,
        --     height = 0.8,
        --     border = "rounded",
        -- }
      })
    end,
    keys = {
      -- { "<leader>ft", [[<CMD>Telescope tt<CR>]], }, -- open terminal picker
    }
}

-- load extension
local telescope = require('telescope')
telescope.load_extension("tt")
```
