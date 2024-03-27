return {
  'folke/which-key.nvim',
  opts = {},
  config = function()
    local wk = require('which-key')
    wk.register({
      D = {
        name = '[D]ebug...'
      },
      g = { name = '[G]it...' },
      l = { name = '[L]sp...' },
      L = { name = '[L]azy...' },
      p = { name = '[P]roject...' },
      w = { name = '[W]iki...' },
      s = { name = '[S]earch...' },
      r = { name = '[R]efactor...' }
    }, { prefix = '<leader>' })

    wk.register({
      m = { name = '[M]arkdown...'},
      r = { name = '[R]efactor...'}
    }, { prefix = '<leader>', mode = 'v' })
  end
}
