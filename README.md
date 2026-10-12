# ctx-copy.nvim

stop playing CodeGuessr - share your code with file location

## features

- copy code with file context (path:line) to clipboard
- copy a visual selection (charwise, linewise or blockwise)
- customizable path prefix removal for cleaner output

## requirements

- Neovim 0.11+

## default keybinds + example output

- **copy context** ~ `<leader>cc`

```
ctx-copy.nvim/README.md:20
```

- **copy line with context** ~ `<leader>cl`

```
ctx-copy.nvim/README.md:48
"zlatej/ctx-copy.nvim",
```

- **copy visual selection with context** ~ `<leader>cc` in visual mode

```
ctx-copy.nvim/README.md:63
prefixes = {
    vim.fn.expand("~"), -- remove home directory
    "code"
},
```

the line number is the first line of the selection.
with `remove_indent`, the indentation shared by all selected lines is stripped and relative indentation is kept.

## setup

lazy:

```lua
return {
	"zlatej/ctx-copy.nvim",
	config = function()
		require("ctx-copy").setup({
            keymap = { -- default keymaps
                cp_context = "<leader>cc",
                cp_line = "<leader>cl",
                cp_visual = "<leader>cc", -- visual mode
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
            -- strip leading whitespace from a copied line, and the shared
            -- indentation from a copied selection
            remove_indent = true
        })
	end,
}
```

## roadmap

- [x] copy only context
- [x] one line copy
- [x] more dynamic path prefix removing
- [x] visual selection copy
- [ ] customize context
