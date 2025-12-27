# ctx-copy.nvim 
Stop playing CodeGuessr - share your code with file location

## Features 
 - Copy code with file context (path:line) to clipboard
 - Customizable path prefix removal for cleaner output

## Default keybinds + example output
 - **Copy context** ~ `<leader>cc`
```
ctx-copy-nvim/README.md:6
```
 - **Copy line with context** ~ `<leader>cl`
```
ctx-copy-nvim/README.md:23
"zlatej/ctx-copy.nvim",
```

## Setup
Lazy:
```lua
return {
	"zlatej/ctx-copy.nvim",
	config = function()
		require("ctx-copy").setup({
            keymap = { -- default keymaps
                cp_context = "<leader>cc"
                cp_line = "<leader>cl", 
            },
            -- Array of path prefixes to strip from absolute file paths
            -- Prefixes are processed sequentially in the order listed
            -- Examples for this config:
                -- /home/user/code/ctx-copy-nvim/README.md -> ctx-copy-nvim/README.md
                -- /home/user/.zshrc -> .zshrc
                -- /home/user2/.zshrc -> /home/user2/.zshrc
            prefixes = {
                vim.fn.expand("~"), -- remove home directory
                "code"
            },
            remove_indent = true
        })
	end,
}
```

## Roadmap 
- [x] Copy only context
- [x] One line copy
- [x] More dynamic path prefix removing
- [ ] Visual selection copy
- [ ] Customize context

