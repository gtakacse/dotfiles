return {
    "scalameta/nvim-metals",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "mfussenegger/nvim-dap",
        },
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
        local metals_config = require("metals").bare_config()

        metals_config.init_options = {
            statusBarProvider = "off"
        }

        metals_config.settings = {
            showImplicitArguments = true,
            excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
        }

        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end,
}
