-- requires neovim >=0.11
vim.g.mapleader = ' '

-- lazy.nvim plugin manager bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- plugins setup
require("lazy").setup("plugins")

-- some options
vim.defer_fn(function()
  vim.cmd("colorscheme kanagawa")
end, 1)
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.completeopt    = "menuone,noselect,popup"
vim.keymap.set("i", "<cr>", "pumvisible() ? '<C-y>' : '<cr>'", { expr = true })
vim.keymap.set("n", "-", "<cmd>Oil<cr>")
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Normal mode
vim.keymap.set('n', '<Find>', '^', { noremap = true, silent = true })  -- Go to line start (non-blank)
vim.keymap.set('n', '<Select>', 'g_', { noremap = true, silent = true })  -- Go to line end (last non-blank)

-- Insert mode
vim.keymap.set('i', '<Find>', '<C-o>^', { noremap = true, silent = true })
vim.keymap.set('i', '<Select>', '<C-o>g_', { noremap = true, silent = true })

-- Visual mode
vim.keymap.set('v', '<Find>', '^', { noremap = true, silent = true })
vim.keymap.set('v', '<Select>', 'g_', { noremap = true, silent = true })


-- terminal setup
vim.keymap.set("n", "<leader>\\", function()
  vim.cmd.vnew()
  vim.cmd.term("ORDENV_SETUP='' bash -l")
  vim.cmd.wincmd("J")
end)

-- lsp setup (native)
vim.lsp.enable({ 'clangd', 'luals', 'pyright', 'gopls', 'rust-analyzer', 'fortls' })
vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.api.nvim_create_autocmd('LspAttach', {
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" }),
  vim.keymap.set("i", "<C-space>", function() vim.lsp.completion.get() end),

  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
    end

    require("lsp-format").on_attach(client, ev.buf)
  end,
})

require("nvim-treesitter.install").prefer_git = true

-- require'lspconfig'.fortls.setup{
-- cmd = {
--       'fortls',
-- 	 '--lowercase_intrinsics',
--       '--hover_signature',
--        '--hover_language=fortran',
--        '--use_signature_help'
--    }
-- }

-- Maestro source files
vim.filetype.add({
  extension = {tsk='bash', cfg='bash', def='bash'}

})


-- Disable mouse
vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"

