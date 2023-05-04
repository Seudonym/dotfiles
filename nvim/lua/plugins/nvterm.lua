return {
	"Nvchad/nvterm",
	opts = {
		terminals = {
			shell = "pwsh.exe",
		},

		behavior = {
			autoclose_on_quit = {
				enabled = true,
				confirm = false,
			},
			close_on_exit = true,
			auto_insert = true,
		},
	},
}
