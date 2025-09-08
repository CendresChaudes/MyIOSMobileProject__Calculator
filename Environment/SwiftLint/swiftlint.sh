#!/usr/bin/env sh

SWIFTLINT_PATH="${PODS_ROOT}/SwiftLint/swiftlint"

if [ ! -f "$SWIFTLINT_PATH" ]; then
    echo "[!] SwiftLint is not installed or not found at $SWIFTLINT_PATH. Please install it before running this script."
    exit 1
fi

if [ -f "$SWIFTLINT_PATH" ]; then
    echo "[*] Starting code scan with linter for configuration: $CONFIGURATION."
    
    "$SWIFTLINT_PATH" lint
    
    echo "[*] Scan completed."
fi
