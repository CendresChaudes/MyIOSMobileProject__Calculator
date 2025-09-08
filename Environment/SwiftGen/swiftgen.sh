#!/usr/bin/env sh

export PATH="$PATH:/opt/homebrew/bin"

OUTPUT_FILES=()
SWIFT_FILES=()

COUNTER=0

while [ $COUNTER -lt ${SCRIPT_OUTPUT_FILE_COUNT} ]; do
    tmp="SCRIPT_OUTPUT_FILE_$COUNTER"
    OUTPUT_FILES+=("${!tmp}")
    COUNTER=$((COUNTER + 1))
done

for file in "${OUTPUT_FILES[@]}"; do
    if [ -d "$file" ]; then
        for swift_file in "$file"/*.swift; do
            if [ -f "$swift_file" ]; then
                SWIFT_FILES+=("$swift_file")
            fi
        done
    elif [ -f "$file" ]; then
        if [[ "$file" == *.swift ]]; then
            SWIFT_FILES+=("$file")
        fi
    fi
done

for file in "${OUTPUT_FILES[@]}"; do
    if [ -f "$file" ]; then
        chmod a=rw "$file"
    fi
done

SWIFTGEN_PATH="${PODS_ROOT}/SwiftGen/bin/swiftgen"

if [ ! -f "$SWIFTGEN_PATH" ]; then
    echo "[!] SwiftGen is not installed or not found at $SWIFTGEN_PATH. Please install it before running this script."
    exit 1
fi

if [ -f "$SWIFTGEN_PATH" ]; then
    echo "[*] Starting code generation for configuration: $CONFIGURATION."
    
    cd Environment/SwiftGen/
    
    if [ ! -f ".swiftgen.yml" ]; then
        echo "[!] Configuration file .swiftgen.yml not found."
        exit 1
    fi
    
    "$SWIFTGEN_PATH" config run --config .swiftgen.yml
    
	if [ $? -ne 0 ]; then
        echo "[!] SwiftGen encountered an error during scanning."
        exit 1
    fi
    
    echo "[*] Generation completed."
fi

for file in "${SWIFT_FILES[@]}"; do
    chmod a=r "$file"
done
