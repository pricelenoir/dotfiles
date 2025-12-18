-- Load base46 treesitter highlights
pcall(function()
    dofile(vim.g.base46_cache .. "syntax")
    dofile(vim.g.base46_cache .. "treesitter")
end)

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "c",
        "cpp",
        "python",
        "bash"
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
})
