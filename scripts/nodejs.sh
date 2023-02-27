#!/usr/bin/env bash
#
# Installs nodejs.

# Global variables
# -----------------------------------------------------------------------------
SCRIPT_NAME="$(basename ${0})"
SRC_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)
NVM_VERSION=""

# Loggers
# -----------------------------------------------------------------------------
info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; exit 0; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; exit 1; }

# Install nvm
# -----------------------------------------------------------------------------
function install_nvm () {
    curl -o- -s https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash &>/dev/null || \
    return 1 && return 0
}

# Get nvm lastest version
# -----------------------------------------------------------------------------
function get_nvm_version () {
    NVM_VERSION=$(curl --silent "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    if [[ -z "${NVM_VERSION}" ]]; then
        return 1
    fi
    return 0
}

# Install nodejs
# -----------------------------------------------------------------------------
function install_nodejs () {
    if ! command -v nvm &>/dev/null; then
        NVM_DIR="$([[ -z "${XDG_CONFIG_HOME-}" ]] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [[ -s "${NVM_DIR}/nvm.sh" ]] && . "${NVM_DIR}/nvm.sh"
        echo &>/dev/null
    fi
    nvm install --lts &>/dev/null || \
    return 1 && return 0
}

# Main
# -----------------------------------------------------------------------------
function main () {
    if command -v node &>/dev/null; then
        warn "nodejs already installed"
    fi
    get_nvm_version || erro "get latest nvm version"
    install_nvm || erro "install nvm"
    install_nodejs || erro "install nodejs"
    info "nodejs install done ✅"
}

main "$@"
