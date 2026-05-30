# Neovim Config

A documented Neovim configuration focused on modern web, Go, Rust, Python, and Lua development.

This config uses **packer.nvim** as the plugin manager and the modern **Neovim 0.11+ native LSP API** (`vim.lsp.config` / `vim.lsp.enable`).

## Features

- JavaScript, TypeScript, React, JSX, and TSX LSP support
- Tailwind CSS IntelliSense for `class`, `className`, `clsx()`, `cx()`, `cva()`, and ``tw`...` `` patterns
- Go support through `gopls`
- Rust support through `rust_analyzer`
- Python support through `pyright`
- Lua support through `lua_ls`
- HTML and CSS language servers
- Format-on-save for:
  - JS / TS / JSX / TSX
  - Rust
  - Go
  - Python
  - Lua
  - HTML
  - CSS
- Manual formatting through `<leader>f` or `:Format`
- Autocomplete with `nvim-cmp`
- Snippets with `LuaSnip` and `friendly-snippets`
- Treesitter syntax highlighting
- Telescope fuzzy finding
- nvim-tree file explorer
- Catppuccin theme

## Requirements

Install the basics first. Use the command for your distro.

```bash
# Arch Linux / EndeavourOS / Manjaro
sudo pacman -Syu
sudo pacman -S --needed git curl unzip ripgrep fd base-devel nodejs npm python python-pip go go-tools gopls rustup rust-analyzer clang lua-language-server stylua python-black python-isort neovim

# If this is your first Rust setup on Arch:
rustup toolchain install stable
rustup default stable
rustup component add rustfmt

# Debian/Ubuntu
sudo apt update
sudo apt install -y git curl unzip ripgrep fd-find build-essential nodejs npm python3 python3-pip golang-go rustup clangd lua-language-server neovim
```

Install **Neovim 0.11.3 or newer**. If your distro package is older, use your distro's latest channel, AppImage, Homebrew, Bob, Mise, or another version manager.

Verify:

```bash
nvim --version
```

## Installation

Back up your old config:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

Copy or clone this config into `~/.config/nvim`:

```bash
git clone https://github.com/utshomh/neovim-config.git ~/.config/nvim
```

Open Neovim:

```bash
nvim
```

Install plugins:

```vim
:PackerSync
```

Close and reopen Neovim after plugin installation completes.

## Language servers

`mason-lspconfig` is configured to ensure these language servers are installed:

| Area | LSP server | Executable |
|---|---|---|
| JavaScript / TypeScript / React | `ts_ls` | `typescript-language-server` |
| Tailwind CSS IntelliSense | `tailwindcss` | `tailwindcss-language-server` |
| Go | `gopls` | `gopls` |
| Rust | `rust_analyzer` | `rust-analyzer` |
| Python | `pyright` | `pyright-langserver` |
| Lua | `lua_ls` | `lua-language-server` |
| HTML | `html` | `vscode-html-language-server` |
| CSS / SCSS / Less | `cssls` | `vscode-css-language-server` |
| C / C++ | `clangd` | `clangd` |

You can inspect or install LSPs from inside Neovim with:

```vim
:Mason
:LspInfo
:checkhealth vim.lsp
```

## Format-on-save

Formatting is powered by `stevearc/conform.nvim`.

| Filetype | Formatter chain |
|---|---|
| `javascript`, `javascriptreact`, `typescript`, `typescriptreact` | `prettierd` or `prettier` |
| `html`, `css` | `prettierd` or `prettier` |
| `go` | `goimports`, then `gofmt` |
| `rust` | `rustfmt` |
| `python` | `isort`, then `black` |
| `lua` | `stylua` |

Format-on-save only runs for the filetypes listed above. Other filetypes are left untouched unless you manually format them.

Useful commands:

```vim
:Format          " format current buffer
:FormatDisable   " disable format-on-save for the current buffer
:FormatDisable!  " disable format-on-save globally for this Neovim session
:FormatEnable    " re-enable format-on-save
:ConformInfo     " inspect available formatters and formatter logs
```

## Installing formatter executables

Mason can install many of the formatter binaries from inside Neovim:

```vim
:MasonInstall prettier prettierd goimports black isort stylua
```

You can also install them manually. On Arch, prefer official packages when available:

