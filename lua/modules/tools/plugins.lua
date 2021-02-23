local tools = {}
local conf = require('modules.tools.config')

tools['kristijanhusak/vim-dadbod-ui'] = {
  cmd = {'DBUIToggle','DBUIAddConnection','DBUI','DBUIFindBuffer','DBUIRenameBuffer'},
  config = conf.vim_dadbod_ui,
  requires = {{'tpope/vim-dadbod',opt = true}}
}

tools['editorconfig/editorconfig-vim'] = {
  ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

tools['glepnir/indent-guides.nvim'] = {
  event = 'BufReadPre *',
  config = conf.indent_guides
}

tools['glepnir/prodoc.nvim'] = {
  event = 'BufReadPre *'
}

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

tools['mhartington/formatter.nvim'] = {
  ft = { 'typescript','typescriptreact','lua' },
  config = conf.fomatter_nvim
}

tools['brooth/far.vim'] = {
  cmd = {'Far','Farp'},
  config = function ()
    vim.g['far#source'] = 'rg'
  end
}

tools['iamcco/markdown-preview.nvim'] = {
  ft = 'markdown',
  cmd = 'MarkdownPreview',
  run = 'sh -c "cd app & yarn install"',
  config = function ()
    vim.g.mkdp_auto_start = 0
  end
}

tools['vimwiki/vimwiki'] = {
  config = conf.vimwiki
}

tools['ferrine/md-img-paste.vim'] = {
  ft = 'markdown',
  confg = function ()
    vim.g.mdip_imgdir = 'pic'
    vim.g.mdip_imgname = 'image'
  end
}

tools['dhruvasagar/vim-table-mode'] = {
  ft = 'markdown',
  config = function ()
    vim.g.table_mode_cell_text_object_i_map = 'k<Bar>'
  end
}

return tools
