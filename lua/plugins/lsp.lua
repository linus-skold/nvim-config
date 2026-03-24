return {
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
			ensure_installed = { "ts_ls", "rust_analyzer", "lua_ls", "html", "cssls", "omnisharp", "clangd" },
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

			-- mason-lspconfig v2: handlers are passed directly to setup()
			mason_lspconfig.setup(vim.tbl_extend("force", opts, {
				handlers = {
					-- Default handler -- called for any server without a specific handler below
					function(server_name)
						lspconfig[server_name].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,

					-- ts_ls: restrict to JS/TS only -- do NOT attach to cshtml/razor/html
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

					-- html: restrict to plain HTML, not cshtml/razor
					["html"] = function()
						lspconfig.html.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							filetypes = { "html" },
						})
					end,

					-- clangd: C/C++/ObjC language server
					["clangd"] = function()
						lspconfig.clangd.setup({
							on_attach = on_attach,
							capabilities = capabilities,
							cmd = {
								"clangd",
								"--background-index",
								"--clang-tidy",
								"--header-insertion=iwyu",
								"--completion-style=detailed",
							},
							filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
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
				},
			}))
		end,
	},
}
