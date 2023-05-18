return {
    "nvim-orgmode/orgmode",
    config = function()
        require("orgmode").setup_ts_grammar()
        require("orgmode").setup({
            org_agenda_files = { "~/Documents/org/agenda/school.org", "~/Documents/org/agenda/personal.org" },
            org_default_notes_file = "~/Documents/org/todo.org",
        })
    end,
}
