return {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    config = function()
        vim.g.autoformat = true
        require("conform").setup({
            formatters_by_ft = {
                bicep = { "bicep" },
                css = { "prettier" },
                go = { "goimports_reviser", "gofmt", "golines" },
                html = { "prettier" },
                htmlangular = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                nix = { "nixfmt" },
                rust = { "rustfmt" },
                scss = { "prettier" },
                sh = { "shfmt" },
                templ = { "templ" },
                toml = { "taplo" },
                yaml = { "prettier" },
            },

            format_after_save = function()
                if not vim.g.autoformat then
                    return
                else
                    if vim.bo.filetype == "ps1" then
                        vim.lsp.buf.format()
                        return
                    end
                    return { lsp_format = "fallback" }
                end
            end,

            formatters = {
                goimports_reviser = {
                    command = "goimports-reviser",
                    args = { "-output", "stdout", "$FILENAME" },
                },
            },
        })

        -- Override bicep's default indent size
        require("conform").formatters.bicep = {
            args = { "format", "--stdout", "$FILENAME", "--indent-size", "2" },
        }

        -- Override prettier's default indent type
        require("conform").formatters.prettier = {
            prepend_args = { "--tab-width", "2" },
        }

        -- Toggle format on save
        vim.api.nvim_create_user_command("ConformToggle", function()
            vim.g.disable_autoformat = not vim.g.disable_autoformat
            print("Conform " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
        end, {
            desc = "Toggle format on save",
        })
    end,
}
