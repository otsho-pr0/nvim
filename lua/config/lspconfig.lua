local servers = {
	lua_ls = {
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_markers = {
			".luarc.json",
			".luarc.jsonc",
			".luacheckrc",
			".stylua.toml",
			"stylua.toml",
			"selene.toml",
			"selene.yml",
			".git",
		},
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
					library = {
						vim.fn.expand "$VIMRUNTIME/lua",
						vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
						"${3rd}/luv/library",
						"${3rd}/love2d/library",
						vim.uv.cwd(),
					},
				},
			},
		},
	},
	clangd = {
		cmd = { "clangd", "--background-index", "--header-insertion=never" },
	},
	zls = {},
	slangd = {},
	html = {},
	emmet_ls = {},
	cssls = {},
	ts_ls = {},
	jsonls = {},
}

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

local servers_to_enable = {}

for server_name, server_config in pairs(servers) do
	vim.lsp.config(server_name, server_config)
	table.insert(servers_to_enable, server_name)
end

vim.lsp.enable(servers_to_enable)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(event)
		local bufnr = event.buf

		local function opts(desc)
			return { buffer = bufnr, remap = false, desc = "LSP " .. desc }
		end

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
		vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts("List workspace folders"))
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
		vim.keymap.set("n", "grr", vim.lsp.buf.references, opts("References"))
		vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts("Rename"))
		vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))
		vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts("Go to next diagnostic"))
		vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts("Go to prev diagnostic"))
	end,
})

local x = vim.diagnostic.severity

vim.diagnostic.config({
	virtual_text = true,
	signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
	underline = false,
	float = { border = "single" },
})

