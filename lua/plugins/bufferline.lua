return {
	"akinsho/bufferline.nvim",
    event = "BufReadPre",
	lazy = false,
	opts = {
		options = {
			offsets = {
				{
					filetype = "snacks_layout_box",
					text = "󰙅  File Explorer",
					highlight = "Directory",
					separator = true,
				},
			},
		},
	},
}
