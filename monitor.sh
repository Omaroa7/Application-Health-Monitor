#!/usr/bin/bash

echo "===== Application Health report =====" > report.txt
echo "Date: $(date)" >> report.txt
echo "" >> report.txt

echo "Disk usage:" >> report.txt
df -h >> report.txt
echo "" >> report.txt

echo "Memory usage:" >> report.txt
free -h >> report.txt
echo "" >> report.txt

echo "CPU usage" >> report.txt
top -bn1 | head -n 5 >> report.txt
echo >> report.txt

disk_usage=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
echo "Disk health check:" >> report.txt

if [ "$disk_usage" -gt 80 ]; then
  echo "WARNING: Disk usage is high ($disk_usage%)" >> report.t
else
  echo "OK: Disk usage is healthy ($disk_usage%)" >> report.txt
fi

echo >> report.txt


echo "Service status:" >> report.txt

if systemctl is-active --quiet ssh; then
echo "SSH service: RUNNING" >> report.txt
else
echo "SSH service: NOT RUNNING" >> report.txt
fi
