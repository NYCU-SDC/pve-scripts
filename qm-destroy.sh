#!/bin/bash

# Parameters
START_ID=$1
END_ID=$2

# Check if both parameters are provided
if [ -z "$START_ID" ] || [ -z "$END_ID" ]; then
    echo "Usage: $0 <START_ID> <END_ID>"
    echo "Please provide the START_ID and END_ID parameters."
    exit 1
fi

# Destroy VMs
echo "Deleting VMs..."
for ((i=$((START_ID)); i<=$((END_ID)); i++))
do
    qm destroy "$i" &
done

wait
echo "All VMs have been destroyed"

# Clear the dataset
echo "Clearing logical volume..."
for ((i=$((START_ID)); i<=$((END_ID)); i++))
do
    lvremove /dev/pve/vm-$i-cloudinit &
done

wait
echo "All logical volume have been removed"