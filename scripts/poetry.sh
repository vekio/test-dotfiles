#!/usr/bin/env bash
#
# Install poetry.

# Global variables
# -----------------------------------------------------------------------------
SCRIPT_NAME="$(basename ${0})"
SRC_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)

# Loggers
# -----------------------------------------------------------------------------
info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; exit 0; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; exit 1; }

# Install poetry
# -----------------------------------------------------------------------------
function update_poetry () {
    poetry self update &>/dev/null || \
    return 1 && return 0
}

# Setup poetry
# -----------------------------------------------------------------------------
function setup_poetry () {
    ~/.local/bin/poetry completions zsh > ~/.zfunc/_poetry && \
    ~/.local/bin/poetry config virtualenvs.in-project true || \
    return 1 && return 0
}

# Install poetry
# -----------------------------------------------------------------------------
function install_poetry () {
    curl -sSL https://install.python-poetry.org | python3 - &>/dev/null || \
    return 1 && return 0
}

# Main
# -----------------------------------------------------------------------------
function main () {
    if command -v poetry &>/dev/null; then
        setup_poetry || erro "poetry setup"
        info "poetry setup done ✅"
        warn "poetry already installed"
    fi
    install_poetry || erro "install poetry"
    info "poetry install done ✅"
    setup_poetry
    info "poetry setup done ✅"
}

main "$@"
