#!/bin/bash

# Dotfiles Installation Script
# Automates symlinking of dotfiles and installation of dependencies

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

print_status "Starting dotfiles installation..."
print_status "Dotfiles directory: $DOTFILES_DIR"

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/debian_version ]] || [[ -f /etc/lsb-release ]]; then
        echo "debian"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
print_status "Detected operating system: $OS"

# Create backup directory if needed
create_backup_dir() {
    if [[ ! -d "$BACKUP_DIR" ]]; then
        mkdir -p "$BACKUP_DIR"
        print_status "Created backup directory: $BACKUP_DIR"
    fi
}

# Function to backup and symlink a file
backup_and_symlink() {
    local source_file="$1"
    local target_file="$2"
    local filename=$(basename "$source_file")
    
    if [[ -f "$DOTFILES_DIR/$source_file" ]]; then
        print_status "Processing $filename..."
        
        # Backup existing file if it exists and is not already a symlink to our file
        if [[ -f "$target_file" ]] && [[ ! -L "$target_file" || "$(readlink "$target_file")" != "$DOTFILES_DIR/$source_file" ]]; then
            create_backup_dir
            cp "$target_file" "$BACKUP_DIR/$filename"
            print_warning "Backed up existing $filename to $BACKUP_DIR/$filename"
        fi
        
        # Remove existing file/symlink
        if [[ -e "$target_file" ]] || [[ -L "$target_file" ]]; then
            rm "$target_file"
        fi
        
        # Create symlink
        ln -s "$DOTFILES_DIR/$source_file" "$target_file"
        print_success "Symlinked $filename"
    else
        print_warning "$filename not found in dotfiles directory, skipping..."
    fi
}

# Symlink dotfiles
print_status "Symlinking dotfiles..."

# List of dotfiles to symlink (source_file:target_file)
dotfiles=(
    ".aliases:$HOME/.aliases"
    ".gitconfig:$HOME/.gitconfig"
    "zshrc:$HOME/.zshrc"
    "vimrc:$HOME/.vimrc"
    "tmux.conf:$HOME/.tmux.conf"
)

for dotfile in "${dotfiles[@]}"; do
    IFS=':' read -r source target <<< "$dotfile"
    backup_and_symlink "$source" "$target"
done

# Install dependencies based on OS
print_status "Installing dependencies for $OS..."

case "$OS" in
    "macos")
        # Check if Homebrew is installed
        if ! command -v brew &> /dev/null; then
            print_status "Homebrew not found. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            
            # Add Homebrew to PATH for this session
            if [[ -f "/opt/homebrew/bin/brew" ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            elif [[ -f "/usr/local/bin/brew" ]]; then
                eval "$(/usr/local/bin/brew shellenv)"
            fi
            
            print_success "Homebrew installed successfully"
        else
            print_success "Homebrew is already installed"
        fi
        ;;
    "debian")
        print_status "Updating package repositories..."
        sudo apt-get update
        print_success "Package repositories updated"
        ;;
    *)
        print_warning "Unknown operating system. Skipping dependency installation."
        ;;
esac

# Summary
print_success "Dotfiles installation completed!"

if [[ -d "$BACKUP_DIR" ]]; then
    print_status "Original files backed up to: $BACKUP_DIR"
fi

echo
print_status "Next steps:"
echo "  1. Restart your shell or run: exec \$SHELL"
echo "  2. Or source your new configuration files:"
if [[ -f "$HOME/.zshrc" ]]; then
    echo "     source ~/.zshrc"
fi
if [[ -f "$HOME/.aliases" ]]; then
    echo "     source ~/.aliases"
fi

echo
print_success "Happy coding! 🎉"