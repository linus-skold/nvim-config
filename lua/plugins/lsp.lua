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
		dependencies = { "mason.nvim", "nvim-lspconfig" },
		opts = {
			-- NOTE: csharp_ls has poor support for .NET Framework 4.8 legacy projects.
			-- If you primarily work with .NET Framework / Razor / cshtml, switch to "omnisharp".
			ensure_installed = { "ts_ls", "eslint", "rust_analyzer", "lua_ls", "html", "cssls", "omnisharp" },
		},
		config = function(_, opts)
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			-- Build shared LSP capabilities (e.g. from mini.completion or another completion plugin)
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			-- Shared on_attach: runs for every server that attaches to a buffer
			local function on_attach(client, bufnr)
				-- Uncomment to disable semantic tokens per-server if you prefer treesitter colours:
				-- client.server_capabilities.semanticTokensProvider = nil
			end

			mason_lspconfig.setup(opts)

			-- mason-lspconfig v2: explicit setup_handlers required (no more auto-setup)
			mason_lspconfig.setup_handlers({
				-- Default handler — called for any server without a specific handler below
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,

				-- ts_ls: restrict to JS/TS only — do NOT attach to cshtml/razor/html
				["ts_ls"] = function()
					lspconfig.ts_ls.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						filetypes = {
							"javascript", "javascriptreact",
							"javascript.jsx", "typescript",
							"typescriptreact", "typescript.tsx",
						},
					})
				end,

				-- eslint LSP: restrict to JS/TS files only
				["eslint"] = function()
					lspconfig.eslint.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						filetypes = {
							"javascript", "javascriptreact",
							"javascript.jsx", "typescript",
							"typescriptreact", "typescript.tsx",
						},
					})
				end,

				-- html: restrict to plain HTML, not cshtml/razor
				["html"] = function()
					lspconfig.html.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						filetypes = { "html" },
					})
				end,

				-- omnisharp: handles C#, .NET Framework 4.8, and Razor/cshtml files
				["omnisharp"] = function()
					lspconfig.omnisharp.setup({
						on_attach = on_attach,
						capabilities = capabilities,
						filetypes = { "cs", "cshtml" },
						enable_roslyn_analyzers = true,
						organize_imports_on_format = true,
						enable_import_completion = true,
					})
				end,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "jay-babu/mason-null-ls.nvim", "mason.nvim", "nvimtools/none-ls-extras.nvim" },
		config = function()
			local null_ls = require("null-ls")

			require("mason-null-ls").setup({
				ensure_installed = { "prettierd", "stylua" },
				automatic_installation = true,
			})

			-- JS/TS filetypes for condition guards
			local js_ts_filetypes = {
				"javascript", "javascriptreact", "javascript.jsx",
				"typescript", "typescriptreact", "typescript.tsx",
			}

			local function is_js_ts(utils)
				return vim.tbl_contains(js_ts_filetypes, vim.bo.filetype)
			end

			null_ls.setup({
				sources = {
					-- ESLint: only attach to JS/TS files, and only when an ESLint config exists
					require("none-ls.diagnostics.eslint").with({
						condition = function(utils)
							return is_js_ts(utils)
								and utils.root_has_file({
									".eslintrc", ".eslintrc.js", ".eslintrc.cjs",
									".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml",
									"eslint.config.js", "eslint.config.mjs",
								})
						end,
						-- Prevent ESLint from re-running on every cursor move;
						-- only run on file save and buffer enter
						method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
					}),
					require("none-ls.code_actions.eslint").with({
						condition = function(utils)
							return is_js_ts(utils)
								and utils.root_has_file({
									".eslintrc", ".eslintrc.js", ".eslintrc.cjs",
									".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml",
									"eslint.config.js", "eslint.config.mjs",
								})
						end,
					}),
					-- prettierd: format JS/TS/HTML/CSS — but NOT C# files
					null_ls.builtins.formatting.prettierd.with({
						filetypes = {
							"javascript", "javascriptreact", "typescript", "typescriptreact",
							"css", "scss", "html", "json", "yaml", "markdown",
						},
					}),
					null_ls.builtins.formatting.stylua,
				},
			})

			vim.api.nvim_create_user_command("Format", function()
				vim.lsp.buf.format({ async = true })
			end, {})
		end,
		keys = {
			{ "<leader>fF", "<cmd>Format<CR>", desc = "Format current buffer" },
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		branch = "main",
		dependencies = { "nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
        event = "LspAttach",
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
