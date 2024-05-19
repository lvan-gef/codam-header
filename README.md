# Codam Header Plugin

This is a Neovim plugin that helps you manage file headers in various programming languages. The plugin inserts and updates headers with metadata such as the filename, author, and date.

## Features

- **Automatic Header Insertion**: Automatically insert a predefined header template at the beginning of your files.
- **Automatic Header Update**: Update the header with the current date and other details when the file is modified.
- **Supports Multiple Languages**: Handles comment styles for various programming languages.

## Installation

You can install this plugin using your preferred plugin manager.

## Configuration

You can configure the plugin by calling the setup function with your preferred options. Available options are:

- author: The author's name.
- email: The author's email.

require('codam-header').setup({
  author = 'Your Name',
  email = 'your.email@example.com'
})

## Usage
The plugin provides two main functions: insert and update.

Insert Header
This function inserts the header into the current buffer if it is not already present.
require('codam-header').insert()

Update Header
This function updates the header with the current date and other details if it is already present in the buffer.
require('codam-header').update()
