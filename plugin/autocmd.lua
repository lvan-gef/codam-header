vim.api.nvim_create_user_command("headerInsert", function()
  require("codam-header").insert()
end, {})

vim.api.nvim_create_user_command("headerUpdate", function()
  require("codam-header").update()
end, {})
