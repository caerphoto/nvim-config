Just the bare bones of my Neovim setup.

Will need to run `:PlugInstall` after opening nvim, then restart, then run `:TSUpdate`.

After that, `:TSInstall <language>` for whatever languages you need. If the language isn't available
for treesitter, you can add it to the `additional_vim_regex_highlighting` list on line 262, to fall
back to normal vim highlighting.
