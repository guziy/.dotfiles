return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',  -- optional: updates parsers on install/update
  event = { 'BufReadPost', 'BufNewFile' },  -- lazy-load
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',  -- optional
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      -- Parsers to install (or "all")
      ensure_installed = {
       'lua',
       'python',
       'bash',
       'json',
       'yaml',
       'markdown',
       'vim',
       'cpp',
       'c',
       'fortran',
      },
      -- ensure_installed="all",

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,  -- enable if you need Vim's fallback highlighting
      },

      indent = {
        enable = true,
      },

      -- optional: Textobjects module
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
    }
  end,
}
