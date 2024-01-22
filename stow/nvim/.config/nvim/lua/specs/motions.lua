return {
    {
        'tpope/vim-unimpaired',
        config = function()
            vim.keymap.set({ 'n', 'o', 'x' }, '(', '[', { remap = true })
            vim.keymap.set({ 'n', 'o', 'x' }, ')', ']', { remap = true })
        end
    },
    'tpope/vim-surround',
    'tpope/vim-commentary',
    {
        'echasnovski/mini.operators',
        config = function()
            require('mini.operators').setup()
        end
    },
}
