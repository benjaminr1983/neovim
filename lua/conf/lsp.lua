local servers = {
--	clangd = {},
	gopls = {},
	pyright = {},
	rust_analyzer = {},
	tsserver = {},
	html = { filetypes = { 'html', 'twig', 'hbs' } },
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = { disable = { 'missing-fields' } },
		},
	},
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
local mason_lspconfig = require "mason-lspconfig"
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end
		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end
	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', function()
		vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
	end, '[C]ode [A]ction')
	nmap('gd', require("telescope.builtin").lsp_definitions, '[G]oto [D]efinition')
	nmap('gr', require("telescope.builtin").lsp_references, '[G]oto [R]eferences')
	nmap('gI', require("telescope.builtin").lsp_implementations, '[G]oto [I]mplementation')
	nmap('<leader>D', require("telescope.builtin").lsp_type_definitions, 'Type [D]efinition')
	nmap('<leader>ds', require("telescope.builtin").lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require("telescope.builtin").lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')
	vim.api.nvim_buf_create_user_command('bufnr', 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current Buffer with LSP' })
end
require("which-key").register {
	['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
	['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
	['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
	['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
	['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
	['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
	['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
	['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
require("which-key").register({
	['<leader>'] = { name = 'VISUAL <leader>' },
	['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })
require("mason").setup()
require("mason-lspconfig").setup()
require("neodev").setup()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}
mason_lspconfig.setup {
	function(server_name)
		require("lspconfig")[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name]).filetypes,
		}
	end,
}
