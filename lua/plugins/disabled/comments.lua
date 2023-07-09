return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            padding = true, -- spaces when adding brackets
            sticky = true, -- cursor stays
            ignore = nil, -- what to ignore when (un)commenting
            ---LHS of toggle mappings in NORMAL mode
            toggler = {
                line = "gcc", -- Line-comment keybind
                block = "gbc", -- Block-comment keybind
            },
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                line = "gc", -- Line-comment keybind
                block = "gb", -- Block-comment keybind
            },
            ---LHS of extra mappings
            extra = {
                above = "gcO", -- add comment above current line
                below = "gco", -- add comment below current line
                eol = "gcA", -- add comment at the end of current line
            },
            ---Enable keybindings
            mappings = {
                basic = true, -- enable basic keybinds
                extra = true, -- enable extra keybinds
            },
            ---Function to call before (un)comment
            pre_hook = nil,
            ---Function to call after (un)comment
            post_hook = nil,
        })
    end,
}
