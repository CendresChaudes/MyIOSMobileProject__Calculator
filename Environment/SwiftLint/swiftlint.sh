#!/usr/bin/env sh

SWIFTLINT_PATH="${PODS_ROOT}/SwiftLint/swiftlint"

if [ ! -f "$SWIFTLINT_PATH" ]; then
    echo "[!] SwiftLint is not installed or not found at $SWIFTLINT_PATH. Please install it before running this script."
    exit 1
fi

if [ -f "$SWIFTLINT_PATH" ]; then
    echo "[*] Starting code scan with linter for configuration: $CONFIGURATION."
    
    cd Environment/SwiftLint/
    
    if [ ! -f ".swiftlint.yml" ]; then
        echo "[!] Configuration file .swiftlint.yml not found."
        exit 1
    fi

    "$SWIFTLINT_PATH" lint --config .swiftlint.yml
	"$SWIFTLINT_PATH" lint --config .swiftlint.yml --fix
        
    if [ $? -ne 0 ]; then
        echo "[!] SwiftLint encountered an error during scanning."
        exit 1
    fi

    echo "[*] Scan completed."
fi
