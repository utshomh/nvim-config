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

