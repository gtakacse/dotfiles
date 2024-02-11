# Starting Vim

Open file
`vim file.txt`

Open multiple files in separate buffers
`vim file1.txt file2.txt`

Open files in multiple windows
- Horizontal split
`vim -o2 file1.txt file2.txt`
- Vertical split
`vim -O2 file.txt file2.txt`

Read STDIN into vim
`ls -la | vim -`
