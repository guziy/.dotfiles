return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = {
      enabled = true,
      bo = {
        filetype = "snacks_terminal",
      },
      wo = {},
      stack = true, -- when enabled, multiple split windows with the same position will be stacked together (useful for terminals)
      keys = {
        q = "hide",
        gf = function(self)
          local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
          if f == "" then
            Snacks.notify.warn("No file under cursor")
          else
            self:hide()
            vim.schedule(function()
              vim.cmd("e " .. f)
            end)
          end
        end,
        term_normal = {
          "<esc>",
          function(self)
            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
            if self.esc_timer:is_active() then
              self.esc_timer:stop()
              vim.cmd("stopinsert")
            else
              self.esc_timer:start(200, 0, function() end)
              return "<esc>"
            end
          end,
          mode = "t",
          expr = true,
          desc = "Double escape to normal mode",
        },
      },
      win = {style = "terminal"},
    },
  },
  keys = {
    { "<C-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    {
        "<leader>N",
        desc = "Neovim News",
        function()
           Snacks.win({
             file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
             width = 0.6,
             height = 0.6,
             wo = {
               spell = false,
               wrap = false,
               signcolumn = "yes",
               statuscolumn = " ",
               conceallevel = 3,
             },
           })
        end,
    }, 
  },
}
