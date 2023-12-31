return {
    s("if", {
        t"if ",
        c(1, {
            i(1, "condition"),
            sn(nil, {
                t"[[ ",
                i(1, "condition"),
                t" ]]",
            })
        }),
        t{"; then", "\t"},
        c(2, {
            i(1),
            sn(nil, fmt([[
            {body1}
            else
                {body2}
            ]], {
                body1 = i(1),
                body2 = i(2)
            }))
        }),
        t{"", "fi"}
    }),

    s({trig = [[\%( \{4\}\| \)\?eif]], hidden = true, regTrig = true, trigEngine = "vim"}, {
        t"elif ",
        c(1, {
            i(1, "condition"),
            sn(nil, {
                t" [[",
                i(1, "condition"),
                t" ]]"
            })
        }),
        t({"; then", "\t"}),
        i(2)
    }),

    s("fn", fmt([[
    function {name}() {{
        {body}
    }}
    ]], {
        name = i(1, "name"),
        body = i(0)
    })),

    s("alias", fmt([[
    alias {name}="{content}"
    ]], {
        name = i(1, "name"),
        content = i(0)
    })),

    s("for", fmt([[
    for {var} in {condition}; do
        {body}
    done
    ]], {
        var = i(1, "i"),
        condition = c(2, {
            i(1,"list"),
            sn(nil, fmt([[$(seq {} {})]], {
                i(1, "start"),
                i(2, "inclusive")
            }))
        }),
        body = i(0)
    })),

    s("var", fmt([[{name}={choice}]], {
        name = c(1, {
            r(1, "varname"),
            sn(nil, {
                t"local ",
                r(1, "varname")
            })
        }),
        choice = c(2, {
            sn(nil, {
                t"$(",
                r(1, "varvalue"),
                t")"
            }),
            sn(nil, {
                t[["]],
                r(1, "varvalue"),
                t[["]],
            })
        })
    }), {
        stored = {
            ["varname"] = i(1, "name"),
            ["varvalue"] = i(1, "value"),
        },
    })
}
