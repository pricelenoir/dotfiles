return {
    -- Core dependencies
    { "nvim-lua/plenary.nvim" },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({
                default = true,
            })
        end,
    },

    -- Colorscheme: Silentium
    {
        "silentium-theme/silentium.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local silentium = require("silentium")

            silentium.setup({
                accent = silentium.accents.blue,
            })

            -- Set colorscheme
            vim.cmd.colorscheme("silentium")

            -- Apply transparency after theme loads
            vim.schedule(function()
                vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "VertSplit", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "NONE" })
                vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "NONE" })

                -- Fix indent-blankline highlight group
                vim.api.nvim_set_hl(0, "IblScope", { fg = "#737373" })
            end)
        end,
    },

    -- Dashboard: startup screen with ASCII art
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- ASCII art
            dashboard.section.header.val = {
                "                                                                     ",
                "       ████ ██████           █████      ██                     ",
                "      ███████████             █████                             ",
                "      █████████ ███████████████████ ███   ███████████   ",
                "     █████████  ███    █████████████ █████ ██████████████   ",
                "    █████████ ██████████ █████████ █████ █████ ████ █████   ",
                "  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
                " ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
                " ",
            }

            -- Buttons
            dashboard.section.buttons.val = {
                dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
                dashboard.button("SPC fw", " > Find Word", "<cmd>Telescope live_grep<CR>"),
                dashboard.button("e", " > New File", "<cmd>ene<CR>"),
                dashboard.button("CTRL N", " > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
                dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
            }

            -- Footer
            local function footer()
                local total_plugins = require("lazy").stats().count
                local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
                local version = vim.version()
                local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

                return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
            end

            dashboard.section.footer.val = footer()

            -- Highlight groups
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"

            alpha.setup(dashboard.opts)

            -- Disable folding on alpha buffer
            vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
        end,
    },

    -- Statusline: minimal and clean
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "alpha" } },
                },
                sections = {
                    lualine_a = {
                        { "mode" },
                    },
                    lualine_b = {
                        { "branch", icon = "" },
                        {
                            "diff",
                            symbols = { added = " ", modified = " ", removed = " " },
                        },
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 1, -- Relative path
                            symbols = {
                                modified = "●",
                                readonly = "",
                                unnamed = "[No Name]",
                            },
                        },
                        "searchcount",
                        "selectioncount",
                    },
                    lualine_x = { "lsp_status", "diagnostics", "filetype" },
                    lualine_y = { "location" },
                    lualine_z = { "progress" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = { "nvim-tree", "lazy" },
            })
        end,
    },

    -- Telescope: fuzzy finder
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("config.configs.telescope")
        end
    },

    -- Treesitter: language parsing, queries, modules
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require("config.configs.treesitter")
        end
    },

    -- Mason: package manager for LSP servers, linters, formatters
    {
        'williamboman/mason.nvim',
        config = function()
            require("config.configs.mason")
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
            require("config.configs.lspconfig").defaults()
        end
    },

    -- Nvimtree: file explorer
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        config = function()
            require("config.configs.nvimtree")
        end
    },

    -- WhichKey: available keybinds popup
    {
        "folke/which-key.nvim",
        keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        config = function()
            require("which-key").setup({})
        end,
    },

    -- Indent-blankline: visualize indentation levels
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        main = "ibl",
        opts = {
            indent = {
                char = "│",
            },
            scope = { enabled = false },
        },
        config = function(_, opts)
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            require("ibl").setup(opts)
        end,
    },

    -- Gitsigns: git integration
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPost",
        config = function()
            require("config.configs.gitsigns")
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
            require("cmp").setup(require("config.configs.cmp"))
        end,
    },
}
