#!/bin/bash
# 쇼핑숏컷 맥 설치·업데이트: 최신 릴리즈를 받아 응용 프로그램 폴더에 넣고 연다.
#   curl -fsSL https://raw.githubusercontent.com/aiteamjang/shoppingshortcut-releases/main/install.sh | bash
set -euo pipefail

REPO="aiteamjang/shoppingshortcut-releases"
APP="ShoppingShortcut.app"

if [ "$(uname -s)" != "Darwin" ]; then
  echo "맥에서만 쓰는 설치 명령이에요. 윈도우는 릴리즈 페이지의 ShoppingShortcut-Setup.exe를 받아 주세요." >&2
  exit 1
fi

# Apple 칩 맥이면 터미널이 인텔 모드(Rosetta)로 떠 있어도 Apple 칩용을 받는다
if [ "$(sysctl -n hw.optional.arm64 2>/dev/null || echo 0)" = "1" ]; then
  ASSET="ShoppingShortcut-mac-arm64.zip"
elif [ "$(uname -m)" = "x86_64" ]; then
  ASSET="ShoppingShortcut-mac-x64.zip"
else
  echo "지원하지 않는 맥이에요($(uname -m))." >&2
  exit 1
fi

DEST="/Applications"
if [ ! -w "$DEST" ]; then
  DEST="$HOME/Applications"
  mkdir -p "$DEST"
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "쇼핑숏컷을 받는 중이에요…"
curl -fL --progress-bar "https://github.com/$REPO/releases/latest/download/$ASSET" -o "$TMP/app.zip"
ditto -x -k "$TMP/app.zip" "$TMP"
if [ ! -x "$TMP/$APP/Contents/MacOS/ShoppingShortcut" ]; then
  echo "받은 파일이 올바르지 않아요. 잠시 뒤 다시 실행해 주세요." >&2
  exit 1
fi

if pgrep -f "$APP/Contents/MacOS/" >/dev/null 2>&1; then
  echo "켜져 있는 쇼핑숏컷을 끄는 중이에요…"
  osascript -e 'quit app id "com.aiteamjang.shoppingshortcut"' >/dev/null 2>&1 || true
  for _ in $(seq 1 20); do
    pgrep -f "$APP/Contents/MacOS/" >/dev/null 2>&1 || break
    sleep 0.5
  done
  if pgrep -f "$APP/Contents/MacOS/" >/dev/null 2>&1; then
    echo "쇼핑숏컷이 아직 켜져 있어요. 앱을 끈 뒤 다시 실행해 주세요." >&2
    exit 1
  fi
fi

# 새 앱을 목적지 옆에 먼저 옮긴 뒤 바꾼다(옮기다 실패하면 기존 앱은 그대로 남는다)
NEW="$DEST/.ShoppingShortcut.app.new"
rm -rf "$NEW"
mv "$TMP/$APP" "$NEW"
rm -rf "${DEST:?}/$APP"
mv "$NEW" "$DEST/$APP"
echo "설치했어요: $DEST/$APP"
open "$DEST/$APP"
