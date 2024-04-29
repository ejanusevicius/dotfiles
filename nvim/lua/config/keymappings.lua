local map = vim.keymap.set

function setup()
-- windows
  map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
  map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
  map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
  map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- i/o
  map("n", "<C-s>", "<cmd>w<CR>", { desc = "save file" })
  map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

end

return {
  setup = setup
}
