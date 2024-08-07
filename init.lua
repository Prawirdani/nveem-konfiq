-- Lazy Package Manager
vim.o.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "typescriptreact",
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
	end,
})

-- Set clipboard to system clipboard, require xclip and maybe wl-clipboard
vim.opt.clipboard:append("unnamedplus")

require("vim-options")
require("lazy").setup("plugins")
