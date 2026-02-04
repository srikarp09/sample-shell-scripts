#!/bin/bash
# ==========================================
# Script: uptime_report.sh
#Usage: ./uptime_report.sh 
# Purpose:
#   - Gives you server uptime information
#   - Also provides server's last 3 recent reboot information
# ==========================================

#Color Codes
NC='\033[0m'
PINK='\033[38;5;212m'
BLUE='\033[0;34m' 

#Current date, time and uptime values
current_time=$(date)
uptime=$(uptime -p)

#Printing the uptime report
echo -e "${BLUE}======================="
echo "UPTIME REPORT"
echo -e "=======================${NC}"
echo -e "${BLUE}Current Time:   ${PINK}$current_time${NC}"
echo -e "${BLUE}Uptime:         ${PINK}$uptime${NC}"
echo -e "${BLUE}Recent Reboots:"
echo -e "${PINK}$(last reboot | head -n 3 | awk '{print "                "$1"   "$2"  "$3" "$5" "$6" "$7" "$10""}')"
echo -e "${BLUE}=======================${NC}"
