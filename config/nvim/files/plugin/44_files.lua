Config.now(function()
  vim.pack.add({ "https://github.com/pencelheimer/tfm.nvim" })
  vim.keymap.set("n", "\\", "<cmd>Tfm<CR>", { desc = "TFM" })
  vim.g.tfm = { ui = { height = 0.85 } }
end)
