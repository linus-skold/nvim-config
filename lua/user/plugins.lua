-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- theme
	{
		"catppuccin/nvim",
		name = "catpuccin",
		priority = 1000,
	},
    {
	    "nvim-lualine/lualine.nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    --"kyazdani42/nvim-web-devicons",
	"ctrlpvim/ctrlp.vim",
	"akinsho/bufferline.nvim",
    --"ibhagwan/fzf-lua",
	--"yuki-yano/fzf-preview.vim",
	"nvim-lua/plenary.nvim", -- required for telescope
	{
		"ckipp01/stylua-nvim",
		run = "cargo install stylua",
		keys = {
			{
				"<leader>fF",
				desc = "Format file with stylua",
				function()
					require("stylua-nvim").format_file()
				end,
				{ noremap = true, silent = true },
			},
			{
				"<leader>fR",
				desc = "Format range with stylua",
				function()
					require("stylua-nvim").format_range()
				end,
				{ noremap = true, silent = true },
			},
		},
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
			},
			picker = { 
                enabled = true, 
                finder = "rg",
                projects = {
                    patterns = { ".git", "package.json" }
                }
            },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
            quickfile = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			styles = {
				notification = {},
			},
		
        },
		keys = {
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<leader>gb",
				function()
					Snacks.git.blame_line()
				end,
				desc = "Git Blame Line",
			},
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "Lazygit Current File History",
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Log (cwd)",
			},
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"<c-/>",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<c-_>",
				function()
					Snacks.terminal()
				end,
				desc = "which_key_ignore",
			},
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},
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
			{
				"<leader>qp",
				function()
					Snacks.picker.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader><space>",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>gc",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find Git Files",
			},
            {
                "<leader>ee",
                function()
                    Snacks.picker.explorer()
                end,
                desc = "File Explorer",
            }
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
    {
        "folke/which-key.nvim", 
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                function() 
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)"
            }
        }
    },
    {
    "atiladefreitas/dooing",
    config = function()
        require("dooing").setup({
            window = {
                width = 80,
                height = 40,
            },
            })
    end,
    },
	-- Language services
	"williamboman/mason.nvim", -- lsp installer
    {
        "nvim-treesitter/nvim-treesitter", -- syntax highlighting
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            ensure_installed = {
                "vim",
                "lua",
                "html",
                "css",
                "scss",
                "c_sharp",
                "razor",
                "c",
                "cpp",
                "markdown",
                "rust",
                "caddy",
                "javascript",
                "typescript",
                "tsx",
                "nu"
            }
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    -- Debugger stuff
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	-- Code tools
    {
        "github/copilot.vim",
        event = "VeryLazy",
        config = function() 
            
        end
    },
	-- "neoclide/coc.nvim", -- use lsp instead
	-- Utils
	"folke/which-key.nvim",
	"editorconfig/editorconfig-vim",
	"mhinz/vim-signify",
	"tpope/vim-fugitive",
	"sindrets/diffview.nvim",
}

local opts = {}

require("lazy").setup(plugins, opts)
