#!/bin/bash

echo "=========================================="
echo "          SYSTEM INFORMATION REPORT       "
echo "=========================================="

# 1. Show OS Version
echo -e "\n[1] OS Version Information:"
if [ -f /etc/os-release ]; then
    # Extracts the pretty name of the OS distribution
    grep "PRETTY_NAME" /etc/os-release | cut -d'=' -f2 | tr -d '"'
else
    uname -a
fi

# 2. Show all users with the Bash shell assigned
echo -e "\n[2] Users with Bash shell assigned:"
if [ -f /etc/passwd ]; then
    # Filters /etc/passwd for lines ending with bash, then extracts the first column (username)
    awk -F ':' '/\/bash$/ {print $1}' /etc/passwd
else
    echo "Could not read /etc/passwd file."
fi

# 3. Show Open Ports
echo -e "\n[3] Active Open Network Ports:"
if command -v ss &> /dev/null; then
    # Prefers 'ss' as it is the modern standard replacement for netstat
    ss -tuln
elif command -v netstat &> /dev/null; then
    netstat -tuln
else
    echo "Neither 'ss' nor 'netstat' tools found. Cannot list open ports."
fi

echo -e "\n=========================================="
