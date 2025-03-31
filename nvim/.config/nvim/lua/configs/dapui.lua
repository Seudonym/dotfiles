local dapui = require("dapui")
dapui.setup();

local dap = require("dap")
dap.adapters.lldb = {
  type = "executable",
  command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/codelldb",
  name = "lldb"
}

dap.configurations.rust = {
  {
    type = "lldb",
    request = "launch",
    name = "Launch",
    program = function()
      -- Prompt for the program path first
      local path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      if not path or path == "" then
        print("No executable provided.")
        return nil
      end
      return path
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      -- Prompt for arguments after the program path is resolved
      local args_string = vim.fn.input("Arguments: ")
      if not args_string or args_string == "" then
        return {} -- Return an empty table if no arguments are provided
      end
      return vim.split(args_string, " ") -- Split arguments into a table
    end,
    runInTerminal = false,
  },
}
