local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
    return
end

local status = require("nvim-spotify").status

status:start()

lualine.setup({
    options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_x = {
            status.listen
        }
    }
})
