#!/bin/bash

# INSTRUCTIONS: Edit the following placeholder command and output filepaths
# For example: cpu_usage_tool > ~/backups/cpuuse/cpu_usage.txt
# The cpu_usage_tool is the command and ~/backups/cpuuse/cpu_usage.txt is the filepath
# In the above example, the `cpu_usage_tool` command will output CPU usage information into a `cpu_usage.txt` file.
# Do not forget to use the -h option for free memory, disk usage, and free disk space

# Free memory output to a free_mem.txt file
echo -e "Free Memory:"\n > ~/backups/freemem/free_mem.txt
free -h | head -2 | tail -1 | awk {'print $4'} > ~/backups/freemem/free_mem.txt


# Disk usage output to a disk_usage.txt file
echo -e "Disk Usage:"\n > ~/backups/diskuse/disk_usage.txt
df -h | awk {'print $1,$3'} > ~/backups/diskuse/disk_usage.txt


# List open files to a open_list.txt file
echo -e "Open Files:"\n > ~/backups/openlist/open_list.txt
lsof /dev/null > ~/backups/openlist/open_list.txt
