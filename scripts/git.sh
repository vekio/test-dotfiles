#!/usr/bin/env bash
#
# Git setup.

# Loggers
# -----------------------------------------------------------------------------
info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; exit 1; }

# Check git installed
# -----------------------------------------------------------------------------
function check_git () {
    if ! command -v git &> /dev/null;then
        return 1
    fi
    return 0
}

# Setup git
# -----------------------------------------------------------------------------
function setup_git () {
    git config --global user.name "Alberto Castañeiras" && \
    git config --global user.email "alberto@casta.me" && \
    git config --global init.defaultBranch main || \
    return 1 && return 0
}

# Main
# -----------------------------------------------------------------------------
function main () {
    check_git || erro "git need to be installed"
    setup_git || erro "git setup"
    info "git setup done ✅"
}

main "$@"
