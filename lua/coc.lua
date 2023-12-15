



local function check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

--vim.g.copilot_tab_fallback = function()
        
--    if vim.fn['coc#pum#visible']() == 1 then
--        print("returns")
--        return vim.fn['coc#pum#next'](1)
--    else
--        return "\t"
--    end
--    if check_back_space() then
--        return vim.fn['coc#refresh']()
--    end
--    return "<Tab>"
--
--end

vim.keymap.set("i", "<C-L>", "copilot#Accept()", opts)

vim.keymap.set("i", "<Tab>", function()

    if vim.fn['coc#pum#visible']() == 1 then
        print("returns")
        return vim.fn['coc#pum#next'](1)
    else
        return "\t"
    end
    if check_back_space() then
        return vim.fn['coc#refresh']()
    end
    return "<Tab>"
end, opts)

vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn['coc#pum#visible']() == 1 then
            return vim.fn['coc#pum#prev'](1)
        end
        return "<S-Tab>"
end, opts)

vim.keymap.set("i", "<CR>", function()
        if vim.fn['coc#pum#visible']() == 1 then
            return vim.fn['coc#pum#confirm']();
        end
       return "\r"
end, opts)


