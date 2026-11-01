# IlyasYOY Monochrome — zsh-syntax-highlighting theme
# Ported from https://github.com/IlyasYOY/dotfiles/blob/master/config/nvim/colors/ilyasyoy-monochrome.lua

typeset -A ZSH_HIGHLIGHT_STYLES

if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
    # === Dark theme ===
    _fg='#dadada'
    _muted='#909090'
    _green='#6ab06a'
else
    # === Light theme ===
    _fg='#000000'
    _muted='#626262'
    _green='#2d8a2d'
fi

# Commands / functions — green bold
ZSH_HIGHLIGHT_STYLES[command]="fg=$_green,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=$_green,bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=$_green,bold"
ZSH_HIGHLIGHT_STYLES[alias]="fg=$_green,bold"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=$_green,bold"

# Arguments / default
ZSH_HIGHLIGHT_STYLES[default]="fg=$_fg"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=$_fg,bold"

# Keywords — muted (like nvim Keyword)
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=$_muted"

# Strings — italic (like nvim String)
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]="fg=$_fg,italic"
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]="fg=$_fg,italic"
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]="fg=$_fg,italic"
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]="fg=$_fg,italic"

# Variables
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]="fg=$_fg"
ZSH_HIGHLIGHT_STYLES[assign]="fg=$_fg"
ZSH_HIGHLIGHT_STYLES[named-fd]="fg=$_fg"

# Operators / punctuation
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=$_muted"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=$_fg"
ZSH_HIGHLIGHT_STYLES[globbing]="fg=$_fg"

# Comments — muted
ZSH_HIGHLIGHT_STYLES[comment]="fg=$_muted"

# Paths — underline (like nvim Type)
ZSH_HIGHLIGHT_STYLES[path]="fg=$_fg,underline"

# Errors — error color
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ff005f'

# Matching brackets — visual color
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#ffaf00,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]="fg=$_fg,bold"
ZSH_HIGHLIGHT_STYLES[bracket-level-3]="fg=$_muted,bold"

# Autosuggestions (zsh-autosuggestions plugin)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=$_muted"

unset _fg _muted _green
