return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  opt = {
    ensure_installed = { "angularls@v14.2.0", "astro", "lua_ls", "ts_ls" },
  },
  config = function()
    require("mason").setup()
    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup({
      settings = {
        Lua = { diagnostics = { globals = { "vim" } } },
      },
    })
    require("mason-lspconfig").setup({
      -- Default handler (per server senza configurazione specifica)
      function(server_name)
        lspconfig[server_name].setup({
        })
      end,

    })
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig').clangd.setup({
      capabilities = capabilities
    })
  end,
}
