#!/bin/bash

LOG_DIR="/var/log/nginx"
BACKUP_DIR="/opt/nginx_logs_backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_NAME="nginx_logs_$DATE.tar.gz"

if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run as root."
    exit 1
fi

CURRENT_USAGE=$(df "$LOG_DIR" | tail -1 | awk '{print $5}' | sed 's/%//')
THRESHOLD=85

if [ "$CURRENT_USAGE" -gt "$THRESHOLD" ]; then
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
    fi

    tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$LOG_DIR" .

    if [ $? -eq 0 ]; then
        truncate -s 0 "$LOG_DIR"/*.log
    else
        echo "Error: Backup failed."
        exit 1
    fi

    find "$BACKUP_DIR" -type f -name "nginx_logs_*.tar.gz" -mtime +10 -delete
fi