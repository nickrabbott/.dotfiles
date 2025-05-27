#!/bin/bash

# Cross-platform CPU + Memory usage (Linux/macOS)
OS=$(uname -s)

if [ "$OS" = "Darwin" ]; then
    # macOS
    CPU=$(ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f%%", s}')
    MEM=$(vm_stat | awk '/Pages free/ {free=$3} /Pages active/ {active=$3} /Pages inactive/ {inactive=$3} /Pages speculative/ {spec=$3} END {used=active+inactive+spec; total=used+free; printf "%.0f%%", (used/total)*100}')
elif [ "$OS" = "Linux" ]; then
    # Linux
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{printf "%.0f%%", 100 - $8}')
    MEM=$(free | awk '/Mem/ {printf "%.0f%%", $3/$2 * 100.0}')
else
    CPU="N/A"
    MEM="N/A"
fi

echo "  CPU $CPU   MEM $MEM"

