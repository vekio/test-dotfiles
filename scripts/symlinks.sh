#!/usr/bin/env bash
#
# Setup dotfiles symlinks.

# Global variables
# -----------------------------------------------------------------------------
SCRIPT_NAME="$(basename ${0})"
SRC_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)

# Loggers
# -----------------------------------------------------------------------------
info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; exit 1; }

# Remove dotfile symlinks
# -----------------------------------------------------------------------------
function remove_symlinks () {
    rm -f "${HOME}/.zshenv" \
        "${HOME}/.config/zsh/.zshrc" \
        "${HOME}/.config/zsh/.aliases" || \
        return 1 && return 0
}

# Create dotfile symlinks
# -----------------------------------------------------------------------------
function create_symlinks () {
    ln -fs "${SRC_DIR}/zshenv" "${HOME}/.zshenv" && \
    ln -fs "${SRC_DIR}/zshrc" "${HOME}/.config/zsh/.zshrc" && \
    ln -fs "${SRC_DIR}/aliases" "${HOME}/.config/zsh/.aliases" || \
        return 1 && return 0
}

# Main
# -----------------------------------------------------------------------------
function main () {
    remove_symlinks || erro "remove symlinks"
    create_symlinks || erro "create symlinks"
    info "dotfiles symlinks done ✅"
}

main "$@"
