-- lua/config/keymaps.lua
--vim.g.mapleader = " "  -- Leader key: Space
--vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Basic
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- Clipboard (already synced via options, but explicit if needed)
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })


--kj acts as escape
map("i", "jj", "<ESC>")
map("i", "JJ", "<ESC>")

--Go back and go Forward
map("n", "gb", "<C-O>")
map("n", "gf", "<C-I>")

--go to definition
map('n', 'gd', vim.lsp.buf.definition, { silent = true })


-- Paste Image using plugin, plugin defines it so not sure if I need it
--map("n", "<leader><leader>p", ":PasteImage<CR>", { noremap = true, silent = true })
--
----- GX go to under cursor, either open with obsidian, link or path
---try to be smart about it
map('n', 'gx', function()
  local function open_with_default_program(path)
    print("Opening: " .. path)
    vim.fn.jobstart({ "open", path }, { detach = true })
  end

  local function is_obsidian_link(link)
    print("Checking if it's an Obsidian Link: " .. link)
    return vim.fn.match(link, "^\\[\\[.*\\]\\]$") ~= -1
  end

  local function extract_link_text(link)
    return vim.fn.matchstr(link, "\\[\\[\\(.*\\)\\]\\]")
  end


  local line = vim.fn.getline('.')
  local cursor_pos = vim.fn.col('.')


  local after_cursor = line:sub(cursor_pos)

  local before_cursor = line:sub(1, cursor_pos - 1)
  local start_bracket = before_cursor:find('%[%[')
  local end_bracket = after_cursor:find('%]%]')

  local link
  if start_bracket and end_bracket then
    link = before_cursor:sub(start_bracket) .. after_cursor:sub(1, end_bracket + 1)
  else
    link = vim.fn.expand('<cfile>')
  end


  local url = vim.fn.trim(link)

  print("URL under cursor: " .. url)

  if is_obsidian_link(url) then
    local link_text = extract_link_text(url)
    print("Detected as Obsidian Link: " .. link_text)
    vim.cmd('ObsidianFollowLink')
  elseif vim.fn.match(url, "^[a-zA-Z]+://") ~= -1 then
    print("Detected as URL Link")
    open_with_default_program(url)
  else
    print("Detected as File Path Link")
    local current_file_dir = vim.fn.expand('%:p:h')


    local full_path
    if url:sub(1, 1) == '.' then
      full_path = vim.fn.resolve(current_file_dir .. '/' .. url)
    else
      full_path = vim.fn.resolve(link)
    end

    open_with_default_program(full_path)
  end
end, { noremap = true, silent = true })
