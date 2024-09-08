local text = require("cathy.track.text")
-- local color = require("track.color")

return {
    add_label = text.mark,
    clear_labels = text.clear,
    edit_label = text.edit,
    remove_label = text.unmark,
    toggle_label = text.toggle,
    search_labels = text.search,
}
