vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Past without affecting the buffer" })

vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to the system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to the system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank to the system clipboard" })

vim.keymap.set("n", "<leader>d", "\"_d", { desc = "Delete without affecting the buffer" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete without affecting the buffer" })

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to the down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to the up window" })

vim.keymap.set("t", "<C-x>", "<C-\\><C-N>", { desc = "Switch to normal mode" })
vim.keymap.set({"n", "t"}, "<M-t>", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle float terminal" })

vim.keymap.set("n", "-", function () vim.cmd("Oil") end, { "Open Oil" });

vim.keymap.set("n", "<leader>r", function ()
	local cmd = "!" .. vim.fn.input("Run: ", "", "file")
	vim.cmd(cmd)
end, { desc = "Run" })

vim.keymap.set("n", "<leader>bd", "<cmd>bp | bd #<CR>", { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>sh", "<cmd>LspClangdSwitchSourceHeader<CR>", { desc = "Switch Between Source/Header" })

vim.keymap.set("n", "<leader>si", "<cmd>LspClangdShowSymbolInfo<CR>", { desc = "Show Symbol Info" })
