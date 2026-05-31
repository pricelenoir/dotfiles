require("mason").setup({
    ui = {
        icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",         -- C/C++
        "pyright",        -- Python
        "bashls",         -- Bash
        "lua_ls",         -- Lua
        "rust_analyzer",  -- Rust
    },
    automatic_installation = true,
})
