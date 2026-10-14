#!/usr/bin/bash

set -euo pipefail

PROJECT_DIR="/home/devops/devops-server"
SERVICE="devops-server.service"
HEALTH-URL="http://127.0.0.1/"

cd "$PROJECT_DIR"

echo "==> Checking Git Working tree..."

if [[ -n "$(git status --porcelain)" ]]; then
echo "ERROR: Uncommitted or untracked changes found."
echo "Commit or resolve them before deployment."
exit 1
fi

echo "==> Pulling latest code..."
git pull --ff-only origin main

echo "==> Restarting application..."
sudo systemctl restart "$SERVICE"

echo "==> Checking website health"

for attemp in {1..10}; do
if curl -fsS --max-time 3 "$HEALTH_URL" > /dev/null; then
echo "PASS: Website is responding."
echo "DEPLOYMENT SUCCESSFUL"
exit 0
fi

echo "Waiting for website...($attempt/10)"
sleep 1
done

echo "FAIL: Website did not become healthy."

sudo systemctl status "$SERVICE" --no-pager || true
sudo journalctl -u "$SERVICE" -m 20 --no-pager || true
exit 1



 
