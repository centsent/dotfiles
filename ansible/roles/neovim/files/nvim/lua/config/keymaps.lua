local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_deep_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

local mode_adapters = {
  ["normal"] = "n",
  ["visual"] = "v",
  ["visual_block"] = "x",
  ["insert"] = "i",
  ["operator_pending"] = "o",
}

local keymaps = {
  normal = {
    { "<space>", "/", { desc = "Search forward" } },
    { "<left>", "<nop>", { desc = "Disable left arrow" } },
    { "<right>", "<nop>", { desc = "Disable right arrow" } },
    { "<up>", "<nop>", { desc = "Disable up arrow" } },
    { "<down>", "<nop>", { desc = "Disable down arrow" } },
    { ";", ":", { desc = "Enter command mode" } },
    { "U", "<c-r>", { desc = "Redo" } },
    { "H", "^", { desc = "Go to first non-blank char" } },
    { "L", "$", { desc = "Go to end of line" } },
    { "<c-d>", "<c-d>zz", { desc = "Scroll down half page (center)" } },
    { "<c-u>", "<c-u>zz", { desc = "Scroll up half page (center)" } },
  },
  visual = {
    { "<leader>y", '"+y', { desc = "Yank to system clipboard" } },
    { "<leader>p", '"+p', { desc = "Paste from system clipboard" } },
    { "<leader>x", '"+d', { desc = "Cut to system clipboard" } },
    { "H", "^", { desc = "Go to first non-blank char (visual)" } },
    { "L", "$", { desc = "Go to end of line (visual)" } },
  },
  insert = {
    { "<c-c>", "<esc>", { desc = "Escape insert mode" } },
    -- Navigation using <c-o> (execute one normal mode command)
    { "<c-b>", "<c-o>h", { desc = "Move cursor left" } },
    { "<c-f>", "<c-o>l", { desc = "Move cursor right" } },
    { "<c-n>", "<c-o>j", { desc = "Move cursor down" } },
    { "<c-p>", "<c-o>k", { desc = "Move cursor up" } },
    { "<c-a>", "<c-o>^", { desc = "Move cursor to line start" } },
    { "<c-e>", "<c-o>$", { desc = "Move cursor to line end" } },
    -- Keep undo history cleaner for <c-u>/<c-d>
    { "<c-u>", "<c-\\><c-o><c-u>", { desc = "Delete from cursor to line start" } },
    { "<c-d>", "<c-\\><c-o><c-d>", { desc = "Delete from cursor to line end (?)" } },
  },
  operator_pending = {
    { "H", "^", { desc = "Operator pending to first non-blank char" } },
    { "L", "$", { desc = "Operator pending to end of line" } },
  },
}

local function load_all_keymaps()
  for mode_key, mappings in pairs(keymaps) do
    local mode_short = mode_adapters[mode_key]
    if mode_short then
      for _, mapping_data in ipairs(mappings) do
        local lhs = mapping_data[1]
        local rhs = mapping_data[2]
        local opts = mapping_data[3]
        map(mode_short, lhs, rhs, opts)
      end
    else
      print("Warning: Unknown mode key '" .. mode_key .. "' in keymap definition.")
    end
  end
end

-- Load all the keymaps
load_all_keymaps()
