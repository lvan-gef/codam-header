# codam-header
A neovim plugin for inserting and updating the Codam header.
It is my first neovim plugin (and also lua) that can insert and update the Codam header in to your buffer.

# Install
You can add it to your config via your plugin manager.
Example for Lazy:
  {"lvan-gef/codam-header",
    opts = {
      author = "intra_name",
      email = "college email}
  },

# How to use it
The plugin hase 2 function, 'insert' and 'update'.
Insert:
  Will insert the header at the top of your file
Update:
  Will update the filename field and the update by field

You can add those function to any keymap or autocmd
