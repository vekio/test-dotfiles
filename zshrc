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

# Load terraform
# -----------------------------------------------------------------------------
[[ -f "/usr/bin/terraform" ]] && complete -C /usr/bin/terraform terraform

# Load nvm
# -----------------------------------------------------------------------------
export NVM_DIR="$([[ -z "${XDG_CONFIG_HOME-}" ]] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[[ -s "${NVM_DIR}/nvm.sh" ]] && . "${NVM_DIR}/nvm.sh"

# Load GPG
# -----------------------------------------------------------------------------
export GPG_TTY=$(tty)
