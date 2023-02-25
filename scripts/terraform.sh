#!/usr/bin/env bash
#
# Install terraform.

# Global variables
# -----------------------------------------------------------------------------
SCRIPT_NAME="$(basename ${0})"
SUDO=""; command -v sudo &>/dev/null && SUDO="sudo"

# Loggers
# -----------------------------------------------------------------------------
info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; exit 0; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; exit 1; }

# Install terraform
# -----------------------------------------------------------------------------
function install_terraform () {
    wget -O- --quiet https://apt.releases.hashicorp.com/gpg | \
        gpg --dearmor | \
        ${SUDO} tee /usr/share/keyrings/hashicorp-archive-keyring.gpg &>/dev/null

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
        https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        ${SUDO} tee /etc/apt/sources.list.d/hashicorp.list &>/dev/null

    ${SUDO} apt-get update &>/dev/null && \
    ${SUDO} apt-get install -y terraform &>/dev/null || \
    return 1 && return 0
}

# Main
# -----------------------------------------------------------------------------
function main () {
    install_terraform || erro "terraform install"
    info "terraform install done ✅"
}

main "$@"
