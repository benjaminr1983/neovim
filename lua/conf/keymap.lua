--MODES
-- "n" -> Normal Mode
-- "i" -> Insert Mode
-- "v" -> Visual Mode
-- "t" -> Terminal Mode
-- "c" -> Command Mode
-- "x" -> Visual Block Mode
--DATASTRUCTURE
local function telescope_live_grep_open_files()
	require('telescope.builtin').live_grep {
		grep_open_files = true,
		prompt_title = 'Live Grep in Open Files',
	}
end
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
vim.opt.rtp:prepend(lazypath)
--GENERAL
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true } )						--leaderkey
--shared keymaps
vim.keymap.set({ 'n', 'v' }, '<leader>u',':undo<CR>' , { noremap = true, silent = true })			--undo
vim.keymap.set({ 'n', 'v' }, '<S-l>', ':bnext<CR>', { noremap = true, silent = true })				--movement
vim.keymap.set({ 'n', 'v' }, '<S-h>', ':bprevious<CR>', { noremap = true, silent = true })			--movement
--normal mode
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })				--nowrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })				--nowrap
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })		--diagnostics
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })			--diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })	--diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })			--diagnostics
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { noremap = true, silent = true })				--sizing
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { noremap = true, silent = true })				--sizing
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })			--sizing
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })			--sizing
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true })					--move text
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true })					--move text
--visual mode
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })				--move text
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })				--move text
vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true })						--move text
--visual block mode
vim.keymap.set('n', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })				--move text
vim.keymap.set('n', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })				--move text
--SPECIAL
--telescope.builtin
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })
--vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd',require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr',require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
