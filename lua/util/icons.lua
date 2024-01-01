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

function M:new(opts)
    opts = opts or {}
    local obj = {}
    setmetatable(obj, self)
    obj.icons = {}
    for k, v in pairs(M.icons) do
        if not k:match("Alt$") and not k:match("Alt%d+$") then
            if opts.alts and opts.alts[k] then
                obj.icons[k] = M.icons[opts.alts[k]]
            else
                obj.icons[k] = v
            end
        end
    end
    return obj
end

return M
