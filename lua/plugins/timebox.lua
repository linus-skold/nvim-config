return {
	"linus-skold/timebox.nvim",
	dev = true,
    dir = "~/Development/timebox.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		duration = {
			work = 1 * 60,
			coffee = 1 * 60,
		},
        win = {
            width = 120,
        },
    },
}
