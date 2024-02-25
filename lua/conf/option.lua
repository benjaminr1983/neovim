--DATASTRUCTURE
--OPTIONS
local option = {
    --GENERAL
	fileencoding = "utf-8",                 --encoding
	clipboard =  'unnamedplus',             --clipboard
	completeopt  = 'menuone,noselect',      --completion
	number  =  true,                        --numbering
	relativenumber = false,                 --relative numbering
	numberwidth = 4,                        --width
	mouse  = 'a',                           --mouse
	scrolloff = 5,                          --cursor space
	sidescrolloff = 5,                      --cursor space
	breakindent  = true,                    --indentation
	smartindent = true,                     --indentation
	pumheight = 10,                         --max height of windows
	showtabline = 1,                        --tabline options
	expandtab = true,                       --tabsettings
	shiftwidth = 2,                         --tabsettings
	tabstop = 2,                            --tabsettings
	splitbelow = true,                      --force split below
	splitright = true,                      --force split right
	swapfile = false,                       --no swapfile
	updatetime  =  250,                     --speed options
	timeoutlen = 300,                       --speedoptions
	wrap = false,                           --nowrap
	linebreak = true,                       --wrapping
	termguicolors  =  true,                 --coloring
	backup = false,				            --backup
	writebackup = false,			        --block files
	undofile = true,			            --undo
    --SEARCH
	cursorline = true,                      --show cursorline
	hlsearch = false,                       --highlighting
	ignorecase  =  true,                    --case sensitivity
	smartcase =  true,                      --case sensitivity
	signcolumn  =  'yes',                   --highlights columns
	cmdheight = 2,                          --command size
	conceallevel = 0,                       --hiding
}

for k,v in pairs(option)
	do
		vim.opt[k] = v
end

vim.opt.shortmess:append "c"
vim.opt.iskeyword:append "-"
vim.opt.formatoptions:remove({ "c", "r", "o" })
