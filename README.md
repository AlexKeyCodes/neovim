# LazyVim Configuration

Personal Neovim setup based on [LazyVim](https://www.lazyvim.org/) - a Neovim setup powered by lazy.nvim.

## Prerequisites

- **Neovim 0.8+** (required for LazyVim compatibility)
- **Git** - for cloning repositories and plugin management
- **Curl** - for downloading plugins and dependencies  
- **Unzip** - for extracting plugin archives
- **GNU Stow** - for managing configuration symlinks

## Installation

### Step 1: Install Dependencies

Choose the appropriate command for your operating system:

**Arch Linux:**
```bash
sudo pacman -S --needed neovim stow git curl unzip
```

**Fedora/RHEL:**
```bash
sudo dnf install -y neovim stow git curl unzip
```

**Debian/Ubuntu:**
```bash
sudo apt update
sudo apt install -y neovim stow git curl unzip
```

**macOS:**
```bash
brew install neovim stow git curl
```

### Step 2: Setup Configuration

1. **Backup existing Neovim config** (if you have one):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d-%H%M%S)
   ```

2. **Clone this repository:**
   ```bash
   git clone git@github.com:AlexKeyCodes/neovim.git
   cd neovim
   ```

3. **Create symlinks using Stow:**
   ```bash
   stow nvim
   ```

### Step 3: First Launch

1. **Start Neovim:**
   ```bash
   nvim
   ```

2. **Wait for plugins to install** - LazyVim will automatically download and install all plugins on first launch (this may take a few minutes)

3. **Restart Neovim** after installation completes

4. **Verify setup:**
   ```bash
   :checkhealth
   ```

## What's Included

- **LazyVim** base configuration with sensible defaults
- **Custom plugins** and overrides for personal workflow
- **Language support** for development (LSP, treesitter, etc.)
- **Modern UI** with telescope, which-key, and more

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
