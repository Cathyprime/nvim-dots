local npairs    = require"nvim-autopairs"
local Rule      = require"nvim-autopairs.rule"
local cond      = require"nvim-autopairs.conds"

local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" }, { "<", ">" }, { "'", "'" }, { '"', '"' }, { "`", "`" } }
npairs.add_rules {
    -- Rule for a pair with left-side ' ' and right side ' '
    Rule(' ', ' ')
    -- Pair will only occur if the conditional function returns true
    :with_pair(function(opts)
        -- We are checking if we are inserting a space in (), [], or {}
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2],
            brackets[4][1] .. brackets[4][2]
        }, pair)
    end)
    :with_move(cond.none())
    :with_cr(cond.none())
    -- We only want to delete the pair of spaces when the cursor is as such: ( | )
    :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local context = opts.line:sub(col - 1, col + 2)
        return vim.tbl_contains({
            brackets[1][1] .. "  " .. brackets[1][2],
            brackets[2][1] .. "  " .. brackets[2][2],
            brackets[3][1] .. "  " .. brackets[3][2],
            brackets[4][1] .. "  " .. brackets[4][2],
        }, context)
    end)
}

for _, bracket in pairs(brackets) do
    npairs.add_rules {
        Rule(bracket[1], bracket[2])
        :with_pair(cond.none())
        :with_del(function() return true end)
        :with_cr(cond.none())
    }
end
