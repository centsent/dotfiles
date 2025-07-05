vim.g.mapleader = ","

local function get_options()
  local default_encoding = "utf-8"
  return {
    -- Copy indent from current line when starting a new line
    autoindent = true,
    -- Automatically read changed files
    autoread = true,
    -- Enable auto write
    autowrite = true,
    -- No backup
    backup = false,
    -- Access system's clipboard
    clipboard = "unnamedplus",
    -- Hide * markup for bold and italic, but not markers with substitutions
    conceallevel = 2,
    -- Confirm to save changes before exiting modified buffer
    confirm = true,
    -- Highlight the current line
    cursorline = true,
    -- String-encoding used internally and for |RPC| communication
    encoding = default_encoding,
    -- Convert tabs to spaces
    expandtab = true,
    -- Enable exrc
    exrc = true,
    -- The encoding written to a file
    fileencoding = default_encoding,
    -- Prefer Unix over Windows Over MacOS formats
    fileformats = "unix,dos,mac",
    foldlevel = 99,
    grepformat = "%f%l%c:%m",
    grepprg = "rg --vimgrep",
    -- Case insensitive searching UNLESS /C or capital in search
    ignorecase = true,
    -- Preview incremental substitute
    inccommand = "nosplit",
    linebreak = true,
    jumpoptions = "view",
    list = true,
    -- Show line number
    number = true,
    -- Pop up blend
    pumblend = 10,
    -- Maximum number of entries in a popup
    pumheight = 10,
    -- Relative line numbers
    relativenumber = true,
    -- Show the line and column number of the cursor position
    ruler = false,
    -- Lines of context
    scrolloff = 4,
    -- Round indent
    shiftround = true,
    -- Size of an indent
    shiftwidth = 2,
    -- Do not show mode since we have a statusline
    showmode = false,
    -- Columns of context
    sidescrolloff = 8,
    -- Always show the signcolumn, otherwise it would shift the text each time
    signcolumn = "yes",
    -- A <Tab> in front of a line inserts blanks according to 'shiftwidth'
    smarttab = true,
    -- Override the 'ignorecase' option if the search pattern contains upper case characters
    smartcase = true,
    -- Insert indents automatically
    smartindent = true,
    smoothscroll = true,
    -- Put new windows below current window
    splitbelow = true,
    splitkeep = "screen",
    -- Put new windows right of current window
    splitright = true,
    -- No swapfile
    swapfile = false,
    -- Insert two spaces for a tab
    tabstop = 2,
    -- True color support
    termguicolors = true,
    -- Time to wait for a mapped sequence to complete (in milliseconds)
    timeoutlen = 1000,
    -- Show the window title
    title = true,
    -- Enable persistent undo
    undofile = true,
    undolevels = 10000,
    -- Save swap file and trigger CursorHold
    updatetime = 200,
    -- Allow cursor to move where there is no text in visual block mode
    virtualedit = "block",
    -- Command-line completion mode
    wildmode = "longest:full,full",
    -- Minimum window width
    winminwidth = 5,
    -- Display lines as one long line
    wrap = false,
    -- Do not make a backup before overwriting a file
    writebackup = false,
  }
end

local function setup_options(opts)
  for option, value in pairs(opts) do
    vim.o[option] = value
  end
end

setup_options(get_options())
