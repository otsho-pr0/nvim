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
						"${3rd}/luv/library",
						vim.uv.cwd(),
					},
				},
			},
		},
	},
	clangd = {
		cmd = { "clangd", "--background-index", "--header-insertion=never", "--function-arg-placeholders=0" },
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

