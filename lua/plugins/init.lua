return
{
	{
		"catppuccin/nvim",
		lazy = false,
		priority=1000,
		name = "catppuccin",
		config = function()
			require("catppuccin").setup
			{
				flavour = "mocha",
				styles = {
					conditionals = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					functions = {},
					loops = {},
					types = {},
					operators = {},
				}
			}
			vim.cmd.colorscheme "catppuccin"
		end
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts =
		{
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = false },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true }
		},
		keys =
		{
			{ "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
			{ "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
			{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
			{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
			{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
			{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
			{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
			{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
			{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
			{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
			{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
			{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
			{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
			{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
			{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
			{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
			{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
			{ "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
			{ "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
			{ "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
			{ "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
			{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
			{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
			{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
			{ '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
			{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
			{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
			{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
			{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
			{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
			{ "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
			{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
			{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
			{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
			{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
			{ "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
			{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
			{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
			{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
			{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
			{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			{ "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
			{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
			{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
			{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
			{ "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "Calls Incoming" },
			{ "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "Calls Outgoing" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
			{ "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
			{ "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
			{ "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
			{ "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
			{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
			{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
			{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
			{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" }
		}
	},
	{
		"neovim/nvim-lspconfig"
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "╎",
			}
		}
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				component_separators = { left = "", right = ""},
				section_separators = { left = "", right = ""},
				globalstatus = true,
				theme = "catppuccin-mocha"
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return " " .. str
						end,
					}
				},
				lualine_b = {
					{
						"filename",
						file_status = true,
						newfile_status = false,
						path = 0,

						shorting_target = 40,
						symbols = {
							modified = "*",
							unnamed = "+",
						}
					}
				},
				lualine_c = {
					{
						"lsp_status",
						icon = "",
						ignore_lsp = {},
					},
					{
						"diagnostics"
					}
				},
				lualine_x = {
					{
						"filetype"
					}
				}
			}
		},
	},
	{
		"mason-org/mason.nvim",
		opts = {}
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}
	},
	{
		"saghen/blink.cmp",

		version = "1.*",

		---@module "blink.cmp"
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "default",

				["<Tab>"] = { "accept", "fallback" },

				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },

				["<C-space>"] = { function(cmp) cmp.show() end },
			},

			appearance = {
				nerd_font_variant = "normal"
			},

			completion =
			{
				documentation = { auto_show = true },
				ghost_text = { enabled = true }
			},

			sources = {
				default = { "lsp", "path", "buffer" },
			},

			signature = { enabled = true },

			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	},
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"Jorenar/nvim-dap-disasm"
		},
		keys = {
			{ "<leader>db", "<cmd>DapToggleBreakpoint<CR>" },
			{ "<leader>dc", "<cmd>DapContinue<CR>" },
			{ "<leader>dp", "<cmd>DapPause<CR>" },
			{ "<leader>dt", "<cmd>DapTerminate<CR>" },
			{ "<leader>dv", "<cmd>DapStepOver<CR>" },
			{ "<leader>du", "<cmd>DapStepOut<CR>" },
			{ "<leader>di", "<cmd>DapStepInto<CR>" },
		},
		config = function()
			local dap, dapui, disasm = require "dap", require "dapui", require "dap-disasm"

			disasm.setup(
				{
					dapui_register = true,

					dapview_register = false,

					dapview = {
						keymap = "D",
						label = "Disassembly [D]",
						short_label = "󰒓 [D]",
					},

					winbar = {
						enabled = true,
						labels = {
							step_into = "Step Into",
							step_over = "Step Over",
							step_back = "Step Back",
						},
						order = {
							"step_into", "step_over", "step_back"
						}
					},

					sign = "DapStopped",

					ins_before_memref = 16,

					ins_after_memref = 16,

					columns = {
						"address",
						"instructionBytes",
						"instruction",
					},
				}
			)

			dapui.setup()

			vim.keymap.set("n", "<leader>ds", dapui.open);
			vim.keymap.set("n", "<leader>dq", dapui.close);

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb.cmd",
					args = {"--port", "${port}"},

					on_start = function()
						vim.defer_fn(function()
							print("CodeLLDB server started, ready to connect")
						end, 500)
					end
				}
			}

			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = "OpenDebugAD7.cmd",
				options = {
					detached = false
				}
			}

			dap.configurations.cpp = {
				{
					name = "Launch file (codelldb)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", "", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false
				},
				{
					name = "Launch file (cppdbg)",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", "", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = false,
				},
				{
					name = "Attach to gdbserver :1234",
					type = "cppdbg",
					request = "launch",
					MIMode = "gdb",
					miDebuggerServerAddress = "localhost:1234",
					miDebuggerPath = "gdb",
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", "", "file")
					end,
				},
			}

			dap.configurations.c = dap.configurations.cpp
			dap.configurations.asm = dap.configurations.cpp
			dap.configurations.zig = dap.configurations.cpp

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "❭", texthl = "DapStopped", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "◉", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
		end,
	},
	{
		"stevearc/oil.nvim",
		---@module "oil"
		---@type oil.SetupOpts
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		lazy = false,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		event = { "BufReadPre", "BufNewFile" },
		config = function ()
			require	"nvim-treesitter.config".setup
			{
				highlight = { enable = true, additional_vim_regex_highlighting = false },
				indent = { enable = true },
			}
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module "render-markdown"
		---@type render.md.UserConfig
		opts = {},
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function ()
			vim.keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
			vim.keymap.set("n", "<leader>he", require("harpoon.ui").toggle_quick_menu)
			vim.keymap.set("n", "<M-1>", function () require("harpoon.ui").nav_file(1) end)
			vim.keymap.set("n", "<M-2>", function () require("harpoon.ui").nav_file(2) end)
			vim.keymap.set("n", "<M-3>", function () require("harpoon.ui").nav_file(3) end)
			vim.keymap.set("n", "<M-4>", function () require("harpoon.ui").nav_file(4) end)
			vim.keymap.set("n", "<M-5>", function () require("harpoon.ui").nav_file(5) end)
			vim.keymap.set("n", "<M-6>", function () require("harpoon.ui").nav_file(6) end)
			vim.keymap.set("n", "<M-7>", function () require("harpoon.ui").nav_file(7) end)
			vim.keymap.set("n", "<M-8>", function () require("harpoon.ui").nav_file(8) end)
			vim.keymap.set("n", "<M-9>", function () require("harpoon.ui").nav_file(9) end)
			vim.keymap.set("n", "<M-0>", function () require("harpoon.ui").nav_file(10) end)
		end
	},
	{
		"tpope/vim-surround"
	},
	{
		"akinsho/toggleterm.nvim",
		lazy = false,
		opts = {}
	},
	{
		"Civitasv/cmake-tools.nvim",
		keys =
		{
			{ "<leader>cb", "<cmd>CMakeBuild<CR>" },
			{ "<leader>cg", "<cmd>CMakeGenerate<CR>" },
			{ "<leader>csbty", "<cmd>CMakeSelectBuildType<CR>" },
			{ "<leader>csbta", "<cmd>CMakeSelectBuildTarget<CR>" },
			{ "<leader>csbp", "<cmd>CMakeSelectBuildPreset<CR>" },
			{ "<leader>cslt", "<cmd>CMakeSelectLaunchTarget<CR>" },
			{ "<leader>cr", "<cmd>CMakeRun<CR>" },
			{ "<leader>cd", "<cmd>CMakeDebug<CR>" },
		},
		opts = {
			cmake_use_preset = true,
			cmake_regenerate_on_save = true,
			cmake_generate_options = { "-G Ninja", "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
			cmake_build_directory = "build/${variant:buildType}",
			cmake_dap_configuration = {
				name = "cpp",
				type = "cppdbg",
				request = "launch",
				stopOnEntry = false,
				runInTerminal = true,
				console = "integratedTerminal"
			},
			cmake_runner = {
				name = "toggleterm",
				opts = {},
				default_opts = {
					toggleterm = {
						direction = "float",
						close_on_exit = false,
						auto_scroll = true,
						singleton = true
					}
				}
			}
		}
	},
	{

		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {},
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		keys =
		{
			{ "]h", "<cmd>Gitsigns nav_hunk next<CR>" },
			{ "[h", "<cmd>Gitsigns nav_hunk prev<CR>" },
			{ "<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>" },
			{ "<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>" },
			{ "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<CR>" },
			{ "<leader>gbs", "<cmd>Gitsigns stage_buffer<CR>" },
			{ "<leader>gbr", "<cmd>Gitsigns reset_buffer<CR>" }
		}
	}
}
