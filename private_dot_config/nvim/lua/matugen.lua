 local M = {}

 function M.setup()
   require('base16-colorscheme').setup {
     -- Background tones
     base00 = '#151312', -- Default Background
     base01 = '#221f1e', -- Lighter Background (status bars)
     base02 = '#2c2928', -- Selection Background
     base03 = '#9b8e88', -- Comments, Invisibles
     -- Foreground tones
     base04 = '#d3c3bd', -- Dark Foreground (status bars)
     base05 = '#e8e1df', -- Default Foreground
     base06 = '#e8e1df', -- Light Foreground
     base07 = '#e8e1df', -- Lightest Foreground
     -- Accent colors
     base08 = '#ffb4ab', -- Variables, XML Tags, Errors
     base09 = '#cdc7aa', -- Integers, Constants
     base0A = '#d4c3bb', -- Classes, Search Background
     base0B = '#e0c0b1', -- Strings, Diff Inserted
     base0C = '#cdc7aa', -- Regex, Escape Chars
     base0D = '#e0c0b1', -- Functions, Methods
     base0E = '#d4c3bb', -- Keywords, Storage
     base0F = '#93000a', -- Deprecated, Embedded Tags
   }
 end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
