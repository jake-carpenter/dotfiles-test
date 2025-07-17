#!/bin/bash
set -e

# Install Homebrew if missing
if ! command -v brew >/dev/null; then
  echo -e "🚀 Installing homebrew\n"
  echo -e "🚨 \033[31mYOU WIlL BE ASKED FOR YOUR PASSWORD\033[0m\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "eval \"\$(\/opt\/homebrew\/bin\/brew shellenv)\"" >> "$HOME"/.zprofile
fi

# Setup Homebrew environment for this shell
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install fish if missing
if ! command -v fish >/dev/null; then
  echo -e "🚀 Installing fish\n"
  echo -e "🚨 \033[31mYOU WIlL BE ASKED FOR YOUR PASSWORD\033[0m\n"
  brew install fish
fi

# Install pnpm if missing
if ! command -v pnpm >/dev/null; then
  echo -e "\n🚀 Installing pnpm\n"
  brew install pnpm
fi

# Install bun if missing
if ! command -v bun >/dev/null; then
  echo -e "🚀 Installing bun\n"
  curl -fsSL https://bun.sh/install | bash
  # Add bun to PATH for this session
  export PATH="$HOME/.bun/bin:$PATH"
fi

# Install fnm if missing
if ! command -v fnm >/dev/null; then
  echo -e "🚀 Installing fnm\n"
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
  # Source fnm environment for this session
  export PATH="$HOME/.fnm:$PATH"
  eval "$(fnm env)"
fi

# fisher
if [ ! -f "$HOME/.config/fish/functions/fisher.fish" ]; then
  echo -e "🚀 Installing fisher\n"
  brew install fisher
fi

# Install LTS NodeJS
if ! command -v node &> /dev/null; then
  echo -e "\n🚀 Installing latest LTS NodeJS\n"
  fnm install --lts
fi

# Install proper chezmoi
if ! command -v chezmoi >/dev/null; then
  echo -e "🚀 Installing chezmoi\n"
  brew install chezmoi
fi

# Now re-apply chezmoi with the second root (full dotfiles)
echo "Running second chezmoi apply for full dotfiles..."
chezmoi --source $HOME/.local/share/chezmoi/macos apply

echo "Bootstrap complete. You can now start fish shell."
