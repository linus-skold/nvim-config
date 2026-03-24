return {
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
}
