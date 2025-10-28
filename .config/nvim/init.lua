vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrap = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 10
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.g.clipboard="wl-copy"

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

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

require("lazy").setup({
    spec = {
        {
            "NMAC427/guess-indent.nvim",
            opts = {},
        },
        {
            "nvim-mini/mini.nvim",
            version = false,
            config = function()
                require("mini.pick").setup()
                vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files)
                vim.keymap.set("n", "<leader>bb", MiniPick.builtin.buffers)
                vim.keymap.set("n", "<leader>hh", MiniPick.builtin.help)
            end
        },
        {
            {
                "folke/tokyonight.nvim",
                lazy = false,
                priority = 1000,
                config = function()
                    require("tokyonight").setup()
                    vim.cmd.colorscheme("tokyonight-night")
                end
            }
        },
        {
            'nvim-lualine/lualine.nvim',
            opts = {
                options = {
                    icons_enabled = false,
                    theme = 'auto',
                    component_separators = { left = ' ', right = ' '},
                    section_separators = { left = ' ', right = ' '},
                }
            }
        },
        { -- Highlight, edit, and navigate code
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            main = 'nvim-treesitter.configs', -- Sets main module to use for opts
            opts = {
                ensure_installed = {"python", "lua", "bash", "tmux", "go", "rust", "c", "cmake"},
            },
        },
    },
})
