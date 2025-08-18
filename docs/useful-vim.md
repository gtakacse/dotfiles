# Vim notes

## Starting Vim

Open file
`vim file.txt`

Open multiple files in separate buffers
`vim file1.txt file2.txt`

Open files in multiple windows

- Horizontal split
  `vim -o2 file1.txt file2.txt`
- Vertical split
  `vim -O2 file.txt file2.txt`

Open file for editing inside vim
`:edit file.txt`
or
`:e file.txt`
It is integrated with builtin file-explorer, so keep pressing Tab for autocomplete.

Read STDIN into vim
`ls -la | vim -`

**Good to know**
In the `.vimrc` file, the option `set hidden` has to be set to enable changing buffers without saving it.

## Searching files

Find files with `:find` which open the file in a new buffer. It is similar to `:edit` but the search location can be customized.
`:find file1.txt`

It finds the file on `path`. The `path` can be extended with:
`:set path+=app/controllers/`
For recursive sources the `**` wildcard can be used:
`:set path+=app/controllers/**`

Searching inside files
With internal grep:
`:vim /regex_pattern/ file`
`:vim /night-fox/ nvim/**/*.lua`
The command redirects you to the first result. All the results can be seen with the `quickfix` operation: `:copen`.

Quickfix commands
`:copen` "Open quickfix window
`:cclose` "Close quickfix window
`:cnext` "Go to the next error
`:cprevious` "Go to the previous error

The problem with `:vim` that it can be slow as the result are read into memory.

With external grep:
`:grep -R "night-owl" nvim`
It displays all the search results with `quickfix`.

Vim's builtin file explorer is `netrw`. It has methods to explore, create and delete folder and files.

## Spell check

Set spell check and language with `:set spell spelllang=en_us`

`]s` - jump to the next misspelled word
`[s` - jump to the previous misspelled word
`zg` - mark word under cursor as [g]ood
`zw` - mark word under cursor as [w]rong
`z=` - suggest correctly spelled word for word under cursor
