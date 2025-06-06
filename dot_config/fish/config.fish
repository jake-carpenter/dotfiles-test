set -gx PATH /usr/local/bin $PATH

# Homebrew
# https://github.com/orgs/Homebrew/discussions/4412#discussioncomment-8651316
if test -d /home/linuxbrew/.linuxbrew # Linux
    set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew"
else if test -d /opt/homebrew # MacOS
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
    set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/homebrew"
end
fish_add_path -gP "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin"
! set -q MANPATH; and set MANPATH ''
set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH
! set -q INFOPATH; and set INFOPATH ''
set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH
set -gx HOMEBREW_NO_AUTO_UPDATE 1

fish_add_path $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin

# pnpm
set -gx PNPM_HOME $HOME/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    fish_add_path "$PNPM_HOME"
end

# fnm (Node version manager)
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

# Android
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
set -gx ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set -gx ANDROID_HOME $ANDROID_SDK_ROOT
fish_add_path $ANDROID_HOME
fish_add_path $ANDROID_HOME/platform-tools

# my env vars
set -gx EDITOR hx
set -gx VISUAL hx
set -gx GITIN_LINESIZE 20

# bun
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

# cargo (Rust)
fish_add_path "$HOME/.cargo/bin"

# dnvm (.NET)
fish_add_path "$HOME/Library/Application Support/dnvm"

# abbr (aliases)
abbr -a vim hx
abbr -a p pnpm
abbr -a px pnpx
abbr -a bx bunx
abbr -a gi git
abbr -a gti git
abbr -a gb "gitin branch"
abbr -a gs "gitin status"
abbr -a gl "gitin log"
