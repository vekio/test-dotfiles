# XDG directories - https://wiki.archlinux.org/title/XDG_Base_Directory
# -----------------------------------------------------------------------------
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Other directories
# -----------------------------------------------------------------------------
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export DOTFILES="${HOME}/.dotfiles"

# Path
# -----------------------------------------------------------------------------
export PATH="${PATH}:${HOME}/.local/bin" # Include .local/bin to path

# Editor
# --------------------------------------------------------------------
# export EDITOR="nvim"
# export VISUAL="${EDITOR}"

# history settings
# -----------------------------------------------------------------------------
export HISTFILE="${XDG_CACHE_HOME}/zsh/.history"
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
export HISTSIZE=50000        # History lines stored in memory.
export SAVEHIST=50000        # History lines stored on disk.
export LISTMAX=50            # The size of asking history.
setopt INC_APPEND_HISTORY    # Immediately append commands to history file.
setopt HIST_IGNORE_ALL_DUPS  # Never add duplicate entries.
setopt HIST_IGNORE_SPACE     # Ignore commands that start with a space.
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blank lines.
