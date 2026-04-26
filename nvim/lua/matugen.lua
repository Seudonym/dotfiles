 local M = {}

 function M.setup()
   require('base16-colorscheme').setup {
     -- Background tones
     base00 = '#111418', -- Default Background
     base01 = '#1d2024', -- Lighter Background (status bars)
     base02 = '#272a2e', -- Selection Background
     base03 = '#8b919b', -- Comments, Invisibles
     -- Foreground tones
     base04 = '#c1c7d1', -- Dark Foreground (status bars)
     base05 = '#e1e2e8', -- Default Foreground
     base06 = '#e1e2e8', -- Light Foreground
     base07 = '#e1e2e8', -- Lightest Foreground
     -- Accent colors
     base08 = '#ffb4ab', -- Variables, XML Tags, Errors
     base09 = '#eeb1ff', -- Integers, Constants
     base0A = '#b3c8e6', -- Classes, Search Background
     base0B = '#9fcaff', -- Strings, Diff Inserted
     base0C = '#eeb1ff', -- Regex, Escape Chars
     base0D = '#9fcaff', -- Functions, Methods
     base0E = '#b3c8e6', -- Keywords, Storage
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
