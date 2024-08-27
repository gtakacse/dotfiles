return {
	-- "oxfist/night-owl.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	--   vim.cmd.colorscheme("night-owl")
	-- end,
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		vim.cmd.colorscheme("tokyonight-storm")
	end,
}
