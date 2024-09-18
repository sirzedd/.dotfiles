vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>")

-- Splitting windows
vim.keymap.set("n", "<leader>h", "<cmd>split<cr>")
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>")

-- Closing vim window with leader key
vim.keymap.set("n", "<leader>q", "<cmd>close<cr>")

-- Shrinking and growing vim windows
-- Need to map this to something that makes sense
--vim.keymap.set("n", "<leader><up>", "<C-w>+")
--vim.keymap.set("n", "<leader><down>", "<C-w>-")
--vim.keymap.set("n", "<leader><left>", "<C-w><")


--automove line when highlighting with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Not sure what this is in normal mode
--vim.keymap.set("n", "J", "mzJ`z")

-- Quick map for end line, beginning line, and bracket
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "J", "%")

--ctrl d and u keep in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--keep cursor in middle for search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- paste without copy into buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank into clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

--goes to next error
--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- substitute visually selected
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file executable with leader x
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--reload source
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("source ~/.config/nvim/init.lua")
end)

--kj acts as escape
vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("i", "KJ", "<ESC>")

vim.keymap.set("n", "gb", "<C-O>")

vim.keymap.set("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return "<cmd>ObsidianFollowLink<CR>"
  else
    return "gf"
  end
end, { noremap = false, expr = true })

vim.keymap.set("n", "<leader><leader>p", ":PasteImage<CR>",{ noremap = true, silent = true })


vim.keymap.set('n', 'gx', function()
  local function open_with_default_program(path) 
    print("Opening: " .. path)
    vim.fn.jobstart({"open", path}, {detach = true})
  end

  local function is_obsidian_link(link)
    print("Checking if it's an Obsidian Link: " .. link)
    return vim.fn.match(link, "^\\[\\[.*\\]\\]$") ~= -1
  end

  local function extract_link_text(link) 
    return vim.fn.matchstr(link, "\\[\\[\\(.*\\)\\]\\]")
  end

  --local url = vim.fn.expand('<cfile>')
  --local url = vim.fn.expand('<cWORD>')

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

--    print("Detected current file dir : " .. current_file_dir)
--    local full_path = vim.fn.fnamemodify(url, ":p") 
--    print("Detected as File Path Link: " .. full_path)
    --local file_path = vim.fn.fnamemodify(url, ":p")
    open_with_default_program(full_path)
  end
end, { noremap = true, silent = true})