```bash
# Arch Linux / EndeavourOS / Manjaro
sudo pacman -S --needed go-tools python-black python-isort stylua

# Web / React / HTML / CSS
npm install -g prettier @fsouza/prettierd

# Go, when not using Arch's go-tools package
go install golang.org/x/tools/cmd/goimports@latest
# gofmt ships with Go itself

# Rust
rustup component add rustfmt

# Python, when not using Arch's python-black/python-isort packages
python3 -m pip install --user black isort

# Lua, when not using Arch's stylua package
cargo install stylua
```

Make sure any manually installed tools are available on your `PATH` before starting Neovim.

## Installing language tooling manually

Mason should handle the configured LSP servers, but these manual commands are useful for non-Mason setups or troubleshooting:

```bash
# JS/TS/React + Python + HTML/CSS + Tailwind
npm install -g typescript typescript-language-server pyright vscode-langservers-extracted @tailwindcss/language-server

# Go
go install golang.org/x/tools/gopls@latest

# Rust
rustup component add rust-analyzer rustfmt

# Lua language server and clangd are usually easiest from your OS package manager.

# Arch Linux / EndeavourOS / Manjaro
sudo pacman -S --needed lua-language-server clang gopls go-tools rust-analyzer stylua python-black python-isort

# Debian/Ubuntu examples may vary by release
sudo apt install -y lua-language-server clangd
```

Verify commands:

```bash
which typescript-language-server
which tailwindcss-language-server
which gopls
which rust-analyzer
which pyright-langserver
which lua-language-server
which vscode-html-language-server
which vscode-css-language-server
which clangd
which prettier
which goimports
which black
which isort
which stylua
```

## Keymaps

The leader key is `<Space>`.

| Keymap | Action |
|---|---|
| `<leader>w` | Save file |
| `<leader>q` | Quit window |
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files with Telescope |
| `<leader>fg` | Live grep with Telescope |
| `<leader>fb` | Find open buffers |
| `<leader>fh` | Search help tags |
| `<leader>f` | Format current buffer |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>d` | Show line diagnostic |

## Project notes

### React, JSX, TSX, and Tailwind

Open Neovim inside the project root so the language servers can find `package.json`, `tsconfig.json`, `tailwind.config.*`, or `.git`.

Recommended project-local dependencies:

```bash
npm install -D typescript prettier tailwindcss
```

For Bun projects:

```bash
bun add -d typescript prettier tailwindcss @types/bun
```

### Go

Open Neovim inside a Go module or workspace:

```bash
go mod init example.com/app
nvim main.go
```

The config enables `gopls` options for `gofumpt`, `staticcheck`, unimported package completion, placeholders, and useful analyses. Formatting uses `goimports` followed by `gofmt`.

### Rust

Open Neovim inside a Cargo project:

```bash
cargo new my-project
cd my-project
nvim src/main.rs
```

`rust_analyzer` is configured to use all Cargo features and `clippy` for checks.

### Python

Using a virtual environment is recommended:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install black isort
nvim app.py
```

### Lua / Neovim config development

`lua_ls` is configured with `vim` as a known global and the Neovim runtime files in the workspace library. Formatting uses `stylua`, configured by `.stylua.toml`.

## File layout

```text
.
├── init.lua
├── lua/core
│   ├── keymaps.lua
│   ├── options.lua
│   ├── plugins.lua
│   └── plugin_config
│       ├── autopairs.lua
│       ├── cmp.lua
│       ├── conform.lua
│       ├── init.lua
│       ├── lsp.lua
│       ├── telescope.lua
│       ├── theme.lua
│       ├── tree.lua
│       └── treesitter.lua
├── .editorconfig
└── .stylua.toml
```

## Troubleshooting

Run these first:

```vim
:checkhealth
:LspInfo
:ConformInfo
:Mason
```

Common issues:

1. **LSP does not start**: check `:LspInfo`, then verify the executable with `which <command>`.
2. **Formatting does not run**: run `:ConformInfo` and install the missing formatter.
3. **Tailwind completions do not appear**: open Neovim at the project root and confirm the project has `tailwind.config.*`, `postcss.config.*`, or `package.json`.
4. **Go imports are not organized**: install `goimports` and confirm `which goimports` works in the same shell that launches Neovim.
5. **Distribution Neovim is too old**: install Neovim 0.11.3+ from a newer source.
