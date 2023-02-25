# Config files
# -----------------------------------------------------------------------------
[[ -f "${XDG_CONFIG_HOME}/zsh/.aliases" ]] && . "${XDG_CONFIG_HOME}/zsh/.aliases"

# Autocompletion
# -----------------------------------------------------------------------------
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# Load zsh plugins
# -----------------------------------------------------------------------------
[[ -d "${XDG_DATA_HOME}/fast-syntax-highlighting" ]] && . "${XDG_DATA_HOME}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[[ -d "${XDG_DATA_HOME}/zsh-autosuggestions" ]] && . "${XDG_DATA_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Load fzf
# --------------------------------------------------------------------
if [[ ! "${PATH}" == *${XDG_DATA_HOME}/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}${XDG_DATA_HOME}/fzf/bin"
fi
[[ $- == *i* ]] && . "${XDG_DATA_HOME}/fzf/shell/completion.zsh" 2> /dev/null
. "${XDG_DATA_HOME}/fzf/shell/key-bindings.zsh"

# Load starship
# -----------------------------------------------------------------------------
[[ -f "${HOME}/.local/bin/starship" ]] && eval "$(starship init zsh)"
