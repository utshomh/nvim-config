# Neovim Config

A modern Neovim config for development with:

- JavaScript / TypeScript
- Rust
- C / C++
- Python
- Lua
- Autocomplete
- Go to definition
- Hover docs
- Diagnostics
- Formatting
- File explorer
- Fuzzy finder
- Treesitter syntax highlighting
- Catppuccin theme

This config uses **packer.nvim** as the plugin manager.

---

## Preview Features

### Language Support

| Language | LSP Server |
|---|---|
| JavaScript / TypeScript | `ts_ls` |
| Rust | `rust_analyzer` |
| C / C++ | `clangd` |
| Python | `pyright` |
| Lua | `lua_ls` |

---

## Requirements

Install these before using the config:

```bash
sudo apt update
sudo apt install -y git curl unzip ripgrep fd-find build-essential
```

Install Neovim:

```bash
sudo apt install -y neovim
```

Install language servers/tools:

```bash
# Node / TypeScript / Pyright
npm install -g typescript typescript-language-server pyright

# Rust analyzer
rustup component add rust-analyzer

# C / C++
sudo apt install -y clangd

# Lua language server
sudo apt install -y lua-language-server
```

For Bun projects:

```bash
bun add -d @types/bun
```

---

## Installation

Backup your old Neovim config:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

Clone this config:

```bash
git clone https://github.com/utsho/nvim-config.git ~/.config/nvim
```

Open Neovim:

```bash
nvim
```

Install plugins:

```vim
:PackerSync
```

Then close and reopen Neovim.

---

## LSP Requirements

This config uses the following language servers:

| Language | LSP Server | Required Command |
|---|---|---|
| JavaScript / TypeScript / Node / Bun | `ts_ls` | `typescript-language-server` |
| Rust | `rust_analyzer` | `rust-analyzer` |
| C / C++ | `clangd` | `clangd` |
| Python | `pyright` | `pyright-langserver` |
| Lua | `lua_ls` | `lua-language-server` |

---

## Install LSP Dependencies

### Arch Linux

```bash
sudo pacman -Syu
sudo pacman -S nodejs npm clang lua-language-server rust-analyzer
```

Then install the Node-based language servers:

```bash
npm install -g typescript typescript-language-server pyright
```

### Rust alternative with rustup

If you manage Rust with `rustup`, install Rust Analyzer with:

```bash
rustup component add rust-analyzer
```

instead of:

```bash
sudo pacman -S rust-analyzer
```

---

## Verify LSP Commands

Run:

```bash
which typescript-language-server
which rust-analyzer
which clangd
which pyright-langserver
which lua-language-server
```

Each command should print a valid path.

You can also check versions:

```bash
typescript-language-server --version
rust-analyzer --version
clangd --version
pyright-langserver --version
lua-language-server --version
```

---

## Project-specific notes

### Node / Bun / TypeScript

For Node projects:

```bash
npm install -D typescript
```

For Bun projects:

```bash
bun add -d typescript @types/bun
```

The global `typescript-language-server` starts the LSP, while project-local `typescript` gives better project-specific type checking.

### Rust

Open Neovim inside a Cargo project:

```bash
cargo new my-project
cd my-project
nvim src/main.rs
```

### C / C++

For best `clangd` support, use a `compile_commands.json` file when possible.

### Python

For Python projects, using a virtual environment is recommended:

```bash
python -m venv .venv
source .venv/bin/activate
```

## Leader Key

The leader key is set to:

```text
Space
```

So when this README says `<leader>e`, press:

```text
Space + e
```

---

## Keybinds

### General

| Shortcut | Action |
|---|---|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `Ctrl + h` | Move to left split |
| `Ctrl + j` | Move to lower split |
| `Ctrl + k` | Move to upper split |
| `Ctrl + l` | Move to right split |

---

### File Explorer

| Shortcut | Action |
|---|---|
| `<leader>e` | Toggle file explorer |

---

### Telescope Search

| Shortcut | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Search text in project |
| `<leader>fb` | Show open buffers |
| `<leader>fh` | Search help pages |

---

### LSP / Code Navigation

These shortcuts work when the language server is attached.

| Shortcut | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Show references |
| `gi` | Go to implementation |
| `K` | Show hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format file |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>d` | Show diagnostic message |

---

### Autocomplete

| Shortcut | Action |
|---|---|
| `Ctrl + Space` | Open completion menu |
| `Enter` | Accept selected completion |
| `Tab` | Next completion item / jump snippet |
| `Shift + Tab` | Previous completion item / jump back |

---

## Useful Neovim Commands

### Save file

```vim
:w
```

### Save and quit

```vim
:wq
```

### Quit without saving

```vim
:q!
```

### Open file

```vim
:e filename
```

### Install/update plugins

```vim
:PackerSync
```

### Check LSP status

```vim
:LspInfo
```

### Check Treesitter

```vim
:TSInstallInfo
```
---

