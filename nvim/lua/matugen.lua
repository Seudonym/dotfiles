 local M = {}

 function M.setup()
   require('base16-colorscheme').setup {
     -- Background tones
     base00 = '#121315', -- Default Background
     base01 = '#1e2021', -- Lighter Background (status bars)
     base02 = '#292a2c', -- Selection Background
     base03 = '#8c9197', -- Comments, Invisibles
     -- Foreground tones
     base04 = '#c2c7cd', -- Dark Foreground (status bars)
     base05 = '#e3e2e4', -- Default Foreground
     base06 = '#e3e2e4', -- Light Foreground
     base07 = '#e3e2e4', -- Lightest Foreground
     -- Accent colors
     base08 = '#ffb4ab', -- Variables, XML Tags, Errors
     base09 = '#dfbbe1', -- Integers, Constants
     base0A = '#bcc8d4', -- Classes, Search Background
     base0B = '#aacae7', -- Strings, Diff Inserted
     base0C = '#dfbbe1', -- Regex, Escape Chars
     base0D = '#aacae7', -- Functions, Methods
     base0E = '#bcc8d4', -- Keywords, Storage
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
