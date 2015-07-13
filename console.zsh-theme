# Console Zsh Theme
#
# Author: Ben White
# URL: benwhite.io
#

# ======
# Colors
# ======
console_grey="%{$FG[240]%}"
console_cyan="%{$FG[045]%}"
console_blue="%{$FG[033]%}"
console_navy="%{$FG[021]%}"
console_yellow="%{$FG[230]%}"
console_tan="%{$FG[179]%}"
console_red="%{$FG[202]%}"
console_rouge="%{$FG[196]%}"
console_purple="%{$FG[057]%}"
console_green="%{$FG[155]%}"
console_reset="%{$reset_color%}"

# ===
# Git
# ===
if [[ $CONSOLE_POWERLINE == 'TRUE' ]]; then
    console_git='\ue0a0'
else
    console_git='±'
fi

ZSH_THEME_GIT_PROMPT_PREFIX=" ${console_tan}[${console_yellow}${console_git}/"
ZSH_THEME_GIT_PROMPT_SUFFIX="${console_tan}]"
ZSH_THEME_GIT_PROMPT_DIRTY="*"

# ==========
# Error Code
# ==========
function precmd () {
  if [ $? -eq 0 ]; then
      console_exit=""
  else
      console_exit=" ${console_rouge}[${console_red}$?${console_rouge}]"
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

# ======
# Prompt
# ======
PROMPT='${console_blue}[${console_cyan}%~${console_blue}]$(git_prompt_info)${console_exit} ${console_vim} ${console_reset}'
RPROMPT='${console_grey}%n on %m at %*${console_reset}'
