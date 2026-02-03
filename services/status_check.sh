#!/bin/bash

# ==========================================
# Script: status_check.sh
#Usage: ./status_check.sh <arg1> <arg2>
# Purpose:
#   - Accept multiple service names as arguments
#   - Check if each service exists
#   - If exists and not running, start the service
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
    echo "Checking service: $service_name"

    # Check if service exists
    if ! systemctl status "$service_name" >/dev/null 2>&1; then
        echo "ERROR: Service '$service_name' not found"
        continue
    fi

    # Check service status
    status=$(systemctl is-active "$service_name")
    echo "Current status: $status"

    # Start service if not running
    if [ "$status" != "active" ]; then
        echo "Service '$service_name' is not running. Attempting to start..."
        systemctl start "$service_name"

        # Verify after start
        if systemctl is-active --quiet "$service_name"; then
            echo "SUCCESS: Service '$service_name' started successfully"
        else
            echo "ERROR: Failed to start service '$service_name'"
        fi
    else
        echo "Service '$service_name' is already running"
    fi

done

echo "--------------------------------------"
echo "Service check completed"
