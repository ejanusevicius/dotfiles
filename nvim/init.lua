local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Load configuration
require("config.keymappings").setup()
require("config.options").setup()
-- Loading "lazy.nvim" only after config
require("lazy").setup("plugins")

require("catppuccin").setup({
  flavour = "mocha",
})

vim.diagnostic.config({
  virtual_text = true,
})

vim.opt.termguicolors = true
require("bufferline").setup({})

require("gitsigns").setup({
  signs = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
})

require("nvim-ts-autotag").setup({
  did_setup = true,
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
    ["html"] = {
      enable_close = true,
    },
    ["tsx"] = {
      enable_close = true,
    },
    ["jsx"] = {
      enable_close = true,
    },
  },
})

require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
  },
})

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end

local lspconfig = require("lspconfig")
lspconfig.tsserver.setup({
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
})

require("telescope").setup({
  defaults = {
    file_ignore_patterns = {
      "node_modules",
    },
  },
})

require("ibl").setup()

require("spectre").setup({
  result_padding = "",
  default = {
    replace = {
      cmd = "sed",
    },
  },
})

local neoscroll = require("neoscroll")
local keymap = {
  ["<C-u>"] = function()
    neoscroll.ctrl_u({ duration = 150 })
  end,
  ["<C-d>"] = function()
    neoscroll.ctrl_d({ duration = 150 })
  end,
}
local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end

-- i/o & buffer changes
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "save file" })
vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", { desc = "exit nvim" })
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "close current buffer (unload from memory)" })
vim.keymap.set("n", "<leader>]", "<cmd>bnext<CR>", { desc = "next buffer" })
vim.keymap.set("n", "<leader>[", "<cmd>bprev<CR>", { desc = "prev buffer" })

-- text editing
vim.keymap.set("n", "<A-o>", "<cmd>OrganizeImports<CR>", { desc = "[TypeScript] OrganizeImports" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-- nvimtree
vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- whichkey
vim.keymap.set({ "n", "v" }, "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

-- global lsp mappings
vim.keymap.set("n", "<leader>lf", vim.diagnostic.open_float, { desc = "lsp floating diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "lsp prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "lsp next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

vim.o.termguicolors = true
vim.cmd([[colorscheme catppuccin]])
vim.cmd("language en_US")

-- nvim-spectre (search & replace)
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre",
})
vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word",
})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file",
})
