#!/usr/bin/env bash
#
# Install fzf.

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

# Install fzf
# -----------------------------------------------------------------------------
function install_fzf () {
    if [[ -d "${XDG_DATA_HOME}/fzf" ]]; then
        warn "fzf already installed"
        return 0
    fi
    git clone --depth 1 https://github.com/junegunn/fzf.git "${XDG_DATA_HOME}/fzf" &>/dev/null && \
    "${XDG_DATA_HOME}/fzf/install" --bin --no-update-rc &>/dev/null || \
    return 1 && return 0
}

# Update fzf
# -----------------------------------------------------------------------------
function update_fzf () {
    if ! command -v fzf &> /dev/null;then
        return 1
    fi

    cd "${XDG_DATA_HOME}/fzf" && \
    git pull &>/dev/null && \
    ./install --bin --no-update-rc &>/dev/null
    cd - &> /dev/null
    return 0
}

# Setup fzf
# -----------------------------------------------------------------------------
function setup_fzf () {
    ln -sf "${SRC_DIR}/fzf" "${HOME}/.config/zsh/.fzf" || \
    return 1 && return 0
}

# Main
# -----------------------------------------------------------------------------
function main () {
    install_fzf || erro "fzf install"
    info "fzf install done ✅"
    setup_fzf || erro "fzf setup"
    info "fzf setup done ✅"
}

main "$@"
