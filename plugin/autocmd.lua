vim.api.nvim_create_user_command("HeaderInsert", function()
  require("codam-header").insert()
end, {})

vim.api.nvim_create_user_command("HeaderUpdate", function()
  require("codam-header").update()
end, {})
