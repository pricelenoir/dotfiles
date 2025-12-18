local opt = vim.opt
local o = vim.o

-- Indentation
o.expandtab = true
o.shiftwidth = 4
o.smartindent = true
o.tabstop = 4
o.softtabstop = 4

-- System clipboard integration
o.clipboard = "unnamedplus"

-- Line numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2

-- Sign column (for LSP diagnostics and git signs)
o.signcolumn = "yes"

-- Mouse support
o.mouse = "a"

-- Persistent undo
o.undofile = true

-- Smart search
o.ignorecase = true
o.smartcase = true

-- Splits open in intuitive directions
o.splitbelow = true
o.splitright = true

-- Faster updates for gitsigns
o.updatetime = 250

-- Disable auto-commenting on new lines
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Add Mason binaries to PATH (required for LSP servers)
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
