# LazyVim Configuration

Personal Neovim setup based on [LazyVim](https://www.lazyvim.org/) - a Neovim setup powered by lazy.nvim.

## Installation

```bash
git clone git@github.com:AlexKeyCodes/neovim.git
cd nvim-config
./install.sh
```

## What's Included

- **LazyVim** base configuration with sensible defaults
- **Custom plugins** and overrides for personal workflow
- **Language support** for development (LSP, treesitter, etc.)
- **Modern UI** with telescope, which-key, and more

## Prerequisites

- Neovim 0.8+
- Git, curl, unzip
- GNU Stow (auto-installed by script)

## First Time Setup

1. Run the install script: `./install.sh`
2. Open Neovim: `nvim`
3. LazyVim will automatically install all plugins (be patient!)
4. Restart Neovim when installation completes
5. Run `:checkhealth` to verify everything works

## Key Features

**Plugin Manager**: Lazy.nvim for fast startup and plugin management  
**LSP**: Built-in language server support  
**Fuzzy Finding**: Telescope for file/text search  
**Git Integration**: Built-in git signs and commands  
**Terminal**: Integrated terminal with toggleterm  

## Useful Commands

- `:Lazy` - Plugin manager interface
- `:LazyHealth` - Check LazyVim health  
- `:checkhealth` - Neovim health check
- `<leader>ff` - Find files
- `<leader>sg` - Search text (grep)

## Customization

- `lua/config/` - LazyVim configuration overrides
- `lua/plugins/` - Custom plugin configurations
- See [LazyVim docs](https://www.lazyvim.org/) for customization guide
