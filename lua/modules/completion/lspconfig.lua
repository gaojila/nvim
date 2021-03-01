local api = vim.api
local lspconfig = require 'lspconfig'
local global = require 'core.global'
local format = require('modules.completion.format')

vim.cmd [[packadd lspsaga.nvim]]
local saga = require 'lspsaga'
saga.init_lsp_saga()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

local enhance_attach = function(client,bufnr)
  if client.resolved_capabilities.document_formatting then
    format.lsp_before_save()
  end
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- lspconfig.gopls.setup {
--   cmd = {"gopls","--remote=auto"},
--   on_attach = enhance_attach,
--   capabilities = capabilities,
--   init_options = {
--     usePlaceholders=true,
--     completeUnimported=true,
--   }
-- }

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
else
  print("Unsupported system for sumneko")
end
local sumneko_root_path = global.home .. '/workstation/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {"vim"}
      },
      runtime = {version = "LuaJIT"},
      workspace = {
        library = vim.list_extend({
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand(global.home .. "/workstation/openresty/lualib")] = true
        },{}),
      },
    },
  }
}

-- lspconfig.tsserver.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = false
--     enhance_attach(client)
--   end
-- }

-- lspconfig.clangd.setup {
--   cmd = {
--     "clangd",
--     "--background-index",
--     "--suggest-missing-includes",
--     "--clang-tidy",
--     "--header-insertion=iwyu",
--   },
-- }

-- local servers = {
--   'dockerls','bashls','rust_analyzer','pyls'
-- }
--
-- for _,server in ipairs(servers) do
--   lspconfig[server].setup {
--     on_attach = enhance_attach
--   }
-- end
