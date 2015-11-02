# Console Zsh Theme
#
# Author: Ben White
# URL: benwhite.io

console_sep="○"

# ====== #
# Colors #
# ====== #
console_grey="%{$FG[239]%}"
console_silver="%{$FG[244]%}"
console_cyan="%{$FG[045]%}"
console_blue="%{$FG[033]%}"
console_navy="%{$FG[021]%}"
console_yellow="%{$FG[230]%}"
console_tan="%{$FG[179]%}"
console_red="%{$FG[202]%}"
console_rouge="%{$FG[196]%}"
console_purple="%{$FG[057]%}"
console_green="%{$FG[028]%}"
console_lime="%{$FG[049]%}"
console_reset="%{$reset_color%}"

# ============ #
# SSH hostname #
# ============ #
function ssh_host {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    if [ -n "$HOST_SYMBOL" ]; then
      echo " ${console_green}${HOST_SYMBOL}${console_reset}"
    else
      echo " ${console_lime}%m ${console_green}${console_sep}${console_reset}"
    fi
  else
    echo "${console_reset}"
  fi
}

# ========= #
# Directory #
# ========= #
function console_dir {
  echo " ${console_cyan}%~${console_blue}"
}

# === #
# Git #
# === #
ZSH_THEME_GIT_PROMPT_PREFIX=" ${console_sep} ${console_yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${console_tan}"

function console_git_info {
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# ========== #
# Error Code #
# ========== #
function precmd {
  console_code="$?"
  if [ $console_code -eq 0 ]; then
    console_exit=""
  else
    console_exit=" ${console_sep} ${console_red}${console_code}${console_rouge}"
  fi
}

# ======= #
# Vi Mode #
# ======= #
function zle-line-init zle-keymap-select {
  console_char=" ${${KEYMAP/vicmd/%(!.#.❮)}/(main|viins)/%(!.#.❯)} ${console_reset}"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# ======
# Prompt
# ======
PROMPT='$(ssh_host)$(console_dir)$(console_git_info)${console_exit}${console_char}'
