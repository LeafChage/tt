## managing terminal with telescope
https://github.com/user-attachments/assets/94372909-410f-4ea5-b71d-5e1acfda55d2

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

# ToDo
* [ ] buffer preview

