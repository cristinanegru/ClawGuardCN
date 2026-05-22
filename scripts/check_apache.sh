#!/bin/bash
set -u

LOG_DIR="/home/ubuntu/ClawGuardCN/logs"
LOG_FILE="$LOG_DIR/health.log"
mkdir -p "$LOG_DIR"

timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

say() {
    echo "$1" | tee -a "$LOG_FILE"
}

say "[$(timestamp)] [ClawGuardCN] Checking Apache status..."

STATUS=$(systemctl is-active apache2)
HTTP_CODE=$(curl -sS -o /dev/null -w "%{http_code}" --max-time 5 http://127.0.0.1/ || echo "000")
ROOT_USE=$(df -P / | awk 'NR==2 {print $5}')
ROOT_FREE=$(df -h / | awk 'NR==2 {print $4}')

if [ "$STATUS" = "active" ]; then
    say "Apache is active. The website engine is awake and wearing pants."
else
    say "Apache is $STATUS. Recovery may be needed."
fi

if [ "$HTTP_CODE" = "200" ]; then
    say "HTTP check returned 200 OK. Visitors should see the page instead of digital soup."
else
    say "HTTP check returned $HTTP_CODE. The server answered weirdly; inspect Apache and site content."
fi

case "$ROOT_USE" in
    9[0-9]%|100%)
        say "Disk warning: / is $ROOT_USE full with $ROOT_FREE free. The server closet is packed to the ceiling."
        ;;
    *)
        say "Disk check: / is $ROOT_USE full with $ROOT_FREE free."
        ;;
esac

if [ "$STATUS" = "active" ] && [ "$HTTP_CODE" = "200" ]; then
    exit 0
fi

exit 1
