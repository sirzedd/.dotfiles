local builtin = require('telescope.builtin')
local default_opts = {noremap = true}

require('telescope').setup{
  pickers = {
    --Allow hidden for grep
    live_grep = {
      additional_args = function(opts)
        return {"--hidden", "--smart-case"}
      end
    }
  }
}


vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
--vim.keymap.set('n', '<C-p>', builtin.git_files, {})
--Default ctrl+p lookup, it doesn't look for . hidden files
--vim.keymap.set('n', '<C-p>', builtin.find_files, {})
--
-- Finds hidden files
vim.keymap.set('n', '<C-p>', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)


 vim.keymap.set('n', '<C-g>', builtin.live_grep, {})

--vim.keymap.set('n', '<leader>ps', function()
--	builtin.grep_string({ search = vim.fn.input("Grep > ") })
--end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})


