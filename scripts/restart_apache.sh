#!/bin/bash
set -u

echo "[ClawGuardCN] Restarting Apache..."

sudo systemctl restart apache2

NEW_STATUS=$(systemctl is-active apache2)

if [ "$NEW_STATUS" = "active" ]; then
    echo "Recovery successful. Apache is running again."

else
    echo "Recovery failed. Manual investigation needed."

fi
