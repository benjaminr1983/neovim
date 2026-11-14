local servers = {
	gopls = {},
	bashls = {},
	pyright = {},
	rust_analyzer = {},
	ts_ls = {},
	html = { filetypes = { 'html', 'twig', 'hbs' } },
	lua_ls = {
		settings = {
			Lua = {
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
				diagnostics = { disable = { 'missing-fields' } },
			},
		},
	},
}
local wk = require("which-key")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
		vim.lsp.buf.code_action({ 
			context = { only = { 'quickfix', 'refactor', 'source' } }, 
		})
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
	
	vim.api.nvim_buf_create_user_command('bufnr', "Format", function()
		vim.lsp.buf.format()
	end, { desc = 'Format current Buffer with LSP' })
end
wk.add({
	{ "<leader>r", group = "[R]ename" },
	{ "<leader>w", group = "[W]orkspace" },
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>t", group = "[T]oggle" },
	{ "<leader>h", group = "Git [H]unk" },
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>g", group = "[G]it" },
	{ "<leader>d", group = "[D]ocument" },
})

wk.add({
	['<leader>'] = { name = 'VISUAL <leader>' },
	['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

require("mason").setup()
require("neodev").setup()

mason_lspconfig.setup ({
	ensure_installed = vim.tbl_keys(servers),
	handlers = {
		function (server_name)
			require("lspconfig")[server_name].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = servers[server_name].settings or {},
				filetypes = servers[server_name].filetypes,
			})
		end,
	},
})
