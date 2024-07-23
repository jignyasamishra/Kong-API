#!/bin/bash

# Function to check and install a utility using Homebrew
check_and_install() {
    local utility=$1
    if brew list $utility &> /dev/null; then
        echo "$utility is already installed."
    else
        echo "$utility not found. Installing $utility..."
        brew install $utility
    fi
}

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not installed. Please install Homebrew first."
    exit 1
fi

# Loop through all passed utilities and check/install them
for utility in "$@"; do
    check_and_install $utility
done
