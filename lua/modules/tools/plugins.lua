local tools = {}
local conf = require('modules.tools.config')

-- tools['kristijanhusak/vim-dadbod-ui'] = {
--   cmd = {'DBUIToggle','DBUIAddConnection','DBUI','DBUIFindBuffer','DBUIRenameBuffer'},
--   config = conf.vim_dadbod_ui,
--   requires = {{'tpope/vim-dadbod',opt = true}}
-- }

tools['editorconfig/editorconfig-vim'] = {
  ft = { 'go','typescript','javascript','vim','rust','zig','c','cpp' }
}

-- tools['glepnir/prodoc.nvim'] = {
--   event = 'BufReadPre'
-- }

tools['tyru/caw.vim'] = {
  event = 'BufReadPre'
}

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

tools['brooth/far.vim'] = {
  cmd = {'Far','Farp'},
  config = function ()
    vim.g['far#source'] = 'rg'
  end
}

tools['iamcco/markdown-preview.nvim'] = {
  run = 'cd app & yarn install',
  cmd = 'MarkdownPreview',
  ft = 'markdown',
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
  -- config = function ()
  --   vim.g.table_mode_cell_text_object_i_map = 'k<Bar>'
  -- end
}

return tools
