local colorschemes = {
	"kanagawa",
	"tokyonight",
	"catppuccin",
	"gruvbox",
	"nord",
	"nightfox",
	"dracula",
	"rose-pine",
	"onedark",
	"cyberdream",
	"material",
	"github_dark",
	"everforest",
	"monokai-pro",
	"solarized-osaka",
}

math.randomseed(os.time())
local initial_scheme = colorschemes[math.random(#colorschemes)]

local function switch_colorscheme()
	local random_index = math.random(#colorschemes)
	local random_scheme = colorschemes[random_index]
	vim.cmd("colorscheme " .. random_scheme)
	vim.notify("Colorscheme switched to: " .. random_scheme, vim.log.levels.INFO)
end

-- Add keymap to change colorscheme manually
vim.keymap.set("n", "<leader>uR", switch_colorscheme, { desc = "Random Colorscheme" })

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local uv = vim.uv or vim.loop
		local timer = uv.new_timer()
		-- 600,000 milliseconds = 10 minutes
		timer:start(600000, 600000, vim.schedule_wrap(switch_colorscheme))
	end,
})

return {
	{ "rebelot/kanagawa.nvim" },
	{ "folke/tokyonight.nvim" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "ellisonleao/gruvbox.nvim" },
	{ "shaunsingh/nord.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "Mofiqul/dracula.nvim" },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "navarasu/onedark.nvim" },
	{ "scottmckendry/cyberdream.nvim" },
	{ "marko-cerovac/material.nvim" },
	{ "projekt0n/github-nvim-theme" },
	{ "neanias/everforest-nvim" },
	{ "loctvl842/monokai-pro.nvim" },
	{ "craftzdog/solarized-osaka.nvim" },
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = initial_scheme,
		},
	},
}
