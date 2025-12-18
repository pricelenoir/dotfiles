return {
    -- NvChad UI: theming framework
    -- supports integration for telescope, treesitter, mason, etc.
    { "nvim-lua/plenary.nvim" },
    {
        "nvim-tree/nvim-web-devicons",
        opts = function()
            dofile(vim.g.base46_cache .. "devicons")
            return { override = require "nvchad.icons.devicons" }
        end,
    },
    {
        "nvchad/ui",
        config = function()
            require "nvchad" 
        end
    },
    {
        "nvchad/base46",
        build = function()
            require("base46").load_all_highlights()
        end
    },
    { "nvzone/volt" },
    { "nvzone/menu" },
    { "nvzone/minty", cmd = { "Huefy", "Shades" } },

    -- Telescope: fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("price.configs.telescope")
        end
    },

    -- Treesitter: language parsing, queries, modules
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require("price.configs.treesitter")
        end
    },

    -- Mason: package manager for LSP servers, linters, formatters
    {
        'williamboman/mason.nvim',
        config = function()
            require("price.configs.mason")
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim' }
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim'
        },
        config = function()
            require("price.configs.lspconfig").defaults()
        end
    },

    -- Nvimtree: file explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        config = function()
            require("price.configs.nvimtree")
        end
    },

    -- WhichKey: available keybinds popup
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        opts = function()
            dofile(vim.g.base46_cache .. "whichkey")
            return {}
        end,
    },

    -- Indent-blankline: visualize indentation levels
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        opts = {
            indent = { char = "│", highlight = "IblChar" },
            scope = { enabled = false },  -- Disable scope underlining
        },
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "blankline")
            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            require("ibl").setup(opts)
        end,
    },

    -- Gitsigns: git integration
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPost",
        config = function()
            require("price.configs.gitsigns")
        end
    },

    -- Autopairs: auto-closing brackets, quotes, etc.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            fast_wrap = {},
            disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)

            -- Integrate with nvim-cmp (if available)
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    -- Nvim-cmp: auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
        },
        config = function()
            require("cmp").setup(require("price.configs.cmp"))
        end,
    },
}