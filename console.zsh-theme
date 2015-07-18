# Console Zsh Theme
#
# Author: Ben White
# URL: benwhite.io
#

# ======
# Colors
# ======
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

# ===
# Git
# ===
console_git_info () {
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

if [[ $CONSOLE_POWERLINE == 'true' ]]; then
    console_git_symbol='\ue0a0'
else
    console_git_symbol='±'
fi

ZSH_THEME_GIT_PROMPT_PREFIX=" ${console_tan}[${console_yellow}${console_git_symbol}${console_tan}:${console_yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${console_tan}]"
ZSH_THEME_GIT_PROMPT_DIRTY="*"

# ==========
# Error Code
# ==========
function precmd () {
  console_code="$?"
  if [ $console_code -eq 0 ]; then
      console_exit=""
  else
      console_exit=" ${console_rouge}[${console_red}${console_code}${console_rouge}]"
  fi
}

# ============
# SSH hostname
# ============
function ssh-hostname () {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo " ${console_green}[${console_lime}♘ ${console_green}:${console_lime}%m${console_green}]${console_reset}"
    else
        echo ''
    fi
}

# =======
# Vi Mode
# =======
console_vim="%(!.#.❯)"
function zle-line-init zle-keymap-select {
    console_vim="${${KEYMAP/vicmd/%(!.#.❮)}/(main|viins)/%(!.#.❯)}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

console_time='${console_grey}[${console_silver}%*${console_grey}]${console_reset}'

# ======
# Prompt
# ======

# Removes space automatically placed on the far right
ZLE_RPROMPT_INDENT=0

PROMPT='${console_blue}[${console_cyan}%~${console_blue}]$(console_git_info)${console_exit} ${console_vim}  ${console_reset}'
RPROMPT="${console_time}$(ssh-hostname)"
