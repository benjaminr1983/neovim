local ts = require("nvim-treesitter")

ts.setup()

ts.install({
	"bash",
	"vim",
	"lua",
	"html",
	"css",
	"javascript",
	"python",
	"go",
	"rust",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"sh",
		"vim",
		"lua",
		"html",
		"css",
		"javascript",
		"python",
		"go",
		"rust",
		"org",
	},
	callback = function (args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
