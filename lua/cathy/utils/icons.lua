local M = {}

M.icons = {
    Array = "",
    Boolean = "",
    Broadcast = "",
    Class = "󰠱",
    ClassAlt = "",
    Color = "󰏘",
    ColorAlt = "",
    Constant = "",
    ConstantAlt = "󰏿",
    Constructor = "",
    Copilot = "",
    Directory = "󰉓",
    Enum = "",
    EnumAlt = "",
    EnumMember = "",
    EnumMemberAlt = "",
    Error = "",
    Event = "",
    EventAlt = "",
    Field = "",
    FieldAlt = "󰜢",
    File = "",
    FileAlt = "󰈙",
    FileAlt2 = "󰈚",
    Folder = "",
    FolderAlt = "󰉋",
    Function = "",
    FunctionAlt = "󰊕",
    Git = "󰊢",
    Hint = "󰍉",
    Info = "",
    Interface = "",
    InterfaceAlt = "",
    Key = "",
    Keyword = "󰌋",
    KeywordAlt = "",
    Method = "",
    MethodAlt = "󰆧",
    Module = "",
    Namespace = "",
    Null = "",
    Number = "",
    Object = "",
    Operator = "",
    OperatorAlt = "󰆕",
    Package = "",
    Property = "",
    PropertyAlt = "󰜢",
    Reference = "",
    ReferenceAlt = "󰈇",
    Snippet = "",
    SnippetAlt = "",
    String = "",
    Struct = "󰙅",
    StructAlt = "",
    Text = "󰊄",
    TextAlt = "󰉿",
    TextAlt2 = "",
    TypeParameter = "",
    Unit = "",
    UnitAlt = "󰑭",
    Unknown = "",
    Value = "󰎠",
    Variable = "",
    VariableAlt = "󰀫",
    Warning = "",
    Web = "󰖟",
}

function M.new(opts)
    opts = opts or {}
    local obj = {}
    if not opts.alts then
        obj.icons = vim.iter(M.icons):filter(function(key)
            return not key:match("Alt$") and not key:match("Alt$d+$")
        end)
        :totable()
    else
        obj.icons = vim.iter(M.icons):filter(function(key)
            return not key:match("Alt$") and not key:match("Alt$d+$")
        end)
            :fold({}, function(acc, key, value)
            if opts.alts[key] then
                acc[key] = M.icons[opts.alts[key]]
            else
                acc[key] = value
            end
            return acc
        end)
    end
    return obj
end

return M
