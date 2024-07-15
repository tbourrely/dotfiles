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
