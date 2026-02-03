#!/bin/bash

# ==========================================
# Script: restart_services.sh
# Usage: ./restart_services.sh <arg1> <arg2>
# Purpose:
#   - Accept multiple service names as arguments
#   - Check if each service exists
#   - If exits then restarts the service
# ==========================================

# Validate at least one argument is provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <service1> <service2> ..."
    exit 1
fi

# Treat all arguments as an array of services
services=("$@")

for service_name in "${services[@]}"; do
    echo "--------------------------------------"
    echo "Restarting service: $service_name"

    # Check if service exists
    if ! systemctl status "$service_name" >/dev/null 2>&1; then
        echo "ERROR: Service '$service_name' not found"
        continue
    fi

    systemctl restart "$service_name"

    # Verify after start
    if systemctl is-active --quiet "$service_name"; then
        echo "SUCCESS: Service '$service_name' restarted successfully"
    else
        echo "ERROR: Failed to restart service '$service_name'"
    fi
    
    

done

echo "--------------------------------------"
echo "Service restart completed"
