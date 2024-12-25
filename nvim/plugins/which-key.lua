require('which-key').setup()
require('which-key').add {
    { '<leader>s', group = '[S]earch' },
    { '<leader>e', group = '[E]rrors' },
    { '<leader>r', group = '[R]efactor' },
}
