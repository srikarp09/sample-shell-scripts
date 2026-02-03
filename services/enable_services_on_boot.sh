
#!/bin/bash

# ==========================================
# Script: enable_services_on_boot.sh
# Usage: ./enable_services_on_boot.sh <arg1> <arg2>
# Purpose:
#   - Accept multiple service names as arguments
#   - Check if each service is enabled for auto-start 
#   - If not then enable the service to auto-start
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
    echo "service: $service_name"

    # Check if service exists
    if ! systemctl status "$service_name" >/dev/null 2>&1; then
        echo "ERROR: Service '$service_name' not found"
        continue
    fi
    systemctl is-enabled $service_name >/dev/null 2>&1
    if [ $? -ne 0 ]; then
            systemctl enable $service_name >/dev/null 2>&1
            echo "$service_name service enabled to start on boot"
    else
            echo "$service_name is already enabled"
    fi    

done

echo "--------------------------------------"
echo "All specified services enabled to start on boot"

