set number relativenumber

" colorscheme habamax

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'voldikss/vim-floaterm'
Plug 'sainnhe/sonokai'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'tpope/vim-fugitive'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

if has('termguicolors')
  set termguicolors
endif

let g:sonokai_style = 'maia'
let g:sonokai_better_performance = 1

" Airline Config
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#branch#enabled = 1

" Colorscheme
colorscheme sonokai

" Map :ff to Telescope find_files
cnoreabbrev ff Telescope find_files
" Map :bf to Telescope find_files
cnoreabbrev bf Telescope current_buffer_fuzzy_find
" Shortcuts/remap(?) for floaterm. Found it somehwere online.
" noremap  <leader>t  :FloatermToggle<CR>
" noremap! <leader>t  <Esc>:FloatermToggle<CR>
" tnoremap <leader>t  <C-\><C-n>:FloatermToggle<CR>
set clipboard+=unnamedplus

filetype plugin indent on
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType go setlocal shiftwidth=4 tabstop=4

lua <<EOF
-- Treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"lua", "go"},
  highlight = {
    enable = true, -- false will disable the whole extension
  },
}
-- LSP Configuration for gopls
require'lspconfig'.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
-- Autocompletion setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-1),
    ['<C-f>'] = cmp.mapping.scroll_docs(1),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- LSP Configuration for Python
require'lspconfig'.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
-- Alternatively, use pylsp
-- require'lspconfig'.pylsp.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- LSP Configuration for Python
require'lspconfig'.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
-- Alternatively, use pylsp
-- require'lspconfig'.pylsp.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- Autocompletion setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-1),
    ['<C-f>'] = cmp.mapping.scroll_docs(1),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- Lualine

require('lualine').setup {
  options = {
    theme = 'auto'
  }
}

require'lspconfig'.gopls.setup{}
EOF
