#!/usr/bin/env sh

PERIPHERY_PATH="/opt/homebrew/bin/periphery"

if [ ! -f "$PERIPHERY_PATH" ]; then
    echo "[!] Periphery is not installed or not found at $PERIPHERY_PATH. Please install it before running this script."
    exit 1
fi

if [ -f "$PERIPHERY_PATH" ]; then
    echo "[*] Starting scan for unused code for configuration: $CONFIGURATION."

    PROJECT_DERIVED_PATH="${BUILD_ROOT%/Build/*}"
    DATA_STORE_PATH="$PROJECT_DERIVED_PATH/Index.noindex/DataStore"
    
    cd Environment/Periphery/
    
	if [ ! -f ".periphery.yml" ]; then
        echo "[!] Configuration file .periphery.yml not found."
        exit 1
    fi
    
    "$PERIPHERY_PATH" clear-cache
    "$PERIPHERY_PATH" scan --index-exclude "../../Derived/**" --index-store-path $DATA_STORE_PATH --skip-build
    
	if [ $? -ne 0 ]; then
        echo "[!] Periphery encountered an error during scanning."
        exit 1
    fi
    
    echo "[*] Scan completed."
fi

