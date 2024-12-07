return {
	"epwalsh/obsidian.nvim",
	version = "*",  -- recommended, use latest release instead of latest commit
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local enable_obsidian = os.getenv("ENABLE_OBSIDIAN")
		if enable_obsidian == "true" then
			require("obsidian").setup({
				workspaces = {
					{
						name = "work",
						path = "~/Nextcloud/vaults/work",
					},
				},
				notes_subdir = "notes",
				daily_notes = {
					folder = "notes/dailies",
					date_format = "%Y-%m-%d",
					alias_format = "%B %-d, %Y",
					default_tags = { "daily-notes" },
					template = nil
				},
			})
		end
	end
}
