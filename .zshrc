# cSpell: disable

# https://zsh.sourceforge.io/Doc/Release/Options.html
#
# 16.2.1 Changing Directories
#
setopt   auto_cd
setopt   auto_pushd
unsetopt cdable_vars
setopt   cd_silent
unsetopt chase_dots
setopt   chase_links
unsetopt posix_cd
setopt   pushd_ignore_dups
unsetopt pushd_minus
setopt   pushd_silent
unsetopt pushd_to_home

#
# 16.2.2 Completion
#
#setopt   always_last_prompt
#setopt   always_to_end
#setopt   auto_list
#setopt   auto_menu
#unsetopt auto_name_dirs
#setopt   auto_param_keys
#setopt   auto_param_slash
#setopt   auto_remove_slash
#setopt   bash_auto_list
#setopt   complete_aliases
#unsetopt complete_in_word
#setopt   glob_complete
#setopt   hash_list_all
#setopt   list_ambiguous
#unsetopt list_beep
#setopt   list_packed
#setopt   list_rows_first
#unsetopt list_types
#unsetopt menu_complete
#unsetopt rec_exact

#
# 16.2.3 Expansion and Globbing
#
# do nothing

#
# 16.24 History
#
export SAVEHIST=10000
export HISTSIZE=1000000
export HISTFILE=~/.zhistory
setopt   append_history
unsetopt bang_hist
setopt   extended_history
setopt   hist_allow_clobber
unsetopt hist_beep
setopt   hist_expire_dups_first
unsetopt hist_fcntl_lock
setopt   hist_find_no_dups
setopt   hist_ignore_all_dups
setopt   hist_ignore_dups
unsetopt hist_ignore_space
unsetopt hist_lex_words
setopt   hist_no_store
setopt   hist_reduce_blanks
setopt   hist_save_by_copy
setopt   hist_save_no_dups
setopt   hist_verify
unsetopt inc_append_history
setopt   inc_append_history_time
setopt   share_history

#
# 16.2.5 Initialisation
#
# (T.B.D.)

#
# 16.2.6 Input/Output
#
# (T.B.D.)

#
# 16.2.7 Job Control
#
# (T.B.D.)

#
# 16.2.8 Prompting
#
# (T.B.D.)

#
# 16.2.9 Scripts and Functions
#
# (T.B.D.)

#
# 16.2.10 Shell Emulation
#
# (T.B.D.)

#
# 16.2.11 Shell State
#
# (T.B.D.)

#
# 16.2.12 Zle
#
# (T.B.D.)

#
# Correct/Completion
#
autoload -U compinit && compinit
autoload -U colors && colors
setopt correct
setopt magic_equal_subst
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

#
# Misc
#
setopt nobeep

#
# keybind
#
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

#
# searching command history
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward


#
# Prompt
#
autoload -U colors && colors
setopt prompt_subst
setopt transient_rprompt
#GREEN=$'%{\e[38;5;84m%}'         # Light Green
#DEFAULT=$'%{\e[0;39m%}'          # Default
PROMPT_BASE='%F{green}%# %f'   # PROMPT: %
RPROMPT='[%m @ %~]'              # RPROMPT: [<hostname> @ <path>]
RPROMPT2=${RPROMPT}              # RPROMPT2 is same as RPROMPT

# prompt
function set_prompt {
    NEW_PROMPT=""

    # vimode
    case $KEYMAP in
        viins|main)
            NEW_PROMPT="%F{green}%#%#%f "
            ;;
        vicmd)
            NEW_PROMPT="%K{green}%F{white}%#%#%f%k "
            ;;
        visual)
            NEW_PROMPT="%K{red}%F{white}%#%#%f%k "
            ;;
        *)
            ;;
    esac

    # git branch
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        if [[ -n "$branch_name" ]]; then
            # Check if repo is dirty (has uncommitted changes)
            if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
                branch_name="${branch_name}*"
            fi
            NEW_PROMPT="%F{cyan}:${branch_name}%f%k ${NEW_PROMPT}"
        fi
    fi

    # virtualenv
    if [[ -n $VIRTUAL_ENV ]]; then
        VENV_NAME=$(basename "$VIRTUAL_ENV")
        NEW_PROMPT="%F{blue}(${VENV_NAME})%f%k ${NEW_PROMPT}"
    fi

    if [[ $PROMPT = $NEW_PROMPT ]]; then
        : # do nothing (no-op)
    else
        PROMPT=$NEW_PROMPT
        zle reset-prompt
    fi

    return
}

zle -N zle-line-init set_prompt
zle -N zle-keymap-select set_prompt

#
# PATH
#
export PATH=${HOME}/bin:${HOME}/local/bin:${HOME}/.local/bin:${PATH}


#
# Aliases
#
function xfind {
    if [[ $# -lt 2 ]]; then
        echo "Usage: xfind <directory> <pattern>"
        return 1
    fi

    find "${1}" -name "${2}"
}


alias tmux='tmux -u'
alias ta='tmux a'

alias sudo='sudo -E '

alias grep='grep --color=auto'
alias xgrep='grep -nrHIE '
alias grep='grep --color=auto'
alias ls='ls -F --color=auto'
alias la='ls -alF'

alias zshrc='source ~/.zshrc; clear'
alias j='jobs -l'
alias p='ps'
alias pl='ps aux | less'
alias pg='ps aux | grep '
alias v='vim'

#
# ssh aliases
#
SSH_CONFIG=${HOME}/.ssh/config
if [[ ${SSH_CONFIG} ]]
then
    # shellcheck disable=SC2207
    #hosts=($( grep -E "Host [^*+]" "${HOME}/.ssh/config" | sed -e 's/Host //g' ))
    #for host in "${hosts[@]}"; do
    #    # shellcheck disable=SC2034,SC2139
    #    alias "ssh-to-${host}"="ssh ${host}"
    #done
fi

#
# Character set
#
LC=en_US.UTF-8
export LANG=${LC}
export LC_CTYPE=${LC}

#
# less
#
# -i: ignore case when search using all lowercase letters
# -M: show verbose prompt
# -R: interpret ANSI color escape sequence
# -S: chop long lines
# -W: highlight the first line when move more than two lines at a time
export PAGER=less
export LESSCHARSET=utf-8
export LESS='-N -i -M -R -S -W'

#
# docker
#
alias docker-pruneall='docker container prune && docker image prune && docker volume prune && docker network prune && docker system prune'

# zinit
declare -A ZINIT
ZINIT[HOME_DIR]="${HOME}/.zinit"
export ZINIT_HOME="${HOME}/.zinit"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

