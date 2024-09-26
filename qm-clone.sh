#!/bin/bash

# Parameters
TEMPLATE_ID=$1
START_ID=$2
END_ID=$3

# Check if all parameters are provided
if [ -z "$TEMPLATE_ID" ] || [ -z "$START_ID" ] || [ -z "$END_ID" ]; then
    echo "Usage: $0 <TEMPLATE_ID> <START_ID> <END_ID>"
    echo "Please provide all parameters: TEMPLATE_ID, START_ID, and END_ID."
    exit 1
fi

# Create VMs in parallel
echo "Creating VMs in parallel..."
for ((VM_ID=START_ID; VM_ID<=END_ID; VM_ID++))
do
    qm clone "$TEMPLATE_ID" "$VM_ID" --name "vm-$VM_ID" &
done

# Wait for all background jobs to finish
wait
echo "All VMs have been created."