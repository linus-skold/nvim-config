
return {
	{
		"nvim-mini/mini.completion",
		version = "*",
		event = "VeryLazy",
	},
	{
		"nvim-mini/mini.bracketed",
		version = "*",
		event = "VeryLazy",
	},
	{
		"nvim-mini/mini.comment",
		version = "*",
		event = "VeryLazy",
	},
	{
		"nvim-mini/mini.diff",
		version = "*",
		opts = {
			view = {
				style = "sign",
			},
		},
	},
    {
        "nvim-mini/mini.sessions",
        dependencies = { "folke/snacks.nvim" },
        version = "*",
        event = "VeryLazy",
        opts = {
            autoread = false,
            autowrite = true,
            directory = function()
                local git_root = vim.fn.finddir(".git", ".;")
                if git_root ~= "" then
                    return vim.fn.fnamemodify(git_root, ":h") .. "/.git/nvim-sessions"
                end
                return vim.fn.stdpath("data") .. "/sessions"
            end,
        },
        keys = {
            { "<leader>cS", function() 
                Snacks.input({
                    prompt = "Session name: ",
                }, function(input)
                    if input then
                        require("mini.sessions").write(input)
                    end
                end)
            end, desc = "Create Session" }  
        },
        config = function(_, opts)
            require("mini.sessions").setup(opts)
            -- Delete initial no-name buffer after session is manually loaded
            vim.api.nvim_create_autocmd("SessionLoadPost", {
                callback = function()
                    vim.defer_fn(function()
                        local bufs = vim.api.nvim_list_bufs()
                        for _, bufnr in ipairs(bufs) do
                            if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_name(bufnr) == "" and vim.bo[bufnr].buftype == "" and not vim.bo[bufnr].modified then
                                vim.api.nvim_buf_delete(bufnr, { force = true })
                            end
                        end
                    end, 10)
                end,
            })
        end,
    }
}
