#!/usr/bin/env bash
#
# Install zsh plugins.

# Global variables
# -----------------------------------------------------------------------------
SCRIPT_NAME="$(basename ${0})"
SRC_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)
XDG_DATA_HOME="${XDG_DATA_HOME:-"${HOME}/.local/share"}"

# Loggers
# -----------------------------------------------------------------------------
info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; exit 0; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; exit 1; }

# Install zsh plugin
# -----------------------------------------------------------------------------
function install_zsh_plugins () {
    local repo_path="${1}"
    local project="$(echo "${repo_path}" | cut -d"/" -f2)"
    local project_path="${XDG_DATA_HOME}/${project}"
    git clone "https://github.com/${repo_path}" "${project_path}" &> /dev/null || \
    return 1 && return 0
}

# Update zsh plugin
# -----------------------------------------------------------------------------
function update_zsh_plugins () {
    if cd "${project_path}" > /dev/null 2>&1; then
        git pull &> /dev/null
        cd - > /dev/null 2>&1
        return 0
    fi
    return 1
}

# Main
# -----------------------------------------------------------------------------
function main () {
    # install_zsh_plugins "zdharma/fast-syntax-highlighting"
    if [[ -d "${XDG_DATA_HOME}/zsh-autosuggestions" ]]; then
        warn "zsh-autosuggestions already installed"
    fi
    install_zsh_plugins "zsh-users/zsh-autosuggestions" || erro "install zsh-autosuggestions"
    info "install zsh-autosuggestions done ✅"
}

main "$@"
