#!/bin/bash

echo "🚀 Setting up LazyVim configuration..."

# Function to install Neovim and dependencies
install_neovim() {
  echo "📦 Installing Neovim and dependencies..."

  if command -v pacman &>/dev/null; then
    sudo pacman -S --needed neovim stow git curl unzip
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y neovim stow git curl unzip
  elif command -v apt &>/dev/null; then
    sudo apt update
    sudo apt install -y neovim stow git curl unzip
  elif command -v brew &>/dev/null; then
    brew install neovim stow git curl
  else
    echo "⚠️  Please install neovim, stow, git, curl, and unzip manually"
    exit 1
  fi
}

# Check Neovim version compatibility
check_neovim_version() {
  if command -v nvim &>/dev/null; then
    version=$(nvim --version | head -n1 | grep -o 'v[0-9]\+\.[0-9]\+' | sed 's/v//')
    major=$(echo $version | cut -d. -f1)
    minor=$(echo $version | cut -d. -f2)

    if [ "$major" -eq 0 ] && [ "$minor" -lt 8 ]; then
      echo "⚠️  LazyVim requires Neovim 0.8+. Current version: $version"
      echo "Please update Neovim before continuing."
      exit 1
    else
      echo "✅ Neovim version $version is compatible"
    fi
  fi
}

# Check if required tools are installed
missing_deps=()

if ! command -v nvim &>/dev/null; then
  missing_deps+=("neovim")
fi

if ! command -v git &>/dev/null; then
  missing_deps+=("git")
fi

if ! command -v curl &>/dev/null; then
  missing_deps+=("curl")
fi

if ! command -v stow &>/dev/null; then
  missing_deps+=("stow")
fi

# Install missing dependencies
if [ ${#missing_deps[@]} -ne 0 ]; then
  echo "Missing dependencies: ${missing_deps[*]}"
  read -p "Install missing dependencies? (Y/n): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "❌ Required dependencies missing. Exiting..."
    exit 1
  else
    install_neovim
  fi
fi

# Check Neovim version after potential installation
check_neovim_version

# Backup existing config if it exists
if [ -d ~/.config/nvim ]; then
  echo "⚠️  Existing Neovim config found"
  read -p "Backup existing config? (Y/n): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    backup_name="nvim.backup.$(date +%Y%m%d-%H%M%S)"
    mv ~/.config/nvim ~/.config/$backup_name
    echo "✅ Backup created at ~/.config/$backup_name"
  else
    echo "⚠️  Removing existing config..."
    rm -rf ~/.config/nvim
  fi
fi

# Deploy configuration
echo "🔗 Creating symlinks..."
stow nvim

echo "✅ LazyVim configuration deployed!"
echo ""
echo "🎯 Next steps:"
echo "1. Run 'nvim' to start Neovim"
echo "2. LazyVim will automatically install plugins on first launch"
echo "3. Wait for all plugins to install (this may take a few minutes)"
echo "4. Restart Neovim after installation completes"
echo ""
echo "💡 Useful LazyVim commands:"
echo "   :Lazy - Open plugin manager"
echo "   :LazyHealth - Check system health"
echo "   :checkhealth - General Neovim health check"
