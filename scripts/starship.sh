#!/usr/bin/env bash
#
# Install starship.

# Global variables
# -----------------------------------------------------------------------------
SCRIPT_NAME="$(basename ${0})"
SRC_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"

# Loggers
# -----------------------------------------------------------------------------
info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; exit 1; }

# Install starship
# -----------------------------------------------------------------------------
function install_starship () {
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "${HOME}/.local/bin" &>/dev/null || \
    return 1 && return 0
}

# Update starship
# -----------------------------------------------------------------------------
function update_starship () {
    if ! command -v starship &>/dev/null; then
        return 1
    fi
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "${HOME}/.local/bin" &>/dev/null || \
    return 1 && return 0
}

# Setup starship
# -----------------------------------------------------------------------------
function setup_starship () {
    ln -sf "${SRC_DIR}/starship.toml" "${XDG_CONFIG_HOME}/starship.toml" || \
    return 1 && return 0
}

# Main
# -----------------------------------------------------------------------------
function main () {
    install_starship || erro "starship install"
    info "starship install done ✅"
    setup_starship || erro "starship setup"
    info "starship setup done ✅"
}

main "$@"
