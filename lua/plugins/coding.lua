return {
  -- Autopairing
  {
    'echasnovski/mini.pairs',
    version = false,
    -- keys = {
    --   {"(",mode="i"},
    --   {")",mode="i"},
    --   {"{",mode="i"},
    --   {"}",mode="i"},
    --   {"[",mode="i"},
    --   {"]",mode="i"},
    --   {"'",mode="i"},
    --   {"`",mode="i"},
    --   {'"',mode="i"},
    -- },
    lazy = false,
    config = function()
      require('plugins.configs.minipairs')()
    end,
  },
}
