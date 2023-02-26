#!/usr/bin/env bash
#
# Install libraries, packages and programs.

# Global variables
# -----------------------------------------------------------------------------
SCRIPT_NAME="$(basename ${0})"
SRC_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DEFAULT_PACKAGES=("git" "ca-certificates" "curl" "gnupg" "lsb-release" "tree" "zip" "unzip" )
SDK_PACKAGES=("${DEFAULT_PACKAGES[@]}" "build-essential" "git-flow" "python3" "python3-pip")
DEVOPS_PACKAGES=("${SDK_PACKAGES[@]}" "software-properties-common" "wget")
WSL_PACKAGES=("${DEVOPS_PACKAGES[@]}" "wslu")
SUDO=""; command -v sudo &>/dev/null && SUDO="sudo"

# Loggers
# -----------------------------------------------------------------------------
info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; exit 1; }

# Directories
# -----------------------------------------------------------------------------
function create_directories () {
    mkdir -p "${HOME}/.config" \
        "${HOME}/.config/zsh" \
        "${HOME}/.cache" \
        "${HOME}/.cache/zsh" \
        "${HOME}/.local/bin" \
        "${HOME}/.local/share" \
        "${HOME}/.local/state" \
        "${HOME}/src" || \
        return 1 && return 0
}

# WSL packages
# -----------------------------------------------------------------------------
function wsl_dotfiles () {
    devops_dotfiles
}

# DevOps packages
# -----------------------------------------------------------------------------
function devops_dotfiles () {
    sdk_dotfiles

    bash ${SRC_DIR}/scripts/terraform.sh
}

# SDK packages
# -----------------------------------------------------------------------------
function sdk_dotfiles () {
    default_dotfiles
}

# Default packages
# -----------------------------------------------------------------------------
function default_dotfiles () {
    create_directories || erro "create directories"

    # configs
    bash ${SRC_DIR}/scripts/symlinks.sh
    bash ${SRC_DIR}/scripts/git.sh
    bash ${SRC_DIR}/scripts/starship.sh
    bash ${SRC_DIR}/scripts/fzf.sh
    bash ${SRC_DIR}/scripts/zsh-plugins.sh
}

# Install packages
# -----------------------------------------------------------------------------
function install_packages () {
    local packages=("$@")
    info "installing: $(echo ${packages[@]})"
    ${SUDO} apt update &>/dev/null && \
    ${SUDO} apt-get install --no-install-recommends -y ${packages[@]} &>/dev/null || \
        return 1 && return 0
}

# Main
# -----------------------------------------------------------------------------
function main () {
    if [[ "$#" -eq 0 ]]; then
        info "setup default dotfiles!"; default_dotfiles
    elif [[ "$#" -gt 1 ]]; then
        erro "too many arguments";
    else
        case "$*" in
            default) info "setup default dotfiles!"; install_packages ${DEFAULT_PACKAGES[@]} || erro "install packages"; default_dotfiles ;;
            sdk) info "setup sdk dotfiles!"; install_packages ${SDK_PACKAGES[@]} || erro "install packages"; sdk_dotfiles ;;
            devops) info "setup devops dotfiles!"; install_packages ${DEVOPS_PACKAGES[@]} || erro "install packages"; devops_dotfiles ;;
            wsl) info "setup wsl dotfiles!"; install_packages ${WSL_PACKAGES[@]} || erro "install packages"; wsl_dotfiles ;;
            *) erro "unknow option" ;;
        esac
    fi
}

main "$@"
