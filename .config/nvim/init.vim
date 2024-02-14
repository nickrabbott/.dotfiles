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

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2

" Lualine

lua << END
require('lualine').setup {
  options = {
    theme = 'auto'
  }
}
END
lua << END
