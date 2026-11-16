vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8

vim.o.cursorline = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitright = true

vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.termfeatures = { osc52 = false }

vim.filetype.add { extension = { hlsl = "hlsl", csp = "html", json = "jsonc" } }

vim.api.nvim_create_autocmd("FileType",
{
	pattern = "hlsl",
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})
