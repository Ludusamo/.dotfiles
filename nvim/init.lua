local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('tpope/vim-surround')

-- FZF
Plug('junegunn/fzf', { ['do'] =
  function()
    vim.call('fzf#install')
  end
})
Plug('ibhagwan/fzf-lua', { ['branch'] = 'main' })
Plug('nvim-tree/nvim-web-devicons')
Plug('tpope/vim-fugitive')
Plug('github/copilot.vim')

vim.call('plug#end')

vim.cmd [[
  colorscheme smyck
  syntax enable
  filetype plugin on
]]

-- FZF Colors

vim.g.fzf_colors =
  { ["fg"] = {"fg", "Normal"}
  , ["bg"] =       {"bg", "Normal"}
  , ["hl"] =       {"fg", "Comment"}
  , ["fg+"] =      {"fg", "CursorLine", "CursorColumn", "Normal"}
  , ["bg+"] =      {"bg", "CursorLine", "CursorColumn"}
  , ["hl+"] =      {"fg", "Statement"}
  , ["info"] =     {"fg", "PreProc"}
  , ["border"] =   {"fg", "Ignore"}
  , ["prompt"] =   {"fg", "Conditional"}
  , ["pointer"] =  {"fg", "Exception"}
  , ["marker"] =   {"fg", "Keyword"}
  , ["spinner"] =  {"fg", "Label"}
  , ["header"] =   {"fg", "Comment"}
  }

-- Sets terminal color to 256
vim.o.t_Co=256

-- Line numbers
vim.o.relativenumber = true
vim.o.nu = true

-- Folds
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Tabs
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smarttab = true
vim.o.expandtab = true

-- File locations
vim.o.backupdir = '.backup/,~/.backup/,/tmp//'
vim.o.directory = '.swp/,~/.swp/,/tmp//'
vim.o.undodir = '.undo/,~/.undo/,/tmp//'

vim.g.mapleader = ' '

-- Insert Mode
vim.keymap.set('i', 'hn', '<esc>')
vim.keymap.set('i', '<esc>', '<nop>')
vim.keymap.set('i', '<C-d>', '<C-R>=strftime("%Y-%m-%d")<CR>')
vim.keymap.set('i', '<C-t>', '<C-R>=strftime("%Y-%m-%dT%H:%M:%S%z")<CR>')

-- Leader commands
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>')
vim.keymap.set('n', '<leader>l', ':set list!<CR>')
vim.keymap.set('n', '<leader>zz', 'm`:TrimSpaces<CR>``')
vim.keymap.set('n', '<silent>', '<leader>rr :so %<CR>')
vim.keymap.set('n', '<silent>', '<leader>rt :! ctags -R .<CR>')
vim.keymap.set('n', '<leader>ev', ':vsplit $HOME/.config/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>oa', ':A<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>n', ':cn<CR>')
vim.keymap.set('n', '<leader>p', ':cp<CR>')

-- Pane movement
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-n>', '<c-w>j')
vim.keymap.set('n', '<c-e>', '<c-w>k')
vim.keymap.set('n', '<c-i>', '<c-w>l')

-- Misc Normal Mode Remap
vim.keymap.set('n', '<c-p>', require('fzf-lua').files, { desc = "fzf files" })
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')
vim.keymap.set('n', '<Enter>', '@@')

-- Colemak
vim.keymap.set('n', 'n', 'j')
vim.keymap.set('n', 'i', 'l')
vim.keymap.set('n', 'e', 'k')
vim.keymap.set('n', 'k', 'n')
vim.keymap.set('n', 'l', 'u')
vim.keymap.set('n', 'u', 'i')
vim.keymap.set('n', 'j', 'e')
vim.keymap.set('n', 'U', 'I')

vim.keymap.set('n', '<S-n>', '<S-j>')
vim.keymap.set('n', '<S-i>', '<S-l>')
vim.keymap.set('n', '<S-e>', '<S-k>')
vim.keymap.set('n', '<S-k>', '<S-n>')
vim.keymap.set('n', '<S-l>', '<S-u>')
vim.keymap.set('n', '<S-u>', '<S-i>')
vim.keymap.set('n', '<S-j>', '<S-e>')

vim.keymap.set('n', '<c-l>', '<c-u>')
vim.keymap.set('n', '<c-u>', '<c-i>')

vim.keymap.set('v', 'n', 'j')
vim.keymap.set('v', 'i', 'l')
vim.keymap.set('v', 'e', 'k')
vim.keymap.set('v', 'k', 'n')
vim.keymap.set('v', 'l', 'u')
vim.keymap.set('v', 'u', 'i')
vim.keymap.set('v', 'j', 'e')

vim.keymap.set('v', '<S-n>', '<S-j>')
vim.keymap.set('v', '<S-i>', '<S-l>')
vim.keymap.set('v', '<S-e>', '<S-k>')
vim.keymap.set('v', '<S-k>', '<S-n>')
vim.keymap.set('v', '<S-l>', '<S-u>')
vim.keymap.set('v', '<S-u>', '<S-i>')
vim.keymap.set('v', '<S-j>', '<S-e>')

vim.keymap.set('v', '<c-l>', '<c-u>')
vim.keymap.set('v', '<c-u>', '<c-i>')

vim.keymap.set('o', 'n', 'j')
vim.keymap.set('o', 'i', 'l')
vim.keymap.set('o', 'e', 'k')
vim.keymap.set('o', 'k', 'n')
vim.keymap.set('o', 'l', 'u')
vim.keymap.set('o', 'u', 'i')
vim.keymap.set('o', 'j', 'e')
