local ls = require("luasnip")
local gen = require("cathy.sniper")
local utils = require("cathy.sniper.utils")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local tsp = require("luasnip.extras.treesitter_postfix")
local fmt = require("luasnip.extras.fmt").fmt

local expr_query = [[
[
    (struct_expression)
    (call_expression)
    (identifier)
    (field_expression)
    (integer_literal)
    (string_literal)
] @prefix
]]

local expr_node_types = {
    ["struct_expression"] = true,
    ["call_expression"] = true,
    ["identifier"] = true,
    ["field_expression"] = true,
    ["integer_literal"] = true,
    ["string_literal"] = true,
}

local expr_or_type_query = [[
[
    (struct_expression)
    (call_expression)
    (identifier)
    (field_expression)
    (integer_literal)
    (string_literal)

    (type_identifier)
    (primitive_type)
    (generic_type)
    (scoped_type_identifier)
    (reference_type)
] @prefix
]]

local expr_or_type_tsp = gen.one_or_other(expr_or_type_query, expr_node_types)

local function new_expr_or_type_tsp(trig, typename)
    local expr_callback = function(match)
        return utils.replace_all(match, typename .. "::new(%s)")
    end
    local type_callback = function(match)
        return utils.replace_all(match, typename .. "<%s>")
    end
    return expr_or_type_tsp(trig, typename, expr_callback, type_callback)
end

local expr_surround = gen.expr_surround_gen({
    query = expr_query,
    query_lang = "rust"
})

return {
    gen.begin_line_snip("pc ", { t"pub(crate) " }),
    gen.begin_line_snip("ps ", { t"pub(super) " }),
    gen.begin_line_snip("#ii", { t"#[inline]" }),
    gen.begin_line_snip("#ia", { t"#[inline(always)]" }),
    gen.begin_line_snip("#tc", { t"#[cfg(test)]" }),
    gen.begin_line_snip("#tt", { t"#[test]" }),
    gen.begin_line_snip("#d", fmt("#[derive({})]", { i(1) })),
    gen.begin_line_snip("##", fmt("#[{}]", i(1))),
    new_expr_or_type_tsp(".rc", "Rc"),
    new_expr_or_type_tsp(".arc", "Arc"),
    new_expr_or_type_tsp(".box", "Box"),
    new_expr_or_type_tsp(".mu", "Mutex"),
    new_expr_or_type_tsp(".rw", "RwLock"),
    new_expr_or_type_tsp(".cell", "Cell"),
    new_expr_or_type_tsp(".refcell", "RefCell"),
    new_expr_or_type_tsp(".vec", "Vec"),
    expr_surround(".print", [[println!("{:?}", %s)]]),
    expr_surround(".dbg", [[dbg!(%s)]]),
    expr_or_type_tsp(
        ".ok",
        "Ok(?)",
        utils.simple_replace_callback("Ok(%s)"),
        utils.simple_replace_callback("Result<%s, ()>")
    ),
    expr_or_type_tsp(
        ".err",
        "Err(?)",
        utils.simple_replace_callback("Err(%s)"),
        utils.simple_replace_callback("Result<(), %s>")
    ),
    expr_or_type_tsp(
        ".some",
        "Some(?)",
        utils.simple_replace_callback("Some(%s)"),
        utils.simple_replace_callback("Option<%s>")
    ),

    s({ trig = "fn ", snippetType = "autosnippet", wordTrig = true }, fmt([[
    fn {funame}({arg}){arrow}{retype} {{
        {body}
    }}
    ]], {
        funame = i(1, "name"),
        arg = i(2),
        retype = i(3),
        arrow = f(function(args)
            if args and args[1] and args[1][1] ~= "" then
                return " -> "
            else
                return ""
            end
        end, { 3 }),
        body = i(0, "unimplemented!();")
    })),

    s("test", fmt([[
    #[test]
    fn {funame}() {{
        {body}
    }}
    ]], {
        funame = i(1, "name"),
        body = i(0, "unimplemented!();")
    })),

    s("p", fmt([[println!({});]], {i(0)})),

}
