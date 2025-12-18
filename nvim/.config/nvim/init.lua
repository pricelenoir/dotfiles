-- Base46 cache path
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

-- Bootstrap lazy.nvim (package manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Add leader before loading lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup plugins
require("lazy").setup("price.plugins")
require("price.keymap")
require("price.options")

-- Load base46 cache after lazy (required)
if vim.fn.isdirectory(vim.g.base46_cache) == 1 then
    for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
        dofile(vim.g.base46_cache .. v)
    end
else
    -- Generate cache if it doesn't exist
    vim.schedule(function()
        require("base46").load_all_highlights()
    end)
end
