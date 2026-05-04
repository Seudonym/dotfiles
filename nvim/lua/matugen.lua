 local M = {}

 function M.setup()
   require('base16-colorscheme').setup {
     -- Background tones
     base00 = '#121317', -- Default Background
     base01 = '#1e1f24', -- Lighter Background (status bars)
     base02 = '#292a2e', -- Selection Background
     base03 = '#8f909b', -- Comments, Invisibles
     -- Foreground tones
     base04 = '#c5c6d2', -- Dark Foreground (status bars)
     base05 = '#e3e2e8', -- Default Foreground
     base06 = '#e3e2e8', -- Light Foreground
     base07 = '#e3e2e8', -- Lightest Foreground
     -- Accent colors
     base08 = '#ffb4ab', -- Variables, XML Tags, Errors
     base09 = '#f5b0ef', -- Integers, Constants
     base0A = '#bec5e5', -- Classes, Search Background
     base0B = '#b3c5ff', -- Strings, Diff Inserted
     base0C = '#f5b0ef', -- Regex, Escape Chars
     base0D = '#b3c5ff', -- Functions, Methods
     base0E = '#bec5e5', -- Keywords, Storage
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
