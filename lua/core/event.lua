local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '..group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

function autocmd.load_autocmds()
  local definitions = {
    packer = {
      {"BufWritePost","*.lua","lua require('core.pack').auto_compile()"};
    },
    bufs = {
      -- Reload vim config automatically
      {"BufWritePost",[[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]]};
      -- Reload Vim script automatically if setlocal autoread
      {"BufWritePost,FileWritePost","*.vim", [[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]]};
      {"BufWritePre","/tmp/*","setlocal noundofile"};
      {"BufWritePre","COMMIT_EDITMSG","setlocal noundofile"};
      {"BufWritePre","MERGE_MSG","setlocal noundofile"};
      {"BufWritePre","*.tmp","setlocal noundofile"};
      {"BufWritePre","*.bak","setlocal noundofile"};
      {"BufWritePre","*.tsx","lua vim.api.nvim_command('Format')"};
      {"BufWritePre","*.go","lua require('internal.golines').golines_format()"};
    };

    wins = {
      -- Highlight current line only on focused window
      {"WinEnter,BufEnter,InsertLeave", "*", [[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]]};
      {"WinLeave,BufLeave,InsertEnter", "*", [[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]]};
      -- Equalize window dimensions when resizing vim window
      {"VimResized", "*", [[tabdo wincmd =]]};
      -- Force write shada on leaving nvim
      {"VimLeave", "*", [[if has('nvim') | wshada! | else | wviminfo! | endif]]};
      -- Check if file changed when its window is focus, more eager than 'autoread'
      {"FocusGained", "* checktime"};
    };

    ft = {
      {"FileType", "dashboard", "set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2"};
      {"FileType", "markdown", "inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>\"_c4l"};
      {"FileType", "markdown", "inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>\"_c5l<CR>"};
      {"FileType", "markdown", "inoremap <buffer> ,n ---<Enter><Enter>"};
      {"FileType", "markdown", "inoremap <buffer> ,b **** <++><Esc>F*hi"};
      {"FileType", "markdown", "inoremap <buffer> ,s ~~~~ <++><Esc>F~hi"};
      {"FileType", "markdown", "inoremap <buffer> ,i ** <++><Esc>F*i"};
      {"FileType", "markdown", "inoremap <buffer> ,d `` <++><Esc>F`i"};
      {"FileType", "markdown", "inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA"};
      {"FileType", "markdown", "inoremap <buffer> ,m - [ ]"};
      {"FileType", "markdown", "inoremap <buffer> ,p ![](<++>) <++><Esc>F[a"};
      {"FileType", "markdown", "inoremap <buffer> ,a [](<++>) <++><Esc>F[a"};
      {"FileType", "markdown", "inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA"};
      {"FileType", "markdown", "inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA"};
      {"FileType", "markdown", "inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA"};
      {"FileType", "markdown", "inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA"};
      {"FileType", "markdown", "inoremap <buffer> ,l --------<Enter>"};
      {"FileType", "markdown", "nnoremap <silent> <C-p> :call mdip#MarkdownClipboardImage()<CR>"};
      {"BufNewFile,BufRead", "*.toml"," setf toml"},
    };

    yank = {
      {"TextYankPost", [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})]]};
    };
  }

  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
