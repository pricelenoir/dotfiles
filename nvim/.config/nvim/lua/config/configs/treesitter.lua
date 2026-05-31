require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "c",
        "cpp",
        "python",
        "bash",
        "javascript",
        "typescript",
        "json",
        "yaml",
        "markdown",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
})
