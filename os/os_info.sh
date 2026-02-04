#!/bin/bash
# ==========================================
# Script: os_info.sh
#Usage: ./os_info.sh
# Purpose:
#   - Gives you deatils about the server
# ==========================================

# Color Codes
NC='\033[0m'
PINK='\033[38;5;212m'
BLUE='\033[0;34m'

# function to find package manager
find_package_manager() {
    if yum --version >/dev/null 2>&1; then
        echo "yum"
    elif apt --version >/dev/null 2>&1; then
        echo "apt"
    elif dnf --version >/dev/null 2>&1; then
        echo "dnf"
    else
        echo "unkown"
    fi
}

os="$(grep '^PRETTY_NAME=' /etc/os-release | cut -d'"' -f2)"
kernal="$(uname -r)"
hostname="$(hostname)"
sockets="$(lscpu | grep "^Socket(s):" | awk ' {print $2}')"
cores="$(lscpu | grep "^Core(s)" | awk ' {print $4}')"
threads="$(lscpu | grep "^Thread(s)" | awk ' {print $4}')"
cpu=$((sockets*(cores*threads)))
arch="$(lscpu | grep "^Architecture:" | awk ' {print $2}')"
pm=$(find_package_manager)

# Output format
echo -e "${BLUE}======================="
echo "OS INFORMATION"
echo -e "=======================${NC}"
echo -e "${BLUE}OS:                  ${PINK}$os${NC}"
echo -e "${BLUE}Kernal:              ${PINK}$kernal${NC}"
echo -e "${BLUE}Hostname:            ${PINK}$hostname${NC}"
echo -e "${BLUE}Socket(s) per core:  ${PINK}$sockets${NC}"
echo -e "${BLUE}Core(s) per core:    ${PINK}$cores${NC}"
echo -e "${BLUE}Threads(s) per core: ${PINK}$threads${NC}"
echo -e "${BLUE}CPU(s):              ${PINK}$cpu${NC}"
echo -e "${BLUE}Architecture:        ${PINK}$arch${NC}"
echo -e "${BLUE}Package Manager:     ${PINK}$pm${NC}"
echo -e "${BLUE}=======================${NC}"
