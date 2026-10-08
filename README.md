# ctx-copy.nvim

stop playing CodeGuessr - share your code with file location

## features

- copy code with file context (path:line) to clipboard
- customizable path prefix removal for cleaner output

## default keybinds + example output

- **copy context** ~ `<leader>cc`

```
ctx-copy-nvim/README.md:6
```

- **copy line with context** ~ `<leader>cl`

```
ctx-copy-nvim/README.md:23
"zlatej/ctx-copy.nvim",
```

## setup

lazy:

```lua
return {
	"zlatej/ctx-copy.nvim",
	config = function()
		require("ctx-copy").setup({
            keymap = { -- default keymaps
                cp_context = "<leader>cc"
                cp_line = "<leader>cl",
            },
            -- array of path prefixes to strip from absolute file paths
            -- prefixes are processed sequentially in the order listed
            -- examples for this config:
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

## roadmap

- [x] copy only context
- [x] one line copy
- [x] more dynamic path prefix removing
- [ ] visual selection copy
- [ ] customize context
