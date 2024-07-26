-- is called manually
return function(pperfomance)
  local tlscp = require('telescope')
  local actions = require('telescope.actions')
  -- Fix  the map  to close  with ESC
  tlscp.setup({
    defaults = {
      mappings = {
        i = {
          ['<ESC>'] = actions.close,
        },
      },
    },
  })
  if pperfomance == 'fzf-native' then
    tlscp.load_extension('fzf')
  end
end
