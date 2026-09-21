vim.g.mapleader = ' '

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
Plug('neovim/nvim-lspconfig')
Plug('saghen/blink.cmp', { ['tag'] = 'v1.*' })

-- DAP
Plug('mfussenegger/nvim-dap')
Plug('nvim-neotest/nvim-nio')
Plug('rcarriga/nvim-dap-ui')
Plug('theHamsta/nvim-dap-virtual-text')

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

require('fzf-lua').setup({
  -- Global defaults
  defaults = {
    git_icons = true,
  },
  -- Providers configuration
  files = {
    -- fd is highly recommended and respects .gitignore by default
    cmd = "fd --type f --hidden --exclude .git",
  },
  grep = {
    -- ripgrep respects .gitignore by default
    cmd = "rg --vimgrep --hidden --glob '!.git/*'",
  },
})

-- Autocomplete
require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<Tab>'] = {
      function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end,
      'snippet_forward',
      'fallback',
    },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<C-y>'] = { 'fallback' },
  },
  sources = {
    default = { 'lsp' },
  },
})

-- LSP: clangd
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>cf', function()
      vim.lsp.buf.code_action({
        context = { only = { 'quickfix' } },
        apply = true,
      })
    end, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  end,
})

vim.lsp.config('clangd', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
vim.lsp.enable('clangd')

-- DAP: gdb
local dap = require('dap')

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError' })
vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn' })
vim.fn.sign_define('DapBreakpointRejected', { text = '✗', texthl = 'DiagnosticError' })
vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DiagnosticInfo' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticOk', linehl = 'CursorLine' })

dap.adapters.gdb = {
  type = 'executable',
  command = 'gdb',
  args = { '-i=dap', '--quiet' },
}

dap.configurations.c = {
  {
    name = 'Launch',
    type = 'gdb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/bin/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
  },
}

local dapui = require('dapui')
dapui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

require('nvim-dap-virtual-text').setup()

vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>do', dap.step_over)
vim.keymap.set('n', '<leader>di', dap.step_into)
vim.keymap.set('n', '<leader>dO', dap.step_out)
vim.keymap.set('n', '<leader>dt', dap.terminate)
vim.keymap.set('n', '<leader>dr', dap.repl.toggle)
vim.keymap.set('n', '<leader>du', dapui.toggle)

local dap_widgets = require('dap.ui.widgets')
vim.keymap.set({ 'n', 'v' }, '<leader>dh', dap_widgets.hover)

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

-- Insert Mode
vim.keymap.set('i', 'hn', '<esc>')
vim.keymap.set('i', '<esc>', '<nop>')
vim.keymap.set('i', '<C-d>', '<C-R>=strftime("%Y-%m-%d")<CR>')
vim.keymap.set('i', '<C-t>', '<C-R>=strftime("%Y-%m-%dT%H:%M:%S%z")<CR>')

-- Leader commands
vim.o.listchars = 'trail:●,tab:▸ '
vim.o.list = true
vim.keymap.set('n', '<leader>zz', ':%s/\\s\\+$//gc<CR>', { desc = 'Confirm removal of trailing whitespace' })
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>')
vim.keymap.set('n', '<leader>l', ':set list!<CR>')
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
