return {
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
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
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
								".eslintrc",
								".eslintrc.js",
								".eslintrc.cjs",
								".eslintrc.json",
								".eslintrc.yaml",
								".eslintrc.yml",
								"eslint.config.js",
								"eslint.config.mjs",
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
								".eslintrc",
								".eslintrc.js",
								".eslintrc.cjs",
								".eslintrc.json",
								".eslintrc.yaml",
								".eslintrc.yml",
								"eslint.config.js",
								"eslint.config.mjs",
							})
					end,
				}),
				-- prettierd: format JS/TS/HTML/CSS — but NOT C# files
				null_ls.builtins.formatting.prettierd.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"css",
						"scss",
						"html",
						"json",
						"yaml",
						"markdown",
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
}
