return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		opts = {
			options = {
				multilines = {
					enabled = false,
				},
			},
		},
		config = function(_, opts)
			local tid = require("tiny-inline-diagnostic")
			tid.setup(opts)
			vim.diagnostic.config({
				virtual_text = false,
			})

			vim.api.nvim_create_user_command("TinyInlineDiagnosticMultilinesToggle", function()
				local current = tid.config.options.multilines.enabled
				tid.config.options.multilines.enabled = not current
			end, {})
		end,
		keys = {
			{
				"<leader>tm",
				"<cmd>TinyInlineDiagnosticMultilinesToggle<CR>",
				desc = "Toggle Tiny Inline Diagnostic Multilines",
			},
		},
	},
	{
		"williamboman/mason.nvim", -- lsp installer
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "nvimdev/lspsaga.nvim" },
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "ts_ls", "eslint", "rust_analyzer", "lua_ls", "html", "cssls", "csharp_ls" },
		},
		dependencies = { "mason.nvim", "nvim-lspconfig" },
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "jay-babu/mason-null-ls.nvim", "mason.nvim", "nvimtools/none-ls-extras.nvim" },
		config = function()
			local null_ls = require("null-ls")

			require("mason-null-ls").setup({
				ensure_installed = { "prettierd", "stylua", "eslint" },
				automatic_installation = true,
			})


            -- TODO: Fix issue where eslint keeps running when moving cursor in a JS/TS file
			null_ls.setup({
				sources = {
					require("none-ls.diagnostics.eslint"),
					require("none-ls.code_actions.eslint"),
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.stylua,
				},
			})

			vim.api.nvim_create_user_command("Format", function()
				vim.lsp.buf.format({ async = true })
			end, {})

			-- Disabled: Synchronous formatting on save causes race conditions and file corruption
			-- Use <leader>fF to format manually, or uncomment with timeout protection
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			-- 	pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.lua" },
			-- 	callback = function()
			-- 		vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
			-- 	end,
			-- })
		end,
		keys = {
			{ "<leader>fF", "<cmd>Format<CR>", desc = "Format current buffer" },
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		branch = "main",
		dependencies = { "nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
		lazy = true,
		opts = {},
		keys = {
			{ "gh", "<cmd>Lspsaga hover_doc<CR>", desc = "LSP Hover Documentation" },
			{ "gd", "<cmd>Lspsaga goto_definition<CR>", desc = "LSP Go to Definition" },
			{ "gr", "<cmd>Lspsaga rename<CR>", desc = "LSP Rename" },
			{ "ga", "<cmd>Lspsaga code_action<CR>", desc = "LSP Code Action" },
		},
	},
}
