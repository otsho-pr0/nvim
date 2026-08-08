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
			
			vim.cmd.colorscheme "catppuccin-nvim"
		end
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
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {
			foldKeymaps = {
				setup = false,
			},
		},

		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
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
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = { { "<C-n>", "<cmd>NvimTreeToggle<CR>" } },
		opts =
		{
			renderer = { root_folder_label = false }
		}
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
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		keys = {
			{"<leader>fpf", "<cmd>Telescope find_files<CR>"},
			{"<leader>fpg", "<cmd>Telescope live_grep<CR>"},
			{"<leader>fgb", "<cmd>Telescope git_branches<CR>"},
			{"<leader>fgf", "<cmd>Telescope git_files<CR>"},
			{"<leader>fgs", "<cmd>Telescope git_status<CR>"},
			{"<leader>fgpc", "<cmd>Telescope git_commits<CR>"},
			{"<leader>fgbc", "<cmd>Telescope git_bcommits<CR>"},
			{"<leader>fd", "<cmd>Telescope diagnostics<CR>"},
			{"<leader>fb", "<cmd>Telescope buffers<CR>"},
			{"<leader>fh", "<cmd>Telescope help_tags<CR>"},
			{"<leader>fk", "<cmd>Telescope keymaps<CR>"},
			{"<leader>ft", "<cmd>Telescope colorscheme<CR>"}
		},
		opts = {}
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
		"folke/which-key.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		opts = {}
	}
}
