return {
	"nvim-treesitter/nvim-treesitter", -- syntax highlighting
	-- branch = 'main',
	branch = "master",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		prefer_git = true,
		auto_install = true,
		sync_install = false,
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		ensure_installed = {
			"c",
			"c_sharp",
			"caddy",
			"cpp",
			"css",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"nu",
			"razor",
			"rust",
			"scss",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
