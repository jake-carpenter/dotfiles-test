#!/usr/bin/env bash
set -e

# Install Homebrew if missing
if ! command -v brew >/dev/null; then
  echo -e "----------------------------------------------------------------------"
  echo -e "🚀 Installing homebrew\n"
  echo -e "🚨 \033[31mYOU WIlL BE ASKED FOR YOUR PASSWORD\033[0m"
  echo -e "----------------------------------------------------------------------"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "eval \"\$(\/opt\/homebrew\/bin\/brew shellenv)\"" >> "$HOME"/.zprofile
  echo -e "----------------------------------------------------------------------"
  echo -e "Homebrew installed successfully."
  echo -e "----------------------------------------------------------------------"
fi

# Setup Homebrew environment for this shell
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install fish if missing
if ! command -v fish >/dev/null; then
  echo -e "----------------------------------------------------------------------"
  echo -e "🚀 Installing fish\n"
  echo -e "🚨 \033[31mYOU WIlL BE ASKED FOR YOUR PASSWORD\033[0m"
  echo -e "----------------------------------------------------------------------"
  brew install fish
  echo -e "----------------------------------------------------------------------"
  echo -e "Fish shell installed successfully."
  echo -e "----------------------------------------------------------------------"
fi

# Install pnpm if missing
if ! command -v pnpm >/dev/null; then
  echo -e "----------------------------------------------------------------------"
  echo -e "🚀 Installing pnpm"
  echo -e "----------------------------------------------------------------------"
  brew install pnpm
  echo -e "----------------------------------------------------------------------"
  echo -e "pnpm installed successfully."
  echo -e "----------------------------------------------------------------------"
fi

# Install bun if missing
if ! command -v bun >/dev/null; then
  echo -e "----------------------------------------------------------------------"
  echo -e "🚀 Installing bun"
  echo -e "----------------------------------------------------------------------"
  curl -fsSL https://bun.sh/install | bash
  # Add bun to PATH for this session
  export PATH="$HOME/.bun/bin:$PATH"
  echo -e "----------------------------------------------------------------------"
  echo -e "bun installed successfully."
  echo -e "----------------------------------------------------------------------"
fi

# Install fnm if missing
if ! command -v fnm >/dev/null; then
  echo -e "----------------------------------------------------------------------"
  echo -e "🚀 Installing fnm"
  echo -e "----------------------------------------------------------------------"
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  # Source fnm environment for this session
  export PATH="$HOME/.fnm:$PATH"
  eval "$(fnm env)"
  echo -e "----------------------------------------------------------------------"
  echo -e "fnm installed successfully."
  echo -e "----------------------------------------------------------------------"
fi

# fisher
if [ ! -f "$HOME/.config/fish/functions/fisher.fish" ]; then
  echo -e "----------------------------------------------------------------------"
  echo -e "🚀 Installing fisher"
  echo -e "----------------------------------------------------------------------"
  brew install fisher
  echo -e "----------------------------------------------------------------------"
  echo -e "fisher installed successfully."
  echo -e "----------------------------------------------------------------------"
fi

# Install LTS NodeJS
if ! command -v node &> /dev/null; then
  echo -e "----------------------------------------------------------------------"
  echo -e "🚀 Installing latest LTS NodeJS"
  echo -e "----------------------------------------------------------------------"
  fnm install --lts
  echo -e "----------------------------------------------------------------------"
  echo -e "NodeJS installed successfully."
  echo -e "----------------------------------------------------------------------"
fi

# Install proper chezmoi
if ! command -v chezmoi >/dev/null; then
  echo -e "----------------------------------------------------------------------"
  echo -e "🚀 Installing chezmoi"
  echo -e "----------------------------------------------------------------------"
  brew install chezmoi
  echo -e "----------------------------------------------------------------------"
  echo -e "chezmoi installed successfully."
  echo -e "----------------------------------------------------------------------"
fi

# Re-apply chezmoi with the second root (full dotfiles)
echo "Running second chezmoi apply for full dotfiles..."
chezmoi --source $HOME/.local/share/chezmoi/roots/macos apply

