#!/usr/bin/env bash

SERVICE="devops-server.service"
URL="http://127.0.0.1:8081"
if systemctl is-active --quiet "$SERVICE"; then
echo "PASS: Service is active"
else 
echo "FAIL: Service is not active"
exit 1
fi

if curl --silent --fail --max-time 3 "$URL" > /dev/null; then
echo "PASS: Website is responding"
else
echo "FAIL: Website is not responding"
exit 1
fi

echo "HEALTH CHECK: Pass"
