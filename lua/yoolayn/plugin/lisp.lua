require("mini.deps").add("julienvincent/nvim-paredit")

require("mini.deps").later(function()
    require("nvim-paredit").setup()
end)
