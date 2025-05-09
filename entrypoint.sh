#!/bin/bash

echo "Menjalankan Chrome Remote Desktop..."

# GANTI DI SINI
CRD_CODE="PASTE_KODE_CRD_DI_SINI"
PIN="123456"

sudo -u chromeuser /opt/google/chrome-remote-desktop/start-host \
  --code="$CRD_CODE" \
  --redirect-url="https://remotedesktop.google.com/_/oauthredirect" \
  --name="$(hostname)" \
  --pin="$PIN" \
  --user-name=chromeuser || true

# Keep alive
echo "Container aktif selama 10 jam..."
sleep 36000
