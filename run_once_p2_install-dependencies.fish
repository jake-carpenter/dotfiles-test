#!/usr/bin/env fish

### Priority 2 - Install other common system dependencies
echo -e "\n  🔎 Verifying system dependencies..."

# Install bun
if type -q bun
  echo -e "  💡 Found bun"
else
  echo -e "  🚀 Installing bun..."
  curl -fsSL https://bun.sh/install | bash
end

# Install pnpm
if type -q pnpm
  set pnpm_version $(pnpm --version)
  echo -e "  💡 Found pnpm"
else
  echo -e "  🚀 Installing pnpm..."
  curl -fsSL https://get.pnpm.io/install.sh | sh -
end

# Install dnvm (dotnet)
if type -q dnvm
  echo -e "  💡 Found dnvm"
else
  echo -e "  🚀 Installing dnvm..."
  curl --proto '=https' -sSf https://dnvm.net/install.sh | sh
end

# Install fnm (node)
if type -q fnm
  set fnm_version $(fnm --version)
  echo -e "  💡 Found fnm"
else
  echo -e "  🚀 Installing fnm..."
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
end

# Install fisher (fish plugins)
if type -q fisher
  echo -e "  💡 Found fisher"
else
  echo -e "  🚀 Installing fisher"
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end